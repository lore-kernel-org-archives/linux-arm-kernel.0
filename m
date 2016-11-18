From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 18 Nov 2016 00:01:15 +0000
Subject: [PATCH RFC 01/12] drm/i2c: tda998x: avoid race in
 tda998x_encoder_mode_set()
In-Reply-To: <E1c45SW-0005jL-52@rmk-PC.armlinux.org.uk>
References: <20161108122420.GP1041@n2100.armlinux.org.uk>
 <E1c45SW-0005jL-52@rmk-PC.armlinux.org.uk>
Message-ID: <20161118000115.GI1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 08, 2016 at 12:25:00PM +0000, Russell King wrote:
> As priv->audio_params can now be changed at run time, we need to be more
> careful about how we deal with a mode set.  We must take the audio lock
> while checking if there's a valid audio configuration.
> 
> However, it's slightly worse than that - during mode set, we mute the
> audio, and it must not be unmuted until we have finished the mode set.
> It is possible that the audio side may start while a mode set is in
> progress, so take the audio_mutex lock around the whole mode setting
> procedure.
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/gpu/drm/i2c/tda998x_drv.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
> index 088900d78ceb..1cc0433ce9d5 100644
> --- a/drivers/gpu/drm/i2c/tda998x_drv.c
> +++ b/drivers/gpu/drm/i2c/tda998x_drv.c
> @@ -1074,13 +1074,12 @@ tda998x_encoder_mode_set(struct drm_encoder *encoder,
>  
>  		tda998x_write_avi(priv, adjusted_mode);
>  
> -		if (priv->audio_params.format != AFMT_UNUSED) {
> -			mutex_lock(&priv->audio_mutex);
> +		mutex_lock(&priv->audio_mutex);
> +		if (priv->audio_params.format != AFMT_UNUSED)
>  			tda998x_configure_audio(priv,
>  						&priv->audio_params,
>  						adjusted_mode->clock);
> -			mutex_unlock(&priv->audio_mutex);
> -		}
> +		mutex_unlock(&priv->audio_mutex);
>  	}
>  }
>  

I've just realised that this (and the following few changes) require this
mutex to be always initialised.  Currently, we only initialise the audio
mutex when in DT mode, which is bad.  So, I'm going to add this patch in
front of this patch set:

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index 088900d78ceb..168c0b4b8f47 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -1405,6 +1405,8 @@ static int tda998x_create(struct i2c_client *client, struct tda998x_priv *priv)
 	int rev_lo, rev_hi, ret;
 	unsigned short cec_addr;
 
+	mutex_init(&priv->audio_mutex); /* Protect access from audio thread */
+
 	priv->vip_cntrl_0 = VIP_CNTRL_0_SWAP_A(2) | VIP_CNTRL_0_SWAP_B(3);
 	priv->vip_cntrl_1 = VIP_CNTRL_1_SWAP_C(0) | VIP_CNTRL_1_SWAP_D(1);
 	priv->vip_cntrl_2 = VIP_CNTRL_2_SWAP_E(4) | VIP_CNTRL_2_SWAP_F(5);
@@ -1519,8 +1521,6 @@ static int tda998x_create(struct i2c_client *client, struct tda998x_priv *priv)
 		priv->vip_cntrl_2 = video;
 	}
 
-	mutex_init(&priv->audio_mutex); /* Protect access from audio thread */
-
 	ret = tda998x_get_audio_ports(priv, np);
 	if (ret)
 		goto fail;


-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
