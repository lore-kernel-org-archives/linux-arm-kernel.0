From: jan.glauber@caviumnetworks.com (Jan Glauber)
Date: Fri, 11 Nov 2016 11:39:21 +0100
Subject: [PATCH v4 1/5] arm64: perf: Basic uncore counter support for
 Cavium ThunderX SOC
In-Reply-To: <20161110165405.GH4418@leverpostej>
References: <cover.1477741719.git.jglauber@cavium.com>
 <73173d6ad2430eead5e9da40564a90a60961b6d9.1477741719.git.jglauber@cavium.com>
 <20161110165405.GH4418@leverpostej>
Message-ID: <20161111103921.GE16907@hardcore>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

thanks for reviewing. One question below, for most of your other comments
I think we need to come to a conclusion about the aggregation first.

On Thu, Nov 10, 2016 at 04:54:06PM +0000, Mark Rutland wrote:
> Hi Jan,
> 
> Apologies for the delay in getting to this.
> 
> On Sat, Oct 29, 2016 at 01:55:29PM +0200, Jan Glauber wrote:
> > diff --git a/drivers/perf/uncore/uncore_cavium.c b/drivers/perf/uncore/uncore_cavium.c
> > new file mode 100644
> > index 0000000..a7b4277
> > --- /dev/null
> > +++ b/drivers/perf/uncore/uncore_cavium.c
> > @@ -0,0 +1,351 @@
> > +/*
> > + * Cavium Thunder uncore PMU support.
> > + *
> > + * Copyright (C) 2015,2016 Cavium Inc.
> > + * Author: Jan Glauber <jan.glauber@cavium.com>
> > + */
> > +
> > +#include <linux/cpufeature.h>
> > +#include <linux/numa.h>
> > +#include <linux/slab.h>
> 
> I believe the following includes are necessary for APIs and/or data
> explicitly referenced by the driver code:
> 
> #include <linux/atomic.h>
> #include <linux/cpuhotplug.h>
> #include <linux/cpumask.h>
> #include <linux/device.h>
> #include <linux/errno.h>
> #include <linux/io.h>
> #include <linux/kernel.h>
> #include <linux/list.h>
> #include <linux/pci.h>
> #include <linux/perf_event.h>
> #include <linux/printk.h>
> #include <linux/smp.h>
> #include <linux/sysfs.h>
> #include <linux/types.h>
> 
> #include <asm/local64.h>
> 
> ... please add those here.

Should I also add includes that are already in the included by uncore_cavium.h?
I usually avoid includes that come through the "local" header file.
