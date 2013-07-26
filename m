From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 26 Jul 2013 15:26:48 +0200
Subject: [PATCH] pinctrl: sunxi: Fix gpio_set behaviour
In-Reply-To: <20130726125445.612b2acf@skate>
References: <1374748876-23461-1-git-send-email-maxime.ripard@free-electrons.com>
 <20130726125445.612b2acf@skate>
Message-ID: <20130726132648.GG3056@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On Fri, Jul 26, 2013 at 12:54:45PM +0200, Thomas Petazzoni wrote:
> On Thu, 25 Jul 2013 12:41:16 +0200, Maxime Ripard wrote:
> > The current gpio_set function is ignoring the previous value set in the
> > GPIO value register, which leads in erasing the values already set for
> > the other GPIOs in the same bank when setting the value of a given GPIO.
> > 
> > Add the usual read/mask/write pattern to fix this brown paper bag bug.
> > 
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  drivers/pinctrl/pinctrl-sunxi.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pinctrl/pinctrl-sunxi.c b/drivers/pinctrl/pinctrl-sunxi.c
> > index fc058b6..4f8bb18 100644
> > --- a/drivers/pinctrl/pinctrl-sunxi.c
> > +++ b/drivers/pinctrl/pinctrl-sunxi.c
> > @@ -464,8 +464,14 @@ static void sunxi_pinctrl_gpio_set(struct gpio_chip *chip,
> >  	struct sunxi_pinctrl *pctl = dev_get_drvdata(chip->dev);
> >  	u32 reg = sunxi_data_reg(offset);
> >  	u8 index = sunxi_data_offset(offset);
> > +	u32 regval = readl(pctl->membase + reg);
> >  
> > -	writel((value & DATA_PINS_MASK) << index, pctl->membase + reg);
> > +	if (value)
> > +		regval |= BIT(index);
> > +	else
> > +		regval &= ~(BIT(index));
> > +
> > +	writel(regval, pctl->membase + reg);
> 
> Hum, what about locking?

Right, I should probably use some spinlocks.

I'll do a followup patch, because this chunk won't be the only area
impacted obviously.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130726/6e3654a2/attachment.sig>
