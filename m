From: sricharan@codeaurora.org (Sricharan)
Date: Mon, 23 Jan 2017 19:44:32 +0530
Subject: [PATCH V6 06/11] drivers: platform: Configure dma operations at
 probe time
In-Reply-To: <20170123120729.GB12593@red-moon>
References: <1484939748-31591-1-git-send-email-sricharan@codeaurora.org>
 <1484939748-31591-7-git-send-email-sricharan@codeaurora.org>
 <20170123120729.GB12593@red-moon>
Message-ID: <007a01d27583$09279400$1b76bc00$@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lorenzo,

>-----Original Message-----
>From: Lorenzo Pieralisi [mailto:lorenzo.pieralisi at arm.com]
>Sent: Monday, January 23, 2017 5:37 PM
>To: Sricharan R <sricharan@codeaurora.org>
>Cc: robin.murphy at arm.com; will.deacon at arm.com; joro at 8bytes.org; iommu at lists.linux-foundation.org; linux-arm-
>kernel at lists.infradead.org; linux-arm-msm at vger.kernel.org; m.szyprowski at samsung.com; bhelgaas at google.com
>Subject: Re: [PATCH V6 06/11] drivers: platform: Configure dma operations at probe time
>
>[+bjorn]
>
>On Sat, Jan 21, 2017 at 12:45:43AM +0530, Sricharan R wrote:
>> Configuring DMA ops at probe time will allow deferring device probe when
>> the IOMMU isn't available yet. The dma_configure for the device is
>> now called from the generic device_attach callback just before the
>> bus/driver probe is called. This way, configuring the DMA ops for the
>> device would be called at the same place for all bus_types, hence the
>> deferred probing mechanism should work for all buses as well.
>>
>> pci_bus_add_devices    (platform/amba)(_device_create/driver_register)
>>        |                         |
>> pci_bus_add_device     (device_add/driver_register)
>>        |                         |
>> device_attach           device_initial_probe
>>        |                         |
>> __device_attach_driver    __device_attach_driver
>>        |
>> driver_probe_device
>>        |
>> really_probe
>>        |
>> dma_configure
>>
>> Similarly on the device/driver_unregister path __device_release_driver is
>> called which inturn calls dma_deconfigure.
>>
>> This patch changes the dma ops configuration time to probe time for
>> both OF and ACPI based devices.
>
>For all device types, inclusive of PCI, so please you have to:
>
>- Update the $SUBJECT
>- Copy linux-pci at vger.kernel.org
>- Copy linux-acpi at vger.kernel org (on the series)

Sure, i will just see till tomorrow for any further comments and
repost with $SUBJECT modified and the lists

Regards,
 Sricharan
