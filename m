From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sun, 10 Jul 2011 17:34:02 +0900
Subject: [PATCH 02/10] ASoc: mxs: add mxs-saif driver
In-Reply-To: <CAA+hA=S0HTqNt+OxprdaqZMF8_9NF8G54UKJprcWc2DCbGf0xA@mail.gmail.com>
References: <1310140790-2132-1-git-send-email-b29396@freescale.com>
	<1310140790-2132-3-git-send-email-b29396@freescale.com>
	<20110709025252.GC26900@sirena.org.uk>
	<CAA+hA=S0HTqNt+OxprdaqZMF8_9NF8G54UKJprcWc2DCbGf0xA@mail.gmail.com>
Message-ID: <20110710083359.GB23199@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 10, 2011 at 04:17:13PM +0800, Dong Aisheng wrote:
> 2011/7/9 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> > On Fri, Jul 08, 2011 at 11:59:42PM +0800, Dong Aisheng wrote:

> >> + ? ? switch (clk_id) {
> >> + ? ? case MXS_SAIF_SYS_CLK:
> >> + ? ? ? ? ? ? clk_set_rate(saif->clk, freq);
> >> + ? ? ? ? ? ? clk_enable(saif->clk);

> > How would one turn this clock off?

> Currenty simply enable clock always.

If that's what you're doing you should enable the clock when the device
is probed and disable it when the device is removed.  These repeated
enables will mean that you're constantly leaking references.

> The problem is that the codec may use the MCLK supplied by SAIF as its
> system clock for normal operations such as i2c r/w.

That may be true for your particular system but it is not going to be
true in general - most devices can handle having their MCLK removed.

> If we disable it after playback or capture. The automatic dapm
> operations of codec may fail on i2c r/w. Will check if dapm has any
> machnism to avoid this.
> Can you share your experience ont this issue?

You should ideally let the machine driver or other system integration
code control if the clock is constantly enabled, or at the very least
control it from the probe and remove.

> >> +static irqreturn_t mxs_saif_irq(int irq, void *dev_id)
> >> +{
> >> + ? ? struct mxs_saif *saif = dev_id;
> >> +
> >> + ? ? if (saif->fifo_err_counter++ % 100 == 0)
> >
> > The rate limit looks awfully suspicious...
> Originally it's just for printing less error messages when the issue happens.
> I could remove the rate limit.

Please do so.

> >> + ? ? clk_set_rate(saif->clk, 12000000);
> >> + ? ? clk_enable(saif->clk);

> > How did you pick this clock rate and why does it need to be set? ?It's
> > not an obvious audio rate...

> It's initial clock rate for normal operations of codecs based on MCLK.
> We found the default MCLK ouput(only about 7.3Khz) can not work for codecs like
> sgtl5000 for its initialization since its clock range is 8Mhz~27Mhz.
> So we set a common working clock 12Mhz here.
> Maybe i should try to set it elsewhere or just set it via platform data.

This is the same issue as the above one with repeated enables?  You
should delegate the rate selection and ideally also the enable control
to the machine driver, it can set something in its probe() function.
