From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 18 Jun 2013 17:28:58 +0200
Subject: [PATCH] ARM: clocksource: add support for MOXA ART SoCs
In-Reply-To: <1371549604-7201-1-git-send-email-jonas.jensen@gmail.com>
References: <1371549604-7201-1-git-send-email-jonas.jensen@gmail.com>
Message-ID: <201306181728.58869.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 18 June 2013, Jonas Jensen wrote:
> This patch adds an clocksource driver for the main timer found
> on MOXA ART SoCs.
> 
> Applies to 3.10-rc1 and arm-soc/for-next (2013-06-15)
> 
> Signed-off-by: Jonas Jensen <jonas.jensen@gmail.com>

I didn't look closely before but I agree with Thomas Petazzoni, this should
be converted to clocksource/clockevent.

A few other things I noticed now:

> +#define APB_CLK 48000000

You are hardcoding the clock rate above, which makes it less portable
than it should be. Ideally you would use clk_get_rate() on
the default clock, but you don't actually implement a clk
driver for your platform and probably don't need one.

I don't know what others think about this, but I'd suggest just
using a "clock-frequency" property in the device node to read
the clock rate.

> +#define TIMER_1_COUNT(base_addr)        (base_addr + 0x00)
> +#define TIMER_1_LOAD(base_addr)         (base_addr + 0x04)
> +#define TIMER_1_MATCH1(base_addr)       (base_addr + 0x08)
> +#define TIMER_1_MATCH2(base_addr)       (base_addr + 0x0C)
> +
> +#define TIMER_2_COUNT(base_addr)        (base_addr + 0x10)
> +#define TIMER_2_LOAD(base_addr)         (base_addr + 0x14)
> +#define TIMER_2_MATCH1(base_addr)       (base_addr + 0x18)
> +#define TIMER_2_MATCH2(base_addr)       (base_addr + 0x1C)
> +
> +#define TIMER_3_COUNT(base_addr)        (base_addr + 0x20)
> +#define TIMER_3_LOAD(base_addr)         (base_addr + 0x24)
> +#define TIMER_3_MATCH1(base_addr)       (base_addr + 0x28)
> +#define TIMER_3_MATCH2(base_addr)       (base_addr + 0x2C)
> +

You actually seem to have three independent timers here, which
means you can use one as the clock source and one for clock
events.

> +#define TIMER1_COUNT                0x0
> +#define TIMER1_LOAD                 0x4
> +#define TIMER1_MATCH1               0x8
> +#define TIMER1_MATCH2               0xC
> +#define TIMER2_COUNT                0x10
> +#define TIMER2_LOAD                 0x14
> +#define TIMER2_MATCH1               0x18
> +#define TIMER2_MATCH2               0x1C
> +#define TIMER3_COUNT                0x20
> +#define TIMER3_LOAD                 0x24
> +#define TIMER3_MATCH1               0x28
> +#define TIMER3_MATCH2               0x2C
> +#define TIMER_INTR_MASK     0x38

These look like duplicates from above. I'd prefer the second syntax, just
do the addition of base_addr where you need it.

	Arnd
