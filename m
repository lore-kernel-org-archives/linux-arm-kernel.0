From: julien.thierry@arm.com (Julien Thierry)
Date: Tue, 2 Oct 2018 09:08:35 +0100
Subject: [PATCH v2 5/7] arm64: make arm uprobes code reusable by arm64
In-Reply-To: <20181001132852eucas1p25ab2ddf39296e2c78b188234d168f814~ZfyJK4W4N0481804818eucas1p2j@eucas1p2.samsung.com>
References: <1537963925-25313-1-git-send-email-m.slodczyk2@partner.samsung.com>
 <CGME20180926121216eucas1p2b896ce19f49214d497721db9d6e59bfb@eucas1p2.samsung.com>
 <1537963925-25313-6-git-send-email-m.slodczyk2@partner.samsung.com>
 <9abe9091-f305-a446-c93f-6418d35a7dee@arm.com>
 <20181001132852eucas1p25ab2ddf39296e2c78b188234d168f814~ZfyJK4W4N0481804818eucas1p2j@eucas1p2.samsung.com>
Message-ID: <7ec4fc83-5bf1-f8c2-d6da-e55485ee6642@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 01/10/18 14:28, Maciej Slodczyk wrote:
> Hi,
> 
> Thank you for the review.
> 
>> I think that it would be good to move the renaming changes out of this
>> patch.
>>
> 
> So, as I understand, you suggest separating renaming from moving and
> putting it in separate patches, right?
> 

Yes, I just feel this patch has a lot of changes and things like 
renaming/adapting the callback handler and renaming the arm32 stucture 
field could be put in their own patches.

Thanks,

>>>  ? })
>>> +#define ARM_COMPAT_LR_OFFSET??? 0
>>
>> Not sure this should be defined here. What's the meaning of compat for
>> arch/arm ?
>>
> 
> Sure, I agree that the name is not very fortunate. I'll change it to
> something like ARM_UPROBES_BRANCH_LR_OFFSET.
> 
>>> @@ -39,7 +39,7 @@ struct arch_uprobe {
>>>  ????? void (*posthandler)(struct arch_uprobe *auprobe,
>>>  ????????????????? struct arch_uprobe_task *autask,
>>>  ????????????????? struct pt_regs *regs);
>>> -??? struct arch_probes_insn asi;
>>> +??? struct arch_probes_insn api;
>>
>> It would be easier to follow thing by making this change in its own
>> patch. (Probably before you move arm32 code to lib/probes)
>>
> 
> Yup.
> 
> 
>>> +enum probes_insn {
>>> +??? INSN_REJECTED,
>>> +??? INSN_GOOD_NO_SLOT,
>>> +??? INSN_GOOD,
>>> +};
>>
>> Why have two definitions of this enum rather than a common one in
>> lib/probes?
>>
> 
> Will fix in v3.
> 
>>> -typedef void (probes_handler_t) (u32 opcode,
>>> -?????????????? struct arch_probe_insn *api,
>>> +typedef void (probes_insn_handler_t) (u32 opcode,
>>> +?????????????? struct arch_probes_insn *api,
>>
>> In the previous patch you were already aligning this handler the ARM32's
>> equivalent. Why not fix the name (for the handler and struct
>> arch_probes_insn) in the previous patch?
>>
> 
> OK.
> 
>>> +
>>> +#define link_register(regs)??????????? ((regs)->compat_lr)
>>> +
>>> +static inline void link_register_set(struct pt_regs *regs,
>>> +?????????????????????? unsigned long val)
>>> +{
>>> +??? link_register(regs) = val;
>>> +}
>>
>> pstate.h isn't really related to compat mode and whichever compat
>> definition it contains the relations are made explicit through their names.
>>
>> I don't think a macro "link_register" defined in arch/arm64 and visible
>> to any file including ptrace.h (which is a lot) should return
>> "compat_lr" instead of the actual link register.
>>
>> I'd say have the link_register macro check whether "regs" refers to a
>> compat mode context or not and provide the adequate link register.
>>
>> Otherwise maybe you can get away with naming the macro
>> "arm_link_register" and the macro "arm_link_register_set". But I would
>> prefer the previous approach.
>>
> 
> OK.
> 
>>> +#ifdef CONFIG_ARM64
>>> +#include <../../../arm/include/asm/opcodes.h>
>>
>> Hmmm not sure this is something that is accepted.
>>
> 
> OK, I'll fix it.
> 
>>> +/*
>>> + * based on arm kprobes implementation
>>> + */
>>> +static void __kprobes simulate_ldm1stm1(probes_opcode_t insn,
>>> +??????? struct arch_probes_insn *asi,
>>
>> The whole asi/api mix become a bit confusing IMO.
>> Should we have api when the argument is of type "arch_probes_insn" and
>> asi when the type is "arch_specific_insn"?
>> Should we have more coherent definitions of those structures between arm
>> and arm64 if we are going to share functions between them?
>>
> 
> OK, I'll try to figure something out that's less confusing.
> 
>>
>> #ifdef CONFIG_ARM64
>>
>>> +enum probes_insn
>>> +uprobe_decode_ldmstm_aarch64(probes_opcode_t insn,
>>> +???????? struct arch_probes_insn *asi,
>>> +???????? const struct decode_header *d)
>>
>> Should be static.
>>
> 
> OK.
> 
> Thanks again for the review. I'll rework the whole patchset to include
> your remarks.
> 
> 
> Thank you,
> Maciej
> 

-- 
Julien Thierry
