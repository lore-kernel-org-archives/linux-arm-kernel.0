From: tixy@yxit.co.uk (Tixy)
Date: Fri, 15 Jun 2012 14:36:25 +0100
Subject: [PATCH] kprobes: only test 'sub pc, pc, #1b-2b+8-2' on ARMv6
In-Reply-To: <CAH+eYFDhXCJRrgX+KTX0bPU89DyGfmb+bD8Cvm-3_iyCuk_==w@mail.gmail.com>
References: <1339502874-9104-1-git-send-email-rabin.vincent@stericsson.com>
 <1339571937.2759.13.camel@computer2.home>
 <CAH+eYFDhXCJRrgX+KTX0bPU89DyGfmb+bD8Cvm-3_iyCuk_==w@mail.gmail.com>
Message-ID: <1339767385.2961.7.camel@computer2.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-06-15 at 15:33 +0530, Rabin Vincent wrote:
> On Wed, Jun 13, 2012 at 12:48 PM, Tixy <tixy@yxit.co.uk> wrote:
> > I agree with this analysis. However, it is possible to have a kernel
> > built to support both ARM v6 and v7 (e.g OMAP2+) in which case
> > __LINUX_ARM_ARCH__ == 6 will be true but the code could be running on v7
> > hardware. Therefore a compile time check for ARM architecture isn't
> > sufficient to fix the problem.
> 
> How about the following check instead?  At least one other place uses
> it.

Can't you point out the other place which uses it, I couldn't find it.

The proposed patch below would work, but feels slightly off as it
assumes that no one will build a kernel to support V6 and V8, but
without V7. That does seem highly unlikely though, so I personally
wouldn't object to the patch.

-- 
Tixy

> 
> 8<---
> From f1e1794c0c12e39e99d4169c934fd43feb889d7b Mon Sep 17 00:00:00 2001
> From: Rabin Vincent <rabin.vincent@stericsson.com>
> Date: Mon, 11 Jun 2012 16:55:37 +0530
> Subject: [PATCH] ARM: kprobes: only test 'sub pc, pc, #1b-2b+8-2' on ARMv6
> 
> 'sub pc, pc, #1b-2b+8-2' results in address<1:0> == '10'.
> 
> sub pc, pc, #const (== ADR pc, #const) performs an interworking branch
> (BXWritePC()) on ARMv7+ and a simple branch (BranchWritePC()) on earlier
> versions.
> 
> In ARM state, BXWritePC() is UNPREDICTABLE when address<1:0> == '10'.
> 
> In ARM state on ARMv6+, BranchWritePC() ignores address<1:0>.  Before
> ARMv6, BranchWritePC() is UNPREDICTABLE if address<1:0> != '00'
> 
> So the instruction is UNPREDICTABLE both before and after v6.
> 
> Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
> ---
>  arch/arm/kernel/kprobes-test-arm.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/kernel/kprobes-test-arm.c
> b/arch/arm/kernel/kprobes-test-arm.c
> index ba32b39..38c1a3b 100644
> --- a/arch/arm/kernel/kprobes-test-arm.c
> +++ b/arch/arm/kernel/kprobes-test-arm.c
> @@ -187,8 +187,8 @@ void kprobe_arm_test_cases(void)
>  	TEST_BF_R ("mov	pc, r",0,2f,"")
>  	TEST_BF_RR("mov	pc, r",0,2f,", asl r",1,0,"")
>  	TEST_BB(   "sub	pc, pc, #1b-2b+8")
> -#if __LINUX_ARM_ARCH__ >= 6
> -	TEST_BB(   "sub	pc, pc, #1b-2b+8-2") /* UNPREDICTABLE before ARMv6 */
> +#if __LINUX_ARM_ARCH__ == 6 && !defined(CONFIG_CPU_V7)
> +	TEST_BB(   "sub	pc, pc, #1b-2b+8-2") /* UNPREDICTABLE before and
> after ARMv6 */
>  #endif
>  	TEST_BB_R( "sub	pc, pc, r",14, 1f-2f+8,"")
>  	TEST_BB_R( "rsb	pc, r",14,1f-2f+8,", pc")
