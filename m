From: liuj97@gmail.com (Jiang Liu)
Date: Mon, 14 Oct 2013 23:50:48 +0800
Subject: [RFT PATCH v2 2/4] arm64: restore FPSIMD to default state for
 kernel and signal contexts
In-Reply-To: <20131014153921.GK10491@mudshark.cambridge.arm.com>
References: <1381674029-430-1-git-send-email-liuj97@gmail.com>
 <1381674029-430-2-git-send-email-liuj97@gmail.com>
 <20131014151638.GI10491@mudshark.cambridge.arm.com>
 <525C0DF8.8040306@gmail.com>
 <20131014153921.GK10491@mudshark.cambridge.arm.com>
Message-ID: <525C12D8.1030505@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/14/2013 11:39 PM, Will Deacon wrote:
> On Mon, Oct 14, 2013 at 04:30:00PM +0100, Jiang Liu wrote:
>> On 10/14/2013 11:16 PM, Will Deacon wrote:
>>> On Sun, Oct 13, 2013 at 03:20:18PM +0100, Jiang Liu wrote:
>>>> From: Jiang Liu <jiang.liu@huawei.com>
>>>>
>>>> Restore FPSIMD control and status registers to default values
>>>> when creating new FPSIMD contexts for kernel context and reset
>>>> FPSIMD status register when creating FPSIMD context for signal
>>>> handling, otherwise the stale value in FPSIMD control and status
>>>> registers may affect the new kernal or signal handling contexts.
>>>>
>>>> Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
>>>> Cc: Jiang Liu <liuj97@gmail.com>
>>>> ---
>>>>  arch/arm64/include/asm/fpsimd.h | 16 ++++++++++++++++
>>>>  arch/arm64/kernel/fpsimd.c      | 11 +++++++++--
>>>>  arch/arm64/kernel/signal.c      |  1 +
>>>>  arch/arm64/kernel/signal32.c    |  1 +
>>>>  4 files changed, 27 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
>>>> index c43b4ac..b2dc30f 100644
>>>> --- a/arch/arm64/include/asm/fpsimd.h
>>>> +++ b/arch/arm64/include/asm/fpsimd.h
>>>> @@ -50,8 +50,24 @@ struct fpsimd_state {
>>>>  #define VFP_STATE_SIZE		((32 * 8) + 4)
>>>>  #endif
>>>>  
>>>> +#define	AARCH64_FPCR_DEFAULT_VAL	0
>>>> +
>>>>  struct task_struct;
>>>>  
>>>> +static inline void fpsimd_init_hw_state(void)
>>>> +{
>>>> +	int val = AARCH64_FPCR_DEFAULT_VAL;
>>>> +
>>>> +	asm ("msr fpcr, %x0\n"
>>>> +	     "msr fpsr, xzr\n"
>>>> +             : : "r"(val));
>>>> +}
>>>> +
>>>> +static inline void fpsimd_clear_fpsr(void)
>>>> +{
>>>> +	asm ("msr fpsr, xzr\n");
>>>> +}
>>>
>>> You have pretty weak asm constraints here...
>> Hi Will,
>> 	We will add an explicit "volatile" here. But according to GCC docs, it
>> should have the same effect:
>> An asm instruction without any output operands is treated identically to
>> a volatile asm instruction.
> 
> I don't think volatile is enough to prevent re-ordering across a function
> call; it just prevents the block from being optimised away entirely and/or
> reordered with respect to other volatile statements.
> 
> A "memory" clobber should do the trick in this case.
Thanks for education, will fix it in next version.

> 
> Will
> 
