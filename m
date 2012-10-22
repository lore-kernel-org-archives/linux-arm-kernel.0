From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 22 Oct 2012 15:08:06 +0200
Subject: [PATCH v3] ARM: SMP_TWD: make setup()/stop() reentrant
In-Reply-To: <50853DE3.7050204@ti.com>
References: <1350900649-25369-1-git-send-email-linus.walleij@stericsson.com>
 <50853DE3.7050204@ti.com>
Message-ID: <CACRpkdZbFwJ6Bo3QuW2wTPM3p9fAUCvyhFKoZ8RTEucF2ibL9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 22, 2012 at 2:36 PM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:

>> @@ -93,6 +95,8 @@ static void twd_timer_stop(struct clock_event_device
>> *clk)
>>   {
>>         twd_set_mode(CLOCK_EVT_MODE_UNUSED, clk);
>>         disable_percpu_irq(clk->irq);
>> +       if (!IS_ERR(twd_clk))
>> +               clk_disable(twd_clk);
>
> Is this really needed? This clock disable is bogus since it
> can not really disable the clock.

Hm yeah I see the point, the CPU is running on that clock at this
point :-/

I'll drop this stuff then.

>> @@ -264,15 +268,46 @@ static struct clk *twd_get_clock(void)
>>   static int __cpuinit twd_timer_setup(struct clock_event_device *clk)
>>   {
>>         struct clock_event_device **this_cpu_clk;
>> +       int cpu = smp_processor_id();
>>
>> -       if (!twd_clk)
>> +       /*
>> +        * If the basic setup for this CPU has been done before don't
>> +        * bother with the below.
>> +        */
>> +       if (per_cpu(percpu_setup_called, cpu)) {
>> +               if (!IS_ERR(twd_clk))
>> +                       clk_enable(twd_clk);
>> +               __raw_writel(0, twd_base + TWD_TIMER_CONTROL);
>> +               clockevents_register_device(*__this_cpu_ptr(twd_evt));
>> +               enable_percpu_irq(clk->irq, 0);
>> +               return 0;
>> +       }
>> +       per_cpu(percpu_setup_called, cpu) = true;
>> +
>> +       /*
>> +        * This stuff only need to be done once for the entire TWD cluster
>> +        * during the runtime of the system.
>> +        */
>> +       if (!common_setup_called) {
>>                 twd_clk = twd_get_clock();
>>
> Moving the 'common_setup_called' code under one helper
> might be cleaner. No strong preference though.

I'll see what I can do. I could merge with the twd_get_clock
and call the result twd_get_rate or something.

>> +       common_setup_called = true;
>>
> So "common_setup_called" will get updated every time the
> twd_timer_setup() gets called. You can move this inside
> the if loop.

Will fix.

Yours,
Linus Walleij
