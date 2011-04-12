From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 12 Apr 2011 11:54:46 +0200
Subject: [PATCH 4/6] ARM: mxc: don't allow to compile together i.MX51
	and i.MX53
In-Reply-To: <alpine.LFD.2.00.1104110944290.28032@xanadu.home>
References: <1302464943-20721-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1302464943-20721-4-git-send-email-u.kleine-koenig@pengutronix.de>
	<alpine.LFD.2.00.1104102157440.28032@xanadu.home>
	<20110411074041.GF18601@pengutronix.de>
	<alpine.LFD.2.00.1104110944290.28032@xanadu.home>
Message-ID: <20110412095446.GB18850@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, Apr 11, 2011 at 10:15:09AM -0400, Nicolas Pitre wrote:
> On Mon, 11 Apr 2011, Uwe Kleine-K?nig wrote:
> > Currently you can build a
> > kernel for i.MX51 + i.MX53 but IIRC it works on no machine.
> 
> Maybe it should be fixed?
To catch similar errors earlier next time, I'd like the compiler to wail
if the physoffsets don't match (in the !ARM_PATCH_PHYS_VIRT case).

The best thing I could come up with up to now is:

#if !defined(CONFIG_ARM_PATCH_PHYS_VIRT)
# if defined CONFIG_ARCH_MX1
#  define PLAT_PHYS_OFFSET              MX1_PHYS_OFFSET
# endif
# if defined CONFIG_MACH_MX21 && (!defined(PLAT_PHYS_OFFSET) || PLAT_PHYS_OFFSET != MX21_PHYS_OFFSET)
#  define PLAT_PHYS_OFFSET              MX21_PHYS_OFFSET
# endif
# if defined CONFIG_ARCH_MX25 && (!defined(PLAT_PHYS_OFFSET) || PLAT_PHYS_OFFSET != MX25_PHYS_OFFSET)
#  define PLAT_PHYS_OFFSET              MX25_PHYS_OFFSET
# endif
...

this is really ugly.  And even to make this work I have to do 

diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index 431077c..957cd7e 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -16,8 +16,6 @@
 #include <linux/compiler.h>
 #include <linux/const.h>
 #include <linux/types.h>
-#include <mach/memory.h>
-#include <asm/sizes.h>
 
 /*
  * Allow for constants defined here to be used from assembly code
@@ -25,6 +23,9 @@
  */
 #define UL(x) _AC(x, UL)
 
+#include <mach/memory.h>
+#include <asm/sizes.h>
+
 #ifdef CONFIG_MMU
 
 /*

because cpp can only compare integers and so needs a definition for UL.
Even when keeping the definition as it is now (i.e. asserting a single
definition by using #ifelse) adding something like:

#if defined(PLAT_PHYS_OFFSET)
# if defined(CONFIG_ARCH_MX1) && (PLAT_PHYS_OFFSET != MX1_PHYS_OFFSET)
#error something
# endif
# ...
#endif

needs the UL macro.

Does someone has a better idea? If not it's probably not worth the change.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
