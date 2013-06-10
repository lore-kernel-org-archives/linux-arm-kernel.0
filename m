From: list-09_linux_arm@tqsc.de (Markus Niebel)
Date: Mon, 10 Jun 2013 10:06:57 +0200
Subject: [PATCH] staging: imx_drm: imx_ldb: fix 18 bit format
In-Reply-To: <20130608072556.GA27993@pengutronix.de>
References: <1370594228-2869-1-git-send-email-s.trumtrar@pengutronix.de>
 <20130608044945.GA22416@S2101-09.ap.freescale.net>
 <20130608072556.GA27993@pengutronix.de>
Message-ID: <51B58921.80500@tqsc.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 08.06.2013 09:25, wrote Steffen Trumtrar:
> Hi Shawn!
> 
> On Sat, Jun 08, 2013 at 12:49:47PM +0800, Shawn Guo wrote:
>> On Fri, Jun 07, 2013 at 10:37:08AM +0200, Steffen Trumtrar wrote:
>>> From: Markus Niebel <Markus.Niebel@tqs.de>
>>>
>>> Since 18 bit is supported as datawidth in device tree it should be
>>> supported in driver. Beside the LDB channel the IPU channel has also
>>> to be configured to use BGR666.
>>>
>>> Signed-off-by: Markus Niebel <Markus.Niebel@tqs.de>
>>> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
>>> ---
>>> This is based on the series: "staging: drm/imx: Add LDB support"
>>> by Philipp.
>>>
>>>
>>>  drivers/staging/imx-drm/imx-ldb.c | 18 +++++++++++++++++-
>>>  1 file changed, 17 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/staging/imx-drm/imx-ldb.c b/drivers/staging/imx-drm/imx-ldb.c
>>> index d8fc93c..84bf7d3 100644
>>> --- a/drivers/staging/imx-drm/imx-ldb.c
>>> +++ b/drivers/staging/imx-drm/imx-ldb.c
>>> @@ -179,6 +179,7 @@ static void imx_ldb_encoder_prepare(struct drm_encoder *encoder)
>>>  	struct imx_ldb_channel *imx_ldb_ch = enc_to_imx_ldb_ch(encoder);
>>>  	struct imx_ldb *ldb = imx_ldb_ch->ldb;
>>>  	struct drm_display_mode *mode = &encoder->crtc->mode;
>>> +	u32 pixel_fmt;
>>>  	unsigned long serial_clk;
>>>  	unsigned long di_clk = mode->clock * 1000;
>>>  	int mux = imx_drm_encoder_get_mux_id(imx_ldb_ch->imx_drm_encoder,
>>> @@ -194,8 +195,23 @@ static void imx_ldb_encoder_prepare(struct drm_encoder *encoder)
>>>  		imx_ldb_set_clock(ldb, mux, imx_ldb_ch->chno, serial_clk, di_clk);
>>>  	}
>>>  
>>> +	switch (imx_ldb_ch->chno) {
>>> +	case 0:
>>> +		pixel_fmt = (ldb->ldb_ctrl & LDB_DATA_WIDTH_CH0_24) ?
>>> +			V4L2_PIX_FMT_RGB24 : V4L2_PIX_FMT_BGR666;
>>> +		break;
>>> +	case 1:
>>> +		pixel_fmt = (ldb->ldb_ctrl & LDB_DATA_WIDTH_CH1_24) ?
>>> +			V4L2_PIX_FMT_RGB24 : V4L2_PIX_FMT_BGR666;
>>> +		break;
>>> +	default:
>>> +		dev_err(ldb->dev, "unable to config di%d panel format\n",
>>> +			imx_ldb_ch->chno);
>>> +		pixel_fmt = V4L2_PIX_FMT_RGB24;
>>> +	}
>>> +
>>>  	imx_drm_crtc_panel_format_pins(encoder->crtc, DRM_MODE_ENCODER_LVDS,
>>> -			V4L2_PIX_FMT_RGB24, 2, 3);
>>> +			pixel_fmt, 2, 3);
>>
>> It seems the patch is based on an updated version of "staging: drm/imx:
>> Add LDB support"?  The last one from Philipp [1] calls function
>> imx_drm_crtc_panel_format() rather than imx_drm_crtc_panel_format_pins()
>> there.
>>
> 
> Grmbl! Yes. The last call should be
> 
> imx_drm_crtc_panel_format(encoder->crtc, DRM_MODE_ENCODER_LVDS,
> 			V4L2_PIX_FMT_RGB24);
> 
> like it already is in Philipps series.
> This patch sits on a topic branch, that (I think) Philipp didn't yet sent out.
> I will resent.

We should call 

imx_drm_crtc_panel_format(encoder->crtc, DRM_MODE_ENCODER_LVDS, pixel_fmt);

Sorry, original patch was created before fixing imx_drm_crtc_panel_format.

> 
> Thanks,
> Steffen
> 
