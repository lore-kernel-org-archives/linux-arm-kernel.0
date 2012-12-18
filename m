From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 18 Dec 2012 14:17:11 -0800
Subject: [RFC PATCH 2/5] clockevents: Add generic timer broadcast receiver
In-Reply-To: <1355832418-31692-3-git-send-email-mark.rutland@arm.com>
References: <1355832418-31692-1-git-send-email-mark.rutland@arm.com>
 <1355832418-31692-3-git-send-email-mark.rutland@arm.com>
Message-ID: <50D0EB67.2060802@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/18/12 04:06, Mark Rutland wrote:
> diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
> index f113755..c2dd022 100644
> --- a/kernel/time/tick-broadcast.c
> +++ b/kernel/time/tick-broadcast.c
> @@ -125,6 +125,21 @@ int tick_device_uses_broadcast(struct clock_event_device *dev, int cpu)
>  	return ret;
>  }
>  
> +int tick_receive_broadcast(void)
> +{
> +	struct tick_device *td = this_cpu_ptr(&tick_cpu_device);
> +	struct clock_event_device *evt = td->evtdev;
> +
> +	if (!evt)
> +		return -ENODEV;
> +
> +	if (!evt->event_handler)
> +		return -EINVAL;
> +

Does this actually happen? It's not obvious to me how it does.

> +	evt->event_handler(evt);
> +	return 0;
> +}
> +
>  /*
>   * Broadcast the event to the cpus, which are set in the mask (mangled).
>   */


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
