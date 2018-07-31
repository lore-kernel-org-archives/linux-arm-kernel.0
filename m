From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 31 Jul 2018 10:42:47 +0100
Subject: [PATCH 4/4] drm/i2c: tda998x: add support for pixel repeated modes
In-Reply-To: <E1fkQvf-0003nV-CW@rmk-PC.armlinux.org.uk>
References: <20180731092343.GH17271@n2100.armlinux.org.uk>
 <E1fkQvf-0003nV-CW@rmk-PC.armlinux.org.uk>
Message-ID: <20180731094247.GI17271@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 31, 2018 at 10:26:55AM +0100, Russell King wrote:
> TDA998x has no support for pixel repeated modes, and the code notes this
> as a "TODO" item.  The implementation appears to be relatively simple,
> so lets add it.
> 
> We need to calculate the serializer clock divisor based on the TMDS
> clock rate, set the repeat control, and set the serializer pixel
> repeat count.  Since the audio code needs the actual TMDS clock,
> record that.

Note that this is an experimental patch - I haven't yet been able to
test it beyond "does it still work with non-doubled modes".  They
tend to be low resolution modes, because the doubling is needed to
maintain a minimum clock rate over HDMI.

The doubled modes are (eg):

VIC 	Name
6	720(1440)x480i at 60Hz
7	720(1440)x480i at 60Hz
8	720(1440)x240 at 60Hz
21	720(1440)x576i at 50Hz
22	720(1440)x576i at 50Hz
23	720(1440)x288 at 50Hz
24	720(1440)x288 at 50Hz

They are probably only found with TVs rather than monitors.

> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/gpu/drm/i2c/tda998x_drv.c | 26 ++++++++++++++++----------
>  1 file changed, 16 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
> index a31809ce30e2..08ce28cbdec4 100644
> --- a/drivers/gpu/drm/i2c/tda998x_drv.c
> +++ b/drivers/gpu/drm/i2c/tda998x_drv.c
> @@ -241,6 +241,7 @@ struct tda998x_priv {
>  # define HVF_CNTRL_1_PAD(x)       (((x) & 3) << 4)
>  # define HVF_CNTRL_1_SEMI_PLANAR  (1 << 6)
>  #define REG_RPT_CNTRL             REG(0x00, 0xf0)     /* write */
> +# define RPT_CNTRL_REPEAT(x)      ((x) & 15)
>  #define REG_I2S_FORMAT            REG(0x00, 0xfc)     /* read/write */
>  # define I2S_FORMAT(x)            (((x) & 3) << 0)
>  #define REG_AIP_CLKSEL            REG(0x00, 0xfd)     /* write */
> @@ -1342,7 +1343,7 @@ static void tda998x_bridge_mode_set(struct drm_bridge *bridge,
>  	u16 vwin1_line_s, vwin1_line_e;
>  	u16 vwin2_line_s, vwin2_line_e;
>  	u16 de_pix_s, de_pix_e;
> -	u8 reg, div, rep;
> +	u8 reg, div, rep, sel_clk;
>  
>  	/*
>  	 * Internally TDA998x is using ITU-R BT.656 style sync but
> @@ -1405,7 +1406,16 @@ static void tda998x_bridge_mode_set(struct drm_bridge *bridge,
>  			       (mode->vsync_end - mode->vsync_start)/2;
>  	}
>  
> -	tmds_clock = mode->clock;
> +	/*
> +	 * Select pixel repeat depending on the double-clock flag
> +	 * (which means we have to repeat each pixel once.)
> +	 */
> +	rep = mode->flags & DRM_MODE_FLAG_DBLCLK ? 1 : 0;
> +	sel_clk = SEL_CLK_ENA_SC_CLK | SEL_CLK_SEL_CLK1 |
> +		  SEL_CLK_SEL_VRF_CLK(rep ? 2 : 0);
> +
> +	/* the TMDS clock is scaled up by the pixel repeat */
> +	tmds_clock = mode->clock * (1 + rep);
>  
>  	/*
>  	 * The divisor is power-of-2. The TDA9983B datasheet gives
> @@ -1421,6 +1431,8 @@ static void tda998x_bridge_mode_set(struct drm_bridge *bridge,
>  
>  	mutex_lock(&priv->audio_mutex);
>  
> +	priv->tmds_clock = tmds_clock;
> +
>  	/* mute the audio FIFO: */
>  	reg_set(priv, REG_AIP_CNTRL_0, AIP_CNTRL_0_RST_FIFO);
>  
> @@ -1443,12 +1455,8 @@ static void tda998x_bridge_mode_set(struct drm_bridge *bridge,
>  	reg_write(priv, REG_SERIALIZER, 0);
>  	reg_write(priv, REG_HVF_CNTRL_1, HVF_CNTRL_1_VQR(0));
>  
> -	/* TODO enable pixel repeat for pixel rates less than 25Msamp/s */
> -	rep = 0;
> -	reg_write(priv, REG_RPT_CNTRL, 0);
> -	reg_write(priv, REG_SEL_CLK, SEL_CLK_SEL_VRF_CLK(0) |
> -			SEL_CLK_SEL_CLK1 | SEL_CLK_ENA_SC_CLK);
> -
> +	reg_write(priv, REG_RPT_CNTRL, RPT_CNTRL_REPEAT(rep));
> +	reg_write(priv, REG_SEL_CLK, sel_clk);
>  	reg_write(priv, REG_PLL_SERIAL_2, PLL_SERIAL_2_SRL_NOSC(div) |
>  			PLL_SERIAL_2_SRL_PR(rep));
>  
> @@ -1516,8 +1524,6 @@ static void tda998x_bridge_mode_set(struct drm_bridge *bridge,
>  	/* must be last register set: */
>  	reg_write(priv, REG_TBG_CNTRL_0, 0);
>  
> -	priv->tmds_clock = adjusted_mode->clock;
> -
>  	/* CEA-861B section 6 says that:
>  	 * CEA version 1 (CEA-861) has no support for infoframes.
>  	 * CEA version 2 (CEA-861A) supports version 1 AVI infoframes,
> -- 
> 2.7.4
> 

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up
