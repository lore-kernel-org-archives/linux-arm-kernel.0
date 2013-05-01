From: horms@verge.net.au (Simon Horman)
Date: Thu, 2 May 2013 07:57:48 +0900
Subject: [PATCH 03/21] ARM: shmobile: don't call irqchip_init
 unconditionally
In-Reply-To: <CAL_JsqJWJvxezXy0RGFutxzvBhca-8=uRH2GxdJgzbEGw+OL0A@mail.gmail.com>
References: <1366910944-3033663-1-git-send-email-arnd@arndb.de>
 <1366910944-3033663-4-git-send-email-arnd@arndb.de>
 <CAL_JsqJWJvxezXy0RGFutxzvBhca-8=uRH2GxdJgzbEGw+OL0A@mail.gmail.com>
Message-ID: <20130501225748.GD6517@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 01, 2013 at 10:54:30AM -0500, Rob Herring wrote:
> On Thu, Apr 25, 2013 at 12:28 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > The irqchip_init function is only available when building
> > with CONFIG_OF enabled, which causes this build failure for
> > bonito_defconfig:
> >
> > arch/arm/mach-shmobile/built-in.o: In function `r8a7740_init_irq_of':
> > :(.init.text+0x580): undefined reference to `irqchip_init'
> >
> > This makes both the OF and the ATAGS portion of the driver
> > conditional, which avoids the build error and also results
> > in smaller object code if not both are enabled, without the
> > need for an #ifdef.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > Cc: Bastian Hecht <hechtb+renesas@gmail.com>
> > Cc: Simon Horman <horms+renesas@verge.net.au>
> > Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > ---
> >  arch/arm/mach-shmobile/intc-r8a7740.c | 13 +++++++++++--
> >  1 file changed, 11 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm/mach-shmobile/intc-r8a7740.c b/arch/arm/mach-shmobile/intc-r8a7740.c
> > index 8871f77..5dc57f1 100644
> > --- a/arch/arm/mach-shmobile/intc-r8a7740.c
> > +++ b/arch/arm/mach-shmobile/intc-r8a7740.c
> > @@ -53,14 +53,23 @@ static void __init r8a7740_init_irq_common(void)
> >
> >  void __init r8a7740_init_irq_of(void)
> >  {
> > +       if (!IS_ENABLED(CONFIG_OF))
> > +               return;
> > +
> >         irqchip_init();
> 
> Why not have an empty irqchip_init? I'd guess we'll need this on other
> platforms and your default mach.

Thanks, I think that could work.

I will see about making it so.
