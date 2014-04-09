From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 9 Apr 2014 17:01:09 +0100
Subject: [PATCH] ARM: reinsert ARCH_MULTI_V4 Kconfig option
In-Reply-To: <5844640.QRALKyBQaa@wuerfel>
References: <1386922149-4561-1-git-send-email-jonas.jensen@gmail.com>
 <20140409151326.GY29751@pengutronix.de>
 <20140409152711.GT16119@n2100.arm.linux.org.uk> <5844640.QRALKyBQaa@wuerfel>
Message-ID: <20140409160108.GU16119@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 09, 2014 at 05:50:57PM +0200, Arnd Bergmann wrote:
> On Wednesday 09 April 2014 16:27:11 Russell King - ARM Linux wrote:
> > If it's called from ARM code, then \reg will contain a 4-byte aligned
> > address.  If it's called from Thumb code, \reg will contain a 2-byte
> > aligned address with bit 0 *always* set.
> 
> Right, that is the assumption.
> 
> > So, with the code originally quoted above, if the helper is called from
> > thumb code, and CONFIG_CPU_32v4 is enabled, then we end up falling past
> > the moveq to the "b ." and entering an infinite loop.
> 
> As Uwe said, that "b ." was not meant to be in the patch used for
> submission, it was to check what goes wrong when running this code
> on ARMv4 -- either crash user space or hang in an infinite loop.
> I forgot what the result of that experiment was.
> 
> The trouble is that this code:
> 
>        .macro  usr_ret, reg
> #ifdef CONFIG_ARM_THUMB
> #ifdef CONFIG_CPU_32v4
> 	tst     \reg, #3
> 	moveq   pc, \reg
> #endif
>         bx      \reg
> #else
> 	mov	pc, \reg
> #endif
> 	.endm
> 
> for some reason does the wrong thing running on ARMv4 (fa526) with non-thumb
> user space when both CONFIG_CPU_32v4 and CONFIG_ARM_THUMB are enabled:
> it still tries to do the 'bx' and triggers an invalid opcode exception.

I assume this has been discussed in off-list (maybe on some irc channel
somewhere), because there's nothing on-list apart from these emails...

So, let's repeat the debugging which probably has already occured, but
this time on-list...

It would be useful to see the register state from the undefined
instruction exception.  That needs this patch, CONFIG_DEBUG_USER in the
kernel config enabled, and user_debug=1 passed on the kernel command
line.

diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 172ee18ff124..abd2fc067736 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -445,6 +445,7 @@ asmlinkage void __exception do_undefinstr(struct pt_regs *regs)
 	if (user_debug & UDBG_UNDEFINED) {
 		printk(KERN_INFO "%s (%d): undefined instruction: pc=%p\n",
 			current->comm, task_pid_nr(current), pc);
+		__show_regs(regs);
 		dump_instr(KERN_INFO, regs);
 	}
 #endif


-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
