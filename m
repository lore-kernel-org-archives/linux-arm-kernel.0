From: tony@atomide.com (Tony Lindgren)
Date: Tue, 25 Oct 2011 09:56:20 +0200
Subject: [PATCH 01/12] ARM: clean up idle handlers
In-Reply-To: <1319449801-12367-2-git-send-email-nico@fluxnic.net>
References: <1319449801-12367-1-git-send-email-nico@fluxnic.net>
	<1319449801-12367-2-git-send-email-nico@fluxnic.net>
Message-ID: <20111025075620.GH4429@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nicolas Pitre <nico@fluxnic.net> [111024 12:16]:
> Let's factor out the need_resched() check instead of having it duplicated
> in every pm_idle implementations to avoid inconsistencies (omap2_pm_idle
> was missing it already).
> 
> The forceful re-enablement of IRQs after pm_idle has returned can go.
> The warning certainly doesn't trigger for existing users.  Similar for
> the redundant  local_irq_disable() call in the OMAP implementations.

Looks good to me.
 
> And finally move the comment explaining the reason for the turning off
> of IRQs to a more proper location.

One minor comment on that comment below.
 
> --- a/arch/arm/kernel/process.c
> +++ b/arch/arm/kernel/process.c
...

> -				 * This will eventually be removed - pm_idle
> -				 * functions should always return with IRQs
> -				 * enabled.
> +				 * pm_idle functions should always
> +				 * return with IRQs enabled.
>  				 */
>  				WARN_ON(irqs_disabled());
> +			} else
>  				local_irq_enable();
> -			}

Any reason to use "should always return" instead of "must always return
with IRQs enabled"?

Regards,

Tony
