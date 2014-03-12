From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Wed, 12 Mar 2014 12:43:43 +0100
Subject: [PATCH v9][ 3/8] staging: imx-drm: Correct BGR666 and the
 board's dts that use them.
In-Reply-To: <1394121702-13257-3-git-send-email-denis@eukrea.com>
References: <1394121702-13257-1-git-send-email-denis@eukrea.com>
 <1394121702-13257-3-git-send-email-denis@eukrea.com>
Message-ID: <20140312124343.448f8287@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Denis Carikli wrote:
> The current BGR666 is not consistent with the other color mapings like BGR24.
> BGR666 should be in the same byte order than BGR24.
> 
[...]
> diff --git a/drivers/staging/imx-drm/ipu-v3/ipu-dc.c b/drivers/staging/imx-drm/ipu-v3/ipu-dc.c
> index 6f9abe8..154d293 100644
> --- a/drivers/staging/imx-drm/ipu-v3/ipu-dc.c
> +++ b/drivers/staging/imx-drm/ipu-v3/ipu-dc.c
> @@ -397,9 +397,9 @@ int ipu_dc_init(struct ipu_soc *ipu, struct device *dev,
>  
>  	/* bgr666 */
>  	ipu_dc_map_clear(priv, IPU_DC_MAP_BGR666);
> -	ipu_dc_map_config(priv, IPU_DC_MAP_BGR666, 0, 5, 0xfc); /* blue */
> +	ipu_dc_map_config(priv, IPU_DC_MAP_BGR666, 0, 17, 0xfc); /* blue */
>  	ipu_dc_map_config(priv, IPU_DC_MAP_BGR666, 1, 11, 0xfc); /* green */
> -	ipu_dc_map_config(priv, IPU_DC_MAP_BGR666, 2, 17, 0xfc); /* red */
> +	ipu_dc_map_config(priv, IPU_DC_MAP_BGR666, 2, 5, 0xfc); /* red */
>  
>  	/* bgr24 */
>  	ipu_dc_map_clear(priv, IPU_DC_MAP_BGR24);
>
You obviously missed this one which is also affected by your change:
diff --git a/drivers/staging/imx-drm/imx-ldb.c b/drivers/staging/imx-drm/imx-ldb.c
index daa54df..e5a600b 100644
--- a/drivers/staging/imx-drm/imx-ldb.c
+++ b/drivers/staging/imx-drm/imx-ldb.c
@@ -185,11 +185,11 @@ static void imx_ldb_encoder_prepare(struct drm_encoder *encoder)
 	switch (imx_ldb_ch->chno) {
 	case 0:
 		pixel_fmt = (ldb->ldb_ctrl & LDB_DATA_WIDTH_CH0_24) ?
-			V4L2_PIX_FMT_RGB24 : V4L2_PIX_FMT_BGR666;
+			V4L2_PIX_FMT_RGB24 : V4L2_PIX_FMT_RGB666;
 		break;
 	case 1:
 		pixel_fmt = (ldb->ldb_ctrl & LDB_DATA_WIDTH_CH1_24) ?
-			V4L2_PIX_FMT_RGB24 : V4L2_PIX_FMT_BGR666;
+			V4L2_PIX_FMT_RGB24 : V4L2_PIX_FMT_RGB666;
 		break;
 	default:
 		dev_err(ldb->dev, "unable to config di%d panel format\n",

Without this patch Red/Blue on an 18bit LVDS display will be swapped.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
