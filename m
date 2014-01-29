From: joe@perches.com (Joe Perches)
Date: Wed, 29 Jan 2014 07:16:24 -0800
Subject: [PATCH v5 17/23] drm/i2c: tda998x: set the PLL division factor
 in range 0..3
In-Reply-To: <d4ba259762605793aee726b5e33dcad6a8bd4777.1390986083.git.moinejf@free.fr>
References: <cover.1390986082.git.moinejf@free.fr>
 <d4ba259762605793aee726b5e33dcad6a8bd4777.1390986083.git.moinejf@free.fr>
Message-ID: <1391008584.11756.59.camel@joe-AO722>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2014-01-25 at 18:14 +0100, Jean-Francois Moine wrote:
> The predivider division factor of the register PLL_SERIAL_2 is in the
> range 0..3, the value 0 being used for a division by 1.

trivia:

> diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
[]
> @@ -886,6 +886,11 @@ tda998x_encoder_mode_set(struct drm_encoder *encoder,
>  	}
>  
>  	div = 148500 / mode->clock;
> +	if (div != 0) {
> +		div--;
> +		if (div > 3)
> +			div = 3;
> +	}

perhaps
	clamp(div, 1, 4)
	div--;
