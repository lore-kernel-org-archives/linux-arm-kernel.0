From: jhovold@gmail.com (Johan Hovold)
Date: Wed, 22 May 2013 11:55:45 +0200
Subject: [PATCH] v2 rtc-at91rm9200: add support for at91sam9x5
In-Reply-To: <519BF353.2060800@interlog.com>
References: <519BF353.2060800@interlog.com>
Message-ID: <20130522095545.GA11420@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 21, 2013 at 06:21:07PM -0400, Douglas Gilbert wrote:
> An unspecified number of SoCs from the Atmel's
> at91sam9x5 family including the at91sam9g25 have a
> broken AT91_RTC_IMR (interrupt mask) register which
> always returns zero.
> 
> If this bug can be neutralized, then the existing
> rtc-at91rm9200 driver will work. On the other hand,
> leaving this bug in place, and starting the RTC
> causes unhandled interrupts which result in the
> "SYS" interrupt being disabled. And that takes down
> several other interrupts wired or-ed through the
> SYS interrupt including the DBG port.
> 
> This is the second version of this patch, and is
> against lk 3.10.0-rc2 .

Your patch is almost identical to the one I submitted about two months
ago in this thread:

	https://lkml.org/lkml/2013/4/3/166

except that you do not use DT to the detect SoCs with broken IMR. (Your
patch is also lacking the register-read-back heuristic to make sure the
interrupts have been disabled before you update the mask.)

Are there sam9x5 SoCs with non-broken RTC_IMR which would prevent us
from using DT for detection? If so, I'd rather see your test for
broken-IMR implemented on top of my implementation.

Thanks,
Johan

> ChangeLog:
>     - checks in probe() function if AT91_RTC_IMR is broken.
>       If so, uses a shadow imr
>     - apart from that check, SoCs with a good IMR register
>       take the same paths through rtc-at91rm9200.c as before
>     - SoCs with a broken IMR take a spinlock while changing
>       the state of IER or IDR (and the shadow), mainly to
>       disable interrupts **.
