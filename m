From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 21 Jan 2013 21:12:18 +0000
Subject: One of these things (CONFIG_HZ) is not like the others..
In-Reply-To: <50FDAC5F.4040605@linaro.org>
References: <CAKGA1bkiowcO7OPSfPmaB6eRj_3FNr+4ONnaQHEZkpxB2XfduQ@mail.gmail.com>
 <201301212041.17951.arnd@arndb.de> <50FDAC5F.4040605@linaro.org>
Message-ID: <20130121211218.GX23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 21, 2013 at 01:00:15PM -0800, John Stultz wrote:
> So if you can not get actual timer ticks any faster then 200 HZ on that  
> hardware, setting HZ higher could cause some jiffies related timer  
> trouble

Err, no John.  It's the other way around - especially on some platforms
which are incapable of being converted to the clock source support.

EBSA110 has _one_ counter.  It counts down at a certain rate, and when
it rolls over from 0 to FFFF, it produces an interrupt and continues
counting down from FFFF.

To produce anything close to a reasonable regular tick rate from that,
the only way to do it is - with interrupts disabled - read the current
value to find out how far the timer has rolled over, and set it so that
the next event will expire as close as possible to the desired HZ rate.

So, none of the clcokevent stuff can be used; and we rely _purely_ on
counting interrupts in jiffy based increments to provide any reference
of time.

Moreover, because the counter is only 16-bit, and it's clocked from
something around 7MHz, well, maths will tell you why 200Hz had to be
chosen rather than 100Hz.
