From: christian.koenig@amd.com (=?UTF-8?Q?Christian_K=c3=b6nig?=)
Date: Thu, 15 Feb 2018 13:29:34 +0100
Subject: [PATCH 02/37] iommu/sva: Bind process address spaces to devices
In-Reply-To: <20180215102113.c7t7rrnyzgazmdli@8bytes.org>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
 <20180212183352.22730-3-jean-philippe.brucker@arm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D191002897@SHSMSX101.ccr.corp.intel.com>
 <b9eacb30-817f-9027-bc0a-1f01cf9f13f9@arm.com>
 <20180215102113.c7t7rrnyzgazmdli@8bytes.org>
Message-ID: <88f5a22a-6db9-f34b-916b-83cd6e683ceb@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 15.02.2018 um 11:21 schrieb joro at 8bytes.org:
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
> Yeah, so the problem on PCI is that all functions of a multi-function
> device are put into one group. For AMD-GPUs this means that the GPU
> (SVA-capable) will end up in the same group as the on-GPU sound
> device (not SVA-capable).

Yeah, but SVA only applies to rather new AMD-GPUs, which in turn can 
only do PCIe and there the problem doesn't seems to exist any more.

E.g. the audio device on my Vega10 gets a separate group despite being 
behind several bridges:
> 0b:00.0 VGA compatible controller: Advanced Micro Devices, Inc. 
> [AMD/ATI] Vega 10 [Radeon Vega Frontier Edition]
> 0b:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Device aaf8
...
> [??? 6.362665] iommu: Adding device 0000:0b:00.0 to group 14
> [??? 6.368468] iommu: Using direct mapping for device 0000:0b:00.0
> [??? 6.380040] iommu: Adding device 0000:0b:00.1 to group 15

Regards,
Christian.

>
> Before this causes us big headaches I suggest to only provide the
> bind_device() function. This should be fine because for SVA we don't
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
>
> These two types of protection are needed to safely assign devices to
> guests, but for bare-metal SVA all we need is type 1) isolation, and
> not even that if we can assume that all SVA-capable devices have an
> exclusive device-id (or stream-id).
>
>
>
> 	Joerg
>
