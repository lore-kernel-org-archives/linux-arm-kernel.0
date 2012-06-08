From: t-kristo@ti.com (Tero Kristo)
Date: Fri, 8 Jun 2012 16:22:53 +0300
Subject: [PATCH 05/11] ARM: OMAP2+: hwmod code/data: fix 32K sync timer
In-Reply-To: <20120607061309.25532.13430.stgit@dusk>
References: <20120607060901.25532.68354.stgit@dusk>
 <20120607061309.25532.13430.stgit@dusk>
Message-ID: <1339161773.2091.49.camel@sokoban>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

There's a bug in this patch, see below.

<clip>

>  {
> @@ -1141,8 +1143,26 @@ static void _enable_sysc(struct omap_hwmod *oh)
>  	sf = oh->class->sysc->sysc_flags;
>  
>  	if (sf & SYSC_HAS_SIDLEMODE) {
> -		idlemode = (oh->flags & HWMOD_SWSUP_SIDLE) ?
> -			HWMOD_IDLEMODE_NO : HWMOD_IDLEMODE_SMART;
> +		if (oh->flags & HWMOD_SWSUP_SIDLE) {
> +			/*
> +			 * IP blocks without smart idle should be left
> +			 * in force-idle.  Currently this only applies
> +			 * to 32k sync "timer" which is guaranteed to
> +			 * be accessible when the kernel is running.
> +			 * HWMOD_SWSUP_IDLE must also be set on these
> +			 * IP blocks to indicate a hardware problem.
> +			 * XXX Not an ideal workaround.
> +			 */
> +			if (oh->class->sysc->idlemodes &
> +			    (SIDLE_NO | SIDLE_FORCE) &&
> +			    !(oh->class->sysc->idlemodes &
> +			      (SIDLE_SMART || SIDLE_SMART_WKUP)))

There should by binary or, not logical here.

-Tero
