From: alexanders83@web.de (Alexander Stein)
Date: Fri, 11 Apr 2014 17:45:02 +0200
Subject: [PATCH] pinctrl/at91: Fix pin_to_mask
In-Reply-To: <075734B2-F667-47DE-A813-8371456A31B9@jcrosoft.com>
References: <1397230537-8727-1-git-send-email-alexanders83@web.de>
 <075734B2-F667-47DE-A813-8371456A31B9@jcrosoft.com>
Message-ID: <21196207.LSji5uQPhJ@kongar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 11 April 2014, 23:42:19 wrote Jean-Christophe PLAGNIOL-VILLARD:
> 
> On Apr 11, 2014, at 11:35 PM, Alexander Stein <alexanders83@web.de> wrote:
> 
> > 
> > We need first to reduce the pin number to only a GPIO bank before we can
> > create the mask.
> > Otherwise only GPIO bank 0 has correct masks as the bits in the other
> > banks are shifted out of range.
> > 
> > Signed-off-by: Alexander Stein <alexanders83@web.de>
> > ---
> > drivers/pinctrl/pinctrl-at91.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
> > index 63176f2..6669e13 100644
> > --- a/drivers/pinctrl/pinctrl-at91.c
> > +++ b/drivers/pinctrl/pinctrl-at91.c
> > @@ -316,7 +316,7 @@ static inline int pin_to_bank(unsigned pin)
> > 
> > static unsigned pin_to_mask(unsigned int pin)
> > {
> > -	return 1 << pin;
> > +	return 1 << (pin % MAX_NB_GPIO_PER_BANK);
> > }
> no need pin_to_mask is already called with it

But this only true for the call within at91_pinconf_set, but not for those in
at91_gpio_dbg_show
at91_pmx_enable
at91_pmx_disable

Regards,
Alexander
