From: dave.long@linaro.org (David Long)
Date: Mon, 24 Mar 2014 15:49:28 -0400
Subject: [PATCH 2/3] ARM: kprobes: Disallow instructions with PC and
 register specified shift
In-Reply-To: <1394556894-18592-3-git-send-email-tixy@linaro.org>
References: <1394556894-18592-1-git-send-email-tixy@linaro.org>
 <1394556894-18592-3-git-send-email-tixy@linaro.org>
Message-ID: <53308C48.3070509@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/11/14 12:54, Jon Medhurst wrote:
> ARM data processing instructions which have a register specified shift
> are defined as UNPREDICTABLE if PC is used for any register, not just
> the shift value as the code was previous assuming. This issue manifests
> on A15 devices as either test case failures or undefined instructions
> aborts.
>
> Reported-by: David Long <dave.long@linaro.org>
> Signed-off-by: Jon Medhurst <tixy@linaro.org>
> ---
>   arch/arm/kernel/kprobes-test-arm.c |   25 +++++++++++++------------
>   arch/arm/kernel/probes-arm.c       |    6 +++---
>   2 files changed, 16 insertions(+), 15 deletions(-)
>
> diff --git a/arch/arm/kernel/kprobes-test-arm.c b/arch/arm/kernel/kprobes-test-arm.c
> index 87839de..8a7428b 100644
> --- a/arch/arm/kernel/kprobes-test-arm.c
> +++ b/arch/arm/kernel/kprobes-test-arm.c
> @@ -73,12 +73,9 @@ void kprobe_arm_test_cases(void)
>   	TEST_RRR( op "lt" s "	r11, r",11,VAL1,", r",14,N(val),", asr r",7, 6,"")\
>   	TEST_RR(  op "gt" s "	r12, r13"       ", r",14,val, ", ror r",14,7,"")\
>   	TEST_RR(  op "le" s "	r14, r",0, val, ", r13"       ", lsl r",14,8,"")\
> -	TEST_RR(  op s "	r12, pc"        ", r",14,val, ", ror r",14,7,"")\
> -	TEST_RR(  op s "	r14, r",0, val, ", pc"        ", lsl r",14,8,"")\
>   	TEST_R(   op "eq" s "	r0,  r",11,VAL1,", #0xf5")			\
>   	TEST_R(   op "ne" s "	r11, r",0, VAL1,", #0xf5000000")		\
> -	TEST_R(   op s "	r7,  r",8, VAL2,", #0x000af000")		\
> -	TEST(     op s "	r4,  pc"        ", #0x00005a00")

The last two lines above confuse me.  Can you explain why those needed 
to be removed?  Is there somehow a shift involved with those instructions?

The rest looked OK to me.  I'm omitting it for the sake of brevity.

-dl
