From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 03 Sep 2014 16:57:39 +0200
Subject: [PATCH v3 13/17] ARM64 / ACPI: Add GICv2 specific ACPI boot
 support
In-Reply-To: <5406DEB6.1060705@linaro.org>
References: <1409583475-6978-1-git-send-email-hanjun.guo@linaro.org>
 <5405BFE7.5060005@arm.com> <5406DEB6.1060705@linaro.org>
Message-ID: <4895927.Zp4WL2AZAF@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 03 September 2014 11:26:14 Tomasz Nowicki wrote:
> On 02.09.2014 15:02, Marc Zyngier wrote:
> > On 02/09/14 12:48, Tomasz Nowicki wrote:
> >> On 01.09.2014 19:35, Marc Zyngier wrote:
> >>>> @@ -78,6 +79,10 @@ void __init set_handle_irq(void (*handle_irq)(struct pt_regs *))
> >>>>    void __init init_IRQ(void)
> >>>>    {
> >>>>       irqchip_init();
> >>>> +
> >>>> +    if (!handle_arch_irq)
> >>>> +            acpi_gic_init();
> >>>> +
> >>>
> >>> Why isn't this called from irqchip_init? It would seem like the logical
> >>> spot to probe an interrupt controller.
> >>
> >> irqchip.c is OF dependent, I want to decouple these from the very
> >> beginning.
> >
> > No. irqchip.c is not OF dependent, it is just that DT is the only thing
> > we support so far. I don't think duplicating the kernel infrastructure
> > "because we're different" is the right way.
> >
> > There is no reason for your probing structure to be artificially
> > different (you're parsing the same information, at the same time). Just
> > put in place a similar probing mechanism, and this will look a lot better.


> >> Having only GICv2, it would work. Considering we would do the same for
> >> GICv3 (arm-gic-v3.h) there will be register name conflicts for both
> >> headers inclusion:
> >>
> >> [...]
> >> #include <linux/irqchip/arm-gic.h>
> >> #include <linux/irqchip/arm-gic-v3.h>
> >> [...]
> >>          err = gic_v3_acpi_init(table);
> >>          if (err)
> >>                  err = gic_v2_acpi_init(table);
> >>          if (err)
> >>                  pr_err("Failed to initialize GIC IRQ controller");
> >> [...]
> >> So instead of changing register names prefix, I choose new header will
> >> be less painfully.
> >
> > Yes, and this is exactly why I pushed back on that last time. I'll
> > continue saying that interrupt controllers should be self-probing, with
> > ACPI as they are with DT.
> >
> > Even with the restrictions of ACPI and SBSA, we end-up with at least 2
> > main families of interrupt controllers (GICv2 and GICv3), both with a
> > number of "interesting" variations (GICv2m and GICv4, to only mention
> > those I'm directly involved with).
> >
> > I can safely predict that the above will become a tangled mess within 18
> > months, and the idea of littering the arch code with a bunch of
> > hardcoded "if (blah())" doesn't fill me with joy and confidence.
> >
> > In summary: we have the infrastructure already, just use it.
> 
> We had that discussion but I see we still don't have consensus here. It 
> would be good to know our direction before we prepare next patch 
> version. Arnd any comments on this from you side?

I still prefer being explicit here for the same reason I mentioned earlier:
I want it to be very clear that we don't support arbitrary irqchips other
than the ones in the APCI specification. The infrastructure exists on DT
because we have to support a large number of incompatible irqchips.

In particular, the ACPI tables describing the irqchip have no way to
identify the GIC at all, if I read the spec correctly, you have to
parse the tables, ioremap the registers and then read the ID to know
if you have GICv1/v2/v2m/v3/v4. There doesn't seem to be any "device"
for the GIC that a hypothetical probe function would be based on.

It does seem wrong to parse the tables in the irq-gic.c file though:
that part can well be common across the various gic versions and then
call into either irq-gic.c or irq-gic-v3.c for the version specific
parts. Whether we put that common code into drivers/irqchip/irqchip.c,
drivers/irqchip/gic-common.c, drivers/irqchip/irq-acpi-gic.c or
drivers/acpi/irq-gic.c I don't care at all.

	Arnd
