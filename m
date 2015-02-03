From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 3 Feb 2015 20:01:41 +0100
Subject: [PATCH] pinctrl: pinctrl-imx: don't use invalid value of conf_reg
In-Reply-To: <CACRpkdbtpGU57-tPn9Z0rNvY4zLk+QE6A9Pd87vLUHOmRiB2yg@mail.gmail.com>
References: <1422399025-25636-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <CACRpkdbtpGU57-tPn9Z0rNvY4zLk+QE6A9Pd87vLUHOmRiB2yg@mail.gmail.com>
Message-ID: <20150203190141.GE10842@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 03, 2015 at 02:01:09PM +0100, Linus Walleij wrote:
> On Tue, Jan 27, 2015 at 11:50 PM, Uwe Kleine-K?nig
> <u.kleine-koenig@pengutronix.de> wrote:
> 
> > The right check for conf_reg to be invalid it testing against -1 not 0
> > as is done in the rest of the driver.
> >
> > This fixes an oops that can be triggered by:
> >
> >         cat /sys/kernel/debug/pinctrl/43fac000.iomuxc/*
> >
> > Fixes: ae75ff814538 ("pinctrl: pinctrl-imx: add imx pinctrl core driver")
> > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> 
> Patch applied.
> 
> But...
> 
> > -       if (!pin_reg || !pin_reg->conf_reg) {
> > +       if (!pin_reg || pin_reg->conf_reg == -1) {
> 
> I can see that the other code checks for -1 in this variable.
> But where is conf_reg ever set to -1?
> 
> freescale]$ git grep "\-1"
> pinctrl-imx.c:          if (pin_reg->mux_reg == -1) {
> pinctrl-imx.c:  if (pin_reg->mux_reg == -1)
> pinctrl-imx.c:  if (pin_reg->mux_reg == -1)
> pinctrl-imx.c:  if (pin_reg->conf_reg == -1) {
> pinctrl-imx.c:  if (pin_reg->conf_reg == -1) {
> pinctrl-imx.c:  if (!pin_reg || pin_reg->conf_reg == -1) {
Uah, ugly. This member gets -1 by means of:

	memset(info->pin_regs, 0xff, sizeof(*info->pin_regs) * info->npins);

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
