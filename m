From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 22 Nov 2011 22:19:53 +0100
Subject: [PATCH] arm/imx: use Kconfig choice for low-level debug UART
 selection
In-Reply-To: <20111122202425.GD9581@n2100.arm.linux.org.uk>
References: <1313530873-24961-1-git-send-email-will.deacon@arm.com>
 <20111122164707.GJ6624@sirena.org.uk>
 <20111122202425.GD9581@n2100.arm.linux.org.uk>
Message-ID: <1484610.g1p0X99tcV@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 22 November 2011 20:24:25 Russell King - ARM Linux wrote:
> On Tue, Nov 22, 2011 at 04:47:07PM +0000, Mark Brown wrote:
> > On Tue, Nov 22, 2011 at 05:38:12PM +0100, Uwe Kleine-K?nig wrote:
> > > On Tue, Nov 22, 2011 at 03:48:38PM +0000, Russell King - ARM Linux wrote:
> > 
> > > > > Ah, I see the problem. It's more subtile than just failure to build: it
> > > > > autoselects DEBUG_ICEDCC then.
> > 
> > > > At this point, I think the right answer is to remove the option in
> > > > linux-next, and tell anyone who complains that they need to convert
> > > > their platform properly.  (We're going to need them converted in this
> > > > way anyway for the single zImage project.)
> > 
> > > I agree.
> > 
> > It'd be nice if things could be arranged so that the build breaks rather
> > than selecting ICEDCC on unconverted platforms - when you run into the
> > problem it's not that easy to diagnose.
> 
> Well, we could leave the choice as is, and make the NONE option cause a
> #error.

In my randconfig branch, I have a temporary patch doing

--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -83,6 +83,8 @@ choice
        depends on DEBUG_LL
 
        config DEBUG_LL_UART_NONE
+               depends on !FOOTBRIDGE && !ARCH_CLPS711X && !ARCH_MXC && \
+                          !PLAT_SAMSUNG && !ARCH_REALVIEW && !ARCH_HIGHBANK
                bool "No low-level debugging UART"
                help
                  Say Y here if your platform doesn't provide a UART option

We can also move ICEDCC to the bottom of the list to ensure that the default
choice is a platform specific one.

In order to make the conversion nicer (avoiding a conflicting patch
every time someone adds "depends on !MY_PLATFORM", how about expressing
it as this:

	config DEBUG_LL_UART_NONE
		depends on !DEBUG_LL_LEGACY

and then selecting DEBUG_LL_LEGACY from all platforms that do their own
thing. That would avoid the possible randconfig errors.

	Arnd
