From: okaya@codeaurora.org (Sinan Kaya)
Date: Tue, 10 Nov 2015 15:58:19 -0500
Subject: [PATCH V2 1/3] scsi: mptxsas: try 64 bit DMA when 32 bit DMA fails
In-Reply-To: <3742888.Lmg2Y11mdz@wuerfel>
References: <1447034266-28003-1-git-send-email-okaya@codeaurora.org>
 <4982446.ZlJVrezq1Y@wuerfel> <56422725.7040809@codeaurora.org>
 <3742888.Lmg2Y11mdz@wuerfel>
Message-ID: <56425A6B.2070900@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/10/2015 2:56 PM, Arnd Bergmann wrote:
>> The ACPI IORT table declares whether you enable IOMMU for a particular
>> >device or not. The placement of IOMMU HW is system specific. The IORT
>> >table gives the IOMMU HW topology to the operating system.
> This sounds odd. Clearly you need to specify the IOMMU settings for each
> possible PCI device independent of whether the OS actually uses the IOMMU
> or not.

There are provisions to have DMA mask in the PCIe host bridge not at the 
PCIe device level inside IORT table. This setting is specific for each 
PCIe bus. It is not per PCIe device.

It is assumed that the endpoint device driver knows the hardware for 
PCIe devices. The driver can also query the supported DMA bits by this 
platform via DMA APIs and will request the correct DMA mask from the DMA 
subsystem (surprise!).

>In a lot of cases, we want to turn it off to get better performance
> when the driver has set a DMA mask that covers all of RAM, but you
> also want to enable the IOMMU for debugging purposes or for device
> assignment if you run virtual machines. The bootloader doesn't know how
> the device is going to be used, so it cannot define the policy here.

I think we'll end up adding a virtualization option to the UEFI BIOS 
similar to how Intel platforms work. Based on this switch, we'll end up 
patching the ACPI table.

If I remove the IORT entry, then the device is in coherent mode with 
device accessing the full RAM range.

If I have the IORT table, the device is in IOMMU translation mode.

Details are in the IORT spec.


-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a 
Linux Foundation Collaborative Project
