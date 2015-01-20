From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Tue, 20 Jan 2015 13:52:30 +0100
Subject: [PATCH v4 9/9] drm/exynos: add support for 'hdmi' clock
In-Reply-To: <1421756219-21037-10-git-send-email-m.szyprowski@samsung.com>
References: <1421756219-21037-1-git-send-email-m.szyprowski@samsung.com>
 <1421756219-21037-10-git-send-email-m.szyprowski@samsung.com>
Message-ID: <54BE4F8E.50605@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Marek,

On 01/20/2015 01:16 PM, Marek Szyprowski wrote:
> Mixed need to have hdmi clock enabled to properly perform power on/off
> sequences, so add handling of this clock directly to the mixer driver.
> Dependency between hdmi clock and mixer module has been observed on
> Exynos4 based boards.
> 
> Suggested-by: Andrzej Hajda <a.hajda@samsung.com>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/gpu/drm/exynos/exynos_mixer.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/gpu/drm/exynos/exynos_mixer.c b/drivers/gpu/drm/exynos/exynos_mixer.c
> index 820b76234ef4..e5ef1fccd8fb 100644
> --- a/drivers/gpu/drm/exynos/exynos_mixer.c
> +++ b/drivers/gpu/drm/exynos/exynos_mixer.c
> @@ -72,6 +72,7 @@ struct mixer_resources {
>  	spinlock_t		reg_slock;
>  	struct clk		*mixer;
>  	struct clk		*vp;
> +	struct clk		*hdmi;
>  	struct clk		*sclk_mixer;
>  	struct clk		*sclk_hdmi;
>  	struct clk		*mout_mixer;
> @@ -774,6 +775,12 @@ static int mixer_resources_init(struct mixer_context *mixer_ctx)
>  		return -ENODEV;
>  	}
>  
> +	mixer_res->hdmi = devm_clk_get(dev, "hdmi");

You need to update the Documentation/devicetree/bindings/video/exynos_mixer.txt
DT binding docs to also mention the "hdmi" clock in the list of clocks.

But as I mentioned in "[PATCH v2 0/6] Enable HDMI support on Exynos platforms"
thread, while this seems to be enough to prevent the issue on Exynos4 is not
enough on the Exynos5420/5422/5800 boards I've tested.

So I wonder if $subject is fixing the root cause or just fixing a symptom and
the cause is that the exynos_hdmi DPMS handler has to be executed before the
exynos_mixer DPMS handler for DRM_MODE_DPMS_ON like is the case for DPMS_OFF
after commit 245f98f269714 ("drm/exynos: hdmi: fix power order issue").

Best regards,
Javier
