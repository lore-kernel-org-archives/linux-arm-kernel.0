From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Sat, 3 Sep 2016 00:34:27 +0100
Subject: [PATCH 05/33] gpio: add generic single-register fixed-direction
 GPIO driver
In-Reply-To: <87zinqj8vr.fsf@belgarion.home>
References: <87fupmc59b.fsf@belgarion.home>
 <20160831084938.GQ1041@n2100.armlinux.org.uk>
 <20160831102721.GR1041@n2100.armlinux.org.uk>
 <87twe0krym.fsf@belgarion.home>
 <20160901092754.GU1041@n2100.armlinux.org.uk>
 <87oa47l1tn.fsf@belgarion.home>
 <20160901230248.GA1041@n2100.armlinux.org.uk>
 <87inuekx78.fsf@belgarion.home>
 <20160902185641.GF1041@n2100.armlinux.org.uk>
 <87zinqj8vr.fsf@belgarion.home>
Message-ID: <20160902233427.GH1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 02, 2016 at 11:21:12PM +0200, Robert Jarzmik wrote:
> Ah I think I know what happens. The trick is that when this
> irq_set_chained_handler_and_data() is called, the irq_desc for irq 305 is not
> yet allocated (ie. is NULL). And it is not allocated because
> pxa_cplds_irqs.cplds_probe() was not yet called, and had not allocated the irq
> descriptors.

Grr.

> I would bet that on neponset the input interrupt to the SA1111 is within
> 0..NR_IRQS, which is not the case on lubbock anymore since the pxa_cplds_irqs
> conversion.

It's not, but it's guaranteed to be allocated, because the SA1111 is
declared by neponset after ensuring that the resources are setup.

> It looks that I have an ordering problem :
>  - I want gpio-pxa.probe() to be called at device initcall time
>  - pxa_cplds_irqs.probe() cannot complete before gpio-pxa.probe() because it
>    needs GPIO0 as its interrupt source
>    => it might need to honor -EPROBE_DEFER
>  - sa1111.sa1111_probe() cannot complete before pxa_cplds_irqs.probe() because
>    it needs IRQ305 as its source
>    => it might need to honor -EPROBE_DEFER
> 
> I fail to see how the "optimized" irq chained handler can be used in a
> device-tree type build, where I don't think the probe ordering is guaranteed.

In a DT environment, platform_get_irq uses of_irq_get() to obtain its
interrupt, which uses irq_find_host() and irq_create_of_mapping() to
get the interrupt number.  The IRQ domain for this must exist.

In a DT build, the SA1111 platform device should be declared in the
DT using the normal IRQ properties, and that should cause
platform_get_irq() to return -EPROBE_DEFER if pxa_cplds_irqs hasn't
initialised.  So I think in general we're fine - where we're not is
we're not propagating the platform_get_irq() error code back (which
is an easy fix.)

The problem is then what to do with non-DT PXA builds to make sure
this works - the current order really doesn't work, and there's no
way afaics to find out whether an interrupt number passed through
as a platform resource is currently setup with handlers etc.  Even
can_request_irq() doesn't tell us that.

We could mess about with the init order to make sure the pxa cplds
stuff initialises earlier (eg, moving it to arch_initcall() rather
than being at device_initcall() time.)

I'm not willing to give up on the current interrupt handling structure
in SA1111 - it's the way it is with good reason, and with a great deal
of experience in getting it working right.  The SA1111 has some
behaviours to make it correctly work in an edge-triggered interrupt
environment that need proper handling of the upper levels of the
interrupt hierachy.

We _used_ to take this "request_irq" approach on ARM prior to my rewrite
of the ARM IRQ subsystem, and we had massive problems with lost SA1111
interrupts - particularly PCMCIA card interrupts.  That's actually the
whole reason why I rewrote the ARM interrupt code to have these chained
interrupt handlers, which is one of the basis of tglx's genirq code that
we now have.  They exist to allow not only a balanced, equal priority
IRQ handling (so any one IRQ can't starve all others if the handlers
are implemented correctly) but also to ensure that IRQs don't get lost,
while avoiding having lots of unnecessary interrupts caused by badly
handled edge IRQs.

The SA1111 is a device designed to be connected to an edge IRQ input,
and it will pulse its interrupt output whenever there's any active
interrupts and _either_ of the interrupt status/clear registers are
written.

The only way to achieve no lost interrupts and no spurious interrupts
is to have SA1111 as a chained interrupt handler and control the
parent at the appropriate points during SA1111 interrupt processing.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
