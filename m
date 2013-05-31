From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 31 May 2013 13:26:31 +0200
Subject: [PATCH 02/39] ARM: u300: device tree support for the timer
In-Reply-To: <7742928.6bJiIVUE0X@wuerfel>
References: <1369991954-17406-1-git-send-email-linus.walleij@stericsson.com>
 <1369991954-17406-3-git-send-email-linus.walleij@stericsson.com>
 <7742928.6bJiIVUE0X@wuerfel>
Message-ID: <CACRpkdZYsnUhjYO_U4L56TMY+fs+ZU9zk3zLWnjPtf8Bmmn0YQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 31, 2013 at 12:31 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 31 May 2013 11:18:37 Linus Walleij wrote:

>> +void __init u300_timer_init()
>> +{
>> +       u300_timer_setup(U300_TIMER_APP_VBASE, IRQ_U300_TIMER_APP_GP1);
>> +}
>> +
>> +#ifdef CONFIG_OF
>> +
>> +static void __init u300_timer_init_of(struct device_node *np)
>> +{
>> +       void __iomem *base;
>> +       struct resource irq_res;
>> +       int irq;
>> +
>> +       base = of_iomap(np, 0);
>> +       /* Get the IRQ for the GP1 timer */
>> +       irq = of_irq_to_resource(np, 2, &irq_res);
>> +       u300_timer_setup(base, irq);
>> +}
>> +
>> +CLOCKSOURCE_OF_DECLARE(u300_timer, "stericsson,u300-apptimer",
>> +                      u300_timer_init_of);
>> +
>> +#endif
>
> You should not need the CONFIG_OF #ifdef, since the CLOCKSOURCE_OF_DECLARE
> macro is designed to let the function get dropped by the compiler when
> that is not set.
>
> You might want a CONFIG_ATAGS check for the other function though.

Both the other function and the #ifdef CONFIG_OF are deleted in
patch 21. Is this OK?

>> diff --git a/arch/arm/mach-u300/timer.h b/arch/arm/mach-u300/timer.h
>> index d34287b..7766dfa 100644
>> --- a/arch/arm/mach-u300/timer.h
>> +++ b/arch/arm/mach-u300/timer.h
>> @@ -1 +1,2 @@
>>  extern void u300_timer_init(void);
>> +
>
> You probably didn't mean to include this newline.

This entire file is also deleted in patch 21.

I can fix it up if you absolutely want to but it feels like
something of an academic exercise.

Yours,
Linus Walleij
