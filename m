From: Andrew.Jackson@arm.com (Andrew Jackson)
Date: Wed, 23 Jul 2014 11:22:06 +0100
Subject: [PATCH v3] ASoC: tda998x: add a codec to the HDMI transmitter
In-Reply-To: <20140708114057.5ef3cfd0@armhf>
References: <20140708114057.5ef3cfd0@armhf>
Message-ID: <53CF8CCE.3030205@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/08/14 10:40, Jean-Francois Moine wrote:
> This patch adds a CODEC function to the NXP TDA998x HDMI transmitter.
> 
> The CODEC handles both I2S and S/PDIF input and does dynamic input
> switch in the TDA998x I2C driver on start/stop audio streaming.
> 
> Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
> ---

Shouldn't the patch also capture the current audio rate in tda998x_codec.c:tda_hw_params?  Otherwise, when tda998x_drv.c:tda998x_audio_start invokes tda998x_drv.c:tda998x_configure_audio, the value of 'N' will be calculated incorrectly.

So something similar to:

diff --git a/drivers/gpu/drm/i2c/tda998x_codec.c b/drivers/gpu/drm/i2c/tda998x_codec.c
index e7f223d..b6c4fb3 100755
--- a/drivers/gpu/drm/i2c/tda998x_codec.c
+++ b/drivers/gpu/drm/i2c/tda998x_codec.c
@@ -111,6 +111,7 @@ static int tda_hw_params(struct snd_pcm_substream *substream,
 		tda998x_audio_start(priv, 0);
 		return 0;
 	}
+	priv->params.audio_sample_rate = params_rate(params);
 	priv->params.audio_format = dai->id;
 	priv->audio_sample_format = params_format(params);
 	params.audio_cfg =


   Andrew
