From: tony@atomide.com (Tony Lindgren)
Date: Tue, 10 Dec 2013 10:38:10 -0800
Subject: OMAP still fails - usb phy stuff
In-Reply-To: <20131210130926.GZ4360@n2100.arm.linux.org.uk>
References: <20131210130926.GZ4360@n2100.arm.linux.org.uk>
Message-ID: <20131210183809.GL13171@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [131210 05:10]:
> I still see some OMAP randconfigs failing with this:
> 
> arch/arm/mach-omap2/built-in.o: In function `usbhs_init_phys':
> dss-common.c:(.text+0x1396c): undefined reference to `usb_bind_phy'
> arch/arm/mach-omap2/built-in.o: In function `omap_2430sdp_init':
> dss-common.c:(.init.text+0x6c90): undefined reference to `usb_bind_phy'
> drivers/built-in.o: In function `omap_usb2_remove':
> powercap_sys.c:(.text+0x3520): undefined reference to `usb_remove_phy'
> drivers/built-in.o: In function `omap_usb_power_off':
> powercap_sys.c:(.text+0x3544): undefined reference to `omap_control_usb_phy_power'
> drivers/built-in.o: In function `omap_usb_power_on':
> powercap_sys.c:(.text+0x3568): undefined reference to `omap_control_usb_phy_power'
> drivers/built-in.o: In function `omap_usb2_probe':
> powercap_sys.c:(.text+0x3638): undefined reference to `omap_control_usb_phy_power'
> powercap_sys.c:(.text+0x36d4): undefined reference to `usb_add_phy_dev'
> drivers/built-in.o: In function `omap_usb2_suspend':
> powercap_sys.c:(.text+0x37d0): undefined reference to `omap_control_usb_phy_power'
> powercap_sys.c:(.text+0x37f4): undefined reference to `omap_control_usb_phy_power'
> drivers/built-in.o: In function `omap_usb2_set_comparator':
> powercap_sys.c:(.text+0x3844): undefined reference to `usb_get_phy'
> drivers/built-in.o: In function `isp1704_charger_remove':
> powercap_sys.c:(.text+0x48d5ec): undefined reference to `usb_put_phy'
> drivers/built-in.o: In function `isp1704_charger_probe':
> powercap_sys.c:(.text+0x48d64c): undefined reference to `usb_get_phy'
> powercap_sys.c:(.text+0x48d884): undefined reference to `usb_put_phy'
> drivers/built-in.o: In function `twl4030_bci_probe':
> powercap_sys.c:(.init.text+0x13fd4): undefined reference to `usb_get_phy'
> powercap_sys.c:(.init.text+0x14114): undefined reference to `usb_put_phy'
> 
> Probably caused by over-use of the damned select statement:
> 
> warning: (OMAP_USB2 && TWL4030_USB) selects USB_PHY which has unmet direct dependencies (USB_SUPPORT)
> warning: (OMAP_USB2) selects OMAP_CONTROL_USB which has unmet direct dependencies (USB_SUPPORT && (ARCH_OMAP2PLUS || COMPILE_TEST))
> warning: (OMAP_USB2 && TWL4030_USB) selects USB_PHY which has unmet direct dependencies (USB_SUPPORT)
> warning: (OMAP_USB2) selects OMAP_CONTROL_USB which has unmet direct dependencies (USB_SUPPORT && (ARCH_OMAP2PLUS || COMPILE_TEST))
> 
> You have to wonder why OMAP_USB2 can be enabled when USB_SUPPORT is
> disabled.

Yeah this causes constant randconfig errors. Felipe, I thought you
had some fixes lined up for these few weeks ago already when we
last talked about it?

Regards,

Tony
