From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 23 Dec 2009 14:16:25 +0000
Subject: [PATCH 1/2] gpio add interrupt support on pca953x
In-Reply-To: <771cded00912230548q12cf26a4j23e260017e3faf80@mail.gmail.com>
References: <771cded00912220429k141600c7yffc7d3955f220934@mail.gmail.com>
	<f17812d70912220541g33cdfcffs6b2e51af805ae7b9@mail.gmail.com>
	<20091222205947.39a1f53d@taxman.wild-wind.fr.eu.org>
	<771cded00912230035j2b8b0da3p323e704ea93cc3d@mail.gmail.com>
	<20091223121825.52b78fed@life-in-the-fast-lane>
	<20091223132932.GA4799@sirena.org.uk>
	<771cded00912230548q12cf26a4j23e260017e3faf80@mail.gmail.com>
Message-ID: <20091223141625.GC14455@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 23, 2009 at 09:48:07PM +0800, Haojian Zhuang wrote:
> On Wed, Dec 23, 2009 at 9:29 PM, Mark Brown

> >> While I fully understand your point, I'm more worried about the
> >> correctness of the approach. I'm under the impression that the use of
> >> IRQ_NESTED_THREAD is mandatory if we're using a threaded handler.

> >> @Mark Brown: what is your take on this? Is it possible to use
> >> generic_handle_irq() from within a threaded handler?

> > ICBW but I believe you'll find that you get into trouble with lockdep if
> > try to do that - the TWL4030 drivers in current mainline jump through
> > some hoops in the client drivers as a result of this if you want to look
> > at some examples. ?Once you're in a threaded IRQ you're in a slightly
> > different context and need to take account of that.

> So do you mean that we should disable IRQ in the threaded IRQ context?

I'm not sure exactly what makes you say that but if you're using the
genirq infrastructure then it should do the right thing for you here.
TWL4030 wasn't doing that (it predates genirq supporting I2C devices)
which was why it was running into trouble.
