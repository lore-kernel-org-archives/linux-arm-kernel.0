From: yad.naveen@gmail.com (naveen yadav)
Date: Mon, 2 Apr 2012 11:16:21 +0530
Subject: top command shows 100% irq
In-Reply-To: <CAJ8eaTza9c7TTHtz97M1QFzsm5KHf0hyjtATa3a+9iQcE1Sgow@mail.gmail.com>
References: <CAJ8eaTza9c7TTHtz97M1QFzsm5KHf0hyjtATa3a+9iQcE1Sgow@mail.gmail.com>
Message-ID: <CAJ8eaTzw3TyPZnhEOqAfq3PtGWHAwSity8QhO9ENXqZ29CQ_jw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

put cc to arm mailing list.


On Sun, Apr 1, 2012 at 9:52 AM, naveen yadav <yad.naveen@gmail.com> wrote:
> Dear Russell,
>
> I am using linux 3.0.22 kernel, I backport patch "ARM: fix rcu stalls
> on SMP platforms"(7deabca0acfe02b8e18f59a4c95676012f49a304) ?and found
> that
>
> when run top command
>
> CPU: ? 0% usr ? 0% sys ? 0% nic 0% idle ? 0% io ? 100% irq ? 0% sirq
>
> I found the issue:
> -----------------------------------------------------------------------------------------------------------------------------
> working condition: I need to modify your original patch for
> ipi_timer() like below.
> --------------------------------------------------------------------------------------------------------------------------------
> diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
> index 57db122..26cdc49 100644
> --- a/arch/arm/kernel/smp.c
> +++ b/arch/arm/kernel/smp.c
> @@ -443,9 +443,7 @@ static DEFINE_PER_CPU(struct clock_event_device,
> percpu_clockevent);
> ?static void ipi_timer(void)
> ?{
> ? ? ? ?struct clock_event_device *evt = &__get_cpu_var(percpu_clockevent);
> ? ? ? irq_enter();
> ? ? ? ?evt->event_handler(evt);
> ? ? ? irq_exit();
> ?}
>
> ?#ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
> @@ -548,7 +546,9 @@ void handle_IPI(int ipinr, struct pt_regs *regs)
>
> ? ? ? ?switch (ipinr) {
> ? ? ? ?case IPI_TIMER:
> //+ ? ? ? ? ? ? ? irq_enter();
> ? ? ? ? ? ? ? ?ipi_timer();
> //+ ? ? ? ? ? ? ? irq_exit();
> ? ? ? ? ? ? ? ?break;
>
> ___________________________________________________________________________________________
> Fail: condition:
> ___________________________________________________________________________________________
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
> ?arch/arm/kernel/smp.c | ? 10 ++++++++--
> ?1 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
> index 57db122..26cdc49 100644
> --- a/arch/arm/kernel/smp.c
> +++ b/arch/arm/kernel/smp.c
> @@ -443,9 +443,7 @@ static DEFINE_PER_CPU(struct clock_event_device,
> percpu_clockevent);
> ?static void ipi_timer(void)
> ?{
> ? ? ? ?struct clock_event_device *evt = &__get_cpu_var(percpu_clockevent);
> - ? ? ? irq_enter();
> ? ? ? ?evt->event_handler(evt);
> - ? ? ? irq_exit();
> ?}
>
> ?#ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
> @@ -548,7 +546,9 @@ void handle_IPI(int ipinr, struct pt_regs *regs)
>
> ? ? ? ?switch (ipinr) {
> ? ? ? ?case IPI_TIMER:
> + ? ? ? ? ? ? ? irq_enter();
> ? ? ? ? ? ? ? ?ipi_timer();
> + ? ? ? ? ? ? ? irq_exit();
> ? ? ? ? ? ? ? ?break;
>
>
>
> So it seams to me when struct clock_event_device *evt =
> &__get_cpu_var(percpu_clockevent); is in irq_enter() function, this
> leads ?100% irq.
> what may be issue.
>
> Thanks a lot
