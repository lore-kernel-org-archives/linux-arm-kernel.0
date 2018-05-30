From: okaya@codeaurora.org (Sinan Kaya)
Date: Tue, 29 May 2018 21:41:33 -0700
Subject: [PATCH] PCI: Add pci=safemode option
In-Reply-To: <20180530043103.GA19734@kroah.com>
References: <1527650389-31575-1-git-send-email-okaya@codeaurora.org>
 <20180530043103.GA19734@kroah.com>
Message-ID: <6c317ed8-cca3-8862-5f3b-12cf14e4d53b@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/29/2018 9:31 PM, Greg Kroah-Hartman wrote:
> On Tue, May 29, 2018 at 11:19:41PM -0400, Sinan Kaya wrote:
>> Adding pci=safemode kernel command line parameter to turn off all PCI
>> Express service driver as well as all optional PCIe features such as LTR,
>> Extended tags, Relaxed Ordering etc.
>>
>> Also setting MPS configuration to PCIE_BUS_SAFE so that MPS and MRRS can be
>> reconfigured with by the kernel in case BIOS hands off a broken
>> configuration.
> 
> Why not fix the BIOS?  That's what sane platforms do :)
> 
>>
>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>> ---
>>  Documentation/admin-guide/kernel-parameters.txt | 2 ++
>>  drivers/pci/pci.c                               | 7 +++++++
>>  drivers/pci/pci.h                               | 2 ++
>>  drivers/pci/pcie/portdrv_core.c                 | 2 +-
>>  drivers/pci/probe.c                             | 6 ++++++
>>  5 files changed, 18 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index 641ec9c..247adbb 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -3153,6 +3153,8 @@
>>  		noari		do not use PCIe ARI.
>>  		noats		[PCIE, Intel-IOMMU, AMD-IOMMU]
>>  				do not use PCIe ATS (and IOMMU device IOTLB).
>> +		safemode	turns of all optinal PCI features. Useful
>> +				for bringup/troubleshooting.
> 
> s/optinal/optional/ ?

sure.

> 
> And you should explain what exactly in PCI is "optional".  Who defines
> this and where is that list and what can go wrong if those options are
> not enabled?

Bjorn and I discussed the need for such a "safe" mode feature when you
want to bring up PCI for a platform. You want to turn off everything as
a starter and just stick to bare minimum.

I can add a few words describing them. The goal of this option is to keep
base PCI features with MSI only. Things like PME, AER, ASPM, Extended
Tags, LTR, Relaxed Ordering, SRIOV are all considered optional. safemode
is certainly not intended for production environments. 

I can taint the kernel as a suggestion.

I defined minimum as just booting a device and to be able to do DMA traffic
only with 0 optimization

> 
> In looking at your patch, I can't determine that at all, so there's no
> way that someone just looking at this sentence will be able to
> understand.
> 
> thanks,
> 
> greg k-h
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
