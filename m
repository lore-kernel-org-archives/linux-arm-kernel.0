From: sakari.ailus@iki.fi (Sakari Ailus)
Date: Tue, 13 Mar 2018 13:14:08 +0200
Subject: [PATCH] media: omap3isp: fix unbalanced dma_iommu_mapping
In-Reply-To: <20180312165207.12436-1-s-anna@ti.com>
References: <20180312165207.12436-1-s-anna@ti.com>
Message-ID: <20180313111407.egptbq5vbkny5q4d@valkosipuli.retiisi.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Suman,

Thanks for the patch.

On Mon, Mar 12, 2018 at 11:52:07AM -0500, Suman Anna wrote:
> The OMAP3 ISP driver manages its MMU mappings through the IOMMU-aware
> ARM DMA backend. The current code creates a dma_iommu_mapping and
> attaches this to the ISP device, but never detaches the mapping in
> either the probe failure paths or the driver remove path resulting
> in an unbalanced mapping refcount and a memory leak. Fix this properly.
> 
> Reported-by: Pavel Machek <pavel@ucw.cz>
> Signed-off-by: Suman Anna <s-anna@ti.com>
> Tested-by: Pavel Machek <pavel@ucw.cz>
> ---
> Hi Mauro, Laurent,
> 
> This fixes an issue reported by Pavel and discussed on this
> thread,
> https://marc.info/?l=linux-omap&m=152051945803598&w=2
> 
> Posting this again to the appropriate lists.
> 
> regards
> Suman
> 
>  drivers/media/platform/omap3isp/isp.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/omap3isp/isp.c b/drivers/media/platform/omap3isp/isp.c
> index 8eb000e3d8fd..c7d667bfc2af 100644
> --- a/drivers/media/platform/omap3isp/isp.c
> +++ b/drivers/media/platform/omap3isp/isp.c
> @@ -1945,6 +1945,7 @@ static int isp_initialize_modules(struct isp_device *isp)
>  
>  static void isp_detach_iommu(struct isp_device *isp)
>  {
> +	arm_iommu_detach_device(isp->dev);
>  	arm_iommu_release_mapping(isp->mapping);
>  	isp->mapping = NULL;
>  }
> @@ -1971,13 +1972,15 @@ static int isp_attach_iommu(struct isp_device *isp)
>  	ret = arm_iommu_attach_device(isp->dev, mapping);
>  	if (ret < 0) {
>  		dev_err(isp->dev, "failed to attach device to VA mapping\n");
> -		goto error;
> +		goto error_attach;

Instead of changing the label here, could you return immediately where the
previous point of error handling is? No need to add another label.

After fixing that you can add:

Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>

>  	}
>  
>  	return 0;
>  
> +error_attach:
> +	arm_iommu_release_mapping(isp->mapping);
> +	isp->mapping = NULL;
>  error:
> -	isp_detach_iommu(isp);
>  	return ret;
>  }
>  
> 

-- 
Sakari Ailus
e-mail: sakari.ailus at iki.fi
