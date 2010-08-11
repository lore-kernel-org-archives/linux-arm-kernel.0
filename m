From: mfuzzey@gmail.com (Martin Fuzzey)
Date: Wed, 11 Aug 2010 13:38:37 +0200
Subject: Problem with non aligned DMA in usbnet on ARM
In-Reply-To: <4C627479.4060400@parrot.com>
References: <AANLkTi=ycg=adcizNWKMCb7EdfDANM=6Es7r_gF1LbhV@mail.gmail.com>
	<4C627479.4060400@parrot.com>
Message-ID: <AANLkTinU2JEkeYJHo4tA+kD9Pd_F3YcUTbK9w6igc7s8@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 11, 2010 at 11:59 AM, Matthieu CASTET
<matthieu.castet@parrot.com> wrote:
> It is best to solve in usb driver, because for example in Asix case the
> driver already do copy (see asix_rx_fixup/asix_tx_fixup).
>
Yes, however those functions are only called for devices which register them.
Looking at the driver_info and product id tables shows that it's only
a subset of the devices that asix supports (88772 and 88178 chips)

In fact my hardware _is_ included
	// DLink DUB-E100 H/W Ver B1 Alternate
	USB_DEVICE (0x2001, 0x3c05),
	.driver_info = (unsigned long) &ax88772_info,

but fixing this in asix_rx_fixup wouldn't solve it for the other
supported devices.

It seems to me these fixup functions are not intended to solve
alignment issues but rather implement device specific framing (such as
when the hardware packs multiple ethernet frames into a single urb)

> PS : what hcd driver do you use ?
imx21_hcd

Martin
