From: broonie@kernel.org (Mark Brown)
Date: Tue, 10 Sep 2013 13:27:54 +0100
Subject: [PATCH RESEND 1/2] i2c: prepare runtime PM support for I2C
 client devices
In-Reply-To: <20130910075100.GK7393@intel.com>
References: <1378733679-19500-1-git-send-email-mika.westerberg@linux.intel.com>
 <1378733679-19500-2-git-send-email-mika.westerberg@linux.intel.com>
 <20130909154028.GP29403@sirena.org.uk>
 <20130910075100.GK7393@intel.com>
Message-ID: <20130910122754.GK29403@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 10, 2013 at 10:51:00AM +0300, Mika Westerberg wrote:
> On Mon, Sep 09, 2013 at 04:40:28PM +0100, Mark Brown wrote:

> > How is this going to interact with client devices which are already
> > enabling runtime PM for themselves, and what are the advantages of doing
> > this over having the client device enable runtime PM for itself (given
> > that the client still needs an explicit put() adding)?

> My understanding is that you can call pm_runtime_enable() several times
> (provided that pm_runtime_disable() is called as many times). So that
> should have no effect on the current drivers that already take advantage of
> runtime PM.

Not quite...

> There is one difference though -- runtime PM is now blocked by default and
> it needs to be unblocked from the userspace per each device.

...as you say.

This seems crazy, why on earth would we want to have userspace be forced
to manually go through every single device and manually enable power
saving?  I can't see anyone finding that helpful and it's going to be a
pain to deploy.

However I had thought it was just a case of the drivers doing a put()
instead of their current code to enable runtime PM (you mention that
later on)?  That seems both sensible and doable, though it would need
doing as part of the conversion to avoid regressions and I'd expect it
does mean that SPI needs to be converted at the same time.

> For the advantages compared to each driver handling it completely
> themselves:

> 	- Few lines less as you only need to call _put().
> 	- It follows what is already been done for other buses, like PCI
> 	  and AMBA .
> 	- The I2C core makes sure that the device is available (from bus
> 	  point of view) when the driver ->probe() is called.

I can't understand your last point here at all, sorry.  Can you expand
please?

> > Given that it's relatively common for devices to have both I2C and SPI
> > control it seems like it'd be sensible to keep the policy common between
> > the two buses to simplify driver implementation.

> Yes and IMHO if I2C and SPI follows what has already been done for other
> buses it should make the driver writer's job easier as the usage is similar
> from one bus to another.

So then the obvious followup question is why this is even something that
needs to be implemented per bus?  Shouldn't we be enhancing the driver
core to do this, or is that the long term plan and this is a step on the
road to doing that?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130910/84c482ec/attachment-0001.sig>
