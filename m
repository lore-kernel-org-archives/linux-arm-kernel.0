From: broonie@kernel.org (Mark Brown)
Date: Mon, 2 May 2016 11:55:01 +0100
Subject: [RFT PATCH 1/3] usb: misc: usb3503: Fix HUB mode after
 bootloader initialization
In-Reply-To: <57272298.50701@samsung.com>
References: <1461927591-7864-1-git-send-email-k.kozlowski@samsung.com>
 <1461927591-7864-2-git-send-email-k.kozlowski@samsung.com>
 <20160429113059.GX3217@sirena.org.uk>
 <57234BA2.6020304@samsung.com>
 <20160429164448.GY3217@sirena.org.uk> <57272298.50701@samsung.com>
Message-ID: <20160502105501.GE6292@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 02, 2016 at 11:49:12AM +0200, Krzysztof Kozlowski wrote:

> This VDD regulator supply actually is not a usb3503 USB HUB regulator
> supply... but a supply to the LAN attached to this HUB. Regulator off/on
> is needed for LAN to show up. The hub will show up with typical reset
> (which is also missing before my patchset btw).

> The LAN, as a USB device, is auto-probed so it cannot take the regulator
> and play with it. The simplest idea I have is to add it as "external
> supply"  to the parent: usb3503.

This is common enough that that just isn't going to scale well I fear
without some generic handling, either walking child devices at the bus
level or at the device level with a pre-probe() callback to get the
device to power on.  The latter is more appropriate to things like
Slimbus where the device is more likely to do active management at
runtime, it's not clear people are building USB devices like that.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160502/7f61db57/attachment.sig>
