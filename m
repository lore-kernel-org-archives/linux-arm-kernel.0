From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 22 May 2018 17:30:07 +0100
Subject: [PATCH 10/14] arm64: ssbd: Add prctl interface for per-thread
 mitigation
In-Reply-To: <20180522154842.pjml5lagtpyvwwqo@isilmar-4.linta.de>
References: <20180522150648.28297-1-marc.zyngier@arm.com>
 <20180522150648.28297-11-marc.zyngier@arm.com>
 <20180522154842.pjml5lagtpyvwwqo@isilmar-4.linta.de>
Message-ID: <86h8mzbqls.wl-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 22 May 2018 16:48:42 +0100,
Dominik Brodowski wrote:
> 
> 
> On Tue, May 22, 2018 at 04:06:44PM +0100, Marc Zyngier wrote:
> > If running on a system that performs dynamic SSBD mitigation, allow
> > userspace to request the mitigation for itself. This is implemented
> > as a prctl call, allowing the mitigation to be enabled or disabled at
> > will for this particular thread.
> > 
> > Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> > ---
> >  arch/arm64/kernel/Makefile |   1 +
> >  arch/arm64/kernel/ssbd.c   | 107 +++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 108 insertions(+)
> >  create mode 100644 arch/arm64/kernel/ssbd.c
> > 
> > diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
> > index bf825f38d206..0025f8691046 100644
> > --- a/arch/arm64/kernel/Makefile
> > +++ b/arch/arm64/kernel/Makefile
> > @@ -54,6 +54,7 @@ arm64-obj-$(CONFIG_ARM64_RELOC_TEST)	+= arm64-reloc-test.o
> >  arm64-reloc-test-y := reloc_test_core.o reloc_test_syms.o
> >  arm64-obj-$(CONFIG_CRASH_DUMP)		+= crash_dump.o
> >  arm64-obj-$(CONFIG_ARM_SDE_INTERFACE)	+= sdei.o
> > +arm64-obj-$(CONFIG_ARM64_SSBD)		+= ssbd.o
> >  
> >  obj-y					+= $(arm64-obj-y) vdso/ probes/
> >  obj-m					+= $(arm64-obj-m)
> > diff --git a/arch/arm64/kernel/ssbd.c b/arch/arm64/kernel/ssbd.c
> > new file mode 100644
> > index 000000000000..34e3c430176b
> > --- /dev/null
> > +++ b/arch/arm64/kernel/ssbd.c
> > @@ -0,0 +1,107 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2018 ARM Ltd, All Rights Reserved.
> > + */
> > +
> > +#include <linux/sched.h>
> > +#include <linux/thread_info.h>
> > +
> > +#include <asm/cpufeature.h>
> > +
> > +/*
> > + * prctl interface for SSBD
> > + * FIXME: Drop the below ifdefery once the common interface has been merged.
> > + */
> > +#ifdef PR_SPEC_STORE_BYPASS
> 
> That FIXME wants to be looked at.

It is what allowed the series to compile with mainline until last
night. Once I rebase on top of -rc7, I'll remove it.

Thanks,

	M.

-- 
Jazz is not dead, it just smell funny.
