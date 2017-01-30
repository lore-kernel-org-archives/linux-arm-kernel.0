From: robin.murphy@arm.com (Robin Murphy)
Date: Mon, 30 Jan 2017 12:22:11 +0000
Subject: [PATCH V7 08/11] drivers: acpi: Handle IOMMU lookup failure with
 deferred probing or error
In-Reply-To: <f2370671-ece8-fbee-de19-350dd625088f@codeaurora.org>
References: <1485188293-20263-1-git-send-email-sricharan@codeaurora.org>
 <1485188293-20263-9-git-send-email-sricharan@codeaurora.org>
 <20170124123711.GA11996@red-moon>
 <f2370671-ece8-fbee-de19-350dd625088f@codeaurora.org>
Message-ID: <93e79759-d614-9b36-d5ab-63e8eb725009@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/01/17 17:53, Sinan Kaya wrote:
> On 1/24/2017 7:37 AM, Lorenzo Pieralisi wrote:
>> [+hanjun, tomasz, sinan]
>>
>> It is quite a key patchset, I would be glad if they can test on their
>> respective platforms with IORT.
>>
> 
> Tested on top of 4.10-rc5.
> 
> 1.	Platform Hidma device passed dmatest
> 2.	Seeing some USB stalls on a platform USB device.
> 3.	PCIe NVME drive probed and worked fine with MSI interrupts after boot.
> 4. 	NVMe driver didn't probe following a hotplug insertion and received an
> SMMU error event during the insertion.

What was the SMMU error - a translation/permission fault (implying the
wrong DMA ops) or a bad STE fault (implying we totally failed to tell
the SMMU about the device at all)?

Robin.

> 
> /sys/bus/pci/slots/4 #
> /sys/bus/pci/slots/4 # dmesg | grep nvme
> [   14.041357] nvme nvme0: pci function 0003:01:00.0
> [  198.399521] nvme nvme0: pci function 0003:01:00.0
> [__198.416232]_nvme_0003:01:00.0:_enabling_device_(0000_->_0002)
> [  264.402216] nvme nvme0: I/O 228 QID 0 timeout, disable controller
> [  264.402313] nvme nvme0: Identify Controller failed (-4)
> [  264.421270] nvme nvme0: Removing after probe failure status: -5
> /sys/bus/pci/slots/4 #
> 
> 
> 
