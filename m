From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 10 Dec 2013 22:25:50 +0100
Subject: oops broken on v7-M
Message-ID: <20131210212550.GF18888@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

__show_regs does among other things the following:

        printk("Flags: %s  IRQs o%s  FIQs o%s  Mode %s  ISA %s  Segment %s\n",
                buf, interrupts_enabled(regs) ? "n" : "ff",
                fast_interrupts_enabled(regs) ? "n" : "ff",
                processor_modes[processor_mode(regs)],
                isa_modes[isa_mode(regs)],
                get_fs() == get_ds() ? "kernel" : "user");

with isa_mode being defined as follows:

	#define isa_mode(regs) \
		((((regs)->ARM_cpsr & PSR_J_BIT) >> 23) | \ 
		 (((regs)->ARM_cpsr & PSR_T_BIT) >> 5))

with

	#define V4_PSR_T_BIT    0x00000020      /* >= V4T, but not V7M */
	#define V7M_PSR_T_BIT   0x01000000
	#if defined(__KERNEL__) && defined(CONFIG_CPU_V7M)
	#define PSR_T_BIT       V7M_PSR_T_BIT
	#else
	/* for compatibility */
	#define PSR_T_BIT       V4_PSR_T_BIT
	#endif          
	...
	#define PSR_J_BIT       0x01000000      /* >= V5J, but not V7M */

so on !CPU_V7M isa_mode maps nicely into [0 .. 3], on CPU_V7M however it
maps to either 0x80000 or 0x80002 which both are bad values for indexing
into isa_modes[].

The possibilities to fix that are:
 1) #define isa_mode(regs) to be 1
    This makes all memory accesses fine, but still the other bits printed
    are bogus (IRQs, FIQs, Mode) as before.
 2) just do:
    printk("xPSR: %08x\n", regs->ARM_cpsr);
    instead of the printk above for CPU_V7M. This is informative, but an
    expert output.
 3) don't hardcode 23 and 5, but calculate these depending on PSR_J_BIT
    and PSR_T_BIT.

I think I will go for b) + c), but not today any more. What do you
think?

Best regards
Uwe


-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
