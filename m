From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 8 Feb 2017 10:08:17 +0100
Subject: i.MX7 pinctrl driver writing to non existent registers
Message-ID: <20170208090817.omm2dydhqukdzgqy@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

The i.MX7 has two pinmux controllers, the LPSR and the regular one. We
instantiate a driver for each one. Now the driver assumes that the pins
are completely configured with one iomux controller, but for the LPSR
pins this is not true: The MUX_CTL and PAD_CTL registers are indeed
in the LPSR controller, but the SELECT_INPUT registers for the same
pin are found in the regular controller.

The result is that with this pin for example:

#define MX7D_PAD_GPIO1_IO06__UART5_DCE_RX                         0x0018 0x0048 0x0714 0x3 0x4

The LPSR controller writes to LPSR_BASE + 0x714 where it should really
be IOMUX_BASE + 0x714.

I have no idea how to fix this. We could split the LPSR pins into two
pins, one for each controller. Another possibility would be to create
some kind of shortcut from one controller to control the other one. Also
not nice. Also we could simply do nothing, as long as the bootloader
configures everything correctly we won't even notice ;)

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
