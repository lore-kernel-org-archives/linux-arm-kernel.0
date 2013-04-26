From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 26 Apr 2013 15:38:45 +0200
Subject: [PATCH 03/23] ARM: u300: device tree support for the timer
In-Reply-To: <201304221336.21921.arnd@arndb.de>
References: <1366624304-6190-1-git-send-email-linus.walleij@stericsson.com>
 <201304221336.21921.arnd@arndb.de>
Message-ID: <CACRpkdbfDwhKA77aUbXhk5sZ0prxR-ic5dntCaAiNjKNBGo_wg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 22, 2013 at 1:36 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 22 April 2013, Linus Walleij wrote:
>> +#ifdef CONFIG_OF
>> +       struct device_node *timer = NULL;
>> +
>> +       timer = of_find_node_by_path("/timer0 at c0014000");
>> +       if (timer) {
>> +               struct resource irq_res;
>> +
>> +               u300_timer_base = of_iomap(timer, 0);
>> +               /* Get the IRQ for the GP1 timer */
>> +               irq = of_irq_to_resource(timer, 2, &irq_res);
>> +       }
>> +#endif
>
> Do you need the #ifdef? The functions should be defined in a way that
> removes this code if CONFIG_OF is not defined.

Actually not, this happens without CONFIG_OF:

  CC      arch/arm/mach-u300/timer.o
/home/elinwal/linux-stericsson/arch/arm/mach-u300/timer.c: In function
'u300_timer_init':
/home/elinwal/linux-stericsson/arch/arm/mach-u300/timer.c:371:2:
error: implicit declaration of function 'of_find_node_by_path'
[-Werror=implicit-function-declaration]
/home/elinwal/linux-stericsson/arch/arm/mach-u300/timer.c:371:8:
warning: assignment makes pointer from integer without a cast [enabled
by default]
/home/elinwal/linux-stericsson/arch/arm/mach-u300/timer.c:377:3:
error: implicit declaration of function 'of_irq_to_resource'
[-Werror=implicit-function-declaration]
cc1: some warnings being treated as errors

make[3]: *** [arch/arm/mach-u300/timer.o] Error 1
make[2]: *** [arch/arm/mach-u300] Error 2
make[2]: *** Waiting for unfinished jobs....

Maybe it's just a bug that these don't have the proper stubs in <linux/of.h>?

Or is there a deeper idea behind this? (CC some OF ppl.)

Yours,
Linus Walleij
