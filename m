From: tony@atomide.com (Tony Lindgren)
Date: Mon, 17 Sep 2012 10:23:44 -0700
Subject: linux-next: build failure after merge of the final tree
 (arm-soc tree related)
In-Reply-To: <20120917141119.GA18715@quad.lixom.net>
References: <20120917212615.91bc134d237dcd5968f9f549@canb.auug.org.au>
 <20120917141119.GA18715@quad.lixom.net>
Message-ID: <20120917172344.GO4521@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Olof Johansson <olof@lixom.net> [120917 07:12]:
> Hi,
> 
> On Mon, Sep 17, 2012 at 09:26:15PM +1000, Stephen Rothwell wrote:
> > Hi all,
> > 
> > After merging the final tree, today's linux-next build (powerpc
> > allyesconfig) failed like this:
> > 
> > drivers/mfd/twl-core.c:49:22: fatal error: plat/cpu.h: No such file or directory
> > 
> > Caused by commit 7d7e1eba7e92 ("ARM: OMAP2+: Prepare for irqs.h removal").
> > 
> > I have added the following patch to restrict this driver to ARM until it
> > is fixed:
> > 
> > From: Stephen Rothwell <sfr@canb.auug.org.au>
> > Date: Mon, 17 Sep 2012 21:18:21 +1000
> > Subject: [PATCH] ARM: retrict TWL4030_CORE to ARM while it is broken
> > 
> > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > ---
> >  drivers/mfd/Kconfig |    1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > index df850c4..af5e5b7 100644
> > --- a/drivers/mfd/Kconfig
> > +++ b/drivers/mfd/Kconfig
> > @@ -257,6 +257,7 @@ config MENELAUS
> >  config TWL4030_CORE
> >  	bool "Texas Instruments TWL4030/TWL5030/TWL6030/TPS659x0 Support"
> >  	depends on I2C=y && GENERIC_HARDIRQS
> > +	depends on ARM
> >  	select IRQ_DOMAIN
> >  	help
> >  	  Say yes here if you have TWL4030 / TWL6030 family chip on your board.
> 
> Gack. This will break on non-OMAP ARM platforms now too, so it needs to be
> depends on ARCH_OMAP instead of ARM.
> 
> Tony, can I get an Acked-by so I can apply this to next/cleanup? Sam, if
> you prefer to apply it yourself, let me know.

Sorry about this, this driver should work with other SoCs too, not just
ARM. I'll post a better fix until the cpu_is_omap usage is removed.

Regards,

Tony
