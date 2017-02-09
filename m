From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 9 Feb 2017 16:29:56 +0000
Subject: [PATCHv3] arm: ftrace: Adds support for
 CONFIG_DYNAMIC_FTRACE_WITH_REGS
In-Reply-To: <1486508275-18449-1-git-send-email-abelvesa@linux.com>
References: <1486508275-18449-1-git-send-email-abelvesa@linux.com>
Message-ID: <20170209162956.GH27312@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 07, 2017 at 10:57:55PM +0000, Abel Vesa wrote:
> +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> +
> +.macro __ftrace_regs_caller
> +
> +	add 	ip, sp, #4	@ move in IP the value of SP as it was
> +				@ before the push {lr} of the mcount mechanism
> +	stmdb	sp!, {ip,lr,pc}
> +	stmdb	sp!, {r0-r11,lr}
> +
> +	@ stack content at this point:
> +	@ 0  4          44    48   52       56   60   64
> +	@ R0 | R1 | ... | R11 | LR | SP + 4 | LR | PC | previous LR |

How important is this to be close to "struct pt_regs" ?  Do we care about
r12 being "wrong" ?  The other issue is that pt_regs is actually 72
bytes in size, not 68 bytes.  So, does that mean we end up inappropriately
leaking some of the kernel stack to userspace through ftrace?

It's possible to save all the registers like this if we need to provide
a complete picture of the register set at function entry:

	str	ip, [sp, #-16]!
	add	ip, sp, #20
	stmia	sp, {ip, lr, pc}
	stmdb	sp!, {r0 - r11}

However, is that even correct - don't we want pt_regs' LR and PC to be
related to the function call itself?  The "previous LR" as you describe
it is where the called function (the one that is being traced) will
return to.  The current LR at this point is the address within the
traced function.  So actually I think this is more strictly correct, if
I'm understanding the intention here correctly:

	str	ip, [sp, #S_IP - PT_REGS_SIZE]!	@ save current IP
	ldr	ip, [sp, #PT_REGS_SIZE - S_IP]	@ get LR at traced function entry
	str	lr, [sp, #S_PC - S_IP]		@ save current LR as PC
	str	ip, [sp, #S_LR - S_IP]		@ save traced function return
	add	ip, sp, #PT_REGS_SIZE - S_IP + 4
	str	ip, [sp, #S_SP - SP_IP]		@ save stack pointer at function entry
	stmdb	sp!, {r0 - r11}
	@ clear CPSR and old_r0 words
	mov	r3, #0
	str	r3, [sp, #S_PSR]
	str	r3, [sp, #S_OLD_R0]

However, that has the side effect of misaligning the stack (the stack
needs to be aligned to 8 bytes).  So, if we decide we don't care about
the saved LR value (except as a mechanism to preserve it across the
call into the ftrace code):

	str	ip, [sp, #S_IP - PT_REGS_SIZE + 4]!
	str	lr, [sp, #S_PC - S_IP]
	ldr	lr, [sp, #PT_REGS_SIZE - 4 - S_IP]
	add	ip, sp, #PT_REGS_SIZE - S_IP
	stmib	sp, {ip, lr}
	stmdb	sp!, {r0 - r11}
	@ clear CPSR and old_r0 words
	mov	r3, #0
	str	r3, [sp, #S_PSR]
	str	r3, [sp, #S_OLD_R0]

and the return would be:

	ldmia	sp, {r0 - pc}

That all said - maybe someone from the ftrace community can comment on
how much of pt_regs is actually necessary here?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
