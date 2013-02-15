From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 15 Feb 2013 16:10:52 +0000
Subject: [V2 0/8] usb: ehci: more bus glues as separate modules
In-Reply-To: <1360923853-7875-1-git-send-email-manjunath.goudar@linaro.org>
References: <1360923853-7875-1-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <201302151610.52523.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 15 February 2013, Manjunath Goudar wrote:
> Separate the SOC On-Chip host controller driver from ehci-hcd
> host code into its own driver module
> 
> V2:
> Modified the patches, based on the first version review comments  
> 

The series looks good to me now, great work!

Please add my 'Acked-by: Arnd Bergmann <arnd@arndb.de>' for each patch.

Alan, Greg: I realize that it's too late to take the entire series for
3.9, but with the move of more ARM platforms to CONFIG_ARCH_MULTIPLATFORM,
it is now possible to enable OMAP, VT8500 and ORION concurrently, along
with the ones that are already moved out.

You should have a patch for OMAP, but that has not made it into linux-next
yet. It would be good to have at least two out the three I mentioned
merged into 3.9, in order to keep allyesconfig building, and take the
rest after the merge window, for integration into 3.10.

What I get today with linux-next ARM allyesconfig is this:

/home/arnd/arm-soc/drivers/usb/host/ehci-hcd.c:1277:0: warning: "PLATFORM_DRIVER" redefined [enabled by default]
 #define PLATFORM_DRIVER  ehci_orion_driver
 ^
/home/arnd/arm-soc/drivers/usb/host/ehci-hcd.c:1257:0: note: this is the location of the previous definition
 #define        PLATFORM_DRIVER         ehci_hcd_omap_driver
 ^
/home/arnd/arm-soc/drivers/usb/host/ehci-hcd.c:1297:0: warning: "PLATFORM_DRIVER" redefined [enabled by default]
 #define PLATFORM_DRIVER  vt8500_ehci_driver
 ^
/home/arnd/arm-soc/drivers/usb/host/ehci-hcd.c:1277:0: note: this is the location of the previous definition
 #define PLATFORM_DRIVER  ehci_orion_driver
 ^
/home/arnd/arm-soc/drivers/usb/host/ehci-hcd.c:1277:0: warning: "PLATFORM_DRIVER" redefined [enabled by default]
 #define PLATFORM_DRIVER  ehci_orion_driver
 ^
/home/arnd/arm-soc/drivers/usb/host/ehci-hcd.c:1257:0: note: this is the location of the previous definition
 #define        PLATFORM_DRIVER         ehci_hcd_omap_driver
 ^
/home/arnd/arm-soc/drivers/usb/host/ehci-hcd.c:1297:0: warning: "PLATFORM_DRIVER" redefined [enabled by default]
 #define PLATFORM_DRIVER  vt8500_ehci_driver
 ^
/home/arnd/arm-soc/drivers/usb/host/ehci-hcd.c:1277:0: note: this is the location of the previous definition
 #define PLATFORM_DRIVER  ehci_orion_driver
 ^

In 3.10, we are going to need spear and s5p as well, possibly also atmel,
mv and tegra, but Manjunath has done all the ARM platforms now (the tegra
patch still has issues).

	Arnd
