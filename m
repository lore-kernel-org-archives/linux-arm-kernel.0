From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 7 Mar 2013 17:11:51 +0100 (CET)
Subject: [BUG] ARM Architected timers appear broken in 3.9-rc1
In-Reply-To: <20130307152619.GA24366@e106331-lin.cambridge.arm.com>
References: <1362654289.3323.18.camel@linaro1.home>
 <20130307152619.GA24366@e106331-lin.cambridge.arm.com>
Message-ID: <alpine.LFD.2.02.1303071710230.22263@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 7 Mar 2013, Mark Rutland wrote:
> From: Mark Rutland <mark.rutland@arm.com>
> Date: Thu, 7 Mar 2013 15:09:24 +0000
> Subject: [PATCH] clockevents: don't allow dummy broadcast timers
> 
> Currently tick_check_broadcast_device doesn't reject clock_event_devices
> with CLOCK_EVT_FEAT_DUMMY, and may select them in preference to real
> hardware if they have a higher rating value. In this situation, the
> dummy timer is responsible for broadcasting to itself, and the core
> clockevents code may attempt to call non-existent callbacks for
> programming the dummy, eventually leading to a panic.

Sigh, yes. I so wish, that this whole broadcast business would go
away.
 
> This patch makes tick_check_broadcast_device always reject dummy timers,
> preventing this problem.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> ---
>  kernel/time/tick-broadcast.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
> index 2fb8cb8..7f32fe0 100644
> --- a/kernel/time/tick-broadcast.c
> +++ b/kernel/time/tick-broadcast.c
> @@ -67,7 +67,8 @@ static void tick_broadcast_start_periodic(struct clock_event_device *bc)
>   */
>  int tick_check_broadcast_device(struct clock_event_device *dev)
>  {
> -	if ((tick_broadcast_device.evtdev &&
> +	if ((dev->features & CLOCK_EVT_FEAT_DUMMY) ||
> +	    (tick_broadcast_device.evtdev &&
>  	     tick_broadcast_device.evtdev->rating >= dev->rating) ||
>  	     (dev->features & CLOCK_EVT_FEAT_C3STOP))
>  		return 0;
> -- 
> 1.8.1.1
> 
> 
