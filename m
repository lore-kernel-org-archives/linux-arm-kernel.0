From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 9 Sep 2014 17:54:45 +0100
Subject: [PATCH v3 02/17] ARM64 / ACPI: Get RSDP and ACPI boot-time tables
In-Reply-To: <20140909162648.GE2910@arm.com>
References: <1409583475-6978-1-git-send-email-hanjun.guo@linaro.org>
 <1409583475-6978-3-git-send-email-hanjun.guo@linaro.org>
 <20140909162648.GE2910@arm.com>
Message-ID: <20140909165445.GC3896@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 09, 2014 at 05:26:49PM +0100, Catalin Marinas wrote:
> On Mon, Sep 01, 2014 at 03:57:40PM +0100, Hanjun Guo wrote:
> > diff --git a/arch/arm64/include/asm/acenv.h b/arch/arm64/include/asm/acenv.h
> > new file mode 100644
> > index 0000000..3899ee6
> > --- /dev/null
> > +++ b/arch/arm64/include/asm/acenv.h
> > @@ -0,0 +1,18 @@
> > +/*
> > + * ARM64 specific ACPICA environments and implementation
> > + *
> > + * Copyright (C) 2014, Linaro Ltd.
> > + *   Author: Hanjun Guo <hanjun.guo@linaro.org>
> > + *   Author: Graeme Gregory <graeme.gregory@linaro.org>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */
> > +
> > +#ifndef _ASM_ACENV_H
> > +#define _ASM_ACENV_H
> > +
> > +#define ACPI_FLUSH_CPU_CACHE() WARN_ONCE(1, "Not currently supported on ARM64")
> 
> Does this mean that it will be supported at some point?

>From what I recall it's impossible to support as we have no equivalent
of WBINVD -- the possibility migration of dirty cache lines renders it
impossible to guarantee that the caches remain empty (or that data even
left the local caches in the first place).

> Looking at the places where this function is called, I don't really
> see how this would ever work on ARM. Which means that we add such
> macro just to be able to compile code that would never be used on
> arm64. I would rather see the relevant ACPI files only compiled on
> x86/IA-64 rather than arm64.

Agreed.

It looks like include/acpi/platform/acenv.h defines an empty
ACPI_FLUSH_CPU_CACHE() stub, so something else should probably be done
to turn the use of ACPI_FLUSH_CPU_CACHE() into a build-time bug on
arm64.

Mark.
