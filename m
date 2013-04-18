From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 18 Apr 2013 16:30:03 +0100
Subject: [PATCH 1/2] ARM: EXYNOS: Add a platform bus notifier to set
 dma masks for Exynos5440
In-Reply-To: <1365072704-4568-1-git-send-email-kgene.kim@samsung.com>
References: <1365072704-4568-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <20130418153003.GW14496@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 04, 2013 at 07:51:43PM +0900, Kukjin Kim wrote:
> +static u64 dma_mask64 = DMA_BIT_MASK(64);
...
> +	if (event != BUS_NOTIFY_ADD_DEVICE)
> +		return NOTIFY_DONE;
> +
> +	dev->dma_mask = &dma_mask64;

Sharing the dma mask in this way is a potential issue should you have a
device driver use dma_set_mask() - which can write to this value.

A better solution would be:

diff --git a/arch/arm/include/asm/device.h b/arch/arm/include/asm/device.h
index dc662fc..51bb740 100644
--- a/arch/arm/include/asm/device.h
+++ b/arch/arm/include/asm/device.h
@@ -22,6 +22,7 @@ struct dev_archdata {
 struct omap_device;
 
 struct pdev_archdata {
+	u64 dma_mask;
 #ifdef CONFIG_ARCH_OMAP
 	struct omap_device *od;
 #endif

and then in your function do:

	struct platform_device *pdev = to_platform_device(dev);
...
	pdev->dev.dma_mask = &pdev->arch_data.dma_mask;
	pdev->arch_data.dma_mask = DMA_BIT_MASK(64);

However... are all your devices really DMA capable?  Normally on a SoC,
it's only the DMA engine which is DMA capable and everything else is not,
and in that case you really only want to set the DMA masks up for the
DMA capable devices.
