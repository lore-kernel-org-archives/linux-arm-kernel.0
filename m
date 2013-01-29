From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 29 Jan 2013 13:42:33 -0500 (EST)
Subject: [PATCH v3 14/15] ARM: vexpress/dcscb: handle platform coherency
 exit/setup and CCI
In-Reply-To: <20130129104642.GK30563@e102568-lin.cambridge.arm.com>
References: <1359445870-18925-1-git-send-email-nicolas.pitre@linaro.org>
 <1359445870-18925-15-git-send-email-nicolas.pitre@linaro.org>
 <20130129104642.GK30563@e102568-lin.cambridge.arm.com>
Message-ID: <alpine.LFD.2.02.1301291327340.6300@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 29 Jan 2013, Lorenzo Pieralisi wrote:

> On Tue, Jan 29, 2013 at 07:51:09AM +0000, Nicolas Pitre wrote:
> 
> [...]
> 
> > +		/*
> > +		 * Flush the local CPU cache.
> > +		 *
> > +		 * A15/A7 can hit in the cache with SCTLR.C=0, so we don't need
> > +		 * a preliminary flush here for those CPUs.  At least, that's
> > +		 * the theory -- without the extra flush, Linux explodes on
> > +		 * RTSM (maybe not needed anymore, to be investigated).
> > +		 */
> > +		flush_cache_louis();
> 
> This is not needed. If it is, that is a model bug and should be flagged
> up as such.

Could someone at ARM do that?

I just confirmed that this is still the case by commenting out the 
preliminary flush calls and hot-plugging CPUs out and back.  Result is a 
non-sensical kernel oops which has the looks of serious memory 
corruption.  This is with RTSM version 7.1.42.

> > +		cpu_proc_fin(); /* disable allocation into internal caches*/
> 
> This code disables the I-cache causing following instruction fetches from
> DRAM; that is extremely slow and should be avoided, there is no point in
> disabling the I-cache here, that is not required.
> On fast-models that's a non-issue, but I really want to prevent copy'n'paste
> of this sequence as it stands.

Agreed, I'll change that.  The (not included in this series) TC2 backend 
does leave the I-cache active already.

> > diff --git a/arch/arm/mach-vexpress/dcscb_setup.S b/arch/arm/mach-vexpress/dcscb_setup.S
> > new file mode 100644
> > index 0000000000..cac033b982
> > --- /dev/null
> > +++ b/arch/arm/mach-vexpress/dcscb_setup.S
> > @@ -0,0 +1,80 @@
> > +/*
> > + * arch/arm/include/asm/dcscb_setup.S
> > + *
> > + * Created by:  Dave Martin, 2012-06-22
> > + * Copyright:   (C) 2012-2013  Linaro Limited
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */
> > +
> > +
> > +#include <linux/linkage.h>
> > +#include <asm/mcpm_entry.h>
> > +
> > +
> > +#define SLAVE_SNOOPCTL_OFFSET	0
> > +#define SNOOPCTL_SNOOP_ENABLE	(1 << 0)
> > +#define SNOOPCTL_DVM_ENABLE	(1 << 1)
> > +
> > +#define CCI_STATUS_OFFSET	0xc
> > +#define STATUS_CHANGE_PENDING	(1 << 0)
> > +
> > +#define CCI_SLAVE_OFFSET(n)	(0x1000 + 0x1000 * (n))
> > +
> > +#define RTSM_CCI_PHYS_BASE	0x2c090000
> > +#define RTSM_CCI_SLAVE_A15	3
> > +#define RTSM_CCI_SLAVE_A7	4
> 
> We need to remove these hardcoded values in due course as you know, I am
> working on new code that allows us to match the CCI port address to
> MPIDR on resume.

Yes, absolutely.  I was expecting this code to become generic and more 
closely tied to the CCI driver.  The CCI init 
code could set up variables to be used by this code.


Nicolas
