From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 22 Aug 2013 13:33:15 -0400
Subject: [PATCH 2/2] clockevents: Prefer clockevents that don't suffer
 from FEAT_C3_STOP
In-Reply-To: <1377191201-14696-2-git-send-email-sboyd@codeaurora.org>
References: <52138784.7050703@linaro.org>
 <1377191201-14696-1-git-send-email-sboyd@codeaurora.org>
 <1377191201-14696-2-git-send-email-sboyd@codeaurora.org>
Message-ID: <52164B5B.5010902@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 22 August 2013 01:06 PM, Stephen Boyd wrote:
> On some ARM systems there are two sets of per-cpu timers: the TWD
> timers and the global timers. The TWD timers are rated at 350 and
> the global timers are rated at 300 but the TWD timers suffer from
> FEAT_C3_STOP while the arm global timers don't. The tick device
> selection logic doesn't consider the FEAT_C3_STOP flag so we'll
> always end up with the TWD as the tick device although we don't
> want that.
> 
> Extend the preference logic to take the FEAT_C3_STOP flag into
> account and always prefer tick devices that don't suffer from
> FEAT_C3_STOP even if their rating is lower than tick devices that
> do suffer from FEAT_C3_STOP. This will remove the need to do any
> broadcasting on such ARM systems.
> 
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  kernel/time/tick-common.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
> index 64522ec..3ae437d 100644
> --- a/kernel/time/tick-common.c
> +++ b/kernel/time/tick-common.c
> @@ -244,12 +244,22 @@ static bool tick_check_preferred(struct clock_event_device *curdev,
>  			return false;
>  	}
>  
> +	if (!curdev)
> +		return true;
> +
> +	/* Always prefer a tick device that doesn't suffer from FEAT_C3STOP */
> +	if (!(newdev->features & CLOCK_EVT_FEAT_C3STOP) &&
> +			(curdev->features & CLOCK_EVT_FEAT_C3STOP))
> +		return true;
> +	if ((newdev->features & CLOCK_EVT_FEAT_C3STOP) &&
> +			!(curdev->features & CLOCK_EVT_FEAT_C3STOP))
> +		return false;
> +
I don't think preferring the clock-event which doesn't suffer
from FEAT_C3STOP is a good idea if the quality of the time source
is not same. Generally the global timers are slow and far away from
CPU(cycle cost). So as long as we don't get impacted because of low power
states, the tick should run out of local timers which are faster access
as well as high resolution.

Regards,
Santosh
