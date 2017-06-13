From: broonie@kernel.org (Mark Brown)
Date: Tue, 13 Jun 2017 19:22:25 +0100
Subject: [PATCH v2 4/4] arm64: dts: rockchip: use cs-gpios for cros_ec_spi
In-Reply-To: <20170613175043.GC9026@google.com>
References: <1497331543-8565-1-git-send-email-jeffy.chen@rock-chips.com>
 <1497331543-8565-4-git-send-email-jeffy.chen@rock-chips.com>
 <20170613175043.GC9026@google.com>
Message-ID: <20170613182225.smahsf3jzvbc7w7z@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 13, 2017 at 10:50:44AM -0700, Brian Norris wrote:
> On Tue, Jun 13, 2017 at 01:25:43PM +0800, Jeffy Chen wrote:
> > The cros_ec requires CS line to be active after last message. But the CS
> > would be toggled when powering off/on rockchip spi, which breaks ec xfer.
> > Use GPIO CS to prevent that.

> I suppose this change is fine. (At least, I don't have a good reason not
> to do this.)

> But I still wonder whether this is something that the SPI core can be
> expected to handle. drivers/mfd/cros_ec_spi.c already sets the
> appropriate trans->cs_change bits, to ensure CS remains active in
> between certain messages (all under spi_bus_lock()). But you're
> suggesting that your bus controller may deassert CS if you runtime
> suspend the device (e.g., in between messages).

> So, is your controller just peculiar? Or should the SPI core avoid
> autosuspending the bus controller when it's been instructed to keep CS
> active? Any thoughts Mark?

This sounds like the controller being unusual - though frankly the
ChromeOS chip select usage is also odd so it's fairly rare for something
like this to come up.  I'd not expect a runtime suspend to loose the pin
state, though possibly through use of pinctrl rather than the
controller.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170613/da670236/attachment-0001.sig>
