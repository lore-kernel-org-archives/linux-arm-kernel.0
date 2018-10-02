From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 2 Oct 2018 12:04:49 +0100
Subject: [PATCH v2 7/7] arm64: uprobes - ARM32 instruction probing
In-Reply-To: <20181001134031eucas1p20355222b5692ca99bbeb915b9dbc6818~Zf8TZ4bLI3108031080eucas1p2e@eucas1p2.samsung.com>
References: <1537963925-25313-1-git-send-email-m.slodczyk2@partner.samsung.com>
 <CGME20180926121218eucas1p1b20a88cfec17c6403a35e4f23de96ade@eucas1p1.samsung.com>
 <1537963925-25313-8-git-send-email-m.slodczyk2@partner.samsung.com>
 <89110505-da2e-3266-c2aa-6e5128c520a4@arm.com>
 <20181001134031eucas1p20355222b5692ca99bbeb915b9dbc6818~Zf8TZ4bLI3108031080eucas1p2e@eucas1p2.samsung.com>
Message-ID: <ed84ac78-dc78-768d-2d95-a50db323bed5@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-10-01 2:40 PM, Maciej Slodczyk wrote:
> Hi Robin,
> 
> Thank you for having a look at my patchset.
> 
> On 27.09.2018 19:01, Robin Murphy wrote:
>> On 26/09/18 13:12, Maciej Slodczyk wrote:
>> [...]
>>> @@ -38,16 +78,44 @@ int arch_uprobe_analyze_insn(struct arch_uprobe
>>> *auprobe, struct mm_struct *mm,
>>>  ????????? unsigned long addr)
>>>  ? {
>>>  ????? probes_opcode_t insn;
>>> +??? enum probes_insn retval;
>>> +??? unsigned int bpinsn;
>>> -??? /* TODO: Currently we do not support AARCH32 instruction probing */
>>> -??? if (mm->context.flags & MMCF_AARCH32)
>>> -??????? return -ENOTSUPP;
>>> -??? else if (!IS_ALIGNED(addr, AARCH64_INSN_SIZE))
>>> +??? insn = *(probes_opcode_t *)(&auprobe->insn[0]);
>>> +
>>> +??? if (!IS_ALIGNED(addr, AARCH64_INSN_SIZE))
>>>  ????????? return -EINVAL;
>>> -??? insn = *(probes_opcode_t *)(&auprobe->insn[0]);
>>> +??? /* check if AARCH32 */
>>> +??? if (is_compat_task()) {
>>> +
>>> +??????? /* Thumb is not supported yet */
>>> +??????? if (addr & 0x3)
>>
>> I'm only skimming, so forgive me if I'm missing something which should
>> be obvious, but this has a big red flag all over it. If "addr" is the
>> actual instruction address (or even a branch target, for a
>> non-interworking branch), plenty of Thumb instructions will just happen
>> to lie at 4-byte-aligned addresses anyway.
>>
> That's the same way Thumb instructions are filtered out in arch/arm
> uprobes and kprobes code. I believe that at this point all Thumb
> instruction have bit 0 set. Please correct me if I'm wrong.

No, only Thumb *symbols* have bit 0 set. AFAICS [ku]probes are dealing 
with arbitrary instruction *addresses* here, which will always be 2- or 
4-byte aligned. Besides, even if that was the case, testing against 0x3 
would be misleading if 0x1 is sufficient. The existing code in arch/arm/ 
looks just as wrong.

>> Furthermore, how would this check ever catch anything anyway given
>> !IS_ALIGNED(addr, AARCH64_INSN_SIZE) above?
> 
> You're right, there's no point in checking it here. I'll fix it in v3.

Although it still won't solve the problem of potentially dumping an A32 
breakpoint in the middle of suitably-aligned T32 code. TBH I'm not sure 
it's even possible to solve that in the general case :(

Robin.
