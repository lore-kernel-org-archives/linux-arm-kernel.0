From: sebastian.reichel@collabora.co.uk (Sebastian Reichel)
Date: Thu, 9 Nov 2017 17:27:42 +0100
Subject: [PATCH v2 4/7] dmtimer: Add timer ops to the platform data
 structure
In-Reply-To: <1510144108-29563-5-git-send-email-j-keerthy@ti.com>
References: <1510144108-29563-1-git-send-email-j-keerthy@ti.com>
 <1510144108-29563-5-git-send-email-j-keerthy@ti.com>
Message-ID: <20171109162742.mrdvh5cvom577whh@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Nov 08, 2017 at 05:58:25PM +0530, Keerthy wrote:
> Add timer ops to the platform data structure
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
> 
> No code changes in this v2 version. Only enhanced patch
> statistics for renames.

I think the solution to provide private functions is not very nice,
but it improves the current situation and does not touch any ABI (so
can easily be changed later on), so:

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

-- Sebastian

>  include/linux/platform_data/dmtimer-omap.h | 38 ++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/include/linux/platform_data/dmtimer-omap.h b/include/linux/platform_data/dmtimer-omap.h
> index a19b78d..a3e1794 100644
> --- a/include/linux/platform_data/dmtimer-omap.h
> +++ b/include/linux/platform_data/dmtimer-omap.h
> @@ -20,12 +20,50 @@
>  #ifndef __PLATFORM_DATA_DMTIMER_OMAP_H__
>  #define __PLATFORM_DATA_DMTIMER_OMAP_H__
>  
> +struct omap_dm_timer_ops {
> +	struct omap_dm_timer *(*request_by_node)(struct device_node *np);
> +	struct omap_dm_timer *(*request_specific)(int timer_id);
> +	struct omap_dm_timer *(*request)(void);
> +
> +	int	(*free)(struct omap_dm_timer *timer);
> +
> +	void	(*enable)(struct omap_dm_timer *timer);
> +	void	(*disable)(struct omap_dm_timer *timer);
> +
> +	int	(*get_irq)(struct omap_dm_timer *timer);
> +	int	(*set_int_enable)(struct omap_dm_timer *timer,
> +				  unsigned int value);
> +	int	(*set_int_disable)(struct omap_dm_timer *timer, u32 mask);
> +
> +	struct clk *(*get_fclk)(struct omap_dm_timer *timer);
> +
> +	int	(*start)(struct omap_dm_timer *timer);
> +	int	(*stop)(struct omap_dm_timer *timer);
> +	int	(*set_source)(struct omap_dm_timer *timer, int source);
> +
> +	int	(*set_load)(struct omap_dm_timer *timer, int autoreload,
> +			    unsigned int value);
> +	int	(*set_match)(struct omap_dm_timer *timer, int enable,
> +			     unsigned int match);
> +	int	(*set_pwm)(struct omap_dm_timer *timer, int def_on,
> +			   int toggle, int trigger);
> +	int	(*set_prescaler)(struct omap_dm_timer *timer, int prescaler);
> +
> +	unsigned int (*read_counter)(struct omap_dm_timer *timer);
> +	int	(*write_counter)(struct omap_dm_timer *timer,
> +				 unsigned int value);
> +	unsigned int (*read_status)(struct omap_dm_timer *timer);
> +	int	(*write_status)(struct omap_dm_timer *timer,
> +				unsigned int value);
> +};
> +
>  struct dmtimer_platform_data {
>  	/* set_timer_src - Only used for OMAP1 devices */
>  	int (*set_timer_src)(struct platform_device *pdev, int source);
>  	u32 timer_capability;
>  	u32 timer_errata;
>  	int (*get_context_loss_count)(struct device *);
> +	struct omap_dm_timer_ops *timer_ops;
>  };
>  
>  #endif /* __PLATFORM_DATA_DMTIMER_OMAP_H__ */
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171109/bed1490d/attachment-0001.sig>
