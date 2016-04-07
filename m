From: ykk@rock-chips.com (Yakir Yang)
Date: Thu, 7 Apr 2016 12:19:01 +0800
Subject: [PATCH] drm: bridge: analogix/dp: fix no drm hpd event when panel
 plug in
In-Reply-To: <1460002529-30719-1-git-send-email-ykk@rock-chips.com>
References: <1460002529-30719-1-git-send-email-ykk@rock-chips.com>
Message-ID: <5705DFB5.4010602@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry for disturb, I make a mistaken about the
receive list, please ignore this email.

- Yakir

On 04/07/2016 12:15 PM, Yakir Yang wrote:
> The enum value of DP_IRQ_TYPE_HP_CABLE_IN is zero, but driver only
> send drm hp event when the irq_type and the enum value is true.
>
> if (irq_type & DP_IRQ_TYPE_HP_CABLE_IN || ...)
> 	drm_helper_hpd_irq_event(dp->drm_dev);
>
> So there would no drm hpd event when cable plug in, to fix that
> just need to assign all hotplug enum with no-zero values.
>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Yakir Yang <ykk@rock-chips.com>
> ---
>   drivers/gpu/drm/bridge/analogix/analogix_dp_core.h | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
> index f09275d..b456380 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
> @@ -127,10 +127,10 @@ enum analog_power_block {
>   };
>   
>   enum dp_irq_type {
> -	DP_IRQ_TYPE_HP_CABLE_IN,
> -	DP_IRQ_TYPE_HP_CABLE_OUT,
> -	DP_IRQ_TYPE_HP_CHANGE,
> -	DP_IRQ_TYPE_UNKNOWN,
> +	DP_IRQ_TYPE_HP_CABLE_IN  = BIT(0),
> +	DP_IRQ_TYPE_HP_CABLE_OUT = BIT(1),
> +	DP_IRQ_TYPE_HP_CHANGE    = BIT(2),
> +	DP_IRQ_TYPE_UNKNOWN      = BIT(3),
>   };
>   
>   struct video_info {
