From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 11 Feb 2013 20:00:17 -0700
Subject: [PATCH V4] ARM: bcm281xx: Add timer driver
In-Reply-To: <1360626279-26701-1-git-send-email-csd@broadcom.com>
References: <1360626279-26701-1-git-send-email-csd@broadcom.com>
Message-ID: <5119B041.9040007@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/11/2013 04:44 PM, Christian Daudt wrote:
> This adds support for the Broadcom timer, used in the following SoCs:
> BCM11130, BCM11140, BCM11351, BCM28145, BCM28155

> diff --git a/drivers/clocksource/bcm_kona_timer.c b/drivers/clocksource/bcm_kona_timer.c

> +static const struct of_device_id bcm_timer_ids[] __initconst = {
> +	{.compatible = "bcm,kona-timer"},
> +	{},
> +};
> +
> +static void __init kona_timers_init(void)
> +{
> +	struct device_node *node;
> +	u32 freq;
> +
> +	node = of_find_matching_node(NULL, bcm_timer_ids);
> +
> +	if (!node)
> +		panic("No timer");

I assume this is for 3.10 now. Can you rework this to remove
bcm_timer_ids[] and that of_find_matching_node() call, and replace it
with e.g.:

CLOCKSOURCE_OF_DECLARE(kona, "bcm,kona-timer", kona_timer_init);

You'd need to change the prototype of kona_timer_init() to accept the DT
node pointer, and pass this through to kona_timers_init().

This would remove the need to have board_bcm.c call the custom
kona_timer_init(); it could use the new standardized clocksource_of_init
instead.
