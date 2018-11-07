From: a.hajda@samsung.com (Andrzej Hajda)
Date: Wed, 7 Nov 2018 12:49:30 +0100
Subject: [PATCH v6 6/6] drm/bridge: add PHY initialization in mhdp8546
 driver.
In-Reply-To: <1539034953-11274-7-git-send-email-dkos@cadence.com>
References: <1539034953-11274-1-git-send-email-dkos@cadence.com>
 <CGME20181008214506epcas2p2cf110c14fcc340c42e1c6da4b03d8901@epcas2p2.samsung.com>
 <1539034953-11274-7-git-send-email-dkos@cadence.com>
Message-ID: <df739067-b1a6-2eda-cb75-e008a0e02534@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08.10.2018 23:42, Damian Kos wrote:
> This patch modifies the mhdp8546 driver to initialize sd0801 "Torrent" PHY.
>
> And removes the dbg_regs field from cdns_mhdp_device structure.
>
> Signed-off-by: Damian Kos <dkos@cadence.com>
> ---
>  drivers/gpu/drm/bridge/cdns-mhdp.c    | 9 +++++++++
>  include/drm/bridge/cdns-mhdp-common.h | 1 -
>  2 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/bridge/cdns-mhdp.c b/drivers/gpu/drm/bridge/cdns-mhdp.c
> index 48ac5cf1e031..caaf3c17d74f 100644
> --- a/drivers/gpu/drm/bridge/cdns-mhdp.c
> +++ b/drivers/gpu/drm/bridge/cdns-mhdp.c
> @@ -17,6 +17,7 @@
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
> +#include <linux/phy/phy.h>
>  
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_bridge.h>
> @@ -1220,6 +1221,12 @@ static int mhdp_probe(struct platform_device *pdev)
>  	if (IS_ERR(mhdp->regs))
>  		return PTR_ERR(mhdp->regs);
>  
> +	mhdp->phy = devm_phy_get(&pdev->dev, "dpphy");


It is not documented in the bindings.


> +	if (IS_ERR(mhdp->phy)) {
> +		dev_err(&pdev->dev, "no PHY configured\n");


dev_err only if err != -EPROBE_DEFER


> +		return PTR_ERR(mhdp->phy);
> +	}
> +
>  	platform_set_drvdata(pdev, mhdp);
>  
>  	ret = load_firmware(mhdp, FW_NAME, CDNS_MHDP_IMEM);
> @@ -1291,6 +1298,8 @@ static int mhdp_probe(struct platform_device *pdev)
>  			   mhdp->dev, HDMI_CODEC_DRV_NAME, PLATFORM_DEVID_AUTO,
>  			   &codec_data, sizeof(codec_data));
>  
> +	phy_init(mhdp->phy);
> +


Beside this:

Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

?--
Regards
Andrzej


>  	/* Enable VIF clock for stream 0 */
>  	cdns_mhdp_reg_read(mhdp, CDNS_DPTX_CAR, &resp);
>  	cdns_mhdp_reg_write(mhdp, CDNS_DPTX_CAR,
> diff --git a/include/drm/bridge/cdns-mhdp-common.h b/include/drm/bridge/cdns-mhdp-common.h
> index d4711091ff2b..1e8a44138ce2 100644
> --- a/include/drm/bridge/cdns-mhdp-common.h
> +++ b/include/drm/bridge/cdns-mhdp-common.h
> @@ -553,7 +553,6 @@ struct cdns_mhdp_device {
>  	struct cdns_mhdp_sink	sink;
>  	struct cdns_mhdp_bridge	bridge;
>  	struct phy		*phy;
> -	void __iomem		*dbg_regs;
>  
>  	struct video_info	video_info;
>  	struct drm_display_mode	mode;
