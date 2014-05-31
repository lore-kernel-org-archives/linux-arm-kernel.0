From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 31 May 2014 20:31:32 +0200
Subject: [PATCH v2 0/7] Fix backtrace support in THUMB2 mode
In-Reply-To: <1401469191-29232-1-git-send-email-nikolay.borisov@arm.com>
References: <1401469191-29232-1-git-send-email-nikolay.borisov@arm.com>
Message-ID: <5507361.VIWsBiqp2f@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 30 May 2014 17:59:44 Nikolay Borisov wrote:
> From: Nikolay Borisov <Nikolay.Borisov@arm.com>
> 
> Currently all the code which deals with backtrace support assumes that R11
> is the frame-pointer. While this is the case for ARM mode and is explicitly
> documented in the AAPCS, this is not the case for THUMB2 mode.
> 
> There is no official document requiring that R11 has to be the frame pointer
> and GCC uses R7 as FP and given that R7's usage is so intertwined within GCC's
> mechanics it is unlikely to change, so fixing backtrace in THUMB2 mode seems
> in order.
> 
> This patch series rectifies the problem by first fixing the
> thread_save_fp macro to reference the correct register. Furthermore, there
> a lot of repetetive sequences of code such as :
> 
> stackframe.fp = pt_regs->ARM_fp
> stackframe.lr = pt_regs->ARM_lr
> 
> so introducing a function arm_get_current_stack_frame which both
> hides this repetition and also utilizes teh frame_pointer(regs) macro
> to reference the correct register depending on the mode.
> 
> Finally, change all the call sites so that they utilize the new routine.

Sorry for the stupid question, but does your series relate to the
#warning "TODO: return_address should use unwind tables" that we see
all the time in arch/arm/kernel/return_address.c?

If I remember the story correctly, the problem is that so far we could
never use the frame pointer in thumb2 mode, and nobody has implemented
a version of that function using the arm unwinder.

Are we now able to use the frame pointer after all?

	Arnd
