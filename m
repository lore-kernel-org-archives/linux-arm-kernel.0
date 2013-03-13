From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 13 Mar 2013 15:49:08 +0000
Subject: [PATCH v3 03/11] clocksource: sp804: add device tree support
In-Reply-To: <CAD6h2NQa-RhR555o_1_RYPuPb4366H_AwK1U9S3pRVPdo_xNNg@mail.gmail.com>
References: <1363151142-32162-1-git-send-email-haojian.zhuang@linaro.org>
 <1363151142-32162-4-git-send-email-haojian.zhuang@linaro.org>
 <1363172730.3100.17.camel@hornet>	<51408A71.9090501@gmail.com>
 <1363185757.3100.66.camel@hornet>	<51409276.8050601@gmail.com>
 <1363186548.3100.75.camel@hornet>
 <CAD6h2NTP+X6RVr23Y-XLrQMqHptH974oYooTX=Y6F_Q4hyrmNA@mail.gmail.com>
 <1363188238.3100.95.camel@hornet>
 <CAD6h2NR+SC4cN5cBzHUNBfDQ1=x8Rbn3C4AizNyy562iMjyU6A@mail.gmail.com>
 <1363188595.3100.101.camel@hornet>
 <CAD6h2NQa-RhR555o_1_RYPuPb4366H_AwK1U9S3pRVPdo_xNNg@mail.gmail.com>
Message-ID: <1363189748.3100.108.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-03-13 at 15:42 +0000, Haojian Zhuang wrote:
> In my current implementation, I need two things to judge whether
> irq is really necessary.
> 
> If the timer contains "arm,sp804-clockevent = <evtoffs>" property,
> I'll check whether the timer irq is specified at the same time.
> 
> TIMINT1 & TIMINTC are not routed. TIMINT2 is used for clock event.

Fine, so simply reverse the logic and drop the "arm,sp804-clock*"
properties. Something like:

if (has_timint1) {
	evtoffs = TIMER_1_BASE;
	irq = irq_of_parse_and_map(np, 1);
	srcoffs = TIMER_2_BASE;
} else (has_timint2) {
	evtoffs = TIMER_2_BASE;
	irq = irq_of_parse_and_map(np, 2);
	srcoffs = TIMER_1_BASE;
} else {
	can't be clockevent, sorry
}

Hope it makes clear what I'd expect from the driver.

Pawe?
