From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 19 Oct 2013 16:55:36 +0100
Subject: imx-drm: Add HDMI support
In-Reply-To: <52602EEA.6060402@prisktech.co.nz>
References: <52602EEA.6060402@prisktech.co.nz>
Message-ID: <20131019155536.GJ25034@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some comments from trying to compile and test this.

Firstly, it's white space damaged.

On Fri, Oct 18, 2013 at 07:39:38AM +1300, Tony Prisk wrote:
> diff --git a/drivers/staging/imx-drm/imx-hdmi.c  
> b/drivers/staging/imx-drm/imx-hdmi.c
> new file mode 100644
> index 0000000..a4b2934
> --- /dev/null
> +++ b/drivers/staging/imx-drm/imx-hdmi.c
> @@ -0,0 +1,1710 @@
...
> +#include <linux/list.h>
> +#include <linux/module.h>
> +#include <linux/of_i2c.h>

Doesn't exist in v3.12-rc.

> +    /* HSYNC active edge delay width (pixel clocks) */
> +    margin = mode->htotal - mode->hsync_end;
> +    hdmi_writeb(hdmi, margin >> 8, HDMI_FC_HSYNCINDELAY1);
> +    hdmi_writeb(hdmi, margin, HDMI_FC_HSYNCINDELAY0);
> +    
...
> +    /* VSYNC active edge delay width (pixel clocks) */
> +    margin = mode->vtotal - mode->vsync_end;
> +    hdmi_writeb(hdmi, margin, HDMI_FC_VSYNCINDELAY);

Both of these are wrong.  The delay is from the end of the active region
to the start of sync pulse.  That's:

	margin = mode->hsync_start - mode->hdisplay;

Also, commentry is wrong: vertical units are in lines, not pixel clocks.

