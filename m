From: broonie@kernel.org (Mark Brown)
Date: Tue, 26 Jan 2016 12:04:32 +0000
Subject: [PATCH] regulator: return NULL for dummy bulk_get operation
In-Reply-To: <1453737537-1960121-1-git-send-email-arnd@arndb.de>
References: <1453737537-1960121-1-git-send-email-arnd@arndb.de>
Message-ID: <20160126120432.GF6588@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 25, 2016 at 04:58:50PM +0100, Arnd Bergmann wrote:
> Drivers that call regulator_bulk_get or devm_regulator_bulk_get when
> CONFIG_REGULATOR is disabled see the function return successfully, but
> cannot use the "consumer" pointers that are meant to be returned from
> the functions, as the values are uninitialized. Gcc warns about this:

> drivers/usb/phy/phy-qcom-8x16-usb.c: In function 'phy_8x16_probe':
> drivers/usb/phy/phy-qcom-8x16-usb.c:284:13: error: 'regs[0].consumer' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> drivers/usb/phy/phy-qcom-8x16-usb.c:285:13: error: 'regs[1].consumer' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> drivers/usb/phy/phy-qcom-8x16-usb.c:286:12: error: 'regs[2].consumer' may be used uninitialized in this function [-Werror=maybe-uninitialized]

The usage in that driver looks a bit dodgy - the disable function is
just an open coding of regulator_bulk_disable() with no error checking
while the enable function is doing a series of set_voltage() calls on
every enable which look a lot like values that I'd expect to come from
constraints rather than being set explicitly (the VDD values are an API
abuse we know about in the Qualcomm drivers).  The fact that it never
varies the voltage is a warning sign that the driver might not want to
be using set_voltage() at all, and it should at least do that once on
init if there's a use case.  A quick glance at in tree DTs suggests that
there's no actual runtime variation.

I'm not 100% convinced this didn't actually warn us about a real
problem.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160126/192be020/attachment.sig>
