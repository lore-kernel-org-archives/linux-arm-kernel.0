From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 17 Nov 2014 10:51:54 +0100
Subject: request an irq without enabling? [Was: Re: [PATCH] gpio: mxs:
 implement get_direction callback]
In-Reply-To: <5469BBBD.30003@elproma.com.pl>
References: <1416004026-9667-1-git-send-email-j.uzycki@elproma.com.pl>
 <20141114232601.GW27002@pengutronix.de>
 <5467A980.5090204@elproma.com.pl>
 <20141116214239.GX27002@pengutronix.de>
 <54693A51.5080907@elproma.com.pl> <54695654.3070209@elproma.com.pl>
 <20141117082848.GZ27002@pengutronix.de>
 <5469BBBD.30003@elproma.com.pl>
Message-ID: <20141117095154.GG27002@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Sorry for the just sent unfinished mail. I pressed "send" instead of
"reedit" after adding tglx to the recipients. Apart from the topic
handled in this mail it's complete though.

On Mon, Nov 17, 2014 at 10:11:25AM +0100, Janusz U?ycki wrote:
> W dniu 2014-11-17 o 09:28, Uwe Kleine-K?nig pisze:
> >I think mctrl_gpio_init should request the needed irqs, but not enable
> >them. Not sure there is a corresponding request_irq variant for that.
> 
> What would you propose?
Thomas: Is there something available among the irq functions for that.
The use case is that when probing an uart driver the modem control irqs
should only be enabled when the enable_ms callback is called by the
tty/serial framework. So we'd like to have something like
request_irq_noenable. This way the enable_ms callback would just need
to call enable_irq without first checking if the handler is already
setup.

The less nice alternatives are:

 - use request_irq(..); disable_irq(); and handle the short window where
   irqs are on but not yet desired.
 - only request_irq in the enable_ms callback, and free_irq in
   disable_ms.

Any ideas?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
