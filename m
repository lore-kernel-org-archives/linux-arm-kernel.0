From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 17 Mar 2014 16:32:04 +0000
Subject: PL310 errata workarounds
In-Reply-To: <20140316152953.GX21483@n2100.arm.linux.org.uk>
References: <20140314144835.GP21483@n2100.arm.linux.org.uk>
 <20140316152953.GX21483@n2100.arm.linux.org.uk>
Message-ID: <20140317163204.GC21483@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 16, 2014 at 03:29:53PM +0000, Russell King - ARM Linux wrote:
> Okay, I've been going through the various initialisations of the L2x0
> cache code, and there's some really fun stuff going on here:

Here's OMAP4 - thankfully I have an OMAP4430 SDP to be able to investigate
what goes on here.  We have this code:

        /*
         * 16-way associativity, parity disabled
         * Way size - 32KB (es1.0)
         * Way size - 64KB (es2.0 +)
         */
        aux_ctrl = L310_AUX_CTRL_ASSOCIATIVITY_16 |
                   L310_AUX_CTRL_CACHE_REPLACE_RR |
                   L310_AUX_CTRL_NS_LOCKDOWN |
                   L310_AUX_CTRL_NS_INT_CTRL;

        if (omap_rev() == OMAP4430_REV_ES1_0) {
                aux_ctrl |= L310_AUX_CTRL_WAY_SIZE(2);
        } else {
                aux_ctrl |= L310_AUX_CTRL_WAY_SIZE(3) |
                            L310_AUX_CTRL_SHARED_OVERRIDE |
                            L310_AUX_CTRL_DATA_PREFETCH |
                            L310_AUX_CTRL_INSTR_PREFETCH |
                            L310_AUX_CTRL_EARLY_BRESP;
        }
        if (omap_rev() != OMAP4430_REV_ES1_0)
                omap_smc1(0x109, aux_ctrl);

        /* Enable PL310 L2 Cache controller */
        omap_smc1(0x102, 0x1);

        if (of_have_populated_dt())
                l2x0_of_init(aux_ctrl, L2X0_AUX_CTRL_MASK);
        else
                l2x0_init(l2cache_base, aux_ctrl, L2X0_AUX_CTRL_MASK);

Now, with my changes to add a "write_sec" hook into the code (to allow
secure-only registers to be written) we appear to be able to kill all
the above code on OMAP4430 ES2.2 - the following messages are from my
replacement L2x0 code with write_sec implemented for OMAP, and the
explicit SMC ops above commented out.

L2C: platform provided aux values match the hardware, so have no effect.  Please remove them.
L2C: platform provided aux values permit register corruption.
L2C-310 errata 727915 769419 enabled
L2C-310 cache controller enabled, 16 ways, 1024 kB
L2C-310: CACHE_ID 0x410000c4, AUX_CTRL 0x7e470000

The first message is produced by:
        old_aux = readl_relaxed(l2x0_base + L2X0_AUX_CTRL);
        if (old_aux != ((old_aux & aux_mask) | aux_val)) {
		pr_err("L2C: platform modifies aux control register: 0x%08x -> 0x%08x\n",
                       old_aux, (old_aux & aux_mask) | aux_val);
        } else if (aux_mask != ~0U && aux_val != 0) {
                pr_alert("L2C: platform provided aux values match the hardware, so have no effect.  Please remove them.\n");
        }

Later on I have:
        if (aux_val & aux_mask)
                pr_alert("L2C: platform provided aux values permit register corruption.\n");
...
        aux = readl_relaxed(l2x0_base + L2X0_AUX_CTRL);
        if (aux != ((aux & aux_mask) | aux_val))
                pr_err("L2C: DT/platform modifies aux control register: 0x%08x -> 0x%08x\n",
                       aux, (aux & aux_mask) | aux_val);

The two pr_alert()s are to provide sufficient motivation to people to
remove aux value configuration which actually matches the hardware.

Annoyingly I can't check the actual configuration registers because it
seems that someone along the way has broken ethernet (KSZ8851) in
recent kernels on this board... so I can't mount the fs with devmem2 on
to read the L2's registers.

I would try and quote some of the kernel messages for that, but: (a)
busybox grep doesn't understand the -<number> argument to give lines of
context, and (b) busybox less doesn't allow searching the kernel log...
So all I can say is that these kernel messages exist:

ks8851 spi1.0: message enable is 0
ks8851 spi1.0 eth0: revision 0, MAC 08:00:28:01:4d:c6, IRQ 194, has EEPROM

and dhcp fails - the ethernet interface doesn't even establish a link with
the connected switch... it just gets better and better.  Why is the modern
ARM kernel a perpetual struggle to make everything work.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
