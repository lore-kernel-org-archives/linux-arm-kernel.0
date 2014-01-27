From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 27 Jan 2014 20:12:31 +0000
Subject: [PATCH v4 24/24] drm/i2c: tda998x: adjust the audio clock
 divider for S/PDIF
In-Reply-To: <20140125181436.5c443251@armhf>
References: <cover.1390646891.git.moinejf@free.fr>
 <20140125181436.5c443251@armhf>
Message-ID: <20140127201231.GY15937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 25, 2014 at 06:14:36PM +0100, Jean-Francois Moine wrote:
> According to some tests on the Cubox (Marvell Armada 510 + TDA19988),
> the S/PDIF input asks for a greater audio clock divider.
> 
> Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
> ---
>  drivers/gpu/drm/i2c/tda998x_drv.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
> index b4827c0..e4dfcb4 100644
> --- a/drivers/gpu/drm/i2c/tda998x_drv.c
> +++ b/drivers/gpu/drm/i2c/tda998x_drv.c
> @@ -679,10 +679,14 @@ tda998x_configure_audio(struct tda998x_priv *priv,
>  	 * There is no detailed info in the datasheet, so we just
>  	 * assume 100MHz requires larger divider.
>  	 */
> +	adiv = AUDIO_DIV_SERCLK_8;
>  	if (mode->clock > 100000)
> -		adiv = AUDIO_DIV_SERCLK_16;
> -	else
> -		adiv = AUDIO_DIV_SERCLK_8;
> +		adiv++;			/* AUDIO_DIV_SERCLK_8 */
> +
> +	/* S/PDIF asks for a larger divider */
> +	if (p->audio_format == AFMT_SPDIF)
> +		adiv++;			/* AUDIO_DIV_SERCLK_16 or _32 */

I'm not sure these comments are quite right... You start off with
adiv at AUDIO_DIV_SERCLK_8, and then you increment it, but the
comment says it's AUDIO_DIV_SERCLK_8 ?  Shouldn't it become
AUDIO_DIV_SERCLK_16 ?

Please review the above change yourself. :)

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
