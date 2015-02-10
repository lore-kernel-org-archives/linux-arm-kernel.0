From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 10 Feb 2015 15:11:25 +0100
Subject: [PATCH 2/2] drm: atmel-hlcdc: Add pinctrl PM select
 sleep,default state in CRTC suspend/resume
In-Reply-To: <1423575646-3273-3-git-send-email-sylvain.rochet@finsecur.com>
References: <1423575646-3273-1-git-send-email-sylvain.rochet@finsecur.com>
 <1423575646-3273-3-git-send-email-sylvain.rochet@finsecur.com>
Message-ID: <20150210151125.65336f20@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 10 Feb 2015 14:40:46 +0100
Sylvain Rochet <sylvain.rochet@finsecur.com> wrote:

> Some LCD panels have back-powering issue when un-powered, allows users
> to use an alternate pinctrl "sleep" in order to clamp outputs to a
> wanted state at suspend.
> 
> Signed-off-by: Sylvain Rochet <sylvain.rochet@finsecur.com>

Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>

> ---
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
> index 79c9a19..decd9ea 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
> @@ -21,6 +21,7 @@
>  #include <linux/clk.h>
>  #include <linux/pm.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/pinctrl/consumer.h>
>  
>  #include <drm/drm_crtc.h>
>  #include <drm/drm_crtc_helper.h>
> @@ -156,6 +157,7 @@ static void atmel_hlcdc_crtc_disable(struct drm_crtc *c)
>  		cpu_relax();
>  
>  	clk_disable_unprepare(crtc->dc->hlcdc->sys_clk);
> +	pinctrl_pm_select_sleep_state(dev->dev);
>  
>  	pm_runtime_allow(dev->dev);
>  
> @@ -178,6 +180,7 @@ static void atmel_hlcdc_crtc_enable(struct drm_crtc *c)
>  
>  	pm_runtime_forbid(dev->dev);
>  
> +	pinctrl_pm_select_default_state(dev->dev);
>  	clk_prepare_enable(crtc->dc->hlcdc->sys_clk);
>  
>  	regmap_write(regmap, ATMEL_HLCDC_EN, ATMEL_HLCDC_PIXEL_CLK);



-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
