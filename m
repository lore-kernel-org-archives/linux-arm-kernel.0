From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 13 Mar 2015 08:50:58 +0100
Subject: [PATCH 0/3] clk: divider: three exactness fixes (and a rant)
In-Reply-To: <1426150673.14455.11.camel@pengutronix.de>
References: <20150306192813.GG10717@pengutronix.de>
 <54FA02B7.8090703@codeaurora.org>
 <1425895136.3152.22.camel@pengutronix.de>
 <54FDEEFE.1060803@codeaurora.org>
 <20150309210735.14952.91257@quantum>
 <20150309215803.GD7525@pengutronix.de>
 <54FE215D.7090804@codeaurora.org>
 <20150309233416.GF7525@pengutronix.de>
 <5500EA26.7090007@codeaurora.org>
 <1426150673.14455.11.camel@pengutronix.de>
Message-ID: <20150313075058.GL952@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 12, 2015 at 09:57:53AM +0100, Philipp Zabel wrote:
> Am Mittwoch, den 11.03.2015, 18:21 -0700 schrieb Stephen Boyd:
> [...]
> > Why does Philipp like 110Hz the most? Where is the desire for that rate
> > coming from?
> > 
> > > And the lower
> > > abs(1 / 110 - 1 / r) the better. 
> > 
> > Similarly, where is this requirement coming from? Some datasheet? Or is
> > it just some arbitrary decision we've made that may not hold true for
> > all consumers?
It's not comming from a datasheet. But that's what I guess is the right
metric for quite some cases. E.g. an UART sample rate and I also
wouldn't be surprised if Philipp's panel example would call for this
metric, too.

For an UART running with say 38400 Bd you want to sample with a freqency
of 38400 Hz (not considering oversampling, but that is only a factor
that doesn't makes my reasoning wrong). If you now consider 38401 Hz and
38399 Hz the respective deltas are 1 Hz. But if you look at the time
between two samples we have:

	38401 Hz -> 26.04098852 us -> delta: 0.6781507 ns
	38400 Hz -> 26.04166667 us
	38399 Hz -> 26.04234485 us -> delta: 0.6781861 ns

So with 38401 it takes a little longer until the slightly deviating rate
results in sampling the wrong bit.

> In this use case, the driver doesn't want the pixel clock to stay below
> a hard frequency limit, but to get as close as possible to the target
> frequency, either above or below, so the relative error to the nominal
> panel refresh rate stays as small as possible. Thus for a fictional
> target rate of 110 Hz, I'd like to minimize abs((round_rate / 110) - 1).
Note that minimizing

	abs((round_rate / 110) - 1)

is equivalent to minimizing

	abs(round_rate - 110)

.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
