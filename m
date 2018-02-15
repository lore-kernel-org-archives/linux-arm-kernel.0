From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Thu, 15 Feb 2018 12:46:36 +0000
Subject: [PATCH 02/37] iommu/sva: Bind process address spaces to devices
In-Reply-To: <20180215102113.c7t7rrnyzgazmdli@8bytes.org>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
 <20180212183352.22730-3-jean-philippe.brucker@arm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D191002897@SHSMSX101.ccr.corp.intel.com>
 <b9eacb30-817f-9027-bc0a-1f01cf9f13f9@arm.com>
 <20180215102113.c7t7rrnyzgazmdli@8bytes.org>
Message-ID: <9d440890-cb57-c890-334d-c40a6c68566e@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/02/18 10:21, joro at 8bytes.org wrote:
> On Tue, Feb 13, 2018 at 12:57:23PM +0000, Jean-Philippe Brucker wrote:
>> * bind_device() fails if the device's group has more than one device,
>> otherwise calls __bind_device(). This prevents device drivers that are
>> oblivious to IOMMU groups from opening a backdoor.
>>
>> * bind_group() calls __bind_device() for all devices in group. This way
>> users that are aware of IOMMU groups can still use them safely. Note that
>> at the moment bind_group() fails as soon as it finds a device that doesn't
>> support SVA. Having all devices support SVA in a given group is
>> unrealistic and this behavior ought to be improved.
> 
> Yeah, so the problem on PCI is that all functions of a multi-function
> device are put into one group. For AMD-GPUs this means that the GPU
> (SVA-capable) will end up in the same group as the on-GPU sound
> device (not SVA-capable).

As I understood it ACS also isolate functions within a device, for example
the two PFs of my ixgbe card are in different groups. Strangely all VFs go
in the same group, I haven't investigated why yet.

> Before this causes us big headaches I suggest to only provide the
> bind_device() function.

Ok. I added bind_group() to make it easier for VFIO - so if one bind()
fails in the group, iommu.c can rollback and remove the bonds already
created. If we mandate a single device in the group for SVA, then VFIO can
use iommu_group_for_each_dev() and ensure that the callback was only
called once.

> This should be fine because for SVA we don't
> need all types of isolation that iommu_groups provide.
> 
> IOMMU-groups provide two types of isolation:
> 
> 	1) They group devices together which the IOMMU can't distinguish
> 	   from each other, like PCI devices behind a PCIe bridge.
> 
> 	2) Devices that can't be isolated from each other are also put
> 	   into the same group. This is the case for multi-function PCIe
> 	   devices as well as all PCIe devices behind a non-ACS bridge.
> 	   But all these devices cann still be distinguished by the
> 	   IOMMU.

But transactions don't necessarily reach the IOMMU if devices are not
isolated by ACS. So even if you disable all translation in the IOMMU for
one device in the group, it may still have a view of address spaces shared
with another device in that group.

> These two types of protection are needed to safely assign devices to
> guests, but for bare-metal SVA all we need is type 1) isolation, and
> not even that if we can assume that all SVA-capable devices have an
> exclusive device-id (or stream-id).

I'm not as optimistic that we won't need IOMMU groups with SVA devices for
2) (hardware bugs, integration issues, etc). I'd be more comfortable if we
added a sanity-check as suggested by Kevin, to ensure that SVA is
disallowed if multiple devices are in the group.

Thanks,
Jean
