From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Mon, 15 Apr 2013 11:13:33 +0400
Subject: =?UTF-8?B?UmVbMl06IFtQQVRDSCAxLzJdIEdQSU86IGNscHM3MTF4OiBSZXdyaXRlIGRy?=
 =?UTF-8?B?aXZlciBmb3IgdXNpbmcgZ2VuZXJpYyBHUElPIGNvZGU=?=
In-Reply-To: <20130415033324.GB10949@quad.lixom.net>
References: <1365826900-30136-1-git-send-email-shc_work@mail.ru>
 <20130415033324.GB10949@quad.lixom.net>
Message-ID: <1366010013.44756903@f279.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Sat, Apr 13, 2013 at 08:21:39AM +0400, Alexander Shiyan wrote:
> > This patch provides rewritten driver for CLPS711X GPIO which uses
> > generic GPIO code.
> > 
> > Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> > ---
> >  arch/arm/configs/clps711x_defconfig            |   1 +
> >  arch/arm/mach-clps711x/Makefile                |   5 +-
> >  arch/arm/mach-clps711x/board-autcpu12.c        |   2 +
> >  arch/arm/mach-clps711x/board-cdb89712.c        |   2 +
> >  arch/arm/mach-clps711x/board-edb7211.c         |   7 +
> >  arch/arm/mach-clps711x/board-p720t.c           |  10 +-
> >  arch/arm/mach-clps711x/devices.c               |  56 ++++++
> >  arch/arm/mach-clps711x/devices.h               |  12 ++
> >  arch/arm/mach-clps711x/include/mach/clps711x.h |  23 +--
> >  drivers/gpio/Kconfig                           |   5 +-
> >  drivers/gpio/gpio-clps711x.c                   | 228 +++++++------------------
> >  11 files changed, 164 insertions(+), 187 deletions(-)
> >  create mode 100644 arch/arm/mach-clps711x/devices.c
> >  create mode 100644 arch/arm/mach-clps711x/devices.h
> 
> It would be nice to see this split up in a short series of patches instead,
> each patch doing one thing. For example, I'm not sure enabling the GPIO driver
> in the defconfig really belongs in the rewrite patch, for example.

New driver replaces arch_initcall by pure platform driver, so for keep working
defconfig should use symbol for driver.
Of course this change can be split into separate patch, but in this case series
will be marked not only for GPIO-sybsustem, if this OK, I will do as you say.

...
> >  static void __init edb7211_init(void)
> >  {
> > +	clps711x_devices_init();
> > +}
> > +
> > +static void __init edb7211_init_late(void)
> > +{
> 
> It'd be good for people reading the changelog in the future to see why you
> chose to split this up among two initcalls now.

OK. It makes sense.
We have some drivers (spi, backlight, nand) which depends on GPIO but not
use deferral probe yet, so at this point I just use separate initcalls for proper
loading sequence.

...
> > +static void __init clps711x_add_gpio(void)
> > +{
> > +	const struct resource clps711x_gpio0_res[] = {
> > +		DEFINE_RES_MEM(PADR, SZ_1),
> > +		DEFINE_RES_MEM(PADDR, SZ_1),
> > +	};
> > +	const struct resource clps711x_gpio1_res[] = {
> > +		DEFINE_RES_MEM(PBDR, SZ_1),
> > +		DEFINE_RES_MEM(PBDDR, SZ_1),
> > +	};
> > +	const struct resource clps711x_gpio2_res[] = {
> > +		DEFINE_RES_MEM(PCDR, SZ_1),
> > +		DEFINE_RES_MEM(PCDDR, SZ_1),
> > +	};
> > +	const struct resource clps711x_gpio3_res[] = {
> > +		DEFINE_RES_MEM(PDDR, SZ_1),
> > +		DEFINE_RES_MEM(PDDDR, SZ_1),
> > +	};
> > +	const struct resource clps711x_gpio4_res[] = {
> > +		DEFINE_RES_MEM(PEDR, SZ_1),
> > +		DEFINE_RES_MEM(PEDDR, SZ_1),
> > +	};
> 
> It's common to have the resources as static globals in the file instead of
> local const variables, so please move them out to stay common with other
> platforms.

AFAIK platform_device_add_resources makes a copy of all used resources,
is resource really need to be a global variable? Or you just mean make these
variables global and put in "__initconst" section?

...
> > --- a/arch/arm/mach-clps711x/include/mach/clps711x.h
> > +++ b/arch/arm/mach-clps711x/include/mach/clps711x.h
> > @@ -23,16 +23,19 @@
> >  
> >  #define CLPS711X_PHYS_BASE	(0x80000000)
> >  
> > -#define PADR		(0x0000)
> > -#define PBDR		(0x0001)
> > -#define PCDR		(0x0002)
> > -#define PDDR		(0x0003)
> > -#define PADDR		(0x0040)
> > -#define PBDDR		(0x0041)
> > -#define PCDDR		(0x0042)
> > -#define PDDDR		(0x0043)
> > -#define PEDR		(0x0083)
> > -#define PEDDR		(0x00c3)
> > +#define CLPS711X_REGS(x)	(CLPS711X_PHYS_BASE + (x))
> > +
> > +#define PADR		CLPS711X_REGS(0x0000)
> > +#define PBDR		CLPS711X_REGS(0x0001)
> > +#define PCDR		CLPS711X_REGS(0x0002)
> > +#define PDDR		CLPS711X_REGS(0x0003)
> > +#define PADDR		CLPS711X_REGS(0x0040)
> > +#define PBDDR		CLPS711X_REGS(0x0041)
> > +#define PCDDR		CLPS711X_REGS(0x0042)
> > +#define PDDDR		CLPS711X_REGS(0x0043)
> > +#define PEDR		CLPS711X_REGS(0x0083)
> > +#define PEDDR		CLPS711X_REGS(0x00c3)
> > +
> 
> Are these needed in a shared include file, or could they just be pushed out in
> the one driver that uses them? There's been a lot of churn moving mach includes
> out to drivers on multiplatform enabled platforms, it'd be nice to avoid adding
> more dependencies on it on legacy platforms that haven't yet been enabled (or
> even if they never will be, it still doesn't hurt).

This just an initial change for avoiding usage CLPS711X_PHYS_BASE in other code.
No new global users for this header.
As you can view in GPIO driver, I remove dependency on <mach/hardware.h> completely.

...
> > diff --git a/drivers/gpio/gpio-clps711x.c b/drivers/gpio/gpio-clps711x.c
> > index ce63b75..3c71815 100644
> > --- a/drivers/gpio/gpio-clps711x.c
> > +++ b/drivers/gpio/gpio-clps711x.c
...
> > -#include <linux/io.h>
> > -#include <linux/slab.h>
> >  #include <linux/gpio.h>
> >  #include <linux/module.h>
> > -#include <linux/spinlock.h>
> > +#include <linux/basic_mmio_gpio.h>
> >  #include <linux/platform_device.h>
> >  
> > -#include <mach/hardware.h>
...

---
