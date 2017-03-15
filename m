From: l.stach@pengutronix.de (Lucas Stach)
Date: Wed, 15 Mar 2017 14:03:09 +0100
Subject: [PATCH] drm/etnaviv: add etnaviv cooling device
In-Reply-To: <E1cn8jj-0002mp-SO@rmk-PC.armlinux.org.uk>
References: <E1cn8jj-0002mp-SO@rmk-PC.armlinux.org.uk>
Message-ID: <1489582989.16018.4.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Sonntag, den 12.03.2017, 19:00 +0000 schrieb Russell King:
> Each Vivante GPU contains a clock divider which can divide the GPU clock
> by 2^n, which can lower the power dissipation from the GPU.  It has been
> suggested that the GC600 on Dove is responsible for 20-30% of the power
> dissipation from the SoC, so lowering the GPU clock rate provides a way
> to throttle the power dissiptation, and reduce the temperature when the
> SoC gets hot.
> 
> This patch hooks the Etnaviv driver into the kernel's thermal management
> to allow the GPUs to be throttled when necessary, allowing a reduction in
> GPU clock rate from /1 to /64 in power of 2 steps.

Are those power of 2 steps a hardware limitation, or is it something you
implemented this way to get a smaller number of steps, with a more
meaningful difference in clock speed?
My understanding was that the FSCALE value is just a regular divider
with all steps values in the range of 1-64 being usable.

