From: broonie@kernel.org (Mark Brown)
Date: Sun, 15 Sep 2013 13:47:44 +0100
Subject: [PATCH v2 1/9] i2c: prepare runtime PM support for I2C client
 devices
In-Reply-To: <20130915064139.GJ7393@intel.com>
References: <1378913560-2752-1-git-send-email-mika.westerberg@linux.intel.com>
 <1378913560-2752-2-git-send-email-mika.westerberg@linux.intel.com>
 <87vc25pvvm.fsf@linaro.org> <20130913065434.GZ7393@intel.com>
 <87bo3whjz4.fsf@linaro.org> <20130913145022.GC7393@intel.com>
 <20130913173149.GE7393@intel.com> <87ioy4e8bw.fsf@linaro.org>
 <20130915064139.GJ7393@intel.com>
Message-ID: <20130915124744.GW29403@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 15, 2013 at 09:41:39AM +0300, Mika Westerberg wrote:

> There's also a less intrusive way of fixing the problem we see with ACPI
> enabled I2C devices:

> 	1. In I2C core i2c_device_probe() we power on the I2C controller
> 	and attach the client device to the ACPI power domain. Just like in
> 	this patch but we don't touch the I2C client device runtime PM.

> 	-> This should allow the existing drivers to keep using whatever
> 	runtime PM strategy they have chosen.

There should be no explicit need to power on the I2C controller if it's
implemented the same way the existing ones are - just have it power
itself on when it is doing a transfer.

> 	2. For ACPI enumerated I2C client devices drivers we need to
> 	implement the runtime PM in order to save power (otherwise the
> 	devices will be left powered on).

> and do the same for SPI devices as well.

> Then only thing that changes for non-ACPI devices is that the controller
> will be powered on during the client device probe (well, and during
> remove).

> Thoughts?

This is definitely less intrusive than the current proposal, there's one
ACPI I2C device binding queued for -next after the merge window (rt5640)
which will need an update.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130915/d4861ca3/attachment.sig>
