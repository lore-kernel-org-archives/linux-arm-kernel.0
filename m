From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 5 Nov 2009 17:32:51 +0000
Subject: [PATCH 2/3] ARM: MXC: mxcmmc: Fix max_seg_size assignment
In-Reply-To: <1257441216-19604-3-git-send-email-daniel@caiaq.de>
References: <1257441216-19604-1-git-send-email-daniel@caiaq.de>
	<1257441216-19604-2-git-send-email-daniel@caiaq.de>
	<1257441216-19604-3-git-send-email-daniel@caiaq.de>
Message-ID: <20091105173251.GF21681@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Err "fix" ?  No, that's not what this is.

max_seg_size is the maximum segment size, not the maximum request size.
The naming of these comes from the block IO subsystem, so it's a good
idea to preserve the naming (and therefore the meaning.)

max_req_size suggests that this parameter indicates the maximum size
of any single request.  A single request can be made up of multiple
segments, so clearly this change is misleading.

On Thu, Nov 05, 2009 at 06:13:35PM +0100, Daniel Mack wrote:
> Signed-off-by: Daniel Mack <daniel@caiaq.de>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/mmc/host/mxcmmc.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
> index 32ac139..8aa6de0 100644
> --- a/drivers/mmc/host/mxcmmc.c
> +++ b/drivers/mmc/host/mxcmmc.c
> @@ -714,7 +714,7 @@ static int mxcmci_probe(struct platform_device *pdev)
>  	mmc->max_blk_size = 2048;
>  	mmc->max_blk_count = 65535;
>  	mmc->max_req_size = mmc->max_blk_size * mmc->max_blk_count;
> -	mmc->max_seg_size = mmc->max_seg_size;
> +	mmc->max_seg_size = mmc->max_req_size;
>  
>  	host = mmc_priv(mmc);
>  	host->base = ioremap(r->start, resource_size(r));
> -- 
> 1.6.5.2
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
