From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 31 Jul 2013 10:32:37 -0700
Subject: [PATCH] clocksource: em_sti: Adjust clock event rating to fix
 SMP broadcast
In-Reply-To: <1375251940-7809-1-git-send-email-horms+renesas@verge.net.au>
References: <1375251940-7809-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <51F94A35.2020907@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/30/13 23:25, Simon Horman wrote:
> From: Magnus Damm <damm@opensource.se>
>
> Update the STI rating from 200 to 80 to fix SMP operation with
> the ARM broadcast timer. This breakage was introduced by:
>
> f7db706 ARM: 7674/1: smp: Avoid dummy clockevent being preferred over real hardware clock-event
>
> Without this fix SMP operation is broken on EMEV2 since no
> broadcast timer interrupts trigger on the secondary CPU cores.
>
> Signed-off-by: Magnus Damm <damm@opensource.se>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---

This looks suspicious. Are you're purposefully deflating the rating so
that the STI timer fills in the broadcast position? Why not make the STI
cpumask be all possible CPUs? Presumably the interrupt can target all
CPUs since it isn't a per-cpu interrupt and doing this would cause the
STI to fill in the broadcast slot, leaving the per-cpu dummys in the
tick position.

>  drivers/clocksource/em_sti.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/clocksource/em_sti.c b/drivers/clocksource/em_sti.c
> index b9c81b7..37b87c0 100644
> --- a/drivers/clocksource/em_sti.c
> +++ b/drivers/clocksource/em_sti.c
> @@ -300,7 +300,7 @@ static void em_sti_register_clockevent(struct em_sti_priv *p)
>  	memset(ced, 0, sizeof(*ced));
>  	ced->name = dev_name(&p->pdev->dev);
>  	ced->features = CLOCK_EVT_FEAT_ONESHOT;
> -	ced->rating = 200;
> +	ced->rating = 80;
>  	ced->cpumask = cpumask_of(0);
>  	ced->set_next_event = em_sti_clock_event_next;
>  	ced->set_mode = em_sti_clock_event_mode;


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
