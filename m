From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Thu, 15 Feb 2018 12:43:06 +0000
Subject: [PATCH 01/37] iommu: Introduce Shared Virtual Addressing API
In-Reply-To: <20180215095909.r4nwqjhuijusssuy@8bytes.org>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
 <20180212183352.22730-2-jean-philippe.brucker@arm.com>
 <20180215095909.r4nwqjhuijusssuy@8bytes.org>
Message-ID: <69405fb7-7453-8575-e020-2ded7b2b92f5@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/02/18 09:59, Joerg Roedel wrote:
> On Mon, Feb 12, 2018 at 06:33:16PM +0000, Jean-Philippe Brucker wrote:
>   
>> +config IOMMU_SVA
>> +	bool "Shared Virtual Addressing API for the IOMMU"
>> +	select IOMMU_API
>> +	help
>> +	  Enable process address space management for the IOMMU API. In systems
>> +	  that support it, device drivers can bind process address spaces to
>> +	  devices and share their page tables using this API.
>> +
>> +	  If unsure, say N here.
> 
> I think this should be an option selected by IOMMU driver and not be
> activly selectable by the user.

Ok

>> +/**
>> + * iommu_sva_device_shutdown() - Shutdown Shared Virtual Addressing for a device
>> + * @dev: the device
>> + *
>> + * Disable SVA. The device should not be performing any DMA while this function
>> + * is running.
> 
> Is this a good idea? How about devices that get hot-unplugged while
> processes still use them and there is DMA going back and forth? This
> function can be the point to shut down all ongoing stuff first and the
> shutdown the device.

To be honest I don't know how hot-unplug works. But sva_device_shutdown()
may be called, for instance, by the device driver before the device
disappears, so it has to know how to stop DMA before calling it. The IOMMU
driver can't really do anything more.

For hot-unplug I guess that device_driver::remove() is called first,
allowing it to stop all DMA and call sva_device_shutdown().

Then the IOMMU gets a BUS_NOTIFY_REMOVED_DEVICE notification and calls
iommu_ops::remove_device(), allowing to clean up SVA structure if the
device driver didn't call unbind_device() and sva_device_shutdown(). But
at that point we don't have a way to cooperate with the driver to stop DMA
anymore.

Thanks,
Jean
