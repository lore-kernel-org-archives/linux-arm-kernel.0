From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 8 Jul 2011 09:39:00 +0100
Subject: [RFC PATCH 05/17] ARM: kernel: save/restore kernel IF
In-Reply-To: <4E166147.70504@ti.com>
References: <1310053830-23779-1-git-send-email-lorenzo.pieralisi@arm.com>
	<1310053830-23779-6-git-send-email-lorenzo.pieralisi@arm.com>
	<4E166147.70504@ti.com>
Message-ID: <20110708083900.GA31699@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Santosh,

Thanks for looking at this series.

On Fri, Jul 08, 2011 at 02:45:43AM +0100, Santosh Shilimkar wrote:
> On 7/7/2011 8:50 AM, Lorenzo Pieralisi wrote:
> > In order to define a common idle interface for the kernel
> > to enter low power modes, this patch provides include files
> > and code that manages OS calls for low power entry and exit.
> >
> 
> [....]
> 
> > diff --git a/arch/arm/kernel/sr_entry.S b/arch/arm/kernel/sr_entry.S
> > new file mode 100644
> > index 0000000..4fa9bef
> > --- /dev/null
> > +++ b/arch/arm/kernel/sr_entry.S
> > @@ -0,0 +1,213 @@
> > +/*
> > + * Copyright (c) 2008-2011 ARM Ltd
> > + *
> > + * Author(s):  Jon Callan, Lorenzo Pieralisi
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + *
> > + */
> > +
> > +#include<linux/linkage.h>
> > +#include<generated/asm-offsets.h>
> > +#include<asm/thread_info.h>
> > +#include<asm/memory.h>
> > +#include<asm/ptrace.h>
> > +#include<asm/glue-proc.h>
> > +#include<asm/assembler.h>
> > +#include<asm-generic/errno-base.h>
> > +#include<mach/entry-macro.S>
> > +
> > +	.text
> > +
> > +ENTRY(default_sleep)
> > +	b out		@ BTAC allocates branch and enters loop mode
> > +idle:			@ power down is entered with GIC CPU IF still on which
> > +	dsb		@ might get wfi instruction to complete before the
> > +	wfi		@ CPU is shut down -- infinite loop
> > +out:
> > +    	b idle
> > +ENDPROC(default_sleep)
> 
> Q: What happens for some reason CPU didn't hit targeted
> state in IDLE. Does CPU keep looping here forever.
> 
> On OMAP4, we need to issue additional interconnect
> barrier before WFI. How can we make provision for the same
> 

That's why I added a function pointer, (*sr_sleep) as a way to override
the default loop behaviour which is there to prevent the cpu to exit wfi
after a point of no return (GIC CPU IF is still on).
It is just a tentative solution, so please feel free to comment on this. 
If you pop out from (*sr_sleep) the current code jumps through cpu_reset and 
emulates a reset, which may not be optimal. You might also want to execute 
from SRAM. I have to cater for that.

Again, comments more than welcome.

Lorenzo
