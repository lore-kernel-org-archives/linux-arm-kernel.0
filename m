From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 3 Mar 2017 20:12:48 +0100
Subject: [PATCH 4/4] tty/serial: sh-sci: remove uneeded IS_ERR_OR_NULL
 calls
In-Reply-To: <CAMuHMdX-K9B20Tu5NtHJRHmGGuT60OFu8TokZxsF8aSaS7HuHQ@mail.gmail.com>
References: <20170303142201.16452-1-richard.genoud@gmail.com>
 <CAMuHMdX-K9B20Tu5NtHJRHmGGuT60OFu8TokZxsF8aSaS7HuHQ@mail.gmail.com>
Message-ID: <20170303191248.wlwjri55ip2x5pgg@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 03, 2017 at 07:58:36PM +0100, Geert Uytterhoeven wrote:
> Hi Richard,
> 
> On Fri, Mar 3, 2017 at 3:22 PM, Richard Genoud <richard.genoud@gmail.com> wrote:
> > Since commit 1d267ea6539f ("serial: mctrl-gpio: simplify init routine"),
> > the mctrl_gpio_to_gpiod() function can't return an error anymore.
> > So, just testing for a NULL pointer is ok.
> 
> If CONFIG_GPIOLIB=n, mctrl_gpio_to_gpiod() always returns ERR_PTR(-ENOSYS).
> That case should be handled correctly, too.

The correct change to handle this is:

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 91e7dddbf72c..2f4cdd4e7b4f 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3022,7 +3022,7 @@ static int sci_probe_single(struct platform_device *dev,
 		return ret;
 
 	sciport->gpios = mctrl_gpio_init(&sciport->port, 0);
-	if (IS_ERR(sciport->gpios) && PTR_ERR(sciport->gpios) != -ENOSYS)
+	if (IS_ERR(sciport->gpios))
 		return PTR_ERR(sciport->gpios);
 
 	if (p->capabilities & SCIx_HAVE_RTSCTS) {

Then mctrl_gpio_to_gpiod isn't called. I don't have a machine to test
this, but I think currently this makes the machine barf to continue
here because with sciport->gpios = ERR_PTR(-ENOSYS) calling

	mctrl_gpio_to_gpiod(sciport->gpios, ...)

is a bad idea.
 
> Perhaps mctrl_gpio_to_gpiod() should always return NULL if !CONFIG_GPIOLIB?

No, mctrl_gpio_to_gpiod is right. You are only supposed to call it if
mctrl_gpio_init succeeded.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
