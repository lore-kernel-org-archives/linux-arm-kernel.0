From: linucherian@gmail.com (Linu Cherian)
Date: Wed, 12 Apr 2017 10:35:19 +0530
Subject: [RFC PATCH 1/7] iommu/arm-smmu-v3: Introduce smmu option
 PAGE0_REGS_ONLY for Silicon errata.
In-Reply-To: <d89ecbd2-ed1b-b13b-a7e4-ff2478655203@arm.com>
References: <1491921765-29475-1-git-send-email-linucherian@gmail.com>
 <1491921765-29475-2-git-send-email-linucherian@gmail.com>
 <d89ecbd2-ed1b-b13b-a7e4-ff2478655203@arm.com>
Message-ID: <CAGOz-0Z-kwxdD0x=X51baRmGe1bWJ4PyNkmRSuyheepPUYKxmg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 11, 2017 at 9:12 PM, Robin Murphy <robin.murphy@arm.com> wrote:
> On 11/04/17 15:42, linucherian at gmail.com wrote:
>> From: Linu Cherian <linu.cherian@cavium.com>
>>
>> Cavium 99xx SMMU implementation doesn't support page 1 register space
>> and PAGE0_REGS_ONLY option will be enabled as an errata workaround.
>
> Ugh :(
>
>> This option when turned on, replaces all page 1 offsets used for
>> EVTQ_PROD/CONS, PRIQ_PROD/CONS register access with page 0 offsets.
>
> I think it might be neater to have something like:
>
> arm_smmu_page1(smmu) {
>         if (smmu->quirk)
>                 return smmu->base;
>         return smmu->base + 64k;
> }
>
> and use it as the base in the appropriate places, rather than override
> the individual registers. Much like ARM_SMMU_GR0_NS in the SMMUv2 driver.
>

IIUC, we need to change the offsets as well for this,
Like,
 #define ARM_SMMU_EVTQ_BASE             0xa0
-#define ARM_SMMU_EVTQ_PROD             0x100a8
-#define ARM_SMMU_EVTQ_CONS             0x100ac
+#define ARM_SMMU_EVTQ_PROD             0xa8
+#define ARM_SMMU_EVTQ_CONS             0xac
 #define ARM_SMMU_EVTQ_IRQ_CFG0         0xb0
 #define ARM_SMMU_EVTQ_IRQ_CFG1         0xb8
 #define ARM_SMMU_EVTQ_IRQ_CFG2         0xbc

 #define ARM_SMMU_PRIQ_BASE             0xc0
-#define ARM_SMMU_PRIQ_PROD             0x100c8
-#define ARM_SMMU_PRIQ_CONS             0x100cc
+#define ARM_SMMU_PRIQ_PROD             0xc8
+#define ARM_SMMU_PRIQ_CONS             0xcc


But, it appears difficult to take this approach, at least with
arm_smmu_init_one_queue function.
This function takes both page0 register offset and and page1 register
offset as an argument.
So, we might need to do additional checks in this function to decide,
whether to use
a pag0 base or page1 base.


Thanks.
