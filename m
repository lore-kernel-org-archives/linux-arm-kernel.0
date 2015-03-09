From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 9 Mar 2015 23:17:52 +0100
Subject: [PATCH v2 04/18] clocksource: Add ARM System timer driver
In-Reply-To: <1425935552.4244.6.camel@x220>
References: <1424455277-29983-1-git-send-email-mcoquelin.stm32@gmail.com>
 <1424455277-29983-5-git-send-email-mcoquelin.stm32@gmail.com>
 <20150220195437.GT19388@pengutronix.de>
 <1424468908.24292.10.camel@x220>
 <CALszF6Bm_Y4ZLednjpmP-hMix3gA23FwLm5hViEjr1QojUY+Mg@mail.gmail.com>
 <1425411786.2606.24.camel@tiscali.nl>
 <CALszF6AEThPrRe7c7nJ6q7yb2fhLMFuHJUV10sf=w0TMcqVVaw@mail.gmail.com>
 <1425935552.4244.6.camel@x220>
Message-ID: <20150309221752.GE7525@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, Mar 09, 2015 at 10:12:32PM +0100, Paul Bolle wrote:
> On Wed, 2015-03-04 at 13:08 +0100, Maxime Coquelin wrote:
> > This is because I added also support for COMPILE_TEST coverage as per
> > Uwe advice,
> > and thought it was necessary to have an entry for this.
> > Maybe I'm just wrong?
> 
> I missed that you added COMPILE_TEST.
> 
> A quick scan of your idea doesn't show any obvious issues. (Note that I
> don't really know how people actually use COMPILE_TEST. I guess things
> like "make allyesconfig" are involved.)
Maybe this can clearify the purpose of COMPILE_TEST:

diff --git a/init/Kconfig b/init/Kconfig
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -67,6 +67,26 @@ config COMPILE_TEST
 	  here. If you are a user/distributor, say N here to exclude useless
 	  drivers to be distributed.
 
+	# If you are a driver author consider to adjust your driver's
+	# dependencies to make it buildable with minimal preconditions if
+	# COMPILE_TEST is enabled. This helps contributers and maintainers
+	# that might not have the necessary toolchain or kernel config handy and
+	# also increases compile test coverage. It's your advantage if others can
+	# build your driver more easily! So for a device that is only found on the
+	# foo cpu use:
+	#
+	# 	depends on CPU_FOO || COMPILE_TEST
+	#
+	# . You might have to use
+	#
+	# 	depends on CPU_FOO || (COMPILE_TEST && COOKIE)
+	#
+	# or
+	#
+	#	depends on COOKIE && (CPU_FOO || COMPILE_TEST)
+	#
+	# if your driver uses features that are only available if COOKIE is on.
+
 config LOCALVERSION
 	string "Local version - append to kernel release"
 	help

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
