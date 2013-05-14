From: horms@verge.net.au (Simon Horman)
Date: Tue, 14 May 2013 11:44:44 +0900
Subject: [PATCH 1/3] gpio-rcar: Add support for IRQ_TYPE_EDGE_BOTH
In-Reply-To: <CANqRtoQ2gLVRz-a1PoQeuy_=XVKMR8x+47NDT9FFQWdRu17c7A@mail.gmail.com>
References: <1368435233-8587-1-git-send-email-horms+renesas@verge.net.au>
 <1368435233-8587-2-git-send-email-horms+renesas@verge.net.au>
 <CANqRtoQ2gLVRz-a1PoQeuy_=XVKMR8x+47NDT9FFQWdRu17c7A@mail.gmail.com>
Message-ID: <20130514024443.GB20239@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 13, 2013 at 07:14:41PM +0900, Magnus Damm wrote:
> On Mon, May 13, 2013 at 5:53 PM, Simon Horman
> <horms+renesas@verge.net.au> wrote:
> > As hardware support for this feature is not universal for all SoCs a flag,
> > has_both_edge_trigger, has been added to the platform data of the driver to
> > allow this feature to be enabled.
> >
> > The motivation for this is to allow use of the gpio-keys driver on the
> > lager board which is based on the r8a7790 SoC. This patch has been lightly
> > exercised using that driver on that board.
> >
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > ---
> >  drivers/gpio/gpio-rcar.c                | 27 ++++++++++++++++++++++-----
> >  include/linux/platform_data/gpio-rcar.h |  1 +
> >  2 files changed, 23 insertions(+), 5 deletions(-)
> 
> Thanks for the patch, Simon!
> 
> > diff --git a/drivers/gpio/gpio-rcar.c b/drivers/gpio/gpio-rcar.c
> > index 0f3d647..33d8f6a 100644
> > --- a/drivers/gpio/gpio-rcar.c
> > +++ b/drivers/gpio/gpio-rcar.c
> > @@ -49,6 +49,7 @@ struct gpio_rcar_priv {
> >  #define POSNEG 0x20
> >  #define EDGLEVEL 0x24
> >  #define FILONOFF 0x28
> > +#define BOTHEDGE 0x4c
> >
> >  static inline u32 gpio_rcar_read(struct gpio_rcar_priv *p, int offs)
> >  {
> > @@ -111,6 +113,11 @@ static void gpio_rcar_config_interrupt_input_mode(struct gpio_rcar_priv *p,
> >         /* Select "Interrupt Input Mode" in IOINTSEL */
> >         gpio_rcar_modify_bit(p, IOINTSEL, hwirq, true);
> >
> > +       if (p->config.has_both_edge_trigger && !level_trigger) {
> > +               /* Select one edge or both edges in BOTHEDGE */
> > +               gpio_rcar_modify_bit(p, IOINTSEL, hwirq, both);
> > +       }
> > +
> >         /* Write INTCLR in case of edge trigger */
> >         if (!level_trigger)
> >                 gpio_rcar_write(p, INTCLR, BIT(hwirq));
> 
> In your hunk above I suspect you want to setup the BOTHEDGE register
> instead of IOINTSEL.

Thanks, I will fix that.

> Also, I wonder how BOTHEDGE should be set in the case of level
> trigger. Say that the user first selects edge trigger and then
> reconfigures to level, then you probably want to make sure the
> BOTHEDGE register is cleared.
> 
> So may want to do something like this (untested):
> 
>        if (p->config.has_both_edge_trigger) {
>                /* Select one edge or both edges in BOTHEDGE */
>                gpio_rcar_modify_bit(p, BOTHEDGE, hwirq, both);
>        }

Sure, if you think so.

> Also, please double check that the register access sequences in the
> documentation are still kept, please see "6.7.1 Setting Edge-Sensitive
> Interrupt Input Mode" in the H2 data sheet. It looks like you want to
> move this setting so it happens before IOINTSEL.

Thanks, I will fix that.
