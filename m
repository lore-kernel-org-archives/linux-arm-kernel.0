From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 26 Jun 2014 14:54:19 +0200
Subject: [PATCH 13/13] AT91: PIT: Move the driver to drivers/clocksource
In-Reply-To: <53AC0882.3010601@free-electrons.com>
References: <1403701605-26678-1-git-send-email-maxime.ripard@free-electrons.com>
 <1403701605-26678-14-git-send-email-maxime.ripard@free-electrons.com>
 <53ABAF1E.5030405@free-electrons.com>
 <20140626093006.GB3385@lukather>
 <53AC0882.3010601@free-electrons.com>
Message-ID: <20140626125419.GC3385@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 26, 2014 at 01:48:18PM +0200, Boris BREZILLON wrote:
> 
> On 26/06/2014 11:30, Maxime Ripard wrote:
> > Hi Boris,
> >
> > On Thu, Jun 26, 2014 at 07:26:54AM +0200, Boris BREZILLON wrote:
> >> On 25/06/2014 15:06, Maxime Ripard wrote:
> >>> Now that we don't depend on anyting in the mach-at91 directory, we can just
> >>> move the driver to where it belongs.
> >>>
> >>> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> >>> ---
> >>>  arch/arm/mach-at91/Kconfig                                     | 4 ----
> >>>  arch/arm/mach-at91/Makefile                                    | 1 -
> >>>  drivers/clocksource/Kconfig                                    | 4 ++++
> >>>  drivers/clocksource/Makefile                                   | 1 +
> >>>  {arch/arm/mach-at91 => drivers/clocksource}/at91sam926x_time.c | 0
> >>>  5 files changed, 5 insertions(+), 5 deletions(-)
> >>>  rename {arch/arm/mach-at91 => drivers/clocksource}/at91sam926x_time.c (100%)
> >>>
> >>> diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
> >>> index a64412a020d3..b10db0990999 100644
> >>> --- a/arch/arm/mach-at91/Kconfig
> >>> +++ b/arch/arm/mach-at91/Kconfig
> >>> @@ -36,10 +36,6 @@ config AT91_SAM9G45_RESET
> >>>  	bool
> >>>  	default !ARCH_AT91X40
> >>>  
> >>> -config AT91_SAM9_TIME
> >>> -	select CLKSRC_OF if OF
> >>> -	bool
> >>> -
> >>>  config HAVE_AT91_SMD
> >>>  	bool
> >>>  
> >>> diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
> >>> index 78e9cec282f4..1a916ececbfd 100644
> >>> --- a/arch/arm/mach-at91/Makefile
> >>> +++ b/arch/arm/mach-at91/Makefile
> >>> @@ -10,7 +10,6 @@ obj-		:=
> >>>  obj-$(CONFIG_OLD_CLK_AT91)	+= clock.o
> >>>  obj-$(CONFIG_AT91_SAM9_ALT_RESET) += at91sam9_alt_reset.o
> >>>  obj-$(CONFIG_AT91_SAM9G45_RESET) += at91sam9g45_reset.o
> >>> -obj-$(CONFIG_AT91_SAM9_TIME)	+= at91sam926x_time.o
> >>>  obj-$(CONFIG_SOC_AT91SAM9)	+= sam9_smc.o
> >>>  
> >>>  # CPU-specific support
> >>> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> >>> index 065131cbfcc0..cd8b73ddbef3 100644
> >>> --- a/drivers/clocksource/Kconfig
> >>> +++ b/drivers/clocksource/Kconfig
> >>> @@ -118,6 +118,10 @@ config CLKSRC_ARM_GLOBAL_TIMER_SCHED_CLOCK
> >>>  	help
> >>>  	 Use ARM global timer clock source as sched_clock
> >>>  
> >>> +config AT91_SAM9_TIME
> >>> +	select CLKSRC_OF if OF
> >>> +	bool
> >>> +
> >>>  config CLKSRC_METAG_GENERIC
> >>>  	def_bool y if METAG
> >>>  	help
> >>> diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
> >>> index 800b1303c236..3088928070f8 100644
> >>> --- a/drivers/clocksource/Makefile
> >>> +++ b/drivers/clocksource/Makefile
> >>> @@ -1,5 +1,6 @@
> >>>  obj-$(CONFIG_CLKSRC_OF)	+= clksrc-of.o
> >>>  obj-$(CONFIG_ATMEL_TCB_CLKSRC)	+= tcb_clksrc.o
> >>> +obj-$(CONFIG_AT91_SAM9_TIME)	+= at91sam926x_time.o
> >> I would rename both Kconfig and source file name into ATMEL_PIT and
> >> atmel_pit.c (or AT91_PIT and atmel_pit.c) to cleary show that this
> >> driver add support for the PIT block.
> > I actually had the same idea, but older AT91 SoCs (rm9200, for
> > example) also mention the PIT, even though the IP is different.
> 
> I checked at91rm9200 datasheet, and indeed it mention the concept of PIT
> (Periodic Interval Timer), but the HW block is called ST (System Timer).
> 
> How about using the name ATMEL_PIT for this driver and later use
> ATMEL_ST when we decide to move at91rm9200_time.c driver into
> drivers/clocksource ?

Works for me.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140626/231253b6/attachment.sig>
