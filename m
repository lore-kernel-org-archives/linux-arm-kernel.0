From: philipp.zabel@gmail.com (Philipp Zabel)
Date: Sun, 26 Feb 2012 11:48:48 +0100
Subject: [PATCH] pxa/hx4700: Avoid unbalanced irq wakeup enables/disables
In-Reply-To: <E1QHn5f-0004Rb-6j@outmx07.plus.net>
References: <E1QHn5f-0004Rb-6j@outmx07.plus.net>
Message-ID: <1330253328.3673.4.camel@flow>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, den 05.05.2011, 01:10 +0000 schrieb Paul Parsons:
> Resuming a suspended hx4700 results in Unbalanced IRQ warnings:
> 
> WARNING: at kernel/irq/manage.c:507 irq_set_irq_wake+0xe0/0xec()
> Unbalanced IRQ 246 wake disable
> ..
> 
> Likewise for IRQ 241 and IRQ 243. The 3 ASIC3 GPIO buttons - RECORD/CALENDAR/HOME - each fail in a call to enable_irq_wake() in gpio_keys_suspend() because of an absent irq_set_wake() handler in the asic3_gpio_irq_chip structure. Matching calls to disable_irq_wake() in gpio_keys_resume() then print the warnings. Since we should never need to resume via the 3 ASIC3 GPIO buttons, nor 2 of the 3 builtin GPIO buttons - MAIL/CONTACTS, the simplest remedy for the warnings is to enable irq wakeup on the POWER button only.
> 
> Signed-off-by: Paul Parsons <lost.distance@yahoo.com>
> ---
> --- clean-2.6.39-rc6/arch/arm/mach-pxa/hx4700.c	2011-05-04 12:09:06.298511475 +0100
> +++ linux-2.6.39-rc6/arch/arm/mach-pxa/hx4700.c	2011-05-05 00:07:57.034493981 +0100
> @@ -191,7 +191,7 @@ static struct pxaficp_platform_data ficp
>  		.active_low = _active_low,		\
>  		.desc       = _desc,			\
>  		.type       = EV_KEY,			\
> -		.wakeup     = 1,			\
> +		.wakeup     = KEY_##_code == KEY_POWER,	\
>  	}
>  
>  static struct gpio_keys_button gpio_keys_buttons[] = {
> 

On my hx4700 iPAQ running Windows Mobile 5, gpio button wakeup is
configurable under "Start -> Settings -> Personal -> Buttons -> Lock".
There is a checkbox "Disable all buttons except power button" which
enables/disables the keypad and ASIC3 GPIO buttons as wakeup sources.

To achieve the same functionality on linux, we could split the power
button and the other buttons into separate gpio_keys devices and let
userspace disable the other buttons as wakeup sources via the device's
pm_wakeup interface. For that we need 

Given that ASIC3 doesn't support irq_set_wake for now,
Acked-By: Philipp Zabel <philipp.zabel@gmail.com>

regards
Philipp
