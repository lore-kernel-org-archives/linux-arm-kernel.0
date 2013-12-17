From: broonie@kernel.org (Mark Brown)
Date: Tue, 17 Dec 2013 19:55:19 +0000
Subject: [PATCH 1/4] arm64: topology: Implement basic CPU topology support
In-Reply-To: <20131217170625.GB9831@e102568-lin.cambridge.arm.com>
References: <1387212565-12668-1-git-send-email-broonie@kernel.org>
 <20131217170625.GB9831@e102568-lin.cambridge.arm.com>
Message-ID: <20131217195519.GD28455@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 17, 2013 at 05:06:25PM +0000, Lorenzo Pieralisi wrote:
> On Mon, Dec 16, 2013 at 04:49:22PM +0000, Mark Brown wrote:

> > +void store_cpu_topology(unsigned int cpuid);

> I still think this function is not needed at all and therefore should
> not be exported.

> > +static void __cpuinit smp_store_cpu_info(unsigned int cpuid)
> > +{
> > +	store_cpu_topology(cpuid);

> As I mentioned this need not be done here. Parse the topology from DT,
> (cpu_logical_map or cpu-map) in one go and get rid of store_cpu_topology().

That's what we're actually doing for parsing, the parsing all happens at
once.

I do think it's useful to to have the function there partly just as a
hook but more for the warning it generates if we manage to boot a core
that we didn't hook up with the topology information.  This seems like
it'll be helpful for debugging issues - we'll actively warn if there are
CPUs that have been omitted from the definition in the firmware.  The
other things the function does could be done elsewhere I think, it
didn't seem worth moving them though.

> > + * arch/arm64/kernel/topology.c
> > + *
> > + * Copyright (C) 2011,2013 Linaro Limited.
> > + * Written by: Vincent Guittot
> 
> You should probably update the header, just a nitpick though.

Well, most of this still is Vincent's code with the serial numbers filed
off but yeah.

> > +#include <linux/cpu.h>
> > +#include <linux/cpumask.h>
> > +#include <linux/export.h>
> > +#include <linux/init.h>
> > +#include <linux/percpu.h>
> > +#include <linux/node.h>
> > +#include <linux/nodemask.h>
> > +#include <linux/sched.h>
> > +#include <linux/slab.h>

> > +#include <asm/cputype.h>
> > +#include <asm/smp_plat.h>

> I think that some of these includes are not needed, they were needed in
> previous versions, but not in this patch as it stands.

Some can probably go.  I don't think some of those were even needed on
arm.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131217/e28cb16c/attachment-0001.sig>
