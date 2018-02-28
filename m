From: giulio.benetti@micronovasrl.com (Giulio Benetti)
Date: Wed, 28 Feb 2018 18:09:22 +0100
Subject: [2/3] drm/sun4i: rgb: Fix potential division by zero
In-Reply-To: <20180221125703.4595-2-maxime.ripard@bootlin.com>
References: <20180221125703.4595-2-maxime.ripard@bootlin.com>
Message-ID: <ddbbd909-f72c-100f-72a4-813d9aca4476@micronovasrl.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Il 21/02/2018 13:57, Maxime Ripard ha scritto:
> In the case where mode_valid callback of our RGB connector was called
> before mode_set was being called, the range of dividers would not be set,
> resulting in a division by zero later on in the clk_round_rate logic.
> 
> Set the range of dividers before calling clk_round_rate to fix this.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Tested-by: Giulio Benetti <giulio.benetti@micronovasrl.com>

Before crtc couldn't be added because of min=0 and max=0.
Now they're initiliazed and crtc is added correctly.
> ---
>   drivers/gpu/drm/sun4i/sun4i_rgb.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun4i_rgb.c b/drivers/gpu/drm/sun4i/sun4i_rgb.c
> index 832f8f9bc47f..b8da5a50a61d 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_rgb.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_rgb.c
> @@ -92,6 +92,8 @@ static int sun4i_rgb_mode_valid(struct drm_connector *connector,
>   
>   	DRM_DEBUG_DRIVER("Vertical parameters OK\n");
>   
> +	tcon->dclk_min_div = 6;
> +	tcon->dclk_max_div = 127;
>   	rounded_rate = clk_round_rate(tcon->dclk, rate);
>   	if (rounded_rate < rate)
>   		return MODE_CLOCK_LOW;
> 


-- 
Giulio Benetti
CTO

MICRONOVA SRL
Sede: Via A. Niedda 3 - 35010 Vigonza (PD)
Tel. 049/8931563 - Fax 049/8931346
Cod.Fiscale - P.IVA 02663420285
Capitale Sociale ? 26.000 i.v.
Iscritta al Reg. Imprese di Padova N. 02663420285
Numero R.E.A. 258642
