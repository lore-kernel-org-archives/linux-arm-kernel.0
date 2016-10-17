From: sricharan@codeaurora.org (Sricharan)
Date: Mon, 17 Oct 2016 12:32:10 +0530
Subject: [PATCH V3 0/8] IOMMU probe deferral support
In-Reply-To: <12cfb59f-f7ca-d4df-eb7f-42348e357979@samsung.com>
References: <CGME20161004170414eucas1p141bebe16e1bf241862833e7ad0270c72@eucas1p1.samsung.com>
 <1475600632-21289-1-git-send-email-sricharan@codeaurora.org>
 <12cfb59f-f7ca-d4df-eb7f-42348e357979@samsung.com>
Message-ID: <000801d22844$645588a0$2d0099e0$@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Resending, missed out on the link last time.

>-----Original Message-----
From: linux-arm-msm-owner@vger.kernel.org [mailto:linux-arm-msm-owner at vger.kernel.org] On Behalf Of Marek Szyprowski
>Sent: Monday, October 10, 2016 6:07 PM
>To: Sricharan R <sricharan@codeaurora.org>; will.deacon at arm.com; robin.murphy at arm.com; joro at 8bytes.org; iommu at lists.linux-
>foundation.org; linux-arm-kernel at lists.infradead.org; linux-arm-msm at vger.kernel.org; laurent.pinchart at ideasonboard.com;
>tfiga at chromium.org; srinivas.kandagatla at linaro.org
>Subject: Re: [PATCH V3 0/8] IOMMU probe deferral support
>
>Hi Sricharan,
>
>
>On 2016-10-04 19:03, Sricharan R wrote:
>> Initial post from Laurent Pinchart[1]. This is
>> series calls the dma ops configuration for the devices
>> at a generic place so that it works for all busses.
>> The dma_configure_ops for a device is now called during
>> the device_attach callback just before the probe of the
>> bus/driver is called. Similarly dma_deconfigure is called during
>> device/driver_detach path.
>>
>>
>> pci_bus_add_devices    (platform/amba)(_device_create/driver_register)
>>         |                         |
>> pci_bus_add_device     (device_add/driver_register)
>>         |                         |
>> device_attach           device_initial_probe
>>         |                         |
>> __device_attach_driver    __device_attach_driver
>>         |
>> driver_probe_device
>>         |
>> really_probe
>>         |
>> dma_configure
>>
>>   Similarly on the device/driver_unregister path __device_release_driver
>> is
>>   called which inturn calls dma_deconfigure.
>>
>>   If the ACPI bus code follows the same, we can add acpi_dma_configure
>>   at the same place as of_dma_configure.
>>
>>   This series is based on the recently merged Generic DT bindings for
>>   PCI IOMMUs and ARM SMMU from Robin Murphy robin.murphy at arm.com [2]
>>
>>   This time tested this with platform and pci device for probe deferral
>>   and reprobe on arm64 based platform. There is an issue on the cleanup
>>   path for arm64 though, where there is WARN_ON if the dma_ops is reset
>> while
>>   device is attached to an domain in arch_teardown_dma_ops.
>>   But with iommu_groups created from the iommu driver, the device is
>> always
>>   attached to a domain/default_domain. So so the WARN has to be
>> removed/handled
>>   probably.
>
>Thanks for continuing work on this feature! Your can add my:
>
>Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
>

Hi Will,Robin,Joerg,
       
       I have tested the probe deferral for platform/pcie bus devices based on latest Generic DT bindings
        series merged [1], for pci/arm-smmu.
       It will be good to know from you on whats the right way to take this forward ?

[1] http://www.spinics.net/lists/devicetree/msg142943.html

Regards,
 Sricharan
