From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 18 Dec 2012 14:17:13 -0800
Subject: [RFC PATCH 4/5] clockevents: Add generic timer broadcast function
In-Reply-To: <1355832418-31692-5-git-send-email-mark.rutland@arm.com>
References: <1355832418-31692-1-git-send-email-mark.rutland@arm.com>
 <1355832418-31692-5-git-send-email-mark.rutland@arm.com>
Message-ID: <50D0EB69.10901@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Minor nit

On 12/18/12 04:06, Mark Rutland wrote:
> diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
> index c2dd022..ec22a80 100644
> --- a/kernel/time/tick-broadcast.c
> +++ b/kernel/time/tick-broadcast.c
> @@ -86,6 +87,12 @@ int tick_is_broadcast_device(struct clock_event_device *dev)
>  	return (dev && tick_broadcast_device.evtdev == dev);
>  }
>  
> +static void err_broadcast(const struct cpumask *mask)
> +{
> +	pr_crit_once("Attempted to broadcast tick, but no broadcast mechanism "
> +		     "present. Some CPUs may be unresponsive.");

This is missing a newline. You may also want to put the string on a
single line so we can easily grep for it in the sources.

> @@ -105,6 +112,14 @@ int tick_device_uses_broadcast(struct clock_event_device *dev, int cpu)
>  	 */
>  	if (!tick_device_is_functional(dev)) {
>  		dev->event_handler = tick_handle_periodic;
> +		if (!dev->broadcast)
> +			dev->broadcast = tick_broadcast;
> +		if (!dev->broadcast) {
> +			pr_warn_once("%s depends on broadcast, but no "
> +				     "broadcast function available\n",

Same one line comment here. I thought checkpatch didn't complain anymore.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
