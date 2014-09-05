From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 05 Sep 2014 12:13:22 +0200
Subject: [Linaro-acpi] [PATCH v3 13/17] ARM64 / ACPI: Add GICv2 specific
 ACPI boot support
In-Reply-To: <540986B2.7000901@arm.com>
References: <1409583475-6978-1-git-send-email-hanjun.guo@linaro.org>
 <4895927.Zp4WL2AZAF@wuerfel> <540986B2.7000901@arm.com>
Message-ID: <3400229.hn32yHbVD2@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 05 September 2014 10:47:30 Marc Zyngier wrote:
> > 
> > I still prefer being explicit here for the same reason I mentioned earlier:
> > I want it to be very clear that we don't support arbitrary irqchips other
> > than the ones in the APCI specification. The infrastructure exists on DT
> > because we have to support a large number of incompatible irqchips.
> 
> I'm not suggesting that we should support more than the ACPI spec says.
> And that's certainly the whole point of a spec, isn't it? ACPI says what
> we support, and we're not going any further. I'm just saying that we
> shouldn't make the maintenance burden heavier, and the code nothing
> short of disgusting. Using our current infrastructure doesn't mean we're
> going to support GIcv2.37.

Ok

> > In particular, the ACPI tables describing the irqchip have no way to
> > identify the GIC at all, if I read the spec correctly, you have to
> > parse the tables, ioremap the registers and then read the ID to know
> > if you have GICv1/v2/v2m/v3/v4. There doesn't seem to be any "device"
> > for the GIC that a hypothetical probe function would be based on.
> 
> This is not the way I read the spec. Table 5-46 (Interrupt Controller
> Structure) tells you if you have a CPU interface (GICv1/v2) or a
> redistributor (GICv3/v4). That's enough to know whether or not you
> should carry on probing a particular controller.

Ah, good. I missed that.

> The various GIC versions don't really have a unified memory map anyway
> (well, none that you can rely on), and you really have to rely on ACPI
> to tell you what you have.

So we are back to needing to support two different irqchip drivers
(v1/v2/v2m and v3/v4), instead of five or more, right?

> > It does seem wrong to parse the tables in the irq-gic.c file though:
> > that part can well be common across the various gic versions and then
> > call into either irq-gic.c or irq-gic-v3.c for the version specific
> > parts. Whether we put that common code into drivers/irqchip/irqchip.c,
> > drivers/irqchip/gic-common.c, drivers/irqchip/irq-acpi-gic.c or
> > drivers/acpi/irq-gic.c I don't care at all.
> 
> I don't think so you can make that common code very easily. The
> information required by both drivers is organized differently.
> If it was, I'd have done that for the DT binding.

I see, and that's also what Tomasz just explained. So can we just
have one an irqchip_init() function doing this:?

if (dt)
	of_irq_init(__irqchip_of_table);
else if (acpi) {
	read cpu-interface and redistributor address from acpi tables
	if (cpu-interface)
		gic_v2_acpi_init(table);
	else if(redistributor)
		gic_v3_acpi_init(table)
}

	Arnd
