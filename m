From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 13 Mar 2013 16:35:02 +0000
Subject: [PATCH v3 03/11] clocksource: sp804: add device tree support
In-Reply-To: <1363189748.3100.108.camel@hornet>
References: <1363151142-32162-1-git-send-email-haojian.zhuang@linaro.org>
 <CAD6h2NQa-RhR555o_1_RYPuPb4366H_AwK1U9S3pRVPdo_xNNg@mail.gmail.com>
 <1363189748.3100.108.camel@hornet>
Message-ID: <201303131635.02355.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 13 March 2013, Pawel Moll wrote:
> Fine, so simply reverse the logic and drop the "arm,sp804-clock*"
> properties. Something like:
> 
> if (has_timint1) {
>         evtoffs = TIMER_1_BASE;
>         irq = irq_of_parse_and_map(np, 1);
>         srcoffs = TIMER_2_BASE;
> } else (has_timint2) {
>         evtoffs = TIMER_2_BASE;
>         irq = irq_of_parse_and_map(np, 2);
>         srcoffs = TIMER_1_BASE;
> } else {
>         can't be clockevent, sorry
> }
> 
> Hope it makes clear what I'd expect from the driver.

Makes sense. I guess you can actually derive "has_timint1"
from the presence of the irq and just try to parse it:

	irq = irq_of_parse_and_map(np, 0);
	if (irq) {
		evtoffs = TIMER_1_BASE;
		srcoffs = TIMER_2_BASE;
	} else {
		irq = irq_of_parse_and_map(np, 1);
		if (!irq)
			return -ENODEV;
		srcoffs = TIMER_1_BASE;
		evtoffs = TIMER_2_BASE;
	}


I wonder if we can ever get into the second case though: If the
first interrupt in not valid, can there be a second one in the
interrupts property? I don't know of a way to put an "invalid"
interrupt in there.

	Arnd
