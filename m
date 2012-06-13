From: tixy@yxit.co.uk (Tixy)
Date: Wed, 13 Jun 2012 08:18:57 +0100
Subject: [PATCH] kprobes: only test 'sub pc, pc, #1b-2b+8-2' on ARMv6
In-Reply-To: <1339502874-9104-1-git-send-email-rabin.vincent@stericsson.com>
References: <1339502874-9104-1-git-send-email-rabin.vincent@stericsson.com>
Message-ID: <1339571937.2759.13.camel@computer2.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-06-12 at 17:37 +0530, Rabin Vincent wrote:
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

I agree with this analysis. However, it is possible to have a kernel
built to support both ARM v6 and v7 (e.g OMAP2+) in which case
__LINUX_ARM_ARCH__ == 6 will be true but the code could be running on v7
hardware. Therefore a compile time check for ARM architecture isn't
sufficient to fix the problem.

I can only suggest to remove the test case. That feels a bit wrong, but
I'm not sure it's worth the effort to get the test code infrastructure
to support runtime checks for architecture version.

-- 
Tixy

> Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
> ---
>  arch/arm/kernel/kprobes-test-arm.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/kernel/kprobes-test-arm.c b/arch/arm/kernel/kprobes-test-arm.c
> index ba32b39..6c926d5 100644
> --- a/arch/arm/kernel/kprobes-test-arm.c
> +++ b/arch/arm/kernel/kprobes-test-arm.c
> @@ -187,8 +187,8 @@ void kprobe_arm_test_cases(void)
>  	TEST_BF_R ("mov	pc, r",0,2f,"")
>  	TEST_BF_RR("mov	pc, r",0,2f,", asl r",1,0,"")
>  	TEST_BB(   "sub	pc, pc, #1b-2b+8")
> -#if __LINUX_ARM_ARCH__ >= 6
> -	TEST_BB(   "sub	pc, pc, #1b-2b+8-2") /* UNPREDICTABLE before ARMv6 */
> +#if __LINUX_ARM_ARCH__ == 6
> +	TEST_BB(   "sub	pc, pc, #1b-2b+8-2") /* UNPREDICTABLE before and after ARMv6 */
>  #endif
>  	TEST_BB_R( "sub	pc, pc, r",14, 1f-2f+8,"")
>  	TEST_BB_R( "rsb	pc, r",14,1f-2f+8,", pc")
