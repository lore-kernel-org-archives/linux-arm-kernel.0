From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 16 Nov 2010 13:45:54 -0700
Subject: [PATCH v5 04/12] spi: add ti-ssp spi master driver
In-Reply-To: <20101116113409.GH3338@sirena.org.uk>
References: <1289848334-8695-1-git-send-email-cyril@ti.com>
	<1289848334-8695-5-git-send-email-cyril@ti.com>
	<20101116072225.GF4074@angua.secretlab.ca>
	<AANLkTi=utWumLKo9QVWXpkC8WxpgaNJJs+dj=pa2eq-q@mail.gmail.com>
	<20101116113409.GH3338@sirena.org.uk>
Message-ID: <20101116204554.GB5016@angua.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 16, 2010 at 11:34:09AM +0000, Mark Brown wrote:
> On Tue, Nov 16, 2010 at 12:47:04AM -0700, Grant Likely wrote:
> > On Tue, Nov 16, 2010 at 12:22 AM, Grant Likely
> 
> > > Instead, it is now incumbent on the board support code to ensure that
> > > any device that depends on another device (including i2c or spi
> > > regulators) will defer registration until the prerequisite devices are
> > > bound to drivers.
> 
> You did also say you were going to write helpers to make this easier - I
> do fear that we're going to end up with far too much boiler plate code
> in machine drivers if we have to open code this.  I guess device tree is
> going to need the helpers anyway :)

Yup, and I will, but as can be seen the boilerplate required is
actually pretty minimal, and I'd like to have a couple of platforms to
work with before actually settling on what the helpers need to look
like.

> 
> > > I don't *think* this change will affect anything in this particular
> > > patch series, but if it does then let me know and I'll help you work out
> > > how to fix it using a bus notifier.
> 
> > Oh, wait, spoke too soon.  You do add a regulator in this series, so
> > this change will require a fixup.  The solution is to register an
> > bus_notifier to the spi bus type before you start registering devices.
> 
> > It also requires deferring the musb_hdrc.1 and tps6116x registrations
> > until the bus_notifier callback gets called with an indication that
> > the regulator is bound.  It will look something like this:
> 
> Did you come up with a way of handling situations like cpufreq where we
> have no device to wait for?

Haven't dug into it yet.

g.
