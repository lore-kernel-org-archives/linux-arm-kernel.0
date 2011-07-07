From: khilman@ti.com (Kevin Hilman)
Date: Thu, 07 Jul 2011 10:08:55 -0700
Subject: [PATCH 2/3] ARM: Call idle notifiers
In-Reply-To: <1309229190-25006-3-git-send-email-toddpoynor@google.com> (Todd
	Poynor's message of "Mon, 27 Jun 2011 19:46:29 -0700")
References: <1309229190-25006-1-git-send-email-toddpoynor@google.com>
	<1309229190-25006-3-git-send-email-toddpoynor@google.com>
Message-ID: <874o2ydnmg.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Todd Poynor <toddpoynor@google.com> writes:

> Change-Id: Id833e61c13baa1783705ac9e9046d1f0cc90c95e
> Signed-off-by: Todd Poynor <toddpoynor@google.com>

I don't think the notifiers should be called in ARM-generic code.
As discussed w/Colin in his proposal for the CPU PM notifiers, the
platform-specific code should decide when to run notifier chain.

To give an example, on OMAP we wouldn't want the notifier chain to be
run until the OMAP PM core has programmed the next states of the various
power domains.  That way the notifier functions could check the next
state to determine if their powerdomain is going to retention or off and
decide whether or not a context save/restore will be needed.

Kevin


> ---
>  arch/arm/kernel/process.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
> index 5e1e541..1b9101e 100644
> --- a/arch/arm/kernel/process.c
> +++ b/arch/arm/kernel/process.c
> @@ -184,6 +184,7 @@ void cpu_idle(void)
>  	while (1) {
>  		tick_nohz_stop_sched_tick(1);
>  		leds_event(led_idle_start);
> +		idle_notifier_call_chain(IDLE_START);
>  		while (!need_resched()) {
>  #ifdef CONFIG_HOTPLUG_CPU
>  			if (cpu_is_offline(smp_processor_id()))
> @@ -208,6 +209,7 @@ void cpu_idle(void)
>  			}
>  		}
>  		leds_event(led_idle_end);
> +		idle_notifier_call_chain(IDLE_END);
>  		tick_nohz_restart_sched_tick();
>  		preempt_enable_no_resched();
>  		schedule();
