From: sricharan@codeaurora.org (Sricharan)
Date: Mon, 17 Oct 2016 12:28:01 +0530
Subject: [PATCH V3 0/8] IOMMU probe deferral support
References: <CGME20161004170414eucas1p141bebe16e1bf241862833e7ad0270c72@eucas1p1.samsung.com>
 <1475600632-21289-1-git-send-email-sricharan@codeaurora.org>
 <12cfb59f-f7ca-d4df-eb7f-42348e357979@samsung.com>
Message-ID: <000601d22843$d0efc4e0$72cf4ea0$@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>-----Original Message-----
>From: Sricharan [mailto:sricharan at codeaurora.org]
>Sent: Wednesday, October 12, 2016 11:55 AM
>To: 'Marek Szyprowski' <m.szyprowski@samsung.com>; 'will.deacon at arm.com' <will.deacon@arm.com>; 'robin.murphy at arm.com'
><robin.murphy@arm.com>; 'joro at 8bytes.org' <joro@8bytes.org>; 'iommu at lists.linux-foundation.org' <iommu@lists.linux-
>foundation.org>; 'linux-arm-kernel at lists.infradead.org' <linux-arm-kernel@lists.infradead.org>; 'linux-arm-msm at vger.kernel.org'
><linux-arm-msm@vger.kernel.org>; 'laurent.pinchart at ideasonboard.com' <laurent.pinchart@ideasonboard.com>;
>'tfiga at chromium.org' <tfiga@chromium.org>; 'srinivas.kandagatla at linaro.org' <srinivas.kandagatla@linaro.org>
>Subject: RE: [PATCH V3 0/8] IOMMU probe deferral support
>
>Hi Marek,
>
>>Hi Sricharan,
>>
>>
>>On 2016-10-04 19:03, Sricharan R wrote:
>>> Initial post from Laurent Pinchart[1]. This is
>>> series calls the dma ops configuration for the devices
>>> at a generic place so that it works for all busses.
>>> The dma_configure_ops for a device is now called during
>>> the device_attach callback just before the probe of the
>>> bus/driver is called. Similarly dma_deconfigure is called during
>>> device/driver_detach path.
>>>
>>>
>>> pci_bus_add_devices    (platform/amba)(_device_create/driver_register)
>>>         |                         |
>>> pci_bus_add_device     (device_add/driver_register)
>>>         |                         |
>>> device_attach           device_initial_probe
>>>         |                         |
>>> __device_attach_driver    __device_attach_driver
>>>         |
>>> driver_probe_device
>>>         |
>>> really_probe
>>>         |
>>> dma_configure
>>>
>>>   Similarly on the device/driver_unregister path __device_release_driver is
>>>   called which inturn calls dma_deconfigure.
>>>
>>>   If the ACPI bus code follows the same, we can add acpi_dma_configure
>>>   at the same place as of_dma_configure.
>>>
>>>   This series is based on the recently merged Generic DT bindings for
>>>   PCI IOMMUs and ARM SMMU from Robin Murphy robin.murphy at arm.com [2]
>>>
>>>   This time tested this with platform and pci device for probe deferral
>>>   and reprobe on arm64 based platform. There is an issue on the cleanup
>>>   path for arm64 though, where there is WARN_ON if the dma_ops is reset while
>>>   device is attached to an domain in arch_teardown_dma_ops.
>>>   But with iommu_groups created from the iommu driver, the device is always
>>>   attached to a domain/default_domain. So so the WARN has to be removed/handled
>>>   probably.
>>
>>Thanks for continuing work on this feature! Your can add my:
>>
>>Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
>>
Hi Will,Robin,Joerg,
       
       I have tested the probe deferral for platform/pcie bus devices based on latest Generic bindings
        series merged [1], for pci/arm-smmu.
       It will good to know from you on whats the right way to take this forward ?

Regards,
 Sricharan
