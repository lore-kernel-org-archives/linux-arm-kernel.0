From: sricharan@codeaurora.org (Sricharan R)
Date: Tue, 28 Mar 2017 21:36:30 +0530
Subject: [V9, 07/11] iommu: of: Handle IOMMU lookup failure with deferred
 probing or error
In-Reply-To: <20170328150001.j57jko6mx35npgp2@rob-hp-laptop>
References: <1489086061-9356-8-git-send-email-sricharan@codeaurora.org>
 <20170328150001.j57jko6mx35npgp2@rob-hp-laptop>
Message-ID: <7312ddb8-3d6e-0665-9e7e-1a39c6fb597b@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 3/28/2017 8:30 PM, Rob Herring wrote:
> On Fri, Mar 10, 2017 at 12:30:57AM +0530, Sricharan R wrote:
>> From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
>>
>> Failures to look up an IOMMU when parsing the DT iommus property need to
>> be handled separately from the .of_xlate() failures to support deferred
>> probing.
>>
>> The lack of a registered IOMMU can be caused by the lack of a driver for
>> the IOMMU, the IOMMU device probe not having been performed yet, having
>> been deferred, or having failed.
>>
>> The first case occurs when the device tree describes the bus master and
>> IOMMU topology correctly but no device driver exists for the IOMMU yet
>> or the device driver has not been compiled in. Return NULL, the caller
>> will configure the device without an IOMMU.
>>
>> The second and third cases are handled by deferring the probe of the bus
>> master device which will eventually get reprobed after the IOMMU.
>>
>> The last case is currently handled by deferring the probe of the bus
>> master device as well. A mechanism to either configure the bus master
>> device without an IOMMU or to fail the bus master device probe depending
>> on whether the IOMMU is optional or mandatory would be a good
>> enhancement.
>>
>> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> Signed-off-by: Laurent Pichart <laurent.pinchart+renesas@ideasonboard.com>
>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>> ---
>>  drivers/base/dma-mapping.c | 5 +++--
>>  drivers/iommu/of_iommu.c   | 4 ++--
>>  drivers/of/device.c        | 7 ++++++-
>>  include/linux/of_device.h  | 9 ++++++---
>>  4 files changed, 17 insertions(+), 8 deletions(-)
>
> Maybe it is the same issue reported for VFIO, but virtio-pci is broken
> with v8 of this series. Bisecting blames this commit which looks like it
> hasn't changeed.

Ya, as Robin mentioned it was broken at patch #2 and
comes out after this patch. I am going to repost this series with
couple of more fixes added as well.

>
> Rob
>
> P.S. Doesn't look like you have copied the DT maintainers nor list for
> the DT changes.

Ha, really sorry about that. will add it.

Regards,
  Sricharan

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member of Code Aurora Forum, hosted by The Linux Foundation
