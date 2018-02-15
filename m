From: joro@8bytes.org (Joerg Roedel)
Date: Thu, 15 Feb 2018 10:59:09 +0100
Subject: [PATCH 01/37] iommu: Introduce Shared Virtual Addressing API
In-Reply-To: <20180212183352.22730-2-jean-philippe.brucker@arm.com>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
 <20180212183352.22730-2-jean-philippe.brucker@arm.com>
Message-ID: <20180215095909.r4nwqjhuijusssuy@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 12, 2018 at 06:33:16PM +0000, Jean-Philippe Brucker wrote:
  
> +config IOMMU_SVA
> +	bool "Shared Virtual Addressing API for the IOMMU"
> +	select IOMMU_API
> +	help
> +	  Enable process address space management for the IOMMU API. In systems
> +	  that support it, device drivers can bind process address spaces to
> +	  devices and share their page tables using this API.
> +
> +	  If unsure, say N here.

I think this should be an option selected by IOMMU driver and not be
activly selectable by the user.

> +/**
> + * iommu_sva_device_shutdown() - Shutdown Shared Virtual Addressing for a device
> + * @dev: the device
> + *
> + * Disable SVA. The device should not be performing any DMA while this function
> + * is running.

Is this a good idea? How about devices that get hot-unplugged while
processes still use them and there is DMA going back and forth? This
function can be the point to shut down all ongoing stuff first and the
shutdown the device.
