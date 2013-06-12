From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 12 Jun 2013 16:57:26 +0200
Subject: [PATCH V3 1/3] Add PCIe driver for Samsung Exynos
In-Reply-To: <002401ce6718$d6bbc8f0$84335ad0$@samsung.com>
References: <000d01ce6360$9504e7e0$bf0eb7a0$@samsung.com>
 <36071399.7aY6jgGn2d@wuerfel> <002401ce6718$d6bbc8f0$84335ad0$@samsung.com>
Message-ID: <201306121657.26441.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 12 June 2013, Jingoo Han wrote:
> On Friday, June 07, 2013 7:53 PM, Arnd Bergmann wrote:
> > On Friday 07 June 2013 18:22:50 Jingoo Han wrote:
> > 
> > > +- ranges: ranges for the PCI memory and I/O regions
> > > +- reset-gpio: gpio pin number of power good signal
> > 
> > The 'reset-gpio' property seems incorrect. I think this should either
> > use the gpio binding or the reset-controller binding. Specifying
> > bare numbers to use as gpio pins does not work, since the number
> > space for Linux internal gpio numbers is not necessarily the same
> > as used by the hardware.
> 
> As you mentioned, other Exynos SoCs such as Exynos5250 set
> GPIO properties in DT, as below:
> (./arch/arm/boot/dts/exynos5250-smdk5250.dts)
> 	hdmi {
> 		hpd-gpio = <&gpx3 7 0>;
> 	};
> 	usb at 12110000 {
> 		samsung,vbus-gpio = <&gpx2 6 0>;
> 	};
> 
> However, the situation of Exynos5440 GPIO is different.
> The following bare numbers of GPIO work properly on Exynos5440.
> (./arch/arm/boot/dts/exynos5440-ssdk5440.dts)
> 	pcie0 at 40000000 {
> 		reset-gpio = <5>;
> 	}
> 	pcie0 at 40000000 {
> 		reset-gpio = <22>;
> 	}
> 
> Thomas Abraham is the author of pinctrl driver for EXYNOS5440.
> (./drivers/pinctrl/pinctrl-exynos5440.c)
> 
> Thomas Abraham or Kukjin Kim, can you confirm this?
> If I am wrong, please let me know kindly. :)

This is not about the code working at the moment, it is about
it being correct. The current method you are using would stop
working if something changes in the pinctrl code, and would
not be portable to other SoCs.

	Arnd
