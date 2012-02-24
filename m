From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 24 Feb 2012 15:03:27 +0000
Subject: [PATCH v2] USB: Support for LPC32xx SoC
In-Reply-To: <20120224063521.GA16412@pengutronix.de>
References: <1330030639-3796-1-git-send-email-stigge@antcom.de>
 <4F46AA06.30502@antcom.de> <20120224063521.GA16412@pengutronix.de>
Message-ID: <201202241503.27406.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 24 February 2012, Wolfram Sang wrote:
>   > To get rid of the remaining #ifdefs, I could as well create a new
> > ohci-lpc32xx.c instead of abusing ohci-pnx4008.c. Would this be the way
> > to go or are there any other suggestions?
> 
> If you could tell the difference between pnx4008 and lpc32xx, then you could
> simply do something like:
> 
>         if (machine_is_pnx4008)
>                 pnx4008_configure();
>         else
>                 lpc32xx_configure();
> 
> or
> 
>         if (machine_is_pnx4008)
>                 pnx4008_(un)set_usb_bits

I would recomment telling this from the device itself rather than from the
platform. You can add a platform_device_id list and put information like this
into the driver_data, then do

	switch (pdev->id.driver_data) {
	case OHCI_PNX4008:
                pnx4008_configure();
		break;
	case 
		lpc32xx_configure();
		break;
	};

	if (pdev->id.driver_data == OHCI_PNX4008)
		pnx4008_(un)set_usb_bits()

Alternatively, you can put the common code into one file, and use separate
files for the parts that are different between pnx4008 and lpc32xx.

Unfortunately, the way that ohci handles the abstraction between the
various implementations is backwards, it would be much easier if the
main driver was following that model to start with.

	Arnd