> +static void imx_hdmi_update_csc_coeffs(struct imx_hdmi *hdmi)
> +{
> +    const u16 (*csc_coeff)[3][4] = &csc_coeff_default;
...
> +    hdmi_writeb(hdmi, ((*csc_coeff)[0][0] & 0xff), HDMI_CSC_COEF_A1_LSB);
> +    hdmi_writeb(hdmi, ((*csc_coeff)[0][0] >> 8), HDMI_CSC_COEF_A1_MSB);
> +    hdmi_writeb(hdmi, ((*csc_coeff)[0][1] & 0xff), HDMI_CSC_COEF_A2_LSB);
> +    hdmi_writeb(hdmi, ((*csc_coeff)[0][1] >> 8), HDMI_CSC_COEF_A2_MSB);
> +    hdmi_writeb(hdmi, ((*csc_coeff)[0][2] & 0xff), HDMI_CSC_COEF_A3_LSB);
> +    hdmi_writeb(hdmi, ((*csc_coeff)[0][2] >> 8), HDMI_CSC_COEF_A3_MSB);
> +    hdmi_writeb(hdmi, ((*csc_coeff)[0][3] & 0xff), HDMI_CSC_COEF_A4_LSB);
> +    hdmi_writeb(hdmi, ((*csc_coeff)[0][4] >> 8), HDMI_CSC_COEF_A4_MSB);

Array overrun.  Should be [0][3] not [0][4].

> +    hdmi_writeb(hdmi, ((*csc_coeff)[1][0] & 0xff), HDMI_CSC_COEF_B1_LSB);
> +    hdmi_writeb(hdmi, ((*csc_coeff)[1][0] >> 8), HDMI_CSC_COEF_B1_MSB);
> +    hdmi_writeb(hdmi, ((*csc_coeff)[1][1] & 0xff), HDMI_CSC_COEF_B2_LSB);
> +    hdmi_writeb(hdmi, ((*csc_coeff)[1][1] >> 8), HDMI_CSC_COEF_B2_MSB);
> +    hdmi_writeb(hdmi, ((*csc_coeff)[1][2] & 0xff), HDMI_CSC_COEF_B3_LSB);
> +    hdmi_writeb(hdmi, ((*csc_coeff)[1][2] >> 8), HDMI_CSC_COEF_B3_MSB);
> +    hdmi_writeb(hdmi, ((*csc_coeff)[1][3] & 0xff), HDMI_CSC_COEF_B4_LSB);
> +    hdmi_writeb(hdmi, ((*csc_coeff)[1][4] >> 8), HDMI_CSC_COEF_B4_MSB);

Array overrun.  Should be [1][3] not [1][4].

> +    hdmi_writeb(hdmi, ((*csc_coeff)[2][0] & 0xff), HDMI_CSC_COEF_C1_LSB);
> +    hdmi_writeb(hdmi, ((*csc_coeff)[2][0] >> 8), HDMI_CSC_COEF_C1_MSB);
> +    hdmi_writeb(hdmi, ((*csc_coeff)[2][1] & 0xff), HDMI_CSC_COEF_C2_LSB);
> +    hdmi_writeb(hdmi, ((*csc_coeff)[2][1] >> 8), HDMI_CSC_COEF_C2_MSB);
> +    hdmi_writeb(hdmi, ((*csc_coeff)[2][2] & 0xff), HDMI_CSC_COEF_C3_LSB);
> +    hdmi_writeb(hdmi, ((*csc_coeff)[2][2] >> 8), HDMI_CSC_COEF_C3_MSB);
> +    hdmi_writeb(hdmi, ((*csc_coeff)[2][3] & 0xff), HDMI_CSC_COEF_C4_LSB);
> +    hdmi_writeb(hdmi, ((*csc_coeff)[2][4] >> 8), HDMI_CSC_COEF_C4_MSB);

Array overrun.  Should be [2][3] not [2][4].

> +static int imx_hdmi_register_drm(struct imx_hdmi *hdmi)
> +{
> +    int ret;
> +
> +    drm_mode_connector_attach_encoder(&hdmi->connector, &hdmi->encoder);

This must be done after the encoder has been added, so that
hdmi->encoder.base.id has been initialised.  Other IMX DRM bridges
do this right at the end.  Failure to do this causes the connector
to have no encoders.

> +
> +    hdmi->connector.funcs = &imx_hdmi_connector_funcs;
> +    hdmi->encoder.funcs = &imx_hdmi_encoder_funcs;
> +
> +    hdmi->encoder.encoder_type = DRM_MODE_ENCODER_TMDS;
> +    hdmi->connector.connector_type = DRM_MODE_CONNECTOR_HDMIA;
> +
> +    hdmi->connector.polled = DRM_CONNECTOR_POLL_HPD;
> +
> +    drm_encoder_helper_add(&hdmi->encoder, &imx_hdmi_encoder_helper_funcs);
> +    ret = imx_drm_add_encoder(&hdmi->encoder, &hdmi->imx_drm_encoder,
> +            THIS_MODULE);
> +    if (ret) {
> +        dev_err(hdmi->dev, "adding encoder failed with %d\n", ret);
> +        return ret;
> +    }
> +
> +    drm_connector_helper_add(&hdmi->connector,
> +            &imx_hdmi_connector_helper_funcs);
> +
> +    ret = imx_drm_add_connector(&hdmi->connector,
> +            &hdmi->imx_drm_connector, THIS_MODULE);
> +    if (ret) {
> +        imx_drm_remove_encoder(hdmi->imx_drm_encoder);
> +        dev_err(hdmi->dev, "adding connector failed with %d\n", ret);
> +        return ret;
> +    }
> +
> +    hdmi->connector.encoder = &hdmi->encoder;

drm_mode_connector_attach_encoder() should be here.

On testing, the display flashes on and off, and there's a definite skew
in the output on the last few lines of a 720p display.  This is due to
the wrong sync margins I point out above.

It also suffers from the magenta line down the left hand side of the
display.  This code doesn't seem to solve the issue on imx6solo:

    hdmi_writeb(hdmi, ~HDMI_MC_SWRSTZ_TMDSSWRST_REQ, HDMI_MC_SWRSTZ); 
 
    val = hdmi_readb(hdmi, HDMI_FC_INVIDCONF);   
    
    for (i = 0; i < 5; i++)
        hdmi_writeb(hdmi, val, HDMI_FC_INVIDCONF);
 
    hdmi_writeb(hdmi, ~HDMI_MC_SWRSTZ_TMDSSWRST_REQ, HDMI_MC_SWRSTZ);

instead, it seems to require this:

	/* TMDS software reset */
	hdmi_writeb(hdmi, (u8)~HDMI_MC_SWRSTZ_TMDSSWRST_REQ, HDMI_MC_SWRSTZ);

 	val = hdmi_readb(hdmi, HDMI_FC_INVIDCONF);
	if (hdmi->mx6dl_workaround) {
		hdmi_writeb(hdmi, val, HDMI_FC_INVIDCONF);
		return;
	}
 
 	for (count = 0; count < 5; count++)
 		hdmi_writeb(hdmi, val, HDMI_FC_INVIDCONF);

where mx6dl_workaround is true for the 6solo/duallite, but false for
6quad.  In other words for mx6dl, one reset, followed by a _single_
read + write of HDMI_FC_INVIDCONF.

As I've written previously, I think we need to use two compatible
strings to identify the different SoCs so we can activate the
appropriate workaround according to which SoC we're running on.
