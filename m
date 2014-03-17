From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 17 Mar 2014 14:40:57 +0000
Subject: PL310 errata workarounds
In-Reply-To: <CAL_JsqLDun2VkCFK9Fec6n38bNz2w9mscPdXcGYeLiZtiXkVDg@mail.gmail.com>
References: <20140314144835.GP21483@n2100.arm.linux.org.uk>
 <20140316152953.GX21483@n2100.arm.linux.org.uk>
 <CAL_JsqLDun2VkCFK9Fec6n38bNz2w9mscPdXcGYeLiZtiXkVDg@mail.gmail.com>
Message-ID: <20140317144057.GA21483@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 17, 2014 at 09:00:03AM -0500, Rob Herring wrote:
> On Sun, Mar 16, 2014 at 10:29 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > Okay, I've been going through the various initialisations of the L2x0
> > cache code, and there's some really fun stuff going on here:
> >
> > arch/arm/mach-imx/system.c:
> >         /* Configure the L2 PREFETCH and POWER registers */
> >         val = readl_relaxed(l2x0_base + L2X0_PREFETCH_CTRL);
> >         val |= 0x70800000;
> 
> I wonder what is the desired setting for "Force write allocate" since
> this fails to mask bit 24. They are probably really wanting to set bit
> 22.

No, this is the prefetch control register, not the auxillary control
register.  Bits 30 and 23 here are to do with double line fills, and
29 and 28 are to do with I/D prefetching.

> > arch/arm/mach-zynq/common.c:
> > static void __init zynq_init_machine(void)
> > {
> >         /*
> >          * 64KB way size, 8-way associativity, parity disabled
> >          */
> >         l2x0_of_init(0x02060000, 0xF0F0FFFF);
> >
> > Oh look, same problem again.
> 
> This all seems unnecessary. All these values should be correct at
> reset and this should be a nop unless the h/w is configured
> incorrectly. Surely h/w folks can tie off WAYSIZE correctly... It is
> also keeping shared attrib override disabled which I believe is
> generally wrong, and is masking 1 bit of force write allocate, but not
> the other.

Yes, they /should/ so that the register starts of appropriately configured,
but have they actually done that... the fact this stuff exists suggests
that they haven't, because if the values were correct, calling
l2x0_of_init() with "0UL, ~0UL" would result in the reset value being used.
That's surely the path of least resistance, because you don't have to go
digging through the documentation to find the values to then write code
to mask/set these values appropriately.

> ePAPR already defines standard properties for cache layout which could
> be used here if really needed.

I'm adding those right now to this code - there's no excuse not to given
this mess - at least we can prevent any future additions of stuff like
this.
> 
> > arch/arm/mach-ux500/cache-l2x0.c:
> >         /* DBx540's L2 has 128KB way size */
> >         if (cpu_is_ux540_family())
> >                 /* 128KB way size */
> >                 aux_val |= (0x4 << L2X0_AUX_CTRL_WAY_SIZE_SHIFT);
> >         else
> >                 /* 64KB way size */
> >                 aux_val |= (0x3 << L2X0_AUX_CTRL_WAY_SIZE_SHIFT);
> >
> >         /* 64KB way size, 8 way associativity, force WA */
> >         if (of_have_populated_dt())
> >                 l2x0_of_init(aux_val, 0xc0000fff);
> >         else
> >                 l2x0_init(l2x0_base, aux_val, 0xc0000fff);
> >
> > Okay, this has to cope with non-DT as well, but for the DT case, it is
> > again the same damned problem.
> 
> This one is interesting in that it has to undo way locking done by the
> bootloader. So the bootloader has setup the L2 to some extent, but
> didn't configure aux ctrl already?
> 
> The way unlocking could be done unconditionally in the core code
> perhaps. There could be issues on non-secure platforms though.

What's more interesting here is that it boots in non-secure mode, and the
platform doesn't have access to the secure monitor to be able to change
any of the L2 configuration registers - this includes the auxillary
control register.  So the above is just trying (for some odd reason) to
supply details to the L2 code that it could just as well retrieve from
the readable auxillary control register (and would use given the correct
masks.)

As for the lock registers, as this code is already writing to those
registers, we can assume that the aux control register is set to allow
non-secure access to these - so we can kill this if we make the L2
code clear these registers if the NS lock access bit is set, even if
the cache is enabled.

> > arch/arm/mach-nomadik/cpu-8815.c:
> > #ifdef CONFIG_CACHE_L2X0
> >         /* At full speed latency must be >=2, so 0x249 in low bits */
> >         l2x0_of_init(0x00730249, 0xfe000fff);
> > #endif
> >
> > Do we actually end up with 0x249 in the low bits - because the fff in
> > the mask field preserves the values already in the aux register.
> > Moreover, don't we have DT properties to specify this information already,
> > so why isn't nomadik using them?  Nomadik is using a DT compatible string
> > of "arm,l210-cache", which has the properties "arm,tag-latency",
> > "arm,data-latency", "arm,dirty-latency" which allow that 0x249 to be
> > specified.
> 
> l2x0_of_setup clears those mask bits if the DT properties are present,
> so it will work in that case. But otherwise, yes this is broken.

"if those properties are present" is the key thing here.  They aren't:

        L2: l2-cache {
                compatible = "arm,l210-cache";
                reg = <0x10210000 0x1000>;
                interrupt-parent = <&vica>;
                interrupts = <30>;
                cache-unified;
                cache-level = <2>;
        };

So what you end up with is an OR of these values and whatever happened
to be in the register at the time.  In other words... a total mess, just
like much of the other code in this area.

> I think we really should have pushed that all aux_ctrl setup go into
> the bootloader. It's really not that different from errata work-around
> setup. It doesn't have the same race condition as enabling errata
> work-arounds may have, but does have the same secure vs. non-secure
> setup issue.
> 
> Keeping the aux val/mask parameters in the DT case was definitely a
> mistake. DT or not, it is a fragile and error prone interface of magic
> values and we should have forced its removal when we had the chance.

Given that caches have standard ePAR parameters, we should have at least
insisted that these parameters were part of the DT specification.

We say in the DT binding docs that cache-unified is required.  However,
these omit it:
- arch/arm/boot/dts/marco.dtsi
- arch/arm/boot/dts/vexpress-v2p-ca5s.dts
- arch/arm/boot/dts/prima2.dtsi (omits cache-level as well)

What good is it having binding documentation when we don't check (by
some means, either by review or by code checking) that the DT files are
actually correct?  The fact that we have _one_ which gets this wrong
now means that "cache-unified" is completely useless should we ever
need to parse it in the future.  We might have decided to omit it
entirely.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
