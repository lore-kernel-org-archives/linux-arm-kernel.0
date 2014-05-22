From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 22 May 2014 10:31:37 +0200
Subject: [PATCH v2] ARM: realview: basic device tree implementation
In-Reply-To: <CACRpkdb8c=k3Ky=TisNdzycc3owJsNSQmSTu03RR5E0QvE0KZA@mail.gmail.com>
References: <1399586896-16906-1-git-send-email-linus.walleij@linaro.org>
 <201405091244.02066.arnd@arndb.de>
 <CACRpkdb8c=k3Ky=TisNdzycc3owJsNSQmSTu03RR5E0QvE0KZA@mail.gmail.com>
Message-ID: <5678119.IM3FN0FlT6@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 22 May 2014 09:41:39 Linus Walleij wrote:
> On Fri, May 9, 2014 at 12:44 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> 
> >> +++ b/arch/arm/boot/dts/arm-realview-pb1176.dts
> >
> > Can you split this up into an arm-realview.dtsi file for the common parts and
> > a pb1176 specific file for the rest?
> 
> I wonder if that makes any kind of sense. The RealView platforms does not
> really share much more than the name, sadly. For example: IP blocks
> aren't even at the same address.
> 
> I could create a .dtsi file but it would be empty :-(

Ok, fair enough.

> >> +     soc {
> >> +             #address-cells = <1>;
> >> +             #size-cells = <1>;
> >> +             compatible = "simple-bus";
> >> +             ranges;
> >> +
> >> +             syscon: syscon at 10000000 {
> >> +                     compatible = "arm,realview-pb1176-syscon", "syscon";
> >> +                     reg = <0x10000000 0x1000>;
> >> +             };
> >
> > Hmm, in order to have a proper reset driver, we probably want a separate
> > node for the reset controller. I believe the x-gene people have just
> > posted a generic reset driver based on syscon. Let's see if we can share
> > that.
> 
> I have looked at it. Patch titled
> "power: reset: Add generic SYSCON register mapped reset"
> 
> Sadly it does not work for our case. This is because it assumes that
> reboot will be triggered by writing one value to one register. The RealViews
> need you to *first* write to a special unlock register, then write a magic
> value to a magic register.

We've already added a significant number of reset drivers like this,
I guess it doesn't hurt to have one more. We have so far resisted
adding a register state machine to DT.

> So of course we could extend the syscon regmap reset driver by
> starting to encode a jam table such as a sequence of register writes
> to a sequence of registers, but we have refused such code in the past
> because as I recall Grant said, it is the beginning of a byte code
> interpreter and then we could as well bite the bullet and start
> implementing open firmware.
> 
> This is exactly the type of thing that ACPI AML code usually does
> by the way so what he says makes a *lot* of sense.
> 
> So for now I keep to our special driver.

Ok.

> >> +/* Pointer to the system controller */
> >> +struct regmap *syscon_regmap;
> >> +u8 syscon_type;
> >> +
> >> +static struct map_desc realview_dt_io_desc[] __initdata = {
> >> +     {
> >> +             /* FIXME: static map needed for LED driver */
> >> +             .virtual        = IO_ADDRESS(REALVIEW_SYS_BASE),
> >> +             .pfn            = __phys_to_pfn(REALVIEW_SYS_BASE),
> >> +             .length         = SZ_4K,
> >> +             .type           = MT_DEVICE,
> >> +     },
> >> +};
> >
> > I've looked at the driver and I don't see why this is required.
> > The driver does a devm_ioremap_resource(), which should work with
> > or without a static mapping.
> 
> Well yeah, the version of the driver that is in linux-next does this.
> This was parallel work and I had no idea which would reach
> mainline first :-)
> 
> Anyway, I just deleted because I realized it was better if I came
> up with the concept of syscon-leds to handle this through the
> syscon.

Ok.


> >> +#if IS_ENABLED(CONFIG_CACHE_L2X0)
> >> +     if (of_machine_is_compatible("arm,realview-eb"))
> >> +             /*
> >> +              * 1MB (128KB/way), 8-way associativity,
> >> +              * evmon/parity/share enabled
> >> +              * Bits:  .... ...0 0111 1001 0000 .... .... ....
> >> +              */
> >> +             l2x0_of_init(0x00790000, 0xfe000fff);
> >> +     else if (of_machine_is_compatible("arm,realview-pb1176"))
> >> +             /*
> >> +              * 128Kb (16Kb/way) 8-way associativity.
> >> +              * evmon/parity/share enabled.
> >> +              */
> >> +             l2x0_of_init(0x00730000, 0xfe000fff);
> >> +     else if (of_machine_is_compatible("arm,realview-pb11mp"))
> >> +             /*
> >> +              * 1MB (128KB/way), 8-way associativity,
> >> +              * evmon/parity/share enabled
> >> +              * Bits:  .... ...0 0111 1001 0000 .... .... ....
> >> +              */
> >> +             l2x0_of_init(0x00730000, 0xfe000fff);
> >> +     else if (of_machine_is_compatible("arm,realview-pbx"))
> >> +             /*
> >> +              * 16KB way size, 8-way associativity, parity disabled
> >> +              * Bits:  .. 0 0 0 0 1 00 1 0 1 001 0 000 0 .... .... ....
> >> +              */
> >> +             l2x0_of_init(0x02520000, 0xc0000fff);
> >> +#endif
> >
> > You wrote that you added the #if IS_ENABLED() here. Why?
> 
> Mainly because I had this other review comment that I
> should use IS_ENABLED() rather than #ifdef and it
> seemed better but I don't know anymore...

There are two reasons for using IS_ENABLED: the first is that it catches
both the =y and the =m case in Kconfig, which doesn't apply here since
the cache controller driver cannot be a loadable module.

The other is that you can replace the #ifdef with an if(), to improve
readability and compile time coverage, but you didn't do that.

> > l2x0_of_init is already a nop if CONFIG_CACHE_L2X0 is not set. If you want to
> > skip a bit of dead code here, you could make it an inline function and do
> >
> >         if (IS_ENABLED(CONFIG_CACHE_L2X0))
> >                 realview_setup_l2x0();
> >
> > Other than that, I still think we should avoid doing anything platform
> > specific here at all, and move it all into the l2x0_of_init function,
> > based on Russell's l2x0 patch series.
> 
> I just need a base branch I guess, then I can build on
> top of Russell's patches, it's just a matter of dependencies.

Ok.

> >> +     soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
> >> +     if (!soc_dev_attr)
> >> +             return;
> >> +     ret = of_property_read_string(root, "compatible",
> >> +                                   &soc_dev_attr->soc_id);
> >> +     if (ret)
> >> +             return;
> >> +     ret = of_property_read_string(root, "model", &soc_dev_attr->machine);
> >> +        if (ret)
> >> +             return;
> >> +     soc_dev_attr->family = "RealView";
> >> +     soc_dev = soc_device_register(soc_dev_attr);
> >> +     if (IS_ERR(soc_dev)) {
> >> +             kfree(soc_dev_attr);
> >> +             return;
> >> +     }
> >> +     parent = soc_device_to_device(soc_dev);
> >> +     ret = of_platform_populate(root, of_default_bus_match_table,
> >> +                                NULL, parent);
> >> +     if (ret) {
> >> +             pr_crit("could not populate device tree\n");
> >> +             return;
> >> +     }
> >
> > I wonder if there is a way to do this without having code in the platform.
> > I would hate it if we get to the point where each platform is completely
> > empty but still requires a copy of this code.
> 
> The question can be rephrased like this:
> Should we create drivers/soc?

I think we just did, not sure if the patches have made it into linux-next
already, but there were a couple of other platforms already that want this
directory.
 
> The structure of the SoC bus device is maybe a bit irritating but it
> has been hammered into the device core so now we have to live with
> it as it is.

We can always improve the code.

> > I also noticed that you pass the DT root here, which isn't actually
> > the intention of the soc device interface: you should pass the DT node
> > that has the on-chip devices but not the board-level (top-level) nodes
> > such as your fixed clocks.
> 
> Hm that's true. I introduced yet another set of compatible tuples
> like this:
> compatible = "simple-bus", "arm-realview-pb1176-soc"
> 
> It will, just like the reset driver generate a new batch of identical
> compatible-strings and documenation sets, but it does have the
> upside of clean separation.

Ok

> >> diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
> >> index 5bf7c3c3b301..5461c4401ed6 100644
> >> --- a/arch/arm/mm/Kconfig
> >> +++ b/arch/arm/mm/Kconfig
> >> @@ -928,7 +928,7 @@ config ARM_L1_CACHE_SHIFT
> >>  config ARM_DMA_MEM_BUFFERABLE
> >>       bool "Use non-cacheable memory for DMA" if (CPU_V6 || CPU_V6K) && !CPU_V7
> >>       depends on !(MACH_REALVIEW_PB1176 || REALVIEW_EB_ARM11MP || \
> >> -                  MACH_REALVIEW_PB11MP)
> >> +                  MACH_REALVIEW_PB11MP || REALVIEW_DT)
> >>       default y if CPU_V6 || CPU_V6K || CPU_V7
> >>       help
> >>         Historically, the kernel has used strongly ordered mappings to
> >
> > Do you have an explanation for why this is needed? I don't remember seeing
> > this before, but I guess it gets in the way of multiplatform support.
> > Is this just a performance optimization on realview, or is it actually
> > required?
> 
> I don't know that actually. And as DMA is likely only used
> on PCI I have no way of testing it either without such hardware.
> But I guess I can just leave it out for the time being.

