From: tony@atomide.com (Tony Lindgren)
Date: Wed, 23 May 2018 11:41:16 -0700
Subject: [PATCH v2] OMAP: CLK: CLKSRC: Add suspend resume hooks
In-Reply-To: <1527013340-8036-1-git-send-email-j-keerthy@ti.com>
References: <1527013340-8036-1-git-send-email-j-keerthy@ti.com>
Message-ID: <20180523184116.GS98604@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Keerthy <j-keerthy@ti.com> [180522 11:24]:
> Add the save and restore for clksrc as part of suspend and resume
> so that it saves the counter value and restores. This is needed in
> modes like rtc+ddr in self-refresh not doing this stalls the time.

Can't we now do this all in drivers/clocksource/timer-ti-*.c?

> @@ -490,6 +513,15 @@ static void __init omap2_gptimer_clocksource_init(int gptimer_id,
>  	res = omap_dm_timer_init_one(&clksrc, fck_source, property,
>  				     &clocksource_gpt.name,
>  				     OMAP_TIMER_NONPOSTED);
> +
> +	if (soc_is_am43xx()) {
> +		clocksource_gpt.suspend = omap2_gptimer_clksrc_suspend;
> +		clocksource_gpt.resume = omap2_gptimer_clksrc_resume;
> +
> +		clocksource_gpt_hwmod =
> +			omap_hwmod_lookup(clocksource_gpt.name);
> +	}
> +

Then you can do this based on a quirk flag set by compatible.

Regards,

Tony
