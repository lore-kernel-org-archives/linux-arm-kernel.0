From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 23 Dec 2009 13:29:33 +0000
Subject: [PATCH 1/2] gpio add interrupt support on pca953x
In-Reply-To: <20091223121825.52b78fed@life-in-the-fast-lane>
References: <771cded00912220429k141600c7yffc7d3955f220934@mail.gmail.com>
	<f17812d70912220541g33cdfcffs6b2e51af805ae7b9@mail.gmail.com>
	<20091222205947.39a1f53d@taxman.wild-wind.fr.eu.org>
	<771cded00912230035j2b8b0da3p323e704ea93cc3d@mail.gmail.com>
	<20091223121825.52b78fed@life-in-the-fast-lane>
Message-ID: <20091223132932.GA4799@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 23, 2009 at 12:18:25PM +0100, Marc Zyngier wrote:
> On Wed, 23 Dec 2009 03:35:57 -0500
> Haojian Zhuang <haojian.zhuang@gmail.com> wrote:
> > On Tue, Dec 22, 2009 at 2:59 PM, Marc Zyngier <maz@misterjones.org> wrote:

> [Putting Mark Brown in the loop, as wm831x is the de-facto reference]

Guys, could you please remember to cut unneeded context from replies?

> > set_irq_nested_thread(irq, 1) will only mark IRQ_NESTED_THREAD on irq
> > descriptor. It results that driver have to invoke request_thread_irq()
> > with thread_fn parameter to declare IRQ. Device could be linked to
> > GPIO directly or GPIO expander. We should keep to use request_irq()
> > for compatible. set_irq_nested_thread() shouldn't use at here.

> While I fully understand your point, I'm more worried about the
> correctness of the approach. I'm under the impression that the use of
> IRQ_NESTED_THREAD is mandatory if we're using a threaded handler.

> @Mark Brown: what is your take on this? Is it possible to use
> generic_handle_irq() from within a threaded handler?

ICBW but I believe you'll find that you get into trouble with lockdep if
try to do that - the TWL4030 drivers in current mainline jump through
some hoops in the client drivers as a result of this if you want to look
at some examples.  Once you're in a threaded IRQ you're in a slightly
different context and need to take account of that.

To the extent that this proves to be a problem in practical systems it's
something that needs to be addressed in the genirq core rather than
trying to jump through hoops in the individual drivers.  Trying to work
around the genirq core is likely to be fragile for both the interrupt
controller driver and the client drivers trying to use it.
