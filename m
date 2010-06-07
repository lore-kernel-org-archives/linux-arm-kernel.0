From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Tue, 8 Jun 2010 01:43:00 +0200
Subject: [PATCH 05/10] [ARM] tegra: Add timer support
In-Reply-To: <1275635441-17378-6-git-send-email-olof@lixom.net>
References: <1275635441-17378-1-git-send-email-olof@lixom.net>
	<1275635441-17378-2-git-send-email-olof@lixom.net>
	<1275635441-17378-3-git-send-email-olof@lixom.net>
	<1275635441-17378-4-git-send-email-olof@lixom.net>
	<1275635441-17378-5-git-send-email-olof@lixom.net>
	<1275635441-17378-6-git-send-email-olof@lixom.net>
Message-ID: <AANLkTilitoPKhSCk1gxwyzOdu8LZD-9xA3EesFKkDsLy@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/6/4 Olof Johansson <olof@lixom.net>:

> (....)
> +static struct clock_event_device tegra_clockevent = {
> + ? ? ? .name ? ? ? ? ? = "timer0",
> + ? ? ? .rating ? ? ? ? = 300,
> + ? ? ? .features ? ? ? = CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_PERIODIC,
> + ? ? ? .mult ? ? ? ? ? = 16777,
> + ? ? ? .shift ? ? ? ? ?= 24,
> + ? ? ? .set_next_event = tegra_timer_set_next_event,
> + ? ? ? .set_mode ? ? ? = tegra_timer_set_mode,
> +};
> +
> +static struct clocksource tegra_clocksource = {
> + ? ? ? .name ? = "timer_us",
> + ? ? ? .rating = 300,
> + ? ? ? .read ? = tegra_clocksource_read,
> + ? ? ? .mask ? = 0xFFFFFFFFUL,
> + ? ? ? .mult ? = 1000,
> + ? ? ? .shift ?= 0,
> + ? ? ? .flags ?= CLOCK_SOURCE_IS_CONTINUOUS,
> +};

How did you calculate the magic mult/shift numbers 16777/24 and
1000/0 above? Especially the latter intuitively seem very inappropriate,
and I guess there will be revisions of this platform with new frequencies
for the timer as well, making these hard-coded values a bug source.

I would consider using the
clocksource_calc_mult_shift() and
clockevents_calc_mult_shift()
functions based on the frequency of the timer counter and a minimum wakeup
range if you don't know exactly why you want these mult+shifts.

I posted some patches to encourage the use of these recently.

Yours,
Linus Walleij
