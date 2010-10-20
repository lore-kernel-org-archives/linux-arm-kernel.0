From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Wed, 20 Oct 2010 11:26:25 +0200
Subject: [PATCH 2/5] ks8695_wdt: explicitly define the SoC timer tick base
	rate
In-Reply-To: <4CBEB23C.7040208@visionsystems.de>
References: <20101020045131.GY12979@mail.wantstofly.org>
	<4CBEB23C.7040208@visionsystems.de>
Message-ID: <20101020092625.GC12979@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 20, 2010 at 11:11:24AM +0200, Yegor Yefremov wrote:

> > ..instead of including mach/timex.h, as the latter is going away.
> > 
> > Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
> > ---
> >  drivers/watchdog/ks8695_wdt.c |    3 ++-
> >  1 files changed, 2 insertions(+), 1 deletions(-)
> > 
> > diff --git a/drivers/watchdog/ks8695_wdt.c b/drivers/watchdog/ks8695_wdt.c
> > index 2852bb2..0060519 100644
> > --- a/drivers/watchdog/ks8695_wdt.c
> > +++ b/drivers/watchdog/ks8695_wdt.c
> > @@ -21,9 +21,10 @@
> >  #include <linux/watchdog.h>
> >  #include <linux/io.h>
> >  #include <linux/uaccess.h>
> > -#include <mach/timex.h>
> >  #include <mach/regs-timer.h>
> >  
> > +#define KS8695_CLOCK_RATE	25000000
> > +
> 
> In this way KS8695_CLOCK_RATE will be defined twice: here and in /arch/arm/mach-ks8695/include/mach/hardware.h
> 
> >  #define WDT_DEFAULT_TIME	5	/* seconds */
> >  #define WDT_MAX_TIME		171	/* seconds */
> 
> I tried without redefining the macro and it compiles without errors.

Alright, I've replaced this patch by the one below.

Thanks!


From: Yegor Yefremov <yegorslists@googlemail.com>

ks8695_wdt: include mach/hardware.h instead of mach/timex.h

ks8695_wdt needs KS8695_CLOCK_RATE, which is defined in
mach/hardware.h, which is pulled in by the include of mach/timex.h,
but the latter is going away, so just include mach/hardware.h
directly.

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>

diff --git a/drivers/watchdog/ks8695_wdt.c b/drivers/watchdog/ks8695_wdt.c
index 2852bb2..8114719 100644
--- a/drivers/watchdog/ks8695_wdt.c
+++ b/drivers/watchdog/ks8695_wdt.c
@@ -21,7 +21,7 @@
 #include <linux/watchdog.h>
 #include <linux/io.h>
 #include <linux/uaccess.h>
-#include <mach/timex.h>
+#include <mach/hardware.h>
 #include <mach/regs-timer.h>
 
 #define WDT_DEFAULT_TIME       5       /* seconds */
