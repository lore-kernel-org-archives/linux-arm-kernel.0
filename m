From: ck.hu@mediatek.com (CK Hu)
Date: Mon, 30 Apr 2018 18:58:36 +0800
Subject: [v3 09/10] drm: mediatek: Omit warning on probe defers
In-Reply-To: <9d514a4ab45f0700663fa756d5aa3913922b6fb7.1524820923.git.mbrugger@suse.com>
References: <cover.1524820923.git.mbrugger@suse.com>
 <9d514a4ab45f0700663fa756d5aa3913922b6fb7.1524820923.git.mbrugger@suse.com>
Message-ID: <1525085916.25456.8.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Matthias:

On Fri, 2018-04-27 at 11:24 +0200, matthias.bgg at kernel.org wrote:
> From: Matthias Brugger <mbrugger@suse.com>
> 
> When probe through the MFD, it can happen that the
> clock drivers wasn't probed before the ddp driver gets
> invoked. The driver used to omit a warning that the driver
> failed to get the clocks. Omit this error on the defered probe path.
> 
> Signed-off-by: Matthias Brugger <mbrugger@suse.com>

It's better to use 'drm/mediatek:' for title to align drm commits.
For the modification,

Acked-by: CK Hu <ck.hu@mediatek.com>

Regards,
CK

> ---
>  drivers/gpu/drm/mediatek/mtk_drm_ddp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> index bafc5c77c4fb..6b399348a2dc 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> @@ -374,7 +374,8 @@ static int mtk_ddp_probe(struct platform_device *pdev)
>  
>  	ddp->clk = devm_clk_get(dev, NULL);
>  	if (IS_ERR(ddp->clk)) {
> -		dev_err(dev, "Failed to get clock\n");
> +		if (PTR_ERR(ddp->clk) != -EPROBE_DEFER)
> +			dev_err(dev, "Failed to get clock\n");
>  		return PTR_ERR(ddp->clk);
>  	}
>  
