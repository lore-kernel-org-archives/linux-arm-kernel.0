From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 11 Jan 2014 18:03:10 +0000
Subject: [PATCH v2 12/28] drm/i2c: tda998x: add DT support
In-Reply-To: <20140109120324.4e2c8aca@armhf>
References: <20140109120324.4e2c8aca@armhf>
Message-ID: <20140111180310.GA15937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 09, 2014 at 12:03:24PM +0100, Jean-Francois Moine wrote:
> This patch adds DT support to the tda998x.
> 
> As a side effect, now, the audio sample rate is always 48kHz and the
> audio clock is always set.
> 
> Signed-off-by: Jean-Francois Moine <moinejf@free.fr>

This patch breaks audio through the renaming of variable names.  When you
do such changes, *never* change all three together.  Do them one at a time,
replacing all instances of one variable before moving on to the next one.
This avoids getting the names muddled up.

> -	struct tda998x_encoder_params params;
> +
> +	u8 audio_type;		/* audio type */
> +	u8 audio_frame[6];
> +	u32 audio_port;

"audio type" is a pointless comment for a variable called "audio_type".
Explain what it is.  It's the input format, which may be SPDIF or I2S.

>  	/* Set audio input source */
> -	switch (p->audio_format) {
> +	switch (priv->audio_type) {

So, "audio_format" has become "audio_type" here.

> @@ -698,7 +703,13 @@ tda998x_encoder_set_config(struct drm_encoder *encoder, void *params)
>  			    VIP_CNTRL_2_SWAP_F(p->swap_f) |
>  			    (p->mirr_f ? VIP_CNTRL_2_MIRR_F : 0);
>  
> -	priv->params = *p;
> +	memcpy(priv->audio_frame, p->audio_frame,
> +			sizeof priv->audio_frame);
> +
> +	if (p->audio_cfg) {
> +		priv->audio_port = p->audio_cfg;
> +		priv->audio_type = p->audio_format;
> +	}

Here, audio_port and audio_type are only written to if audio_cfg is
non-zero, which is not quite what is intended here.  If you want DT
to override this, then make that explicit.

Moreover, we can see that this confirms that "audio_format" becomes
"audio_type", and "audio_cfg" becomes "audio_port".

> @@ -947,8 +958,8 @@ tda998x_encoder_mode_set(struct drm_encoder *encoder,
>  
>  		tda998x_write_avi(priv, mode);
>  
> -		if (priv->params.audio_cfg)
> -			tda998x_configure_audio(priv, mode, &priv->params);
> +		if (priv->audio_type)
> +			tda998x_configure_audio(priv, mode);

And here we have the real bug.  "audio_cfg" has become "audio_type",
which in the case of SPDIF, is zero.  Hence, with a SPDIF source,
tda998x_configure_audio() is no longer called.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
