From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Thu, 18 Feb 2016 14:21:16 +0000
Subject: [PATCH 9/9] ARM: fix kprobe test with CONFIG_CPU_32v3
In-Reply-To: <1455804123-2526139-10-git-send-email-arnd@arndb.de>
References: <1455804123-2526139-1-git-send-email-arnd@arndb.de>
 <1455804123-2526139-10-git-send-email-arnd@arndb.de>
Message-ID: <1455805276.3036.3.camel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2016-02-18 at 15:02 +0100, Arnd Bergmann wrote:
> ARMv3 did not have 16-bit load/store or 32-bit multiply instructions,
> so building the kprobe test code fails with lots of warnings about
> these:
> 
> /tmp/ccI4SKHx.s:19585: Error: selected processor does not support ARM mode `umull r0,r1,r2,r3'
> /tmp/ccI4SKHx.s:19617: Error: selected processor does not support ARM mode `umullls r7,r8,r9,r10'
> /tmp/ccI4SKHx.s:19645: Error: selected processor does not support ARM mode `umull lr,r12,r11,r13'
> /tmp/ccI4SKHx.s:19727: Error: selected processor does not support ARM mode `umulls r0,r1,r2,r3'
> ...
> /tmp/ccI4SKHx.s:21273: Error: selected processor does not support ARM mode `strh r0,[r1,-r2]'
> /tmp/ccI4SKHx.s:21309: Error: selected processor does not support ARM mode `streqh r14,[r11,r12]'
> /tmp/ccI4SKHx.s:21333: Error: selected processor does not support ARM mode `streqh r14,[r13,r12]'
> 
> This puts all the affected instructions inside an #ifdef section,
> like we do for the other architecture levels.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

I was about to say that I didn't know that we supported ARMv3 then got a
feeling of deja vu :-) [1]

Acked-by: Jon Medhurst <tixy@linaro.org>

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-March/242997.html

>  arch/arm/probes/kprobes/test-arm.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/probes/kprobes/test-arm.c b/arch/arm/probes/kprobes/test-arm.c
> index 8866aedfdea2..4e8511f0582d 100644
> --- a/arch/arm/probes/kprobes/test-arm.c
> +++ b/arch/arm/probes/kprobes/test-arm.c
> @@ -391,6 +391,7 @@ void kprobe_arm_test_cases(void)
>  	TEST_UNSUPPORTED(__inst_arm(0xe0700090) " @ undef")
>  	TEST_UNSUPPORTED(__inst_arm(0xe07fff9f) " @ undef")
>  
> +#if __LINUX_ARM_ARCH__ >= 4
>  	TEST_RR(  "umull	r0, r1, r",2, VAL1,", r",3, VAL2,"")
>  	TEST_RR(  "umullls	r7, r8, r",9, VAL2,", r",10, VAL1,"")
>  	TEST_R(   "umull	lr, r12, r",11,VAL3,", r13")
> @@ -436,6 +437,7 @@ void kprobe_arm_test_cases(void)
>  	TEST_UNSUPPORTED(__inst_arm(0xe0f0f392) " @ smlals r0, pc, r2, r3")
>  	TEST_UNSUPPORTED(__inst_arm(0xe0f0139f) " @ smlals r0, r1, pc, r3")
>  	TEST_UNSUPPORTED(__inst_arm(0xe0f01f92) " @ smlals r0, r1, r2, pc")
> +#endif
>  
>  	TEST_GROUP("Synchronization primitives")
>  
> @@ -478,7 +480,7 @@ void kprobe_arm_test_cases(void)
>  	TEST_UNSUPPORTED("ldrexh	r2, [sp]")
>  #endif
>  	TEST_GROUP("Extra load/store instructions")
> -
> +#if __LINUX_ARM_ARCH__ >= 4
>  	TEST_RPR(  "strh	r",0, VAL1,", [r",1, 48,", -r",2, 24,"]")
>  	TEST_RPR(  "streqh	r",14,VAL2,", [r",11,0, ", r",12, 48,"]")
>  	TEST_UNSUPPORTED(  "streqh	r14, [r13, r12]")
> @@ -560,6 +562,7 @@ void kprobe_arm_test_cases(void)
>  	TEST(      "ldrsh	r0, [pc, #0]")
>  	TEST_UNSUPPORTED(__inst_arm(0xe1ffc3f0) "	@ ldrsh r12, [pc, #48]!")
>  	TEST_UNSUPPORTED(__inst_arm(0xe0d9f3f0) "	@ ldrsh pc, [r9], #48")
> +#endif
>  
>  #if __LINUX_ARM_ARCH__ >= 7
>  	TEST_UNSUPPORTED("strht	r1, [r2], r3")
