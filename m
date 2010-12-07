From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 7 Dec 2010 09:02:39 +0100
Subject: [PATCH] support PMIC mc13892
In-Reply-To: <AANLkTi=fG_GGBO2PDDABDMoRfACLMBwxs=vKDwmAnKD7@mail.gmail.com>
References: <1291616735-29645-1-git-send-email-yong.shen@freescale.com>
	<20101206072237.GH10693@pengutronix.de>
	<AANLkTi=fG_GGBO2PDDABDMoRfACLMBwxs=vKDwmAnKD7@mail.gmail.com>
Message-ID: <20101207080239.GC21020@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Yong,

On Tue, Dec 07, 2010 at 03:57:12PM +0800, Yong Shen wrote:
> 2010/12/6 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> >> + ? ? if ((val & 0x0000FFFF) == 0x45d0) {
> >> + ? ? ? ? ? ? mc13xxx_lock(mc13892);
> >> + ? ? ? ? ? ? ret = mc13xxx_reg_rmw(mc13892, MC13892_SWITCHERS4,
> >> + ? ? ? ? ? ? ? ? ? ? MC13892_SWITCHERS4_SW1MODE_M |
> >> + ? ? ? ? ? ? ? ? ? ? MC13892_SWITCHERS4_SW2MODE_M,
> >> + ? ? ? ? ? ? ? ? ? ? MC13892_SWITCHERS4_SW1MODE_AUTO |
> >> + ? ? ? ? ? ? ? ? ? ? MC13892_SWITCHERS4_SW2MODE_AUTO);
> >> + ? ? ? ? ? ? mc13xxx_unlock(mc13892);
> > It should be possible to hold the lock for longer that a single mc13xxx
> > API call. ?Your error handler just needs to unlock for that.
> I found this can not work, since regulator_register in probe function
> will in turn call regulator ops->enable or alike, which require
> mc13xxx_lock again. So we do not use long lock here.
You probably cannot only take the lock once per function, but here for
these two mc13xxx_reg_rmw it should be possible.

> >> [...]
> >> +
> >> +static struct platform_driver mc13892_regulator_driver = {
> >> + ? ? .driver = {
> >> + ? ? ? ? ? ? .name ? = "mc13892-regulator",
> >> + ? ? ? ? ? ? .owner ?= THIS_MODULE,
> >> + ? ? },
> >> + ? ? .remove ? ? ? ? = __devexit_p(mc13892_regulator_remove),
> >> + ? ? .probe ? ? ? ? ?= mc13892_regulator_probe,
> > If you ask me just use a single space before =, but there is no common
> > style visible in the kernel, so do as you prefer.
> > (The advantage of using a single space is that if later
> > .averylongmembername needs to be initialized you either have to fix
> > lines that are technically unrelated or the indention isn't uniform.)
BTW, using tabs you get a mixture, too.  Then some =s are aligned, some
don't.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