Regards,
Lucas
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 84 ++++++++++++++++++++++++++++-------
>  drivers/gpu/drm/etnaviv/etnaviv_gpu.h |  2 +
>  2 files changed, 71 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> index 130d7d517a19..bd95182d0852 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> @@ -18,6 +18,7 @@
>  #include <linux/dma-fence.h>
>  #include <linux/moduleparam.h>
>  #include <linux/of_device.h>
> +#include <linux/thermal.h>
>  
>  #include "etnaviv_cmdbuf.h"
>  #include "etnaviv_dump.h"
> @@ -409,6 +410,17 @@ static void etnaviv_gpu_load_clock(struct etnaviv_gpu *gpu, u32 clock)
>  	gpu_write(gpu, VIVS_HI_CLOCK_CONTROL, clock);
>  }
>  
> +static void etnaviv_gpu_update_clock(struct etnaviv_gpu *gpu)
> +{
> +	unsigned int fscale = 1 << (6 - gpu->freq_scale);
> +	u32 clock;
> +
> +	clock = VIVS_HI_CLOCK_CONTROL_DISABLE_DEBUG_REGISTERS |
> +		VIVS_HI_CLOCK_CONTROL_FSCALE_VAL(fscale);
> +
> +	etnaviv_gpu_load_clock(gpu, clock);
> +}
> +
>  static int etnaviv_hw_reset(struct etnaviv_gpu *gpu)
>  {
>  	u32 control, idle;
> @@ -426,11 +438,10 @@ static int etnaviv_hw_reset(struct etnaviv_gpu *gpu)
>  	timeout = jiffies + msecs_to_jiffies(1000);
>  
>  	while (time_is_after_jiffies(timeout)) {
> -		control = VIVS_HI_CLOCK_CONTROL_DISABLE_DEBUG_REGISTERS |
> -			  VIVS_HI_CLOCK_CONTROL_FSCALE_VAL(0x40);
> -
>  		/* enable clock */
> -		etnaviv_gpu_load_clock(gpu, control);
> +		etnaviv_gpu_update_clock(gpu);
> +
> +		control = gpu_read(gpu, VIVS_HI_CLOCK_CONTROL);
>  
>  		/* Wait for stable clock.  Vivante's code waited for 1ms */
>  		usleep_range(1000, 10000);
> @@ -490,11 +501,7 @@ static int etnaviv_hw_reset(struct etnaviv_gpu *gpu)
>  	}
>  
>  	/* We rely on the GPU running, so program the clock */
> -	control = VIVS_HI_CLOCK_CONTROL_DISABLE_DEBUG_REGISTERS |
> -		  VIVS_HI_CLOCK_CONTROL_FSCALE_VAL(0x40);
> -
> -	/* enable clock */
> -	etnaviv_gpu_load_clock(gpu, control);
> +	etnaviv_gpu_update_clock(gpu);
>  
>  	return 0;
>  }
> @@ -1526,17 +1533,13 @@ static int etnaviv_gpu_hw_suspend(struct etnaviv_gpu *gpu)
>  #ifdef CONFIG_PM
>  static int etnaviv_gpu_hw_resume(struct etnaviv_gpu *gpu)
>  {
> -	u32 clock;
>  	int ret;
>  
>  	ret = mutex_lock_killable(&gpu->lock);
>  	if (ret)
>  		return ret;
>  
> -	clock = VIVS_HI_CLOCK_CONTROL_DISABLE_DEBUG_REGISTERS |
> -		VIVS_HI_CLOCK_CONTROL_FSCALE_VAL(0x40);
> -
> -	etnaviv_gpu_load_clock(gpu, clock);
> +	etnaviv_gpu_update_clock(gpu);
>  	etnaviv_gpu_hw_init(gpu);
>  
>  	gpu->switch_context = true;
> @@ -1548,6 +1551,47 @@ static int etnaviv_gpu_hw_resume(struct etnaviv_gpu *gpu)
>  }
>  #endif
>  
> +static int
> +etnaviv_gpu_cooling_get_max_state(struct thermal_cooling_device *cdev,
> +				  unsigned long *state)
> +{
> +	*state = 6;
> +
> +	return 0;
> +}
> +
> +static int
> +etnaviv_gpu_cooling_get_cur_state(struct thermal_cooling_device *cdev,
> +				  unsigned long *state)
> +{
> +	struct etnaviv_gpu *gpu = cdev->devdata;
> +
> +	*state = gpu->freq_scale;
> +
> +	return 0;
> +}
> +
> +static int
> +etnaviv_gpu_cooling_set_cur_state(struct thermal_cooling_device *cdev,
> +				  unsigned long state)
> +{
> +	struct etnaviv_gpu *gpu = cdev->devdata;
> +
> +	mutex_lock(&gpu->lock);
> +	gpu->freq_scale = state;
> +	if (!pm_runtime_suspended(gpu->dev))
> +		etnaviv_gpu_update_clock(gpu);
> +	mutex_unlock(&gpu->lock);
> +
> +	return 0;
> +}
> +
> +static struct thermal_cooling_device_ops cooling_ops = {
> +	.get_max_state = etnaviv_gpu_cooling_get_max_state,
> +	.get_cur_state = etnaviv_gpu_cooling_get_cur_state,
> +	.set_cur_state = etnaviv_gpu_cooling_set_cur_state,
> +};
> +
>  static int etnaviv_gpu_bind(struct device *dev, struct device *master,
>  	void *data)
>  {
> @@ -1556,13 +1600,20 @@ static int etnaviv_gpu_bind(struct device *dev, struct device *master,
>  	struct etnaviv_gpu *gpu = dev_get_drvdata(dev);
>  	int ret;
>  
> +	gpu->cooling = thermal_of_cooling_device_register(dev->of_node,
> +				(char *)dev_name(dev), gpu, &cooling_ops);
> +	if (IS_ERR(gpu->cooling))
> +		return PTR_ERR(gpu->cooling);
> +
>  #ifdef CONFIG_PM
>  	ret = pm_runtime_get_sync(gpu->dev);
>  #else
>  	ret = etnaviv_gpu_clk_enable(gpu);
>  #endif
> -	if (ret < 0)
> +	if (ret < 0) {
> +		thermal_cooling_device_unregister(gpu->cooling);
>  		return ret;
> +	}
>  
>  	gpu->drm = drm;
>  	gpu->fence_context = dma_fence_context_alloc(1);
> @@ -1616,6 +1667,9 @@ static void etnaviv_gpu_unbind(struct device *dev, struct device *master,
>  	}
>  
>  	gpu->drm = NULL;
> +
> +	thermal_cooling_device_unregister(gpu->cooling);
> +	gpu->cooling = NULL;
>  }
>  
>  static const struct component_ops gpu_ops = {
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.h b/drivers/gpu/drm/etnaviv/etnaviv_gpu.h
> index 1c0606ea7d5e..6a1e68eec24c 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.h
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.h
> @@ -97,6 +97,7 @@ struct etnaviv_cmdbuf;
>  
>  struct etnaviv_gpu {
>  	struct drm_device *drm;
> +	struct thermal_cooling_device *cooling;
>  	struct device *dev;
>  	struct mutex lock;
>  	struct etnaviv_chip_identity identity;
> @@ -150,6 +151,7 @@ struct etnaviv_gpu {
>  	u32 hangcheck_fence;
>  	u32 hangcheck_dma_addr;
>  	struct work_struct recover_work;
> +	unsigned int freq_scale;
>  };
>  
>  static inline void gpu_write(struct etnaviv_gpu *gpu, u32 reg, u32 data)
