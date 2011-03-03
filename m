From: khilman@ti.com (Kevin Hilman)
Date: Thu, 03 Mar 2011 15:24:48 -0800
Subject: [PATCH 1/2] OMAP3: cpuidle: prevent CORE power domain from going
	to RET or OFF when DSS is on
In-Reply-To: <20110301224918.32613.95176.stgit@twilight.localdomain> (Paul
	Walmsley's message of "Tue, 01 Mar 2011 15:49:24 -0700")
References: <20110301220833.32613.54669.stgit@twilight.localdomain>
	<20110301224918.32613.95176.stgit@twilight.localdomain>
Message-ID: <87pqq7pz27.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Paul Walmsley <paul@pwsan.com> writes:

> From: Tero Kristo <tero.kristo@nokia.com>
>
> Prevent the CORE power domain from entering RETENTION or OFF when DSS
> is on.  Otherwise, the display FIFO(s) may underflow due to the time
> needed for the CORE to wake back up, causing tearing and unnecessary
> interrupts.
>
> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
> [paul at pwsan.com: wrote commit message]
> Signed-off-by: Paul Walmsley <paul@pwsan.com>

This isn't quite ready for merge, and needs a little more testing with
current DSS driver and mainline.

> ---
>  arch/arm/mach-omap2/cpuidle34xx.c |   10 ++++++++--
>  1 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
> index 0335cd8..d1b7789 100644
> --- a/arch/arm/mach-omap2/cpuidle34xx.c
> +++ b/arch/arm/mach-omap2/cpuidle34xx.c
> @@ -9,8 +9,9 @@
>   * Copyright (C) 2007 Texas Instruments, Inc.
>   * Karthik Dasu <karthik-dp@ti.com>
>   *
> - * Copyright (C) 2006 Nokia Corporation
> + * Copyright (C) 2006, 2011 Nokia Corporation
>   * Tony Lindgren <tony@atomide.com>
> + * Tero Kristo <tero.kristo@nokia.com>
>   *
>   * Copyright (C) 2005 Texas Instruments, Inc.
>   * Richard Woodruff <r-woodruff2@ti.com>
> @@ -268,6 +269,12 @@ static int omap3_enter_idle_bm(struct cpuidle_device *dev,
>  		goto select_state;
>  	}
>  
> +	/* If DSS is active, prevent CORE RET/OFF */
> +	dss_state = pwrdm_read_pwrst(dss_pd);
> +	if (dss_state == PWRDM_POWER_ON &&
> +	    core_next_state != PWRDM_POWER_ON)
> +		core_next_state = PWRDM_POWER_INACTIVE;
> +

Due to sleepdeps/autodeps, when this code runs, DSS powerdomain is
always on.  The result is that CORE is always set to INACTIVE.

A side effect of this problem is exposing a known issue with PER wakeups
(UART3, GPIO).  Since CORE never goes to retention/off, IO-pad
wakeups are never enabled, so PER wakeups do not work.

I think we need a different way of checking for DSS activity.

Sounds like another usecase for idle notifiers.

Kevin
