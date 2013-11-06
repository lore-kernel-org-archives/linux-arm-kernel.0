From: carlo.caione@gmail.com (Carlo Caione)
Date: Wed, 6 Nov 2013 22:07:36 +0100
Subject: [PATCH v3 1/2] ARM: sun4i/sun7i: RTC driver
In-Reply-To: <20131106141357.GQ26440@lukather>
References: <1383172738-8206-1-git-send-email-carlo.caione@gmail.com>
 <20131106141357.GQ26440@lukather>
Message-ID: <CAOQ7t2b4WpH2fpSMC9DbczVSZMSQ=WNyQzoKiJi=r1JD9os-7Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 6, 2013 at 3:13 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi Carlo,
[cut]

> So this means that whenever the time actually has a number of seconds
> = 0, you just loop over, adding a 500ms delay? That seems pretty
> inefficient to me.

I agree. Any suggestion is welcome.

> Also, what happens if you get two times in a row a number of seconds
> equals to 0?

in that case I think that using t <= 2 in the for cycle will solve the problem.

> This kind of construct seems really really odd, and doesn't the issue
> you were trying to address.
>
> However, this looks like a common issue. Have you looked at the other
> drivers to see how they are handling it? Maybe Alessandro will have
> some suggestions as well.

This portion of the code is taken from the original RTC driver leaked
from Allwinner.
Otherwise a better solution could be something like in
http://lxr.linux.no/linux+v3.12/drivers/rtc/rtc-at91rm9200.c#L114

> So, that means that the A10 RTC starts a year 1900, and the A20 at
> year 2010? Why not just put those in your year_offset field directly?

Agree

> Why not just busy-wait ? (with a timeout if you really want to).

because if it fails after 150ms you are almost certainly screwed and
something is wrong

> Isn't the write operation supposed to be done already?

In theory yes, in practice you cannot be sure. This is also a legacy
of the old AW's code. I'll investigate more to check if this is really
useful.

Thanks,

--
Carlo Caione