Ok, let's try that. It would be good to have some insight from somebody
who understands the architecture though.

>From reading the code, I understand that

* On ARMv7, we always treat memory as bufferable, dma_alloc_coherent()
  uses L_PTE_MT_BUFFERABLE just like dma_alloc_writecombine does,
  and the mb/rmb/wmb macros flush the write buffers as needed.
* On ARMv5, we never treat dma_alloc_coherent() memory as bufferable,
  and the mb/rmb/wmb macros do not need to flush the write buffers.
* On ARMv6-only kernels we allow the user to pick the behavior at
  compile time.
* The code above for Realview was introduced by this commit:

commit 42c4dafe803dcad82980fd8b0831a89032156f93
Author: Catalin Marinas <catalin.marinas@arm.com>
Date:   Thu Jul 1 13:22:48 2010 +0100

    ARM: 6202/1: Do not ARM_DMA_MEM_BUFFERABLE on RealView boards with L210/L220
    
    RealView boards with certain revisions of the L210/L220 cache controller
    may have issues (hardware deadlock) with the mandatory barriers (DSB
    followed by an L2 cache sync) when ARM_DMA_MEM_BUFFERABLE is enabled.
    The patch disables ARM_DMA_MEM_BUFFERABLE for these boards.
    
    Tested-by: Linus Walleij <linus.walleij@stericsson.com>
    Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
    Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index fc1b2fa..101105e 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -813,6 +813,8 @@ config ARM_L1_CACHE_SHIFT
 
 config ARM_DMA_MEM_BUFFERABLE
        bool "Use non-cacheable memory for DMA" if CPU_V6 && !CPU_V7
+       depends on !(MACH_REALVIEW_PB1176 || REALVIEW_EB_ARM11MP || \
+                    MACH_REALVIEW_PB11MP)
        default y if CPU_V6 || CPU_V7
        help
          Historically, the kernel has used strongly ordered mappings to

This means that in a kernel that supports one of these three realview
variants, we shouldn't enable this option, but that in turn will break
any ARMv7 machine supported by the same kernel. This is bad. Not
setting ARM_DMA_MEM_BUFFERABLE will break with MACH_REALVIEW_DT on your
PB1176, which is also bad.

Maybe Catalin remembers the exact nature of the deadlock so we can come
up with another solution. If I read the original patches correctly, the
dsb() wasn't a problem, but the outer_sync() was. Maybe we can do
an alternative implementation for outer_sync() for the affected machines
that avoids the deadlock?

	Arnd
