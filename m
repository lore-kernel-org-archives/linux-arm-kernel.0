From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 9 Jul 2015 09:12:52 +0200
Subject: [PATCH] pinctrl: imx1-core: Fix debug output pin array index
In-Reply-To: <1436364966-19778-1-git-send-email-mpa@pengutronix.de>
References: <1436364966-19778-1-git-send-email-mpa@pengutronix.de>
Message-ID: <20150709071252.GF1426@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Markus,

Cc += Chris Ruehl

On Wed, Jul 08, 2015 at 04:16:06PM +0200, Markus Pargmann wrote:
> The pins do not have a 1:1 mapping from index to pin_id. Unfortunately
> the debug output assumes exactly that.
> 
> The first driver using imx1-core was imx27, which had exactly this 1:1
> mapping. It was accidently removed when removing all unused pads which
> were listed:
> 	607af165c047 (pinctrl: i.MX27: Remove nonexistent pad definitions)
> 
> The patch fixes this issue by printing the pin_id directly and not the
> pin name.
Knowing a bit about the imx pinctrl drivers I failed to understand what
you wrote here. Probably because I first though that "1:1 mapping" is a
hardware property. What about:

	Subject: pinctrl: imx1-core: Fix debug output in .pin_config_set callback

	imx1_pinconf_set assumes that the array of pins in struct
	imx1_pinctrl_soc_info can be indexed by pin id to get the
	pinctrl_pin_desc for a pin. This used to be correct up to commit
	607af165c047 ("pinctrl: i.MX27: Remove nonexistent pad definitions")
	which removed some entries from the array and so made it wrong to access
	the array by pin id.

	Implement the easiest fix by not resolving the pin id to a name but
	printing the id instead.

	Fixes: 607af165c047 ("pinctrl: i.MX27: Remove nonexistent pad definitions")
	Cc: stable at vger.kernel.org
	Reported-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
	Signed-off-by: Markus Pargmann <mpa@pengutronix.de>

Having the pad name in the output is nice, is it worth to search for the
right pinctrl_pin_desc in the array? The array is still sorted, so a
binary search would do, maybe a function for this already exists?

How did Chris notice the error? Just a bogus output, or did it crash the
kernel? That would be worth to note in the commit log, too.

Otherwise the change looks fine.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
