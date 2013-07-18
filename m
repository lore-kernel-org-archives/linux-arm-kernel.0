From: jonas.jensen@gmail.com (Jonas Jensen)
Date: Thu, 18 Jul 2013 13:55:26 +0200
Subject: [PATCH v3] clk: add MOXA ART SoCs clock driver
In-Reply-To: <20130718110201.GB29153@e106331-lin.cambridge.arm.com>
References: <1372943292-6960-1-git-send-email-jonas.jensen@gmail.com>
 <1374067396-30155-1-git-send-email-jonas.jensen@gmail.com>
 <20130718095035.GA29153@e106331-lin.cambridge.arm.com>
 <CACmBeS2SnpiUtiQD6j9qyaXZ5-chHSHVeo4c5=UhitVonvkKtw@mail.gmail.com>
 <20130718110201.GB29153@e106331-lin.cambridge.arm.com>
Message-ID: <CACmBeS24smrJ4SLY7snv1_6SRcuXRkZ8t0PGMvBupUpKMMb43w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18 July 2013 13:02, Mark Rutland <mark.rutland@arm.com> wrote:
> Ok. I'm just concerned that the linkage isn't explicit or obvious.

> This does leave apb-clock completely dependent on core-clock, and unless
> I've missed something there's no linkage between the two described in
> the dt.

I can add a description in the core-clock binding and also for
apb-clock pointing
out that it's set from core-clock.

> How does core-clock physically relate to apb-clock? Does it feed or is
> it fed by apb-clock?

apb-clock is entirely a DT construct used by drivers to get the fixed
rate 48MHz.
It's not fed by core-clock more than what happens in probe.

For UC-7112-LX, drivers using apb-clock are: clocksource, MMC, watchdog

Because clocksource relies on apb-clock, a successful probe of
core-clock is critical.

Commonly, drivers look up the apb-clock node and call clk_get_rate.

> Are we always guaranteed to have core-clock if we have apb-clock, and is
> it part of the same block in hardware? If so we could describe the
> amalgamation as a provider with two clock outputs, with core-clock's
> registers for configuration at probe-time.

Yes, as described above, there can not be a apb-clock without core-clock.


I think drivers could find and use core-clock instead. Maybe the abstraction
of apb-clock is unnecessary?


Best regards,
Jonas
