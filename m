From: kbaidarov@dev.rtsoft.ru (Konstantin Baydarov)
Date: Wed, 27 Jun 2012 22:04:32 +0400
Subject: [PATCH v3 0/7] OMAP System Control Module
Message-ID: <4FEB4B30.2040305@dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Hello.

This is a next version of series of patches(based on Eduardo Valentin's patch set) adding a basic support for system control module, on OMAP4+ context. It is a working in progress.

Main changes since previous patch set version:
- Bandgap and usb phy: drivers are now independent from control module driver, they use their own functions to acess scm registers.
- omap-control-core: resources aren't hardcoded, they are specified in dts file.
- omap-control-core: Control module is a built-in driver - added control module select to ARCH_HAS_CONTROL_MODULE and ARCH_OMAP4.
Probably, no configuration option is required!
- omap-control-core: Added early init call that ioremaps control module IOMEM window, this allows access of SCM registers very early, for example from omap_type()
- omap-control-core: Removed device pointer from omap-control-core API arguments, becuase there can be only one instance control
module device.
- omap-control-core: removed omap_control_get, omap_control_readl, omap_control_writel
- omap-control-core: added omap_control_status_read that is used early in omap_type
- Bandgap and usb phy: Added private spinlocks for bandgap and usb drivers.
- Bandgap: Check the type of bandgap dynamically in bandgap driver probe function by reading
omap core control module revision register CONTROL_GEN_CORE_REVISION.
- Bandgap and usb phy: Parent SCM platform device IOMEM resources is used to get the base address of SCM window.
- Bandgap masks defines were moved to drivers/thermal/omap-bandgap.c.

TODO list for bandgap driver:
- Reserve omap-control-core IOMEM window.
- Improve thermal zone definition for OMAP4
- Introduce the thermal zones for OMAP5
