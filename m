From: mturquette@linaro.org (Michael Turquette)
Date: Sun, 26 Apr 2015 12:07:29 -0700
Subject: Question about DC-DC frequency handling
In-Reply-To: <604104768.496325.1430058690855.JavaMail.open-xchange@oxbaltgw00.schlund.de>
References: <604104768.496325.1430058690855.JavaMail.open-xchange@oxbaltgw00.schlund.de>
Message-ID: <20150426190729.16410.58019@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Stefan Wahren (2015-04-26 07:31:30)
> Hi,
> 
> i'm current working on a regulator driver which should be able to change DC-DC
> clock frequency.
> 
> Now here is my question. What is the prefered way to implement the clock
> handling?

Fun question. I have a question for you: who are the consumers of this
DC-DC? Do the downstream, consuming devices care about "clock rate" of
your regulator?

I'll hazard a guess that they do not care. DC-DC switching frequency is
an important aspect of power supply design, but switching frequency of a
power supply is not controlled by the clock framework in any example
that I am aware of.

> 
> Option A):
> 
> The regulator driver handles all internally (select clock source, set
> frequency).

Mark should weigh in on this, but I think option A is correct. Maybe
something like regulator_set_mode could program your switching
frequency?

> 
> Option B):
> 
> The DC-DC clock domain is implemented in the clock driver and the regulator
> driver uses the clock framework.

The only reason to use the clock framework is if downstream devices will
call clk_get and do something with the rate (e.g. clk_get_rate,
clk_set_rate, clk_enable, clk_disable, etc).

It sounds like your downstream devices will want to enable & disable the
regulator, but probably that's it?

Of course I could be wrong about the DC-DC switching frequency stuff
above, but that's my guess for now.

Regards,
Mike

> 
> Best regards
> Stefan
