From: will.deacon@arm.com (Will Deacon)
Date: Fri, 19 Aug 2011 12:08:22 +0100
Subject: [PATCH 1/3] ARM: debug: use kconfig choice for selecting
	DEBUG_LL UART
In-Reply-To: <20110819045956.GB12527@S2100-06.ap.freescale.net>
References: <1313530873-24961-1-git-send-email-will.deacon@arm.com>
	<20110818161105.GA12527@S2100-06.ap.freescale.net>
	<20110818160712.GA26691@e102144-lin.cambridge.arm.com>
	<20110819045956.GB12527@S2100-06.ap.freescale.net>
Message-ID: <20110819110822.GB8918@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 19, 2011 at 05:59:57AM +0100, Shawn Guo wrote:
> On Thu, Aug 18, 2011 at 05:07:12PM +0100, Will Deacon wrote:
> > I'm not sure that sorting this list in alphabetical order is a good idea.
> > This is a Kconfig choice, so the default value is the first one in the list
> > that has its dependencies satisfied. Therefore, the ordering has a direct
> > impact on the default UART selection.
> > 
> I'm unsure that the default UART selection makes much sense here.
> When we build so many platforms into single image, it's hard to say
> which one should be the default.  People anyway need to check if the
> the UART selection matches the platform they are debugging on.

Ok, how about having the default choice as a dummy option which doesn't
correspond to a UART?:

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index f23975a..455bc8c 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -65,8 +65,12 @@ config DEBUG_USER
 
 # These options are only for real kernel hackers who want to get their hands dirty.
 config DEBUG_LL
+       bool
+
+config DEBUG_LL_UART
        bool "Kernel low-level debugging functions"
        depends on DEBUG_KERNEL
+       select DEBUG_LL if !DEBUG_UART_NONE
        help
          Say Y here to include definitions of printascii, printch, printhex
          in the kernel.  This is helpful if you are debugging code that
@@ -74,7 +78,12 @@ config DEBUG_LL
 
 choice
        prompt "Kernel low-level debugging port"
-       depends on DEBUG_LL
+       depends on DEBUG_LL_UART && (FOOTBRIDGE || ARCH_CLPS711X || \
+                                    PLAT_SAMSUNG || ARCH_REALVIEW)
+       default DEBUG_UART_NONE
+
+       config DEBUG_UART_NONE
+               bool "No UART selected (default)"
 
        config DEBUG_DC21285_PORT
                bool "Kernel low-level debugging messages via footbridge serial port"


That way, you really have to select the UART for DEBUG_LL to be enabled.

> BTW, I just posted one patch for imx based on your series.  Are you
> interested in folding it into yours?

Yep, I'll pick it up once Sascha is happy with it. If we go with the above,
I'm happy to make the necessary changes.

Cheers,

Will
