From: richardcochran@gmail.com (Richard Cochran)
Date: Tue, 17 Aug 2010 12:52:32 +0200
Subject: [PATCH 1/5] ptp: Added a brand new class driver for ptp clocks.
In-Reply-To: <201008170925.55592.arnd@arndb.de>
References: <cover.1281956490.git.richard.cochran@omicron.at>
	<201008162159.39734.arnd@arndb.de>
	<20100817083216.GA3330@riccoc20.at.omicron.at>
	<201008170925.55592.arnd@arndb.de>
Message-ID: <20100817105232.GA9079@riccoc20.at.omicron.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 17, 2010 at 09:25:55AM +0000, Arnd Bergmann wrote:
> Another difference is that we generally use ioctl for devices that can
> be enumerated, while syscalls are for system services that are not tied to
> a specific device. This argument works both ways for PTP IMHO: On the one
> hand you want to have a reliable clock that you can use without knowing
> where it comes from, on the other you might have multiple PTP sources that
> you need to differentiate.

Yes, I agree. In normal use, there will be only one PTP clock in a
system. However, for research purposes, it would be nice to have more
than one.

I've been looking at offering the PTP clock as a posix clock, and it
is not as hard as I first thought. The PTP clock or clocks just have
to be registered as one of the posix_clocks[MAX_CLOCKS] in
posix-timers.c.

My suggestion would be to reserve three clock ids in time.h,
CLOCK_PTP0, CLOCK_PTP1, and CLOCK_PTP2. The first one would be the
same as CLOCK_REALTIME, for SW timestamping, and the other two would
allow two different PTP clocks at the same time, for the research use
case.

Using the clock id will bring another advantage, since it will then be
possible for user space to specify the desired timestamp source for
SO_TIMESTAMPING.

Richard
