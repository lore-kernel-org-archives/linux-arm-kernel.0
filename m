From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 25 Jan 2011 12:32:13 +0000
Subject: timer_tick vs clockevent
In-Reply-To: <AANLkTikfhObABzCcq4gMYaTQ+i2UdVN-xS+XDWc8kZw2@mail.gmail.com>
References: <AANLkTikfhObABzCcq4gMYaTQ+i2UdVN-xS+XDWc8kZw2@mail.gmail.com>
Message-ID: <20110125123213.GI11507@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 25, 2011 at 03:21:12PM +0300, Sergey Mironov wrote:
> Hi. I am working on porting linux to ARM 1176-based SoC. My quiestion
> is about system time. I see 2 ways of implementing it: 1) Define
> struct sys_timer variable and call timer_tick() from timer's interrupt
> handler 2) Use clocksource/clockevents. Looks like 2nd way is more
> elaborate, but what will I get if choose it?

For all new implementations, (2) is the way to go.  (1) is deprecated,
and involves some pretty hairy code for the gettimeoffset() stuff.

While (2) is more elaborate, you get additional features like NO_HZ
mode and hi-res timer support.  We recently had someone complaining that
they couldn't do something in userspace because their platform support
implemented (1) rather than (2), but I don't recall the details.
