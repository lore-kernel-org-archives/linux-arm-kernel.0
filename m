From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 26 Feb 2016 09:14:10 +0100
Subject: next-20160225 build: 2 failures 44 warnings (next-20160225)
In-Reply-To: <20160226030949.GL18327@sirena.org.uk>
References: <E1aYsmb-0006qb-76@optimist> <20160226030949.GL18327@sirena.org.uk>
Message-ID: <20160226091410.5dad4306@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark,

On Fri, 26 Feb 2016 12:09:49 +0900, Mark Brown wrote:

> also caused by b4f596b19624 (arm64: add mvebu architecture entry) which
> enables MVBEU on arm64, the commit was present for a little while and
> the error cropped up but didn't get reported due to other things masking
> it.  atomic_io_modify() is only available on ARM, I'm unsure if this
> needs a driver change or if the driver is just specific to older
> hardware anyway.  The code is only used in the init path accessing what
> look to be device specific registers so I'm not 100% clear why it
> specifically needs to be an atomic modify.

atomic_io_modify() is also used in the ->start() and ->stop() hooks, so
not only during initialization. The reason we use atomic_io_modify()
here is because this TIMER_CTRL register is shared with the clocksource
drivers (time-orion.c, time-armada-370-xp.c). Indeed, the timers and
watchdogs share a single register that allows to enable/disable all
timers/watchdogs. Somewhat unfortunate choice, but that's how the HW is.

By far the easiest solution is to add "depends on ARM" to
ORION_WATCHDOG.

Another solution would be to provide an implementation of
atomic_io_modify() on arm64, though that would need the ACK from the
ARM64 maintainers.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
