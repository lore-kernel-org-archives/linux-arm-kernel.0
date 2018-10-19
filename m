From: john.garry@huawei.com (John Garry)
Date: Fri, 19 Oct 2018 15:30:28 +0100
Subject: [PATCH v5 1/2] iommu/arm-smmu-v3: Poll for CMD_SYNC outside cmdq
 lock
In-Reply-To: <3e52b993-a850-301e-85e1-71597df45dc5@huawei.com>
References: <61b4c3e5f1322dfe96ca2062a7fe058298340996.1539782799.git.robin.murphy@arm.com>
 <2c4e00a2-cd53-a6f5-8561-97379dcf9c02@huawei.com>
 <535fd13d-4cc5-e551-01d9-f7eb05c3ddb0@arm.com>
 <3e52b993-a850-301e-85e1-71597df45dc5@huawei.com>
Message-ID: <12a80824-da53-899c-b530-750c42c3ff37@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/10/2018 12:48, John Garry wrote:
> On 18/10/2018 12:19, Robin Murphy wrote:
>> On 18/10/18 11:55, John Garry wrote:
>> [...]
>>>> @@ -976,18 +1019,19 @@ static int __arm_smmu_cmdq_issue_sync(struct
>>>> arm_smmu_device *smmu)
>>>>  {
>>>>      u64 cmd[CMDQ_ENT_DWORDS];
>>>>      unsigned long flags;
>>>> -    bool wfe = !!(smmu->features & ARM_SMMU_FEAT_SEV);
>>>>      struct arm_smmu_cmdq_ent ent = { .opcode = CMDQ_OP_CMD_SYNC };
>>>> -    int ret;
>>>> +    int sync_idx, sync_gen;
>>>>
>>>>      arm_smmu_cmdq_build_cmd(cmd, &ent);
>>>>
>>>>      spin_lock_irqsave(&smmu->cmdq.lock, flags);
>>>> -    arm_smmu_cmdq_insert_cmd(smmu, cmd);
>>>> -    ret = queue_poll_cons(&smmu->cmdq.q, true, wfe);
>>>> +    if (smmu->prev_cmd_opcode != CMDQ_OP_CMD_SYNC)
>>>> +        arm_smmu_cmdq_insert_cmd(smmu, cmd);
>>>
>>> Hi Robin,
>>>
>>> If we did stop rebuilding the non-MSI command as I suggested, then we
>>> would not have the case of building the command and then discarding
>>> it, right?
>>
>> I suppose so. But that build/discard case can also be avoided by
>> applying patch 2/2 of this series ;)
>

So we can avoid the build/discard but the command is built under the 
lock. Hopefully worth it.

However there is still scope (and - considering the locking - maybe more 
need) for a static non-MSI CMD_SYNC command :)

Anyway, we'll look to get some numbers.

Cheers,

> OK, I'll check it more detail. TBH, I found 2/2 hard to follow from just
> the diff.
