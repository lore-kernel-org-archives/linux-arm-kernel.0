From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 17 Mar 2014 16:51:13 +0000
Subject: PL310 errata workarounds
In-Reply-To: <20140317163204.GC21483@n2100.arm.linux.org.uk>
References: <20140314144835.GP21483@n2100.arm.linux.org.uk>
 <20140316152953.GX21483@n2100.arm.linux.org.uk>
 <20140317163204.GC21483@n2100.arm.linux.org.uk>
Message-ID: <20140317165113.GE21483@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 17, 2014 at 04:32:04PM +0000, Russell King - ARM Linux wrote:
> On Sun, Mar 16, 2014 at 03:29:53PM +0000, Russell King - ARM Linux wrote:
> > Okay, I've been going through the various initialisations of the L2x0
> > cache code, and there's some really fun stuff going on here:
> 
> Here's OMAP4 - thankfully I have an OMAP4430 SDP to be able to investigate
> what goes on here.  We have this code:
> 
>         /*
>          * 16-way associativity, parity disabled
>          * Way size - 32KB (es1.0)
>          * Way size - 64KB (es2.0 +)
>          */
>         aux_ctrl = L310_AUX_CTRL_ASSOCIATIVITY_16 |
>                    L310_AUX_CTRL_CACHE_REPLACE_RR |
>                    L310_AUX_CTRL_NS_LOCKDOWN |
>                    L310_AUX_CTRL_NS_INT_CTRL;
> 
>         if (omap_rev() == OMAP4430_REV_ES1_0) {
>                 aux_ctrl |= L310_AUX_CTRL_WAY_SIZE(2);
>         } else {
>                 aux_ctrl |= L310_AUX_CTRL_WAY_SIZE(3) |
>                             L310_AUX_CTRL_SHARED_OVERRIDE |
>                             L310_AUX_CTRL_DATA_PREFETCH |
>                             L310_AUX_CTRL_INSTR_PREFETCH |
>                             L310_AUX_CTRL_EARLY_BRESP;
>         }
>         if (omap_rev() != OMAP4430_REV_ES1_0)
>                 omap_smc1(0x109, aux_ctrl);
> 
>         /* Enable PL310 L2 Cache controller */
>         omap_smc1(0x102, 0x1);
> 
>         if (of_have_populated_dt())
>                 l2x0_of_init(aux_ctrl, L2X0_AUX_CTRL_MASK);
>         else
>                 l2x0_init(l2cache_base, aux_ctrl, L2X0_AUX_CTRL_MASK);
> 
> Now, with my changes to add a "write_sec" hook into the code (to allow
> secure-only registers to be written) we appear to be able to kill all
> the above code on OMAP4430 ES2.2 - the following messages are from my
> replacement L2x0 code with write_sec implemented for OMAP, and the
> explicit SMC ops above commented out.
> 
> L2C: platform provided aux values match the hardware, so have no effect.  Please remove them.
> L2C: platform provided aux values permit register corruption.
> L2C-310 errata 727915 769419 enabled
> L2C-310 cache controller enabled, 16 ways, 1024 kB
> L2C-310: CACHE_ID 0x410000c4, AUX_CTRL 0x7e470000

Damn it, I keep forgetting to build then install - the change to make
zinstall not do a build keeps biting me.

When the kernel boots, AUX_CTRL is set in hardware to 0x0e070000, which
is basically as close as the hardware strapping can get it.  The rest of
the bits must be modified by software.  So we /do/ need to modify this
register.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
