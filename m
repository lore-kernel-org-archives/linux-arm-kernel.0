From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Fri, 20 Jul 2012 12:55:35 +0530
Subject: [RFC 2/4] ARM: OMAP: PM: Get rid of Powerdomain book-keeping from
 cpuidle
In-Reply-To: <1342764284-8143-3-git-send-email-rnayak@ti.com>
References: <1342764284-8143-1-git-send-email-rnayak@ti.com>
 <1342764284-8143-3-git-send-email-rnayak@ti.com>
Message-ID: <CAMQu2gyCmx57ctZFBoAUKUXY+9zwFLCDHsBfehXicH7mEyDzQg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 20, 2012 at 11:34 AM, Rajendra Nayak <rnayak@ti.com> wrote:
> pwrdm_pre_transition()/pwrdm_post_transition() have always been high latency
> operations done within cpuidle to do Powerdomain level book-keeping to know
> what state transitions for different Powerdomains have been triggered.
> This is also useful to do a restore-on-demand in some cases when we know
> the context for the given Powerdomain was lost etc.
>
> Now that we have definitive entry/exit points (thanks to the Powerdomain
> level usecounting) for Powerdomain transitions, these book-keeping functions
> can very well be moved from within CPUidle into pwrdm_clkdm_enable()/pwrdm_
> clkdm_disable() functions.
>
> Also rename _pwrdm_pre/post_transition_cb() to pwrdm_pre/post_transition()
> and get rid of the original ones which iterate over all powerdomains.
>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> ---
>  arch/arm/mach-omap2/omap-mpuss-lowpower.c |    4 ++--
>  arch/arm/mach-omap2/pm34xx.c              |    4 ++--
>  arch/arm/mach-omap2/powerdomain.c         |   28 ++++++++--------------------
>  arch/arm/mach-omap2/powerdomain.h         |    4 ++--
>  4 files changed, 14 insertions(+), 26 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
> index 13670aa..ea19439 100644
> --- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
> +++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
> @@ -255,7 +255,7 @@ int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state)
>                 return -ENXIO;
>         }
>
> -       pwrdm_pre_transition();
> +       pwrdm_cpu_idle();
>
Glad to see this is getting optimized.
I haven't seen how "pwrdm_cpu_[idle/wakeup]()" is
implemented but will those work on SMP system ?
I mean OMAP4, any CPU can make this call ?

Regards
Santosh
