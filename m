From: jernej.skrabec@siol.net (Jernej =?utf-8?B?xaBrcmFiZWM=?=)
Date: Mon, 27 Nov 2017 17:07:04 +0100
Subject: [PATCH v2 05/18] drm/sun4i: Force the mixer rate at 150MHz
In-Reply-To: <55becb3a86a0a28ccca3f7c831ac6f6cf4854390.1511797218.git-series.maxime.ripard@free-electrons.com>
References: <cover.d89f3ea4e1698f9343aef4852977c80edc75f21a.1511797218.git-series.maxime.ripard@free-electrons.com>
 <55becb3a86a0a28ccca3f7c831ac6f6cf4854390.1511797218.git-series.maxime.ripard@free-electrons.com>
Message-ID: <9630064.mDmGGWOQGt@jernej-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

Dne ponedeljek, 27. november 2017 ob 16:41:29 CET je Maxime Ripard napisal(a):
> It seems like the mixer can only run properly when clocked at 150MHz. In
> order to have something more robust than simply a fire-and-forget
> assigned-clocks-rate, let's put that in the code.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/gpu/drm/sun4i/sun8i_mixer.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c
> b/drivers/gpu/drm/sun4i/sun8i_mixer.c index cb193c5f1686..c0cdccf772a2
> 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
> @@ -315,6 +315,13 @@ static int sun8i_mixer_bind(struct device *dev, struct
> device *master, }
>  	clk_prepare_enable(mixer->mod_clk);
> 
> +	/*
> +	 * It seems that we need to enforce that rate for whatever
> +	 * reason for the mixer to be functional. Make sure it's the
> +	 * case.
> +	 */
> +	clk_set_rate(mixer->mod_clk, 150000000);
> +

H3 mixer works at much higher rate and if we want to support tv out, it must 
be dividable by 432 MHz, so either 432 MHz or maybe even 864 MHz.

We talked about that few months ago.

I guess this should be read from mixer configuration structure.

Best regards,
Jernej

>  	list_add_tail(&mixer->engine.list, &drv->engine_list);
> 
>  	/* Reset the registers */
> --
> git-series 0.9.1
