From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 13 Nov 2014 17:48:37 +0000
Subject: [PATCH] ARM: b.L: fix unmet dependency for CPU_PM
In-Reply-To: <alpine.LFD.2.11.1411131231060.11690@knanqh.ubzr>
References: <1415857098-16928-1-git-send-email-pankaj.dubey@samsung.com>
 <alpine.LFD.2.11.1411131231060.11690@knanqh.ubzr>
Message-ID: <20141113174837.GB4042@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 13, 2014 at 12:44:22PM -0500, Nicolas Pitre wrote:
> On Thu, 13 Nov 2014, Pankaj Dubey wrote:
> 
> > If BL_SWITCHER is enabled but SUSPEND and CPU_IDLE is not enabled
> > we are getting following config warning.
> > 
> > warning: (BL_SWITCHER) selects CPU_PM which has unmet direct
> > dependencies (SUSPEND || CPU_IDLE)
> > 
> > So BL_SWITCHER should enable CPU_PM only if either of SUSPEND or
> > CPU_IDLE is selected.
> > 
> > Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> > ---
> >  arch/arm/Kconfig |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index 9d580d0..fe3d969 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -1417,7 +1417,7 @@ config BL_SWITCHER
> >  	bool "big.LITTLE switcher support"
> >  	depends on BIG_LITTLE && MCPM && HOTPLUG_CPU
> >  	select ARM_CPU_SUSPEND
> > -	select CPU_PM
> > +	select CPU_PM if (SUSPEND || CPU_IDLE)
> 
> NAK.  You just broke the code by doing this. CPU_PM is a requirement 
> here.  The dependencies for CPU_PM is lacking.

Is there any real technical reason that CPU_PM depends on SUSPEND ||
CPU_IDLE ?  If not, those dependencies should be killed.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
