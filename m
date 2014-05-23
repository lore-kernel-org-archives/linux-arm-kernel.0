From: will.deacon@arm.com (Will Deacon)
Date: Fri, 23 May 2014 17:55:54 +0100
Subject: [PATCH RESEND 0/7] Fix backtrace support in THUMB2 mode
In-Reply-To: <1400837196-22339-1-git-send-email-Nikolay.Borisov@arm.com>
References: <1400837196-22339-1-git-send-email-Nikolay.Borisov@arm.com>
Message-ID: <20140523165554.GB22176@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 23, 2014 at 10:26:29AM +0100, Nikolay Borisov wrote:
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

For everything apart from patch 2 (where Robert pointed out that
arm_get_current_stackframe would be better inline):

  Acked-by: Will Deacon <will.deacon@arm.com>

Will
