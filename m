From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 23 Oct 2009 13:58:44 +0200
Subject: [PATCH] imx/gpio: Use handle_level_irq
In-Reply-To: <4e090d470910230427t3fb2d20rce3c25b3be392944@mail.gmail.com>
References: <1255983568-20958-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20091020081303.GO8818@pengutronix.de>
	<20091020173737.GA6819@pengutronix.de>
	<4e090d470910230427t3fb2d20rce3c25b3be392944@mail.gmail.com>
Message-ID: <20091023115844.GA1821@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, Oct 23, 2009 at 07:27:08PM +0800, Richard Zhao wrote:
> 2009/10/21 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> > Hello Sascha,
> >
> > On Tue, Oct 20, 2009 at 10:13:03AM +0200, Sascha Hauer wrote:
> >> On Mon, Oct 19, 2009 at 10:19:28PM +0200, Uwe Kleine-K?nig wrote:
> >> > According to Russell King handle_edge_irq is only useful for "edge-based
> >> > inputs where the controller does not remember transitions with the input
> >> > masked."
> >> >
> >> > So using handle_edge_irq unconditionally for both edge and level irqs is
> >> > wrong. ?Testing showed that the controller does remember transitions
> >> > while the interrupt is masked. ?So use handle_level_irq unconditionally.
> >>
> >> As this fixes only rt kernels and we have no reports that something is
> >> not working on non rt kernels I suggest putting this into the next merge
> >> window.
> > The PMIC on pcm038 doesn't work anymore with handle_edge_irq since I
> > switched to using threaded irqs in the driver. ?But as this won't hit
> > mainline before the next merge window that is fine for me, too.
> 
> handle_level_irq may lost edge irq request. The controller won't
> change ISR when irq's masked.
> Why not decide to use handle_level_irq or handle_edge_irq in gpio_set_irq_type?
Have you read the commit log?  If yes, do you know a test case where
handle_level_irq fails to detect an edge irq when masked?

I did on a Phytec pcm038:

	set_irq_type(TRIGGER_RISING)
	mask(irq=119)
	provoke a rising edge on gpio55
	unmask(irq=119)

and after that the irq handler was entered.

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
