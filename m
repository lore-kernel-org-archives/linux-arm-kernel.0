From: frowand.list@gmail.com (Frank Rowand)
Date: Mon, 10 Apr 2017 04:56:20 -0700
Subject: [PATCH V11 00/11] IOMMU probe deferral support
In-Reply-To: <1491823266-1209-1-git-send-email-sricharan@codeaurora.org>
References: <1491823266-1209-1-git-send-email-sricharan@codeaurora.org>
Message-ID: <58EB72E4.6030009@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/10/17 04:20, Sricharan R wrote:
> This series calls the dma ops configuration for the devices
> at a generic place so that it works for all busses.
> The dma_configure_ops for a device is now called during
> the device_attach callback just before the probe of the
> bus/driver is called. Similarly dma_deconfigure is called during
> device/driver_detach path.
> 
> pci_bus_add_devices    (platform/amba)(_device_create/driver_register)
>        |                         |
> pci_bus_add_device     (device_add/driver_register)
>        |                         |
> device_attach           device_initial_probe
>        |                         |
> __device_attach_driver    __device_attach_driver
>        |
> driver_probe_device
>        |
> really_probe
>        |
> dma_configure
> 
> Similarly on the device/driver_unregister path __device_release_driver is
> called which inturn calls dma_deconfigure.
> 
> Rebased the series against mainline 4.11-rc5. Applies and builds cleanly
> against iommu-next and with 3-way merge applies on top of linux-next
> as well (patch #8), because of "ACPI platform MSI support" from
> Hanjun being merged.
>   
> * Tested with platform and pci devices for probe deferral
>   and reprobe on arm64 based platform.
> 
> Previous post of this series [8]. 
> 
> Please note that, i have kept the tested/acked tags intact from V8
> because V9/10/11 were for more fixes that was added, so the original
> tags that was given for the functional testing remains the same.
> 
>  [V11]
>      * No functional changes.
> 
>      * Rebased on top of 4.11-rc6.
> 
>      * Dropped patch#3 from V10, as a result have to make
>        a change in patch#7 to return a 'non-void' to fix a
>        build warning.
> 
>      * Added Robin's and Rob's tags.

< snip >

The changes are good enough for me and you have Rob's acks, so the
series looks good from the device tree standpoint.

-Frank
