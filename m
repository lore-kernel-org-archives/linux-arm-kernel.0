From: liviu.dudau@arm.com (liviu.dudau at arm.com)
Date: Thu, 5 May 2016 17:52:33 +0100
Subject: [PATCH 2/2] drm: hdlcd: Suspend/resume only active crtcs
In-Reply-To: <759fe8d3dde95091a9df83018051cba00f494e1e.1462464611.git.robin.murphy@arm.com>
References: <eeb2a5540f50f5a3dd7f87861be1e9117bc4ed65.1462464611.git.robin.murphy@arm.com>
 <759fe8d3dde95091a9df83018051cba00f494e1e.1462464611.git.robin.murphy@arm.com>
Message-ID: <20160505165233.GI28464@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 05, 2016 at 05:13:38PM +0100, Robin Murphy wrote:
> The current PM ops simply unconditionally enable/disable the HDLCD,
> which proves problematic when there is no display plugged in - since
> without a crtc the hardware itself is still in an uninitialised state,
> coming out of suspend results in it being enabled without a valid
> framebuffer address, which typically results in it trying to scan out
> from bus address 0 and flooding the system with error interrupts.
> 
> Fix this by checking the crtc state on resume, and only enabling the
> hardware if it's actually supposed to be. For the sake of consistency,
> do the same on the suspend path as well, although there it's merely a
> case of skipping unnecessary work.
> 
> CC: Liviu Dudau <liviu.dudau@arm.com>

Acked-by: Liviu Dudau <liviu.dudau@arm.com>

Thanks for the patch, Robin!

Liviu

> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/gpu/drm/arm/hdlcd_crtc.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/arm/hdlcd_crtc.c b/drivers/gpu/drm/arm/hdlcd_crtc.c
> index fef1b04c2aab..bf6ff5e48adc 100644
> --- a/drivers/gpu/drm/arm/hdlcd_crtc.c
> +++ b/drivers/gpu/drm/arm/hdlcd_crtc.c
> @@ -296,12 +296,14 @@ static struct drm_plane *hdlcd_plane_init(struct drm_device *drm)
>  
>  void hdlcd_crtc_suspend(struct drm_crtc *crtc)
>  {
> -	hdlcd_crtc_disable(crtc);
> +	if (crtc->state->active)
> +		hdlcd_crtc_disable(crtc);
>  }
>  
>  void hdlcd_crtc_resume(struct drm_crtc *crtc)
>  {
> -	hdlcd_crtc_enable(crtc);
> +	if (crtc->state->active)
> +		hdlcd_crtc_enable(crtc);
>  }
>  
>  int hdlcd_setup_crtc(struct drm_device *drm)
> -- 
> 2.8.1.dirty
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
