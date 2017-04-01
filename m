From: robdclark@gmail.com (Rob Clark)
Date: Fri, 31 Mar 2017 22:58:16 -0400
Subject: [PATCH V3 0/5] iommu/arm-smmu: Add runtime pm/sleep support
In-Reply-To: <20170331175457.GD4897@arm.com>
References: <1489073748-3659-1-git-send-email-sricharan@codeaurora.org>
 <20170331175457.GD4897@arm.com>
Message-ID: <CAF6AEGv_1pNvhCc-mVP5S28Yt5kTJmTRfe8tKSJpEmxfOKM7Jg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 31, 2017 at 1:54 PM, Will Deacon <will.deacon@arm.com> wrote:
> On Thu, Mar 09, 2017 at 09:05:43PM +0530, Sricharan R wrote:
>> This series provides the support for turning on the arm-smmu's
>> clocks/power domains using runtime pm. This is done using the
>> recently introduced device links patches, which lets the symmu's
>> runtime to follow the master's runtime pm, so the smmu remains
>> powered only when the masters use it.
>
> Do you have any numbers for the power savings you achieve with this?
> How often do we actually manage to stop the SMMU clocks on an SoC with
> a handful of masters?
>
> In other words, is this too coarse-grained to be useful, or is it common
> that all the devices upstream of the SMMU are suspended?

well, if you think about a phone/tablet with a command mode panel,
pretty much all devices will be suspended most of the time ;-)

maybe it's a different case with servers.. unfortunately we have to
share the same driver across both..

BR,
-R

> Thanks,
>
> Will
>
>>
>> Took some reference from the exynos runtime patches [2].
>> Tested this with MDP, GPU, VENUS devices on apq8096-db820c board.
>>
>> Previous version of the patchset [1].
>>
>> [V3]
>>    * Reworked the patches to keep the clocks init/enabling function
>>      seperately for each compatible.
>>
>>    * Added clocks bindings for MMU40x/500.
>>
>>    * Added a new compatible for qcom,smmu-v2 implementation and
>>      the clock bindings for the same.
>>
>>    * Rebased on top of 4.11-rc1
>>
>> [V2]
>>    * Split the patches little differently.
>>
>>    * Addressed comments.
>>
>>    * Removed the patch #4 [3] from previous post
>>      for arm-smmu context save restore. Planning to
>>      post this separately after reworking/addressing Robin's
>>      feedback.
>>
>>    * Reversed the sequence to disable clocks than enabling.
>>      This was required for those cases where the
>>      clocks are populated in a dependent order from DT.
>>
>> [1] https://www.spinics.net/lists/linux-arm-msm/msg23870.html
>> [2] https://lkml.org/lkml/2016/10/20/70
>> [3] https://patchwork.kernel.org/patch/9389717/
>>
>> Sricharan R (5):
>>   iommu/arm-smmu: Add pm_runtime/sleep ops
>>   iommu/arm-smmu: Add support for MMU40x/500 clocks
>>   drivers: arm-smmu: Add clock support for QCOM_SMMUV2
>>   iommu/arm-smmu: Invoke pm_runtime during probe, add/remove device
>>   iommu/arm-smmu: Add the device_link between masters and smmu
>>
>>  .../devicetree/bindings/iommu/arm,smmu.txt         |  35 +++
>>  drivers/iommu/arm-smmu.c                           | 349 ++++++++++++++++++++-
>>  2 files changed, 373 insertions(+), 11 deletions(-)
>>
>> --
>> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
>>
> _______________________________________________
> iommu mailing list
> iommu at lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
