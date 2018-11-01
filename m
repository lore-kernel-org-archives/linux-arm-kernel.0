From: natechancellor@gmail.com (Nathan Chancellor)
Date: Thu, 1 Nov 2018 07:58:50 -0700
Subject: [PATCH] pinctrl: lpc18xx: Use define directive for
 PIN_CONFIG_GPIO_PIN_INT
In-Reply-To: <0af2686f-3d9a-3ca6-e5c2-2955ffbd8bd5@mentor.com>
References: <20181101005257.8778-1-natechancellor@gmail.com>
 <0af2686f-3d9a-3ca6-e5c2-2955ffbd8bd5@mentor.com>
Message-ID: <20181101145850.GA13794@flashbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 01, 2018 at 10:52:14AM +0200, Vladimir Zapolskiy wrote:
> Hi Nathan,
> 
> thank you for your patch.
> 
> On 11/01/2018 02:52 AM, Nathan Chancellor wrote:
> > Clang warns when one enumerated type is implicitly converted to another:
> > 
> > drivers/pinctrl/pinctrl-lpc18xx.c:643:29: warning: implicit conversion
> > from enumeration type 'enum lpc18xx_pin_config_param' to different
> > enumeration type 'enum pin_config_param' [-Wenum-conversion]
> >         {"nxp,gpio-pin-interrupt", PIN_CONFIG_GPIO_PIN_INT, 0},
> >         ~                          ^~~~~~~~~~~~~~~~~~~~~~~
> > drivers/pinctrl/pinctrl-lpc18xx.c:648:12: warning: implicit conversion
> > from enumeration type 'enum lpc18xx_pin_config_param' to different
> > enumeration type 'enum pin_config_param' [-Wenum-conversion]
> >         PCONFDUMP(PIN_CONFIG_GPIO_PIN_INT, "gpio pin int", NULL, true),
> >         ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > ./include/linux/pinctrl/pinconf-generic.h:163:11: note: expanded from
> > macro 'PCONFDUMP'
> >         .param = a, .display = b, .format = c, .has_arg = d     \
> >                  ^
> > 2 warnings generated.
> > 
> > It is expected that pinctrl drivers can extend pin_config_param because
> > of the gap between PIN_CONFIG_END and PIN_CONFIG_MAX so this conversion
> > isn't an issue. Most drivers that take advantage of this define the
> > PIN_CONFIG variables as constants, rather than enumerated values. Do the
> > same thing here so that Clang no longer warns.
> > 
> > Link: https://github.com/ClangBuiltLinux/linux/issues/140
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> >  drivers/pinctrl/pinctrl-lpc18xx.c | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> > 
> > diff --git a/drivers/pinctrl/pinctrl-lpc18xx.c b/drivers/pinctrl/pinctrl-lpc18xx.c
> > index a14bc5e5fc24..4bee606088e1 100644
> > --- a/drivers/pinctrl/pinctrl-lpc18xx.c
> > +++ b/drivers/pinctrl/pinctrl-lpc18xx.c
> > @@ -631,13 +631,10 @@ static const struct pinctrl_pin_desc lpc18xx_pins[] = {
> >  };
> >  
> >  /**
> > - * enum lpc18xx_pin_config_param - possible pin configuration parameters
> >   * @PIN_CONFIG_GPIO_PIN_INT: route gpio to the gpio pin interrupt
> >   * 	controller.
> >   */
> > -enum lpc18xx_pin_config_param {
> > -	PIN_CONFIG_GPIO_PIN_INT = PIN_CONFIG_END + 1,
> > -};
> > +#define PIN_CONFIG_GPIO_PIN_INT		(PIN_CONFIG_END + 1)
> >  
> >  static const struct pinconf_generic_params lpc18xx_params[] = {
> >  	{"nxp,gpio-pin-interrupt", PIN_CONFIG_GPIO_PIN_INT, 0},
> > 
> 
> The change, if it is applied, starts to produce a W=1 warning:
> 
> 	drivers/pinctrl/pinctrl-lpc18xx.c:634: warning: Cannot understand  * @PIN_CONFIG_GPIO_PIN_INT: route gpio to the gpio pin interrupt on line 634 - I thought it was a doc line
> 
> Could you please take a look how to satisfy process_name() check from scripts/kernel-doc?
> 
> My proposals are:
> 1) change the first line of the comment block from '/**' to '/*',
> 2) remove '@' prefix symbol and place pinconf description on one line.
> 
> --
> Best wishes,
> Vladimir

Hi Vladimir,

Thank you for the review! I will go ahead and send a v2 with that fixed.

Nathan
