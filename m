From: jamie@jamieiles.com (Jamie Iles)
Date: Fri, 5 Aug 2011 12:32:55 +0100
Subject: [RFC PATCH 1/2] ARM: CSR: add rtc i/o bridge interface for
	SiRFprimaII
In-Reply-To: <CAGsJ_4wy=6DHeyqi1ZpkfDxDFsJpGvhvbzz1K=12soC29MZUAg@mail.gmail.com>
References: <1312512888-25070-1-git-send-email-bs14@csr.com>
	<1312512888-25070-2-git-send-email-bs14@csr.com>
	<20110805100938.GP2899@pulham.picochip.com>
	<CAGsJ_4wy=6DHeyqi1ZpkfDxDFsJpGvhvbzz1K=12soC29MZUAg@mail.gmail.com>
Message-ID: <20110805113255.GR2899@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 05, 2011 at 07:28:05PM +0800, Barry Song wrote:
> Hi Jamie,
> Thanks.
> 
> 2011/8/5 Jamie Iles <jamie@jamieiles.com>:
> > Hi Barry, Zhiwu,
> >
> > A couple of minor comments inline.
> >
> > Jamie
> >
> > On Thu, Aug 04, 2011 at 07:54:47PM -0700, Barry Song wrote:
> >> From: Zhiwu Song <zhiwu.song@csr.com>
> >>
> >> The module is a bridge between the RTC clock domain and the CPU interface
> >> clock domain. ARM access the register of SYSRTC, GPSRTC and PWRC through
> >> this module.
> >>
> >> Signed-off-by: Zhiwu Song <zhiwu.song@csr.com>
> >> Signed-off-by: Barry Song <baohua.song@csr.com>
> >> ---
> >> ?arch/arm/mach-prima2/Makefile ? ? ? ?| ? ?1 +
> >> ?arch/arm/mach-prima2/rtciobrg.c ? ? ?| ?118 ++++++++++++++++++++++++++++++++++
> >> ?include/linux/rtc/sirfsoc_rtciobrg.h | ? 18 +++++
> >> ?3 files changed, 137 insertions(+), 0 deletions(-)
> >> ?create mode 100644 arch/arm/mach-prima2/rtciobrg.c
> >> ?create mode 100644 include/linux/rtc/sirfsoc_rtciobrg.h
> >>
> >> diff --git a/arch/arm/mach-prima2/Makefile b/arch/arm/mach-prima2/Makefile
> >> index 7af7fc0..f49d70b 100644
> >> --- a/arch/arm/mach-prima2/Makefile
> >> +++ b/arch/arm/mach-prima2/Makefile
> >> @@ -3,5 +3,6 @@ obj-y += irq.o
> >> ?obj-y += clock.o
> >> ?obj-y += rstc.o
> >> ?obj-y += prima2.o
> >> +obj-y += rtciobrg.o
> >> ?obj-$(CONFIG_DEBUG_LL) += lluart.o
> >> ?obj-$(CONFIG_CACHE_L2X0) += l2x0.o
> >> diff --git a/arch/arm/mach-prima2/rtciobrg.c b/arch/arm/mach-prima2/rtciobrg.c
> >> new file mode 100644
> >> index 0000000..0dc29f8
> >> --- /dev/null
> >> +++ b/arch/arm/mach-prima2/rtciobrg.c
> >> @@ -0,0 +1,118 @@
> >> +/*
> >> + * RTC I/O Bridge interfaces for CSR SiRFprimaII
> >> + * ARM access the registers of SYSRTC, GPSRTC and PWRC through this module
> >> + *
> >> + * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
> >> + *
> >> + * Licensed under GPLv2 or later.
> >> + */
> >> +
> >> +#include <linux/kernel.h>
> >> +#include <linux/module.h>
> >> +#include <linux/io.h>
> >> +#include <linux/of.h>
> >> +#include <linux/of_address.h>
> >> +
> >> +#define SIRFSOC_CPUIOBRG_CTRL ? ? ? ? ? 0x00
> >> +#define SIRFSOC_CPUIOBRG_WRBE ? ? ? ? ? 0x04
> >> +#define SIRFSOC_CPUIOBRG_ADDR ? ? ? ? ? 0x08
> >> +#define SIRFSOC_CPUIOBRG_DATA ? ? ? ? ? 0x0c
> >> +
> >> +void __iomem *sirfsoc_rtciobrg_base;
> >
> > static void __iomem?
> 
> this var will be accessed by sleep.S in patch 2/2.

OK, but then shouldn't these be in a header file somewhere?  I think 
sparse will warn about this otherwise saying it could be declared as 
static.

[...]
> >> +u32 __sirfsoc_rtc_iobrg_readl(u32 addr)
> >> +{
> >
> > Maybe for clarity have offset rather than address for these accessors to
> > indicate the nature of their use?
> 
> it should be an address not an offset. the address is local address
> againest rtciobrg. it is not an address in memory bus againest CPU
> core.
> if it is an offset, than its memory address is:
> MEMORY_BASE + addr.
> 
> but here its address is addr in local bus.

OK, I guess it's a terminology thing, but I don't particularly mind 
either way.

Jamie
