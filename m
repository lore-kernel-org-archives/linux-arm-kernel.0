From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 22 May 2017 11:37:31 +0100
Subject: [PATCH V4 3/4] ACPI/IORT: Ignore all errors except EPROBE_DEFER
In-Reply-To: <1495119257-26724-3-git-send-email-sricharan@codeaurora.org>
References: <1495119257-26724-1-git-send-email-sricharan@codeaurora.org>
 <1495119257-26724-3-git-send-email-sricharan@codeaurora.org>
Message-ID: <20170522103730.GB7553@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sricharan,

On Thu, May 18, 2017 at 08:24:16PM +0530, Sricharan R wrote:
> While deferring the probe of IOMMU masters, xlate and
> add_device callbacks called from iort_iommu_configure
> can pass back error values like -ENODEV, which means
> the IOMMU cannot be connected with that master for real
> reasons. Before the IOMMU probe deferral, all such errors
> were ignored. Now all those errors are propagated back,
> killing the master's probe for such errors. Instead ignore
> all the errors except EPROBE_DEFER, which is the only one
> of concern and let the master work without IOMMU, thus
> restoring the old behavior.
> 
> Fixes: 5a1bb638d567 ("drivers: acpi: Handle IOMMU lookup failure with deferred probing or error")
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> ---
> [V4] Added this patch newly.
> 
>  drivers/acpi/arm64/iort.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index c5fecf9..16e101f 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -782,6 +782,12 @@ const struct iommu_ops *iort_iommu_configure(struct device *dev)
>  	if (err)
>  		ops = ERR_PTR(err);
>  
> +	/* Ignore all other errors apart from EPROBE_DEFER */
> +	if (IS_ERR(ops) && (PTR_ERR(ops) != -EPROBE_DEFER)) {
> +		dev_dbg(dev, "Adding to IOMMU failed: %ld\n", PTR_ERR(ops));
> +		ops = NULL;
> +	}
> +
>  	return ops;
>  }
>  

It is getting a bit convoluted. Is not it better to propagate the
error back and let acpi_dma_configure() make a decision accordingly ?

Something like:

-- >8 --
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index e39ec7b..3a10d757 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1371,8 +1371,8 @@ int acpi_dma_configure(struct device *dev, enum dev_dma_attr attr)
 	iort_set_dma_mask(dev);
 
 	iommu = iort_iommu_configure(dev);
-	if (IS_ERR(iommu))
-		return PTR_ERR(iommu);
+	if (IS_ERR(iommu) && PTR_ERR(iommu) == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
 
 	size = max(dev->coherent_dma_mask, dev->coherent_dma_mask + 1);
 	/*
