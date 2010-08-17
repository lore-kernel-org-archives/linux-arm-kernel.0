From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 17 Aug 2010 13:36:29 +0200
Subject: [PATCH 1/5] ptp: Added a brand new class driver for ptp clocks.
In-Reply-To: <20100817105232.GA9079@riccoc20.at.omicron.at>
References: <cover.1281956490.git.richard.cochran@omicron.at>
	<201008170925.55592.arnd@arndb.de>
	<20100817105232.GA9079@riccoc20.at.omicron.at>
Message-ID: <201008171336.29375.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 17 August 2010, Richard Cochran wrote:
> On Tue, Aug 17, 2010 at 09:25:55AM +0000, Arnd Bergmann wrote:
> > Another difference is that we generally use ioctl for devices that can
> > be enumerated, while syscalls are for system services that are not tied to
> > a specific device. This argument works both ways for PTP IMHO: On the one
> > hand you want to have a reliable clock that you can use without knowing
> > where it comes from, on the other you might have multiple PTP sources that
> > you need to differentiate.
> 
> Yes, I agree. In normal use, there will be only one PTP clock in a
> system. However, for research purposes, it would be nice to have more
> than one.
> 
> I've been looking at offering the PTP clock as a posix clock, and it
> is not as hard as I first thought. The PTP clock or clocks just have
> to be registered as one of the posix_clocks[MAX_CLOCKS] in
> posix-timers.c.

Ok sounds good.

> My suggestion would be to reserve three clock ids in time.h,
> CLOCK_PTP0, CLOCK_PTP1, and CLOCK_PTP2. The first one would be the
> same as CLOCK_REALTIME, for SW timestamping, and the other two would
> allow two different PTP clocks at the same time, for the research use
> case.

I don't think there is a point in making exactly two independent sources
available. The clockid_t space is not really limited, so we could define
an arbitrary range of ids for ptp sources that could be used simultaneously,
as long as we have space more more ids with a fixed number.

Would it be reasonable to assume that on a machine with a large number
of NICs, you'd want a separate ptp source for each of them for timestamping?
Or would you preferably define just one source in such a setup?

I think both could be done with the use of class device attributes in
sysfs for configuration. Maybe you can have one CLOCK_PTP value for one
global PTP source and use sysfs to configure which device that is.

If you also need simultaneous access to the specific clocks, you could
have run-time configured clockid numbers in a sysfs attribute for each
ptp class device.

> Using the clock id will bring another advantage, since it will then be
> possible for user space to specify the desired timestamp source for
> SO_TIMESTAMPING.

God point.

	Arnd
