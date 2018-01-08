From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 8 Jan 2018 16:46:36 +0100
Subject: [PATCH v4 4/4] ARM: pinctrl: sunxi-pinctrl: fix pin funtion can
 not be match correctly.
In-Reply-To: <CAJeuY79_w+8Gv=jRxK4tajiecNSAZkMGYY_d7PJmsjyOZHPkJw@mail.gmail.com>
References: <20171213144748.GA18267@arx-s1>
 <20171213154549.5zn4uxhsssqw3pb7@flea.lan>
 <CAJeuY79_w+8Gv=jRxK4tajiecNSAZkMGYY_d7PJmsjyOZHPkJw@mail.gmail.com>
Message-ID: <20180108154636.vqwcyb4cznqyclip@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 08, 2018 at 07:08:53PM +0800, Hao Zhang wrote:
> 2017-12-13 23:45 GMT+08:00 Maxime Ripard <maxime.ripard@free-electrons.com>:
> > Hi,
> >
> > Thanks for your patch!
> >
> > On Wed, Dec 13, 2017 at 10:47:48PM +0800, hao_zhang wrote:
> >> Pin function can not be match correctly when SUNXI_PIN describe with
> >> mutiple variant and same function.
> >>
> >> such as:
> >> on pinctrl-sun4i-a10.c
> >>
> >> SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 2),
> >>               SUNXI_FUNCTION(0x0, "gpio_in"),
> >>               SUNXI_FUNCTION(0x1, "gpio_out"),
> >>               SUNXI_FUNCTION_VARIANT(0x2, "pwm",    /* PWM0 */
> >>                       PINCTRL_SUN4I_A10 |
> >>                       PINCTRL_SUN7I_A20),
> >>               SUNXI_FUNCTION_VARIANT(0x3, "pwm",    /* PWM0 */
> >>                       PINCTRL_SUN8I_R40)),
> >>
> >> it would always match to the first variant function
> >> (PINCTRL_SUN4I_A10, PINCTRL_SUN7I_A20)
> >>
> >> so we should add variant compare on it.
> >>
> >> Signed-off-by: hao_zhang <hao5781286@gmail.com>
> >> ---
> >>  drivers/pinctrl/sunxi/pinctrl-sunxi.c | 6 ++++--
> >>  1 file changed, 4 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> >> index 4b6cb25..f23e74e 100644
> >> --- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> >> +++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> >> @@ -83,9 +83,11 @@ sunxi_pinctrl_desc_find_function_by_name(struct sunxi_pinctrl *pctl,
> >>                       struct sunxi_desc_function *func = pin->functions;
> >>
> >>                       while (func->name) {
> >> -                             if (!strcmp(func->name, func_name))
> >> +                             if (!strcmp(func->name, func_name)) {
> >> +                                     if (!(func->variant) ||
> >> +                                        (func->variant & pctl->variant))
> >
> > I guess it would be better to have:
> >         if (!strcmp(func->name, func_name) &&
> >             (!func->variant || (func->variant & pctl->variant)))
> 
> It would over 80 characters, can i change it by this ?
> if (!strcmp(func->name, func_name) &&
>          (func->variant & pctl->variant ||
>           !func->variant))

It feels more natural to have !func->variant first, but feel free to
have it split that way yes.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180108/a819570d/attachment-0001.sig>
