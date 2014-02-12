From: broonie@kernel.org (Mark Brown)
Date: Wed, 12 Feb 2014 18:33:01 +0000
Subject: [PATCH 1/3] mmc: add support for power-on sequencing through DT
In-Reply-To: <201401281148.10670.arnd@arndb.de>
References: <1390190215-22700-1-git-send-email-olof@lixom.net>
 <52E700F0.7040708@gmail.com>
 <CAPDyKFpOhQtiyCmzie3=sfg42Vv5_rReRNgUf8kALoE6TBe2cw@mail.gmail.com>
 <201401281148.10670.arnd@arndb.de>
Message-ID: <20140212183301.GL28112@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 28, 2014 at 11:48:10AM +0100, Arnd Bergmann wrote:

> I think there is another option, which does have its own pros and cons:
> We could move all the power handling back into the sdio function driver
> if we allow a secondary detection path using DT rather than the probing
> of the SDIO bus. Essentially you'd have to list the class/vendor/device
> ID for each function that cannot be autodetected in DT, and have the
> SDIO core pretend that it found the device just by looking at the
> device nodes, and register the struct sdio_func so it can be bound to
> the driver. The driver then does all the power handling in a device
> specific way. At some point the hardware gets registered at the 
> mmc host, and the sdio core connects the bus state to the already present
> sdio_func, possibly notifying the function driver that it has become
> usable.

> Obviously, this can only work for CAP_NONREMOVABLE devices, but those
> are exactly the ones we are worried about here. The advantage is that
> the power sequencing for a particular device can then be in device
> specific code and can have an arbitrarily complex in the driver without
> needing the mmc code to handle all possible corner cases.

I think this is going to be the most generic solution overall, it's
going to work with other buses and it's going to allow the device to
fully power itself off while running (I don't know if it's useful for SD
but that's definitely common with some other buses).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140212/aba45cd9/attachment.sig>
