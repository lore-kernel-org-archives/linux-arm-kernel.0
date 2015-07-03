From: ezequiel@vanguardiasur.com.ar (Ezequiel Garcia)
Date: Fri, 3 Jul 2015 11:56:14 -0300
Subject: [PATCH v2 1/2] watchdog: NXP LPC18xx Watchdog Timer Driver
In-Reply-To: <CAGhQ9VzLX_hy2Z=jUH6on0_sOZBp_mg5cC0JXkHntWxxrr2K6A@mail.gmail.com>
References: <1435783930-20184-1-git-send-email-ariel@vanguardiasur.com.ar>
 <1435783930-20184-2-git-send-email-ariel@vanguardiasur.com.ar>
 <CAGhQ9VzLX_hy2Z=jUH6on0_sOZBp_mg5cC0JXkHntWxxrr2K6A@mail.gmail.com>
Message-ID: <CAAEAJfDo9QNK5kNV8kHxmnwhfUm__xn3XuDyOBeCnLZQZy6OJA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joachim,

On 1 July 2015 at 20:04, Joachim  Eastwood <manabian@gmail.com> wrote:
[..]
>> +static int lpc18xx_wdt_start(struct watchdog_device *wdt_dev)
>> +{
>> +       struct lpc18xx_wdt_dev *lpc18xx_wdt = watchdog_get_drvdata(wdt_dev);
>> +       unsigned int val;
>> +
>> +       if (timer_pending(&lpc18xx_wdt->timer))
>> +               del_timer(&lpc18xx_wdt->timer);
>> +
>> +       val = readl(lpc18xx_wdt->base + LPC18XX_WDT_MOD);
>> +       val |= LPC18XX_WDT_MOD_WDEN;
>> +       val |= LPC18XX_WDT_MOD_WDRESET;
>> +       writel(val, lpc18xx_wdt->base + LPC18XX_WDT_MOD);
>
> R-M-W sequence should probably be protect with a lock.
>

Notice the watchdog framework serializes this access (see the mutex in
watchdog_dev.c). So we only need protection for the registers
accessed in the timer and the restart handler.

-- 
Ezequiel Garc?a, VanguardiaSur
www.vanguardiasur.com.ar
