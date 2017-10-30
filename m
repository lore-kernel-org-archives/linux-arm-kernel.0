From: gabriele.paoloni@huawei.com (Gabriele Paoloni)
Date: Mon, 30 Oct 2017 15:31:21 +0000
Subject: [PATCH v10 1/9] LIB: Introduce a generic PIO mapping method
In-Reply-To: <49ac8217-1e89-bb4a-8592-9d57039f792c@acm.org>
References: <1509120687-7352-1-git-send-email-gabriele.paoloni@huawei.com>
 <1509120687-7352-2-git-send-email-gabriele.paoloni@huawei.com>
 <49ac8217-1e89-bb4a-8592-9d57039f792c@acm.org>
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E40CAED4C@FRAEML521-MBX.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Corey

Many Thanks for your comments

[...]

> >   #define IO_SPACE_LIMIT 0xffff
> >   #endif
> >
> > +#include <linux/logic_pio.h>
> 
> This whole thing would be a lot simpler if you had:
> 
> #ifdef CONFIG_INDIRECT_PIO
> #define inb logic_inb
> #define outb logic outb
> .
> .
> #endif /* CONFIG_INDIRECT_PIO */
> 
> and let the "ifndef XXX" below handle not enabling the standard code.
> You could even put that in logic_pio.h to avoid polluting io.h.

Agreed. I'll move it into "logic_pio.h"

> 
> You might have to add "#ifndef inb", etc. above, but I still think it
> would
> be better.

Yes agreed also on adding the "#ifndef ***" around each function re-definition
in logic_pio.h

This will be fixed in v11

> 
> I'm not sure if this wouldn't be better done in arm64/include/asm/io.h,
> though.
> A specific machine may want to only do this in ranges, for instance.

No I don?t think so...this io functions re-0definition has nothing to do
with ARM architecture and I think it is better to keep everything in
logic_pio.h including the file from "include/asm-generic/io.h"

Cheers
Gab

> 
> -corey

[...]

> > --- a/lib/Kconfig
> > +++ b/lib/Kconfig
> > @@ -59,6 +59,32 @@ config ARCH_USE_CMPXCHG_LOCKREF
> >   config ARCH_HAS_FAST_MULTIPLIER
> >   	bool
> >
> > +config LOGIC_PIO
> > +	bool "Generic logical I/O management"
> > +	def_bool y if PCI && !X86 && !IA64 && !POWERPC
> > +	help
> > +	  For some architectures, there are no IO space. To support the
> > +	  accesses to legacy I/O devices on those architectures, kernel
> > +	  implemented the memory mapped I/O mechanism based on bridge bus
> > +	  supports. But for some buses which do not support MMIO, the
> > +	  peripherals there should be accessed with device-specific way.
> > +	  To abstract those different I/O accesses into unified I/O
> accessors,
> > +	  this option provide a generic I/O space management way after
> mapping
> > +	  the device I/O to system logical/fake I/O and help to hide all
> the
> > +	  hardware detail.
> > +
> > +config INDIRECT_PIO
> > +	bool "Access I/O in non-MMIO mode" if LOGIC_PIO
> > +	help
> > +	  On some platforms where no separate I/O space exist, there are
> I/O
> > +	  hosts which can not be accessed in MMIO mode. Based on
> LOGIC_PIO
> > +	  mechanism, the host-local I/O resource can be mapped into
> system
> > +	  logic PIO space shared with MMIO hosts, such as PCI/PCIE, then
> system
> > +	  can access the I/O devices with the mapped logic PIO through
> I/O
> > +	  accessors.
> > +	  This way has a little I/O performance cost. Please make sure
> your
> > +	  devices really need this configure item enabled.
> > +
> 
> If this is always available on the hisilicon chips, I think you would
> want to just always
> enable this on those chips.

In patch 6/9 we have 

+config HISILICON_LPC
+	bool "Support for ISA I/O space on Hisilicon Hip0X"
+	depends on (ARM64 && (ARCH_HISI || COMPILE_TEST))
+	select LOGIC_PIO
+	select INDIRECT_PIO

So the LPC host controller driver is selecting INDIRECT_PIO...

> 
> -corey
> 

Cheers
Gab
