From: broonie@kernel.org (Mark Brown)
Date: Mon, 16 Sep 2013 11:12:49 +0100
Subject: [PATCH v2 1/9] i2c: prepare runtime PM support for I2C client
 devices
In-Reply-To: <20130915132823.GL7393@intel.com>
References: <1378913560-2752-2-git-send-email-mika.westerberg@linux.intel.com>
 <87vc25pvvm.fsf@linaro.org> <20130913065434.GZ7393@intel.com>
 <87bo3whjz4.fsf@linaro.org> <20130913145022.GC7393@intel.com>
 <20130913173149.GE7393@intel.com> <87ioy4e8bw.fsf@linaro.org>
 <20130915064139.GJ7393@intel.com>
 <20130915124744.GW29403@sirena.org.uk>
 <20130915132823.GL7393@intel.com>
Message-ID: <20130916101249.GX29403@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 15, 2013 at 04:28:24PM +0300, Mika Westerberg wrote:
> On Sun, Sep 15, 2013 at 01:47:44PM +0100, Mark Brown wrote:
> > On Sun, Sep 15, 2013 at 09:41:39AM +0300, Mika Westerberg wrote:

> > > 	1. In I2C core i2c_device_probe() we power on the I2C controller
> > > 	and attach the client device to the ACPI power domain. Just like in
> > > 	this patch but we don't touch the I2C client device runtime PM.

> > > 	-> This should allow the existing drivers to keep using whatever
> > > 	runtime PM strategy they have chosen.

> > There should be no explicit need to power on the I2C controller if it's
> > implemented the same way the existing ones are - just have it power
> > itself on when it is doing a transfer.

> The problem is that the ACPI child device can't be in higher power state
> than its parent (and this is also what the runtime PM expects). If we don't
> power the I2C controller device before we power on the I2C client device
> that rule is violated and we get an complaint to the console.

That's definitely an ACPI specific (probably x86 specific ACPI?)
requirement not a generic one, on some systems it would increase power
consumption since the controller will need to sit on while the device is
functioning autonomously.  Even though the controller power consumption
is going to be minimal the power domain it is in may be relatively
large.  Can't the power domains for ACPI deal with this requirement, for
example by making the I2C slave power domains children of the controller
power domain?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130916/391522eb/attachment.sig>
