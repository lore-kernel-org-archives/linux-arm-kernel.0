From: sunil.kovvuri@gmail.com (Sunil Kovvuri)
Date: Mon, 24 Apr 2017 22:26:53 +0530
Subject: [PATCH] iommu/arm-smmu-v3: Increase SMMU CMD queue poll timeout
In-Reply-To: <20170424160841.GS12323@arm.com>
References: <1493035176-3633-1-git-send-email-gakula@caviumnetworks.com>
 <20170424160841.GS12323@arm.com>
Message-ID: <CA+sq2CeyVm4pcAVME7OAFVxpOcSJc5CsP0vz3ypDkSxdx0SKnQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 24, 2017 at 9:38 PM, Will Deacon <will.deacon@arm.com> wrote:
> On Mon, Apr 24, 2017 at 05:29:36PM +0530, Geetha sowjanya wrote:
>> From: Geetha <gakula@cavium.com>
>>
>> When large memory is being unmapped, huge no of tlb invalidation cmds are
>> submitted followed by a SYNC command. This sometimes hits CMD queue full and
>> poll on queue drain is being timedout throwing error message 'CMD_SYNC timeout'.
>>
>> Although there is no functional issue, error message confuses user. Hence increased
>> poll timeout to 500us
>
> Hmm, what are you doing to unmap that much? Is this VFIO teardown? Do you
> have 7c6d90e2bb1a ("iommu/io-pgtable-arm: Fix iova_to_phys for block
> entries") applied?

Yes it's VFIO teardown and again yes the above fix is applied.
But i didn't get how above fix is related.
TLB invalidation commands are submitted at 'arm_smmu_tlb_inv_range_nosync()'
and it's a loop over granule size.

1357         do {
1358                 arm_smmu_cmdq_issue_cmd(smmu, &cmd);
1359                 cmd.tlbi.addr += granule;
1360         } while (size -= granule);

So if invalidation size is big then huge no of invalidation commands
will be submitted
irrespective of fix that you pointed above, right ?

Thanks,
Sunil.

>
> Will
>
>>
>> Signed-off-by: Geetha <gakula@cavium.com>
>> ---
>>  drivers/iommu/arm-smmu-v3.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
>> index 591bb96..1dcd154 100644
>> --- a/drivers/iommu/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm-smmu-v3.c
>> @@ -407,7 +407,7 @@
>>  #define PRIQ_1_ADDR_MASK             0xfffffffffffffUL
>>
>>  /* High-level queue structures */
>> -#define ARM_SMMU_POLL_TIMEOUT_US     100
>> +#define ARM_SMMU_POLL_TIMEOUT_US     500
>>
>>  #define MSI_IOVA_BASE                        0x8000000
>>  #define MSI_IOVA_LENGTH                      0x100000
>> --
>> 1.9.1
>>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
