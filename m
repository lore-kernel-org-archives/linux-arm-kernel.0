From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 4 Feb 2014 10:09:26 +0100
Subject: [PATCH v3 3/5] spi: sunxi: Add Allwinner A31 SPI controller driver
In-Reply-To: <20140204002110.GP22609@sirena.org.uk>
References: <1391165752-1819-1-git-send-email-maxime.ripard@free-electrons.com>
 <1391165752-1819-4-git-send-email-maxime.ripard@free-electrons.com>
 <20140131124809.GE22609@sirena.org.uk>
 <20140131224704.GI2950@lukather>
 <20140204002110.GP22609@sirena.org.uk>
Message-ID: <20140204090926.GI25625@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Tue, Feb 04, 2014 at 12:21:10AM +0000, Mark Brown wrote:
> On Fri, Jan 31, 2014 at 11:47:04PM +0100, Maxime Ripard wrote:
> > On Fri, Jan 31, 2014 at 12:48:09PM +0000, Mark Brown wrote:
> > > On Fri, Jan 31, 2014 at 11:55:50AM +0100, Maxime Ripard wrote:
> 
> > > > +	pm_runtime_enable(&pdev->dev);
> > > > +	if (!pm_runtime_enabled(&pdev->dev)) {
> > > > +		ret = sun6i_spi_runtime_resume(&pdev->dev);
> > > > +		if (ret) {
> > > > +			dev_err(&pdev->dev, "Couldn't resume the device\n");
> > > > +			return ret;
> > > > +		}
> > > > +	}
> 
> > > No, as discussed don't do this - notice how other drivers aren't written
> > > this way either.  Like I said leave the device powered on startup and
> > > then let it be idled by runtime PM.
> 
> > Well, some SPI drivers are actually written like that (all the tegra
> 
> It's not been done consistently, no - that should be fixed.
> 
> > SPI drivers for example). It's not an excuse, but waking up the device
> > only to put it back in suspend right away seems kind of
> 
> It isn't awesome, no.  Ideally the runtime PM code would do this but
> then you couldn't ifdef the operations which as far as I can tell is the
> main thing people want from disabling it and it gets complicated for
> devices that genuinely do power up on startup so here we are.

We discussed it with Kevin on IRC, and he suggested that we move that
pm_runtime initialization to the SPI core, but I guess that would also
mean that all drivers shouldn't ifdef the operations, so that the core
can call the runtime_resume callback directly.

However, I don't really get why any driver should be doing so, since
you still need these functions to at least to the device
suspend/resume in the probe/remove, and you don't really want to
duplicate the code.

Right now, about half of the SPI drivers using auto_runtime_pm are
using a ifdef, the other half is not.

> > inefficient. Plus, the pm_runtime_idle callback you suggested are
> > actually calling runtime_idle, while we want to call runtime_suspend.
> 
> Yeah, I didn't actually check if I was looking at the right call there.

I was actually wrong, it does so in its very last line.

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140204/60ce6bb9/attachment.sig>
