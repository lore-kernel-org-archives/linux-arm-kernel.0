From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 19 Aug 2011 19:15:19 +0200
Subject: [PATCH] arm/imx: use Kconfig choice for low-level debug UART
	selection
In-Reply-To: <20110819123543.GE8918@e102144-lin.cambridge.arm.com>
References: <1313530873-24961-1-git-send-email-will.deacon@arm.com>
	<1313729819-30301-1-git-send-email-shawn.guo@linaro.org>
	<20110819063533.GR31404@pengutronix.de>
	<20110819110940.GC8918@e102144-lin.cambridge.arm.com>
	<20110819113937.GS31404@pengutronix.de>
	<20110819123543.GE8918@e102144-lin.cambridge.arm.com>
Message-ID: <20110819171519.GV31404@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 19, 2011 at 01:35:43PM +0100, Will Deacon wrote:
> On Fri, Aug 19, 2011 at 12:39:37PM +0100, Sascha Hauer wrote:
> > On Fri, Aug 19, 2011 at 12:09:41PM +0100, Will Deacon wrote:
> > > But it's an unfortunate hinderence to a single zImage kernel which we can
> > > only solve sensibly in the generic ARM code.
> > 
> > My problem is that if this option is enabled the kernel will not run
> > on any other SoC except the one being selected here, at least when
> > earlyprintk is passed on the command line. One could argue
> > that this option is for people who exactly know what they do only.
> > Still there should pop up a big fat warning somewhere.
> 
> Could do - but where?

Good question, I don't know.

> 
> > The old i.MX way ensured that by refusing to compile the kernel with
> > multi SoC support.
> 
> That's a worse solution, because now the kernel doesn't run *anywhere* if
> you enable DEBUG_LL and multiple SoCs.

Better a kernel that does not compile than a kernel that compiles and
does not run.

> A use case for the new method is that
> you have a kernel .config file for a multi-SoC kernel which is known not to
> fail early on a given board. You can enable DEBUG_LL for that board and solve
> the problem. It should never be enabled for a kernel that is designed to be
> portable!

Indeed.

How about the something like the following?

config DEBUG_LL
        bool "Kernel low-level debugging functions (read help!)"
        depends on DEBUG_KERNEL
        help
          Say Y here to include definitions of printascii, printch,printhex
          in the kernel.  This is helpful if you are debugging code that
          executes before the console is initialized.
	  The UART lowlevel functions will limit the kernel to exactly
	  the system specified below. Trying to use these on any other
	  system will lock up the kernel or even worse.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
