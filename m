From: viktor.rosendahl@nokia.com (Viktor Rosendahl)
Date: Tue, 29 Mar 2011 16:46:15 +0300
Subject: [PATCH] Fix ldrd/strd emulation for kprobes/ARM
In-Reply-To: <1301403301.2519.125.camel@computer2.home>
References: <1301087944.2744.85.camel@computer2.home>	
	<1301327765-6996-1-git-send-email-viktor.rosendahl@nokia.com>
	<1301403301.2519.125.camel@computer2.home>
Message-ID: <4D91E2A7.4040304@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/29/2011 03:55 PM, ext Tixy wrote:

> From looking at them, the changes look functionally
> correct though. I do have a suggestion for slight change, see inline
> comments below...
>

>
> If the variables rnv and rmv were declared as registers then we could
> avoid 3 stores and 3 loads of stack values. This would require changing
> the the assembler as well, e.g. something like this...
>
> 	register long rnv asm("r0");
> 	register long rmv asm("r1");
> 	rnv = (rn == 15) ? ppc : regs->uregs[rn];
> 	rmv = (rm == 15) ? ppc : regs->uregs[rm];
>
> 	__asm__ __volatile__ (
> 		"msr	cpsr_fs, %[cpsr]\n\t"
> 		"mov	lr, pc		\n\t"
> 		"mov	pc, %[i_fn]	\n\t"
> 		"str	r2, %[rd0]	\n\t"
> 		"str	r3, %[rd1]	\n\t"
> 		:       "=r" (rnv),
> 		  [rd0] "=m" (regs->uregs[rd]),
> 		  [rd1] "=m" (regs->uregs[rd+1])
> 		:        "0" (rnv),
> 		         "r" (rmv),
> 		  [cpsr] "r" (regs->ARM_cpsr),
> 		  [i_fn] "r" (i_fn)
> 		: "r2", "r3", "lr", "cc"
>   	);
> 	if (rn != 15)
> 		regs->uregs[rn] = rnv;
>

My patch was about fixing the correctness of the emulation regarding the 
use of the PC register as Rn. To my understanding, this is a performance 
optimization that will optimize the register/stack usage.

I am not opposed to this in any way but I really think that fixing the 
correctness and optimizing the performance should be in separate 
patches. Also, I already submitted my patch to RMK's patch system, so 
you are a bit late :)

Like I have said before, my suspicion is that most of the kprobe 
slowdown will come from the handling of illegal instruction exceptions 
when the probe is hit and at the end of the single stepping, so I don't 
think 3 loads and 3 stores in the emulation will do that much difference.

My suggestion is for you to submit a separate patch that sits on top of 
my patch 6853/1, if you want to change this code.

best regards,

Viktor
