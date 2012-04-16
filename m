From: stern@rowland.harvard.edu (Alan Stern)
Date: Mon, 16 Apr 2012 11:09:25 -0400 (EDT)
Subject: [PATCH v2 1/3] USB: Add driver for NXP ISP1301 USB transceiver
In-Reply-To: <1334582166-5485-1-git-send-email-stigge@antcom.de>
Message-ID: <Pine.LNX.4.44L0.1204161106410.1408-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 16 Apr 2012, Roland Stigge wrote:

> This very-lowlevel driver registers the NXP ISP1301 chip via the I2C subsystem.
> The chip is the USB transceiver shared by ohci-nxp, lpc32xx_udc (gadget) and
> isp1301_omap.
> 
> Following patches let the respective USB host and gadget drivers use this
> driver, instead of duplicating ISP1301 handling.
> 
> Signed-off-by: Roland Stigge <stigge@antcom.de>
> 
> ---
> 
> Applies to v3.4-rc3
> 
> This driver needs to be probe()d before the respective USB driver using it. For
> modules, this is handled via the module dependency. When linking statically, it
> is done via linking order in the Makefile (misc/ before host/ and the gadget/).
> 
> Currently, only one ISP1301 chip is supported. To support multiple instances,
> we would need a mechanism to identify the respective chips via DT (and static
> resources or platform data) to be referenced by the higher level USB driver at
> isp1301_get_client(). Any suggestions?
> 
> 
>  drivers/usb/Makefile        |    5 ++
>  drivers/usb/misc/Kconfig    |   12 ++++++
>  drivers/usb/misc/Makefile   |    1 
>  drivers/usb/misc/isp1301.c  |   64 ++++++++++++++++++++++++++++++++++
>  include/linux/usb/isp1301.h |   82 ++++++++++++++++++++++++++++++++++++++++++++

You know, drivers/usb/misc is meant for miscellaneous USB device 
drivers.  Not for host or transceiver drivers.

You should put the new file somewhere else.  Maybe in the otg 
directory, although that may not be completely appropriate either.  
Maybe something under the host directory.

Alan Stern
