From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 15 Mar 2013 12:34:08 +0000
Subject: [PATCH v3 06/11] ARM: vexpress: use clocksource_of_init for sp804
In-Reply-To: <5140AA01.1010007@gmail.com>
References: <1363151142-32162-7-git-send-email-haojian.zhuang@linaro.org>
 <1363173037.3100.22.camel@hornet>
 <CAD6h2NQWB3+1QepQjBE0BZiG44YAQRi7e-9+oZvVYpYV8QycDA@mail.gmail.com>
 <1363175175.3100.37.camel@hornet>
 <CAD6h2NSUyFvhoqMsYqT=rzFZ--MWv+0vHOCtAV9n-5YO+LNTMA@mail.gmail.com>
 <1363186087.3100.72.camel@hornet>
 <CAD6h2NRkS4qk+iqbWhaOpBHmjSYOB=YBbfNkn0X3jzNawzgNEA@mail.gmail.com>
 <1363187979.3100.93.camel@hornet>
 <CAD6h2NTufx2rRwbwsgGHN42t7+_KL418++zk_C++EvFKU+ZwLg@mail.gmail.com>
 <5140AA01.1010007@gmail.com>
Message-ID: <20130315123408.GJ4977@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 13, 2013 at 11:32:01AM -0500, Rob Herring wrote:
> If you have 2 sp804's, why do you care which one is used by the OS? If
> they are identical, then it doesn't matter. If they are not, then
> describe how they are not identical.
> 
> The realview and versatile boards currently do this, but there is no
> good reason that I see and I intend to change this.

It is highly likely that the timer choice on these boards was made by
independent people, who came up with different random choices.  Nothing
more than that - I believe it to be entirely arbitary.  I do think
discussion is getting too bogged down on this point.

So, we could make the decision about which timer to use for the clock
event based on whether an interrupt is specified, the known clock rate
and size of the timer register.

Same can be done for the clock source, but preferring a timer without
an interrupt in preference to one with an interrupt.

We do have this nice rating system for clocksources and clockevents -
and it could be more flexible if it didn't separate clocksources from
clockevents - allowing just a single "timer" and marking it as being
suitable as a clocksource or a clockevent, or indeed both.

However, for SP804 selection, there are cases where it matters, such as
on Versatile Express where you have to select the right set of SP804 to
have a working system (because ARM didn't fully document the SP804 setup
there) and we have no way to switch some of those timers from their
32kHz clock source.  But then we could just omit the clock source for
the "bad" SP804s which would prevent them being used.
