From: ck.hu@mediatek.com (CK Hu)
Date: Mon, 22 May 2017 14:07:16 +0800
Subject: [PATCH] drm/mediatek: fix
 mtk_hdmi_setup_vendor_specific_infoframe mistake
In-Reply-To: <1490084823-3968-1-git-send-email-nickey.yang@rock-chips.com>
References: <1490084823-3968-1-git-send-email-nickey.yang@rock-chips.com>
Message-ID: <1495433236.20811.13.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Nickey:

Sorry for the late reply. I've applied this patch to my branch
mediatek-drm-fixes-4.12-rc1.

Regards,
CK

On Tue, 2017-03-21 at 16:27 +0800, Nickey Yang wrote:
> mtk_hdmi_setup_vendor_specific_infoframe will return before handle
> mtk_hdmi_hw_send_info_frame.Because hdmi_vendor_infoframe_pack
> returns the number of bytes packed into the binary buffer or
> a negative error code on failure.
> So correct it.
> 
> Signed-off-by: Nickey Yang <nickey.yang@rock-chips.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_hdmi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
> index c262512..b43aa29 100644
> --- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
> @@ -1062,7 +1062,7 @@ static int mtk_hdmi_setup_vendor_specific_infoframe(struct mtk_hdmi *hdmi,
>  	}
>  
>  	err = hdmi_vendor_infoframe_pack(&frame, buffer, sizeof(buffer));
> -	if (err) {
> +	if (err < 0) {
>  		dev_err(hdmi->dev, "Failed to pack vendor infoframe: %zd\n",
>  			err);
>  		return err;
