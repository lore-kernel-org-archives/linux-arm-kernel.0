From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 25 Jul 2017 18:01:06 +0100
Subject: [PATCH] perf: qcom_l2: fix column exclusion check
In-Reply-To: <1500931022-21000-1-git-send-email-nleeder@codeaurora.org>
References: <1500931022-21000-1-git-send-email-nleeder@codeaurora.org>
Message-ID: <20170725170105.GF12749@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 24, 2017 at 05:17:02PM -0400, Neil Leeder wrote:
> The check for column exclusion did not verify that the event being
> checked was an L2 event, and not a software event.
> Software events should not be checked for column exclusion.
> This resulted in a group with both software and L2 events sometimes
> incorrectly rejecting the L2 event for column exclusion and
> not counting it.
> 
> Add a check for PMU type before applying column exclusion logic.
> 
> Signed-off-by: Neil Leeder <nleeder@codeaurora.org>

This looks correct, so:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Should this have:

Fixes: 21bdbb7102edeaeb ("perf: add qcom l2 cache perf events driver")

... ?

> ---
>  drivers/perf/qcom_l2_pmu.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/perf/qcom_l2_pmu.c b/drivers/perf/qcom_l2_pmu.c
> index c259848..b242cce 100644
> --- a/drivers/perf/qcom_l2_pmu.c
> +++ b/drivers/perf/qcom_l2_pmu.c
> @@ -546,6 +546,7 @@ static int l2_cache_event_init(struct perf_event *event)
>  	}
>  
>  	if ((event != event->group_leader) &&
> +	    !is_software_event(event->group_leader) &&
>  	    (L2_EVT_GROUP(event->group_leader->attr.config) ==
>  	     L2_EVT_GROUP(event->attr.config))) {
>  		dev_dbg_ratelimited(&l2cache_pmu->pdev->dev,
> @@ -558,6 +559,7 @@ static int l2_cache_event_init(struct perf_event *event)
>  	list_for_each_entry(sibling, &event->group_leader->sibling_list,
>  			    group_entry) {
>  		if ((sibling != event) &&
> +		    !is_software_event(sibling) &&
>  		    (L2_EVT_GROUP(sibling->attr.config) ==
>  		     L2_EVT_GROUP(event->attr.config))) {
>  			dev_dbg_ratelimited(&l2cache_pmu->pdev->dev,

It's unfortunate that we duplicate the checks for the leader and
siblings, but that's not a new problem, and we can fix that in a
follow-up patch.

Thanks,
Mark.
