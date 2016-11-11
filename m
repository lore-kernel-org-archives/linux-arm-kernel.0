From: jan.glauber@caviumnetworks.com (Jan Glauber)
Date: Fri, 11 Nov 2016 08:37:35 +0100
Subject: [PATCH v4 1/5] arm64: perf: Basic uncore counter support for
 Cavium ThunderX SOC
In-Reply-To: <20161110165405.GH4418@leverpostej>
References: <cover.1477741719.git.jglauber@cavium.com>
 <73173d6ad2430eead5e9da40564a90a60961b6d9.1477741719.git.jglauber@cavium.com>
 <20161110165405.GH4418@leverpostej>
Message-ID: <20161111073735.GB16907@hardcore>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 10, 2016 at 04:54:06PM +0000, Mark Rutland wrote:
> > +/*
> > + * Some notes about the various counters supported by this "uncore" PMU
> > + * and the design:
> > + *
> > + * All counters are 64 bit long.
> > + * There are no overflow interrupts.
> > + * Counters are summarized per node/socket.
> > + * Most devices appear as separate PCI devices per socket with the exception
> > + * of OCX TLK which appears as one PCI device per socket and contains several
> > + * units with counters that are merged.
> 
> As a general note, as I commented on the QC L2 PMU driver [1,2], we need
> to figure out if we should be aggregating physical PMUs or not.

As said before, although it would be possible to create separate PMUs
for each unit, the individual counters are not interesting. For example
we are not interested in individual counters of Tag-and-data unit 0..7,
we just want the global view.

> Judging by subsequent patches, each unit has individual counters and
> controls, and thus we cannot atomically read/write counters or controls
> across them. As such, I do not think we should aggregate them, and
> should expose them separately to userspace.

That sounds like just moving the problem of aggregating the counters to
user-space. And would make the results even worse, if the user needs
several calls to summarize the counters, given how slow a perf counter
read is.


> That will simplify a number of things (e.g. the CPU migration code no
> longer has to iterate over a list of units).

Sure, it simplifies the kernel part, but it moves the cost to the user.
