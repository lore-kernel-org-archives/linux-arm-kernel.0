From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 7 Mar 2014 16:35:46 +0000
Subject: [PATCH v9][ 4/8] imx-drm: Match ipu_di_signal_cfg's clk_pol
 with its description.
In-Reply-To: <1394121869-13387-1-git-send-email-denis@eukrea.com>
References: <1394121702-13257-3-git-send-email-denis@eukrea.com>
 <1394121869-13387-1-git-send-email-denis@eukrea.com>
Message-ID: <20140307163546.GN21483@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 06, 2014 at 05:04:25PM +0100, Denis Carikli wrote:
> According to the datasheet, setting the di0_polarity_disp_clk
> field in the GENERAL di register sets the output clock polarity
> to active high.
> 
> Signed-off-by: Denis Carikli <denis@eukrea.com>
> ---
> ChangeLog v8->v9:
> - New patch that is now needed by the
>   "staging: imx-drm: Use de-active and pixelclk-active" patch.
> ---
>  drivers/staging/imx-drm/ipu-v3/ipu-di.c |    2 +-
>  drivers/staging/imx-drm/ipuv3-crtc.c    |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/imx-drm/ipu-v3/ipu-di.c b/drivers/staging/imx-drm/ipu-v3/ipu-di.c
> index 82a9eba..849b3e1 100644
> --- a/drivers/staging/imx-drm/ipu-v3/ipu-di.c
> +++ b/drivers/staging/imx-drm/ipu-v3/ipu-di.c
> @@ -595,7 +595,7 @@ int ipu_di_init_sync_panel(struct ipu_di *di, struct ipu_di_signal_cfg *sig)
>  		}
>  	}
>  
> -	if (!sig->clk_pol)
> +	if (sig->clk_pol)
>  		di_gen |= DI_GEN_POLARITY_DISP_CLK;
>  
>  	ipu_di_write(di, di_gen, DI_GENERAL);
> diff --git a/drivers/staging/imx-drm/ipuv3-crtc.c b/drivers/staging/imx-drm/ipuv3-crtc.c
> index e646017..f506075 100644
> --- a/drivers/staging/imx-drm/ipuv3-crtc.c
> +++ b/drivers/staging/imx-drm/ipuv3-crtc.c
> @@ -158,7 +158,7 @@ static int ipu_crtc_mode_set(struct drm_crtc *crtc,
>  		sig_cfg.Vsync_pol = 1;
>  
>  	sig_cfg.enable_pol = 1;
> -	sig_cfg.clk_pol = 1;
> +	sig_cfg.clk_pol = 0;
>  	sig_cfg.width = mode->hdisplay;
>  	sig_cfg.height = mode->vdisplay;
>  	sig_cfg.pixel_fmt = out_pixel_fmt;

I brought this up a while back:

http://archive.arm.linux.org.uk/lurker/message/20131015.103500.0c058eb9.en.html

it looks like it was never properly addressed, so yes, I think this is
the right solution, and brings the kernel inline with the code which
was in uboot back in October, and the value of sig_cfg.clk_pol now
matches the register bit.

However, I think an even better solution would be to have the clk_pol
values to be defined: CLK_POL_ACTIVE_HIGH and CLK_POL_ACTIVE_LOW.
This makes the actual value used irrelevant, and helps readability.
Maybe something to consider for a future patch?

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
