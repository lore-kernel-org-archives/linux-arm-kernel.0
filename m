From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 17 Apr 2012 13:29:10 +0200
Subject: [RFC PATCH 0/8] MXS: Add i.MX28 USB Host driver
In-Reply-To: <1334657751-27678-1-git-send-email-marex@denx.de>
References: <1334657751-27678-1-git-send-email-marex@denx.de>
Message-ID: <20120417112910.GA3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

On Tue, Apr 17, 2012 at 12:15:43PM +0200, Marek Vasut wrote:
> This patchset introduces the USB Host driver for i.MX28 CPU, utilising the
> generic USB PHY infrastructure.
> 

Your patches won't work when more than one USB port is enabled because
of the singular usb transceiver present in the kernel. That of course is
not your fault. I think Heikki (Added to Cc) is working on this issue,
but I don't know the status here.

Another problem is that what you are doing does not integrate at all
with otg. I don't ask you to implement otg support because you are
likely not interested in this, but since you are adding a new ehci
glue driver anyway I suggest another approach:

Put a driver under drivers/usb/otg which:

- matches a 'imx-usb' device
- gets/enables all clocks needed for USB
- finds the transceiver
- registers a ehci device

Future additions would be:

- Put a USB_MODE_HOST/DEVICE flag into platform_data, and register a
  host or gadget driver depending on this flag
- Add a USB_MODE_OTG flag to platform_data and implement otg in this
  driver (or use whatever infrastructure present in the kernel then)

This is similar to what msm does. This way we have the clocks and phys
handled where they are needed. We may use this code on i.MX later.

We did this wrong on i.MX (and several other architectures) and getting
this right will be hard work. No need to introduce the same flaws again
with a new architecture.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
