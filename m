From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 28 Nov 2011 11:29:16 -0500 (EST)
Subject: [PATCH] ARM: kprobes: Change testcase with unpredictable STRD
 instruction
In-Reply-To: <1322395885.2408.1.camel@computer2>
References: <1322395885.2408.1.camel@computer2>
Message-ID: <alpine.LFD.2.02.1111281128440.17904@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 27 Nov 2011, Tixy wrote:

> There is a kprobes testcase for the instruction "strd r2, [r3], r4".
> This has unpredictable behaviour as it uses r3 for register writeback
> addressing and also stores it to memory.
> 
> On a cortex A9, this testcase would fail because the instruction writes
> the updated value of r3 to memory, whereas the kprobes emulation code
> writes the original value.
> 
> Fix this by changing testcase to used r5 instead of r3.
> 
> Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>

Acked-by: Nicolas Pitre <nico@linaro.org>


> ---
>  arch/arm/kernel/kprobes-test-arm.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/kernel/kprobes-test-arm.c b/arch/arm/kernel/kprobes-test-arm.c
> index fc82de8..edf9ad8 100644
> --- a/arch/arm/kernel/kprobes-test-arm.c
> +++ b/arch/arm/kernel/kprobes-test-arm.c
> @@ -550,7 +550,7 @@ void kprobe_arm_test_cases(void)
>  	TEST_RPR(  "strccd	r",8, VAL2,", [r",13,0, ", r",12,48,"]")
>  	TEST_RPR(  "strd	r",4, VAL1,", [r",2, 24,", r",3, 48,"]!")
>  	TEST_RPR(  "strcsd	r",12,VAL2,", [r",11,48,", -r",10,24,"]!")
> -	TEST_RPR(  "strd	r",2, VAL1,", [r",3, 24,"], r",4,48,"")
> +	TEST_RPR(  "strd	r",2, VAL1,", [r",5, 24,"], r",4,48,"")
>  	TEST_RPR(  "strd	r",10,VAL2,", [r",9, 48,"], -r",7,24,"")
>  	TEST_UNSUPPORTED(".word 0xe1afc0fa	@ strd r12, [pc, r10]!")
>  
> -- 
> 1.7.2.5
> 
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
