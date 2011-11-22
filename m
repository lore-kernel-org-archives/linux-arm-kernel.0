From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 22 Nov 2011 18:13:47 +0100
Subject: [PATCH] arm/imx: use Kconfig choice for low-level debug UART
 selection
In-Reply-To: <20111122164707.GJ6624@sirena.org.uk>
References: <1313530873-24961-1-git-send-email-will.deacon@arm.com>
 <1313729819-30301-1-git-send-email-shawn.guo@linaro.org>
 <20111122085834.GB19986@pengutronix.de>
 <20111122115017.GK20518@mudshark.cambridge.arm.com>
 <20111122130233.GF19986@pengutronix.de>
 <20111122132055.GA32572@mudshark.cambridge.arm.com>
 <20111122133040.GG19986@pengutronix.de>
 <20111122154838.GZ9581@n2100.arm.linux.org.uk>
 <20111122163812.GH19986@pengutronix.de>
 <20111122164707.GJ6624@sirena.org.uk>
Message-ID: <20111122171347.GJ19986@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 22, 2011 at 04:47:07PM +0000, Mark Brown wrote:
> On Tue, Nov 22, 2011 at 05:38:12PM +0100, Uwe Kleine-K?nig wrote:
> > On Tue, Nov 22, 2011 at 03:48:38PM +0000, Russell King - ARM Linux wrote:
> 
> > > > Ah, I see the problem. It's more subtile than just failure to build: it
> > > > autoselects DEBUG_ICEDCC then.
> 
> > > At this point, I think the right answer is to remove the option in
> > > linux-next, and tell anyone who complains that they need to convert
> > > their platform properly.  (We're going to need them converted in this
> > > way anyway for the single zImage project.)
> 
> > I agree.
> 
> It'd be nice if things could be arranged so that the build breaks rather
> than selecting ICEDCC on unconverted platforms - when you run into the
> problem it's not that easy to diagnose.
What about the patch below? It's a small step back as DEBUG_ICEDCC is
moved out of the choice, but seems to work in my tests.

Best regards
Uwe

--------->8-------------------
From: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Subject: [PATCH RFC] ARM: remove DEBUG_LL_UART_NONE from choice of debug UARTs

Moreover move DEBUG_ICEDCC out of the choice.
This way platforms that don't have an item to pick in the choice
automatically fall back to the traditional behaviour instead of
choosing DEBUG_ICEDCC when only removing DEBUG_LL_UART_NONE.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/Kconfig.debug |   32 ++++++++++++--------------------
 1 files changed, 12 insertions(+), 20 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index c5213e7..4cca427 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -77,28 +77,20 @@ config DEBUG_LL
 	  image on a different platform *will not work*, so this option should
 	  not be enabled for kernels that are intended to be portable.
 
-choice
-	prompt "Kernel low-level debugging port"
-	depends on DEBUG_LL
-
-	config DEBUG_LL_UART_NONE
-		bool "No low-level debugging UART"
-		help
-		  Say Y here if your platform doesn't provide a UART option
-		  below. This relies on your platform choosing the right UART
-		  definition internally in order for low-level debugging to
-		  work.
+config DEBUG_ICEDCC
+	bool "Kernel low-level debugging via EmbeddedICE DCC channel"
+	help
+	  Say Y here if you want the debug print routines to direct
+	  their output to the EmbeddedICE macrocell's DCC channel using
+	  co-processor 14. This is known to work on the ARM9 style ICE
+	  channel and on the XScale with the PEEDI.
 
-	config DEBUG_ICEDCC
-		bool "Kernel low-level debugging via EmbeddedICE DCC channel"
-		help
-		  Say Y here if you want the debug print routines to direct
-		  their output to the EmbeddedICE macrocell's DCC channel using
-		  co-processor 14. This is known to work on the ARM9 style ICE
-		  channel and on the XScale with the PEEDI.
+	  Note that the system will appear to hang during boot if there
+	  is nothing connected to read from the DCC.
 
-		  Note that the system will appear to hang during boot if there
-		  is nothing connected to read from the DCC.
+choice
+	prompt "Kernel low-level debugging port"
+	depends on DEBUG_LL && !DEBUG_ICEDCC
 
 	config DEBUG_FOOTBRIDGE_COM1
 		bool "Kernel low-level debugging messages via footbridge 8250 at PCI COM1"
-- 
1.7.7.2

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
