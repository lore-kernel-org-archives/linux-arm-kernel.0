From: fweisbec@gmail.com (Frederic Weisbecker)
Date: Mon, 11 Jul 2011 21:50:04 +0200
Subject: [PATCH 2/3] ARM: Call idle notifiers
In-Reply-To: <1309229190-25006-3-git-send-email-toddpoynor@google.com>
References: <1309229190-25006-1-git-send-email-toddpoynor@google.com>
	<1309229190-25006-3-git-send-email-toddpoynor@google.com>
Message-ID: <20110711195000.GH4109@somewhere.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 27, 2011 at 07:46:29PM -0700, Todd Poynor wrote:
> Change-Id: Id833e61c13baa1783705ac9e9046d1f0cc90c95e
> Signed-off-by: Todd Poynor <toddpoynor@google.com>
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

You seem to use this notifier with different semantics than x86.
x86 notifies idle state when it knows it goes to sleep and exit it any
time it gets interrupted. And it does that every time in the need_resched()
loop.

But here in ARM you enter idle only once before the loop (and you don't even
know if you will enter the loop). And you don't notify idle exit state on interrupts.

So if in the end this idle notifier is something that is really wanted, it needs
to have a consistant behaviour across archs.
