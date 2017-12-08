From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 8 Dec 2017 11:50:12 +0100
Subject: [PATCH] i2c: core: Use GPIO descriptors for recovery
In-Reply-To: <20171208102002.26456-1-linus.walleij@linaro.org>
References: <20171208102002.26456-1-linus.walleij@linaro.org>
Message-ID: <20171208105010.xn6m4bl3hiaxhizq@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 08, 2017 at 11:20:02AM +0100, Linus Walleij wrote:
> The I2C core contains code for handling a fallback recovery
> using GPIO when a piece of I2C hardware fails in duty.
> 
> This code passes GPIO numbers from the global GPIO
> numberspace around and we want to get rid of this and use
> GPIO descriptors associated with the devices.
> 
> After some digging it turns out that there are two users
> of the mechanism in the entire kernel:
> 
> - i.MX that simply define "scl-gpios" and "sda-gpios" in
>   the device tree which is already creating descriptors
>   associated with the device, that we can pick up and use.
> 
> - Two DaVinci boards that pass the SCL and SDA GPIOs using
>   custom platform data.
> 
> Refactor the core to grab the SCL and SDA GPIO descriptors
> on-demand when doing recovery, and release them when
> recovery is done. Grab the named descriptors "scl" and
> "sda" which will make the i.MX method work out of the
> box.
> 
> Augment the two DaVinci board files to pass descriptors
> using static tables.
> 
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: Kevin Hilman <khilman@kernel.org>
> Cc: Keerthy <j-keerthy@ti.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

We have this in i2c/for-next:

3991c5c80beaf7 ("i2c: Switch to using gpiod interface for gpio bus recovery")

Sorry, I just noticed you were not on CC. I wrongly remembered you took
part in that discussion, too.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171208/d1f0d39f/attachment.sig>
