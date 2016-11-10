From: will.deacon@arm.com (Will Deacon)
Date: Thu, 10 Nov 2016 19:46:59 +0000
Subject: [PATCH v4 1/5] arm64: perf: Basic uncore counter support for
 Cavium ThunderX SOC
In-Reply-To: <20161110165405.GH4418@leverpostej>
References: <cover.1477741719.git.jglauber@cavium.com>
 <73173d6ad2430eead5e9da40564a90a60961b6d9.1477741719.git.jglauber@cavium.com>
 <20161110165405.GH4418@leverpostej>
Message-ID: <20161110194659.GD17134@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 10, 2016 at 04:54:06PM +0000, Mark Rutland wrote:
> On Sat, Oct 29, 2016 at 01:55:29PM +0200, Jan Glauber wrote:
> > diff --git a/drivers/perf/uncore/uncore_cavium.c b/drivers/perf/uncore/uncore_cavium.c
> > new file mode 100644
> > index 0000000..a7b4277
> > --- /dev/null
> > +++ b/drivers/perf/uncore/uncore_cavium.c
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
> 
> Judging by subsequent patches, each unit has individual counters and
> controls, and thus we cannot atomically read/write counters or controls
> across them. As such, I do not think we should aggregate them, and
> should expose them separately to userspace.

I thought each unit was registered as a separate PMU to perf? Or are you
specifically commenting on the OCX TLK? The comment there suggests that
the units cannot be individually enabled/disabled and, without docs, I
trust that's the case.

Will
