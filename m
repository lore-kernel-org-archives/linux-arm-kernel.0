From: srinivas.kandagatla@st.com (Srinivas KANDAGATLA)
Date: Mon, 10 Jun 2013 14:41:58 +0100
Subject: [PATCH v2 02/11] clocksource:global_timer: Add ARM global timer
 support.
In-Reply-To: <CACRpkdbQCRKBzRF4HzNsXHwXCLJJcFZ9T36GPmmYsnX1OfgGRg@mail.gmail.com>
References: <1370855828-5318-1-git-send-email-srinivas.kandagatla@st.com>
 <1370856087-6452-1-git-send-email-srinivas.kandagatla@st.com>
 <CACRpkdbQCRKBzRF4HzNsXHwXCLJJcFZ9T36GPmmYsnX1OfgGRg@mail.gmail.com>
Message-ID: <51B5D7A6.1020101@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/06/13 14:13, Linus Walleij wrote:
> On Mon, Jun 10, 2013 at 11:21 AM, Srinivas KANDAGATLA
> <srinivas.kandagatla@st.com> wrote:

>>
>> Signed-off-by: Stuart Menefy <stuart.menefy@st.com>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>
>> CC: Arnd Bergmann <arnd@arndb.de>
>> CC: Rob Herring <robherring2@gmail.com>
>> CC: Linus Walleij <linus.walleij@linaro.org>
>> CC: Will Deacon <will.deacon@arm.com>
>> CC: Thomas Gleixner <tglx@linutronix.de>
> 
> This is starting to look very good!
> 
> (...)
Thankyou.
>> +static int __cpuinit gt_clockevents_init(struct clock_event_device *clk)
>> +{
>> +       struct clock_event_device **this_cpu_clk;
>> +       int cpu = smp_processor_id();
>> +
>> +       clk->name = "ARM global timer clock event";
>> +       clk->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
>> +       clk->set_mode = gt_clockevent_set_mode;
>> +       clk->set_next_event = gt_clockevent_set_next_event;
>> +       this_cpu_clk = __this_cpu_ptr(gt_evt);
>> +       *this_cpu_clk = clk;
>> +       clk->cpumask = cpumask_of(cpu);
>> +       clk->irq = gt_ppi;
>> +       clockevents_config_and_register(clk, gt_clk_rate,
>> +                                       0, 0xffffffff);
> 
> What do you mean with being able to set event on
> 0?
Its a bit of over do from me.. I will change it to what you suggested...

> 
> This should most probably be:
> 
> 
> clockevents_config_and_register(clk, gt_clk_rate,
>                                       1, 0xffffffff);
> 
> (...)
>> +static struct clk *gt_get_clock(void)
>> +{
>> +       struct clk *clk;
>> +       int err;
>> +
>> +       clk = clk_get_sys("gt", NULL);
>> +       if (IS_ERR(clk)) {
>> +               pr_err("global-timer: clock not found: %ld\n", PTR_ERR(clk));
>> +               return clk;
>> +       }
> (...)
>> +       clk = of_clk_get(np, 0);
>> +       if (!IS_ERR(clk))
>> +               clk_register_clkdev(clk, NULL, "gt");
> 
> Well that was clever.
> 
> Isn't it better to pass a struct device_node *np around and have that as
> NULL in the non-DT boot path?
I will try it and see how it will look.

Thanks,
srini
> 
> (Maybe somebody in the community asked you to do this, then I
> will live with it.)

> 
> Yours,
> Linus Walleij
> 
> 
