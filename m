From: jszhang@marvell.com (Jisheng Zhang)
Date: Fri, 9 Oct 2015 17:22:38 +0800
Subject: [PATCH v4 2/6] pinctrl: berlin: add the berlin4ct pinctrl driver
In-Reply-To: <20151009090353.GA2842@kwain>
References: <1444378629-3057-1-git-send-email-jszhang@marvell.com>
 <1444378629-3057-3-git-send-email-jszhang@marvell.com>
 <20151009090353.GA2842@kwain>
Message-ID: <20151009172238.68fdd51c@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Antoine,

On Fri, 9 Oct 2015 11:03:53 +0200
Antoine Tenart <antoine.tenart@free-electrons.com> wrote:

> Hi Jisheng,
> 
> On Fri, Oct 09, 2015 at 04:17:05PM +0800, Jisheng Zhang wrote:
> > diff --git a/drivers/pinctrl/berlin/Kconfig b/drivers/pinctrl/berlin/Kconfig
> > index b18322b..c13f6d2 100644
> > --- a/drivers/pinctrl/berlin/Kconfig
> > +++ b/drivers/pinctrl/berlin/Kconfig
> > @@ -17,4 +17,9 @@ config PINCTRL_BERLIN_BG2Q
> >  	bool
> >  	select PINCTRL_BERLIN
> >  
> > +config PINCTRL_BERLIN_BG4CT
> > +	depends on OF && (ARCH_BERLIN || COMPILE_TEST)
> > +	bool "Marvell berlin4ct pin controller driver"
> > +	select PINCTRL_BERLIN
> > +
> >  endif
> 
> This endif ends the following condition:
> 
> 	if ARCH_BERLIN
> 	[...]
> 
> So the "depends on ARCH_BERLIN" here can be dropped. Also the
> COMPILE_TEST can be moved as it isn't BG4CT specific and all other
> Berlin pinctrl drivers would benefit from this.
> 
> So we would have something like:
> 
> 	if (ARCH_BERLIN || COMPILE_TEST)

Oh yeah! This is better.

> 	[...]
> 	endif
> 
> Finally you can move the OF dependency to the PINCTRL_BERLIN config as
> all Berlin pinctrl drivers depends on it.

PINCTRL_BERLIN isn't user visible and it's selected by PINCTRL_BERLIN_BG4CT. So
we may have the following random config case:

CONFIG_OF=n
CONFIG_PINCTRL_BERLIN_BG4CT=y

In this case, there will be build errors for we missed OF. So we have to
make PINCTRL_BERLIN_BG4CT depends on OF. What do you think? Or is there
better solution?

Thanks for kind review,
Jisheng

> 
> Thanks!
> 
> Antoine
> 
