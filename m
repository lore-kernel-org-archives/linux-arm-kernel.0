From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 4 Jan 2016 09:27:25 +0100
Subject: [PATCH] drm: arm-hdlcd: remove DMA_CMA select
In-Reply-To: <4194408.X82ccDjh5X@wuerfel>
References: <4194408.X82ccDjh5X@wuerfel>
Message-ID: <20160104082725.GE23797@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 01, 2016 at 03:09:10PM +0100, Arnd Bergmann wrote:
> The newly added DRM_HDLCD driver tries to select DMA_CMA, but that is
> not necessarily possible, as not all configurations contain HAVE_DMA_CONTIGUOUS:
> 
> warning: (DRM_HDLCD) selects DMA_CMA which has unmet direct dependencies (HAVE_DMA_CONTIGUOUS && CMA)
> drivers/built-in.o: In function `dma_alloc_from_contiguous':
> :(.text+0x1dee00): undefined reference to `cma_alloc'
> drivers/built-in.o: In function `dma_release_from_contiguous':
> :(.text+0x1dee24): undefined reference to `cma_release'
> 
> This removes the 'select' statement. It is not needed because CMA is meant
> to transparently change the behavior of dma_alloc_coherent to make it succeed
> for larger allocations, but there is no actual build-time dependency, and
> the driver can still work without CMA in many cases.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 1561e558334d ("drm: Add support for ARM's HDLCD controller.")
> ---
> Found on ARM randconfig builds with yesterday's linux-next

Reviewed-by: Thierry Reding <treding@nvidia.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160104/e10f1e0d/attachment.sig>
