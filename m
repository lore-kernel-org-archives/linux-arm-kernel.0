From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 31 May 2011 17:27:55 +0200
Subject: [PATCH 2/4] ARM: mxc: migrate mach-mx5 gpio driver to gpio-mxc
In-Reply-To: <20110531151019.GA32275@S2100-06.ap.freescale.net>
References: <1306767139-24763-1-git-send-email-shawn.guo@linaro.org>
	<201105311328.18012.arnd@arndb.de>
	<20110531151019.GA32275@S2100-06.ap.freescale.net>
Message-ID: <201105311727.55985.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 31 May 2011, Shawn Guo wrote:
> 
> On Tue, May 31, 2011 at 01:28:17PM +0200, Arnd Bergmann wrote:
> > On Tuesday 31 May 2011, Shawn Guo wrote:
> > > > Just open-code the mxc_add_mxc_gpio() by moving the individual calls to
> > > > mxc_add_gpio() into the respective callers. Having a global
> > > > mxc_add_mxc_gpio() function that does something different for each
> > > > caller seems entirely pointless to me.
> > > > 
> > > Right now, mxc_add_mxc_gpio() is a postcore_initcall.  Moving
> > > individual mxc_add_gpio() call into irq_init function does not work.
> > > And I need to find a proper caller for each SoC to call mxc_add_gpio
> > > to register gpio devices.
> >  
> > Why not init_machine? That is an arch_initcall(), so it's probably close
> > enough.
> > 
> The init_machine is mostly a board specific function than SoC specific
> one.  That is to say we will call mxc_add_gpio() in every single board
> init function even for the same SoC.

But the machine is the only place that knows what SOC is being used.
Your patch right now detects it by looking at the CPU type that is
also being set by the board file using the init_early call, which
is a bit silly.

I would leave e.g. the imx51_register_gpios() in place, but only
change the definition and the caller to

void __init imx51_register_gpios(void)
{
        mxc_add_gpio(0, MX51_GPIO1_BASE_ADDR, SZ_16K, MX51_MXC_INT_GPIO1_LOW, MX51_MXC_INT_GPIO1_HIGH);
        mxc_add_gpio(1, MX51_GPIO2_BASE_ADDR, SZ_16K, MX51_MXC_INT_GPIO2_LOW, MX51_MXC_INT_GPIO2_HIGH);
        mxc_add_gpio(2, MX51_GPIO3_BASE_ADDR, SZ_16K, MX51_MXC_INT_GPIO3_LOW, MX51_MXC_INT_GPIO3_HIGH);
        mxc_add_gpio(3, MX51_GPIO4_BASE_ADDR, SZ_16K, MX51_MXC_INT_GPIO4_LOW, MX51_MXC_INT_GPIO4_HIGH);
}

Then you can call that function from each i.mx51 based board, or
from a new imx51_soc_init() function that groups multiple such
functions.

	Arnd
