From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Sun, 1 May 2016 15:17:46 +0200
Subject: [RFT PATCH 0/3] usb: misc: usb3503: Fix missing device when TFTP
 booting
In-Reply-To: <57247E50.1020000@xs4all.nl>
References: <1461927591-7864-1-git-send-email-k.kozlowski@samsung.com>
 <57247E50.1020000@xs4all.nl>
Message-ID: <20160501131746.GA16766@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 30, 2016 at 11:43:44AM +0200, Hans Verkuil wrote:
> Hi Krzysztof,
> 
> On 04/29/2016 12:59 PM, Krzysztof Kozlowski wrote:
> > Hi,
> > 
> > Patches are independent, please pick up as you wish.
> > 
> > However all of them are needed to solve the issue, so I am sending
> > everything together for easier testng.
> > 
> > 
> > Problem
> > =======
> > When Odroid U3 (usb3503 + smsc95xx + max77686) boots from network (TFTP),
> > the usb3503 does not show up in "lsusb". Hard-reset is required, e.g.
> > by suspend to RAM. The actual TFTP boot does not have to happen. Just
> > "usb start" from U-Boot is sufficient.
> > 
> > 
> > Solution
> > ========
> > Perform real hardware reset (including regulator off/on) when probing.
> > 
> > 
> > Tested on Odroid U3 so far. Please kindly test on X2 and other
> > configurations and bootloaders.
> 
> Against which kernel git repo is this patch?
> 
> I did apply this patch series first:
> 
> http://www.spinics.net/lists/arm-kernel/msg500764.html

Indeed it is based on above patchset... and on linux-next. It touches
multiple trees so next seems the easiest base.

> 
> followed by this patch series.
> 
> I've tested with both 4.6.0-rc2 and -rc5, but in all cases (even without
> applying these patches!) the boot sequence hangs here:
> 
> ...
> [drm] Exynos DRM: using 12c10000.mixer device for DMA mapping operations
> exynos-drm exynos-drm: bound 12c10000.mixer (ops mixer_component_ops)
> exynos-drm exynos-drm: bound 12d00000.hdmi (ops hdmi_component_ops)
> [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
> [drm] No driver support for vblank timestamp query.
> Console: switching to colour frame buffer device 240x67
> exynos-drm exynos-drm: fb0:  frame buffer device
> [drm] Initialized exynos 1.0.0 20110530 on minor 0
> brd: module loaded
> loop: module loaded
> s3c64xx-spi 13930000.spi: spi bus clock parent not specified, using clock
> at index 0 as parent
> s3c64xx-spi 13930000.spi: number of chip select lines not specified,
> assuming 1 chip select line
> tun: Universal TUN/TAP device driver, 1.6
> tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
> usbcore: registered new interface driver asix
> usbcore: registered new interface driver ax88179_178a
> usbcore: registered new interface driver cdc_ether
> usbcore: registered new interface driver smsc95xx
> usbcore: registered new interface driver cdc_ncm
> dwc2 12480000.hsotg: Specified GNPTXFDEP=1024 > 768
> dwc2 12480000.hsotg: EPs: 16, dedicated fifos, 7808 entries in SPRAM
> ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> ehci-exynos: EHCI EXYNOS driver
> exynos-ehci 12580000.ehci: EHCI Host Controller
> exynos-ehci 12580000.ehci: new USB bus registered, assigned bus number 1
> exynos-ehci 12580000.ehci: irq 51, io mem 0x12580000
> exynos-ehci 12580000.ehci: USB 2.0 started, EHCI 1.00
> usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
> usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> usb usb1: Product: EHCI Host Controller
> usb usb1: Manufacturer: Linux 4.6.0-rc5-odroid ehci_hcd
> usb usb1: SerialNumber: 12580000.ehci
> hub 1-0:1.0: USB hub found
> hub 1-0:1.0: 3 ports detected
> ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
> ohci-exynos: OHCI EXYNOS driver
> usbcore: registered new interface driver usb-storage
> usb3503 0-0008: switched to HUB mode
> usb3503 0-0008: usb3503_probe: probed in hub mode
> using random self ethernet address
> using random host ethernet address
> usb0: HOST MAC 66:79:ef:11:72:85
> usb0: MAC 1e:66:f2:66:8e:2a
> using random self ethernet address
> using random host ethernet address
> g_ether gadget: Ethernet Gadget, version: Memorial Day 2008
> g_ether gadget: g_ether ready
> dwc2 12480000.hsotg: bound driver g_ether
> mousedev: PS/2 mouse device common for all mice
> max77686-rtc max77686-rtc: rtc core: registered max77686-rtc as rtc0
> i2c /dev entries driver
> s5p-fimc-md camera: Entity type for entity FIMC.0 was not initialized!
> usb 1-2: new high-speed USB device number 2 using exynos-ehci
> usb 1-2: New USB device found, idVendor=0424, idProduct=9730
> usb 1-2: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> smsc95xx v1.0.4
> smsc95xx 1-2:1.0 eth0: register 'smsc95xx' at usb-12580000.ehci-2, smsc95xx
> USB 2.0 Ethernet, c2:22:09:f2:5f:e8
> usb 1-3: new high-speed USB device number 3 using exynos-ehci
> usb 1-3: New USB device found, idVendor=0424, idProduct=3503
> usb 1-3: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> hub 1-3:1.0: USB hub found
> hub 1-3:1.0: 3 ports detected
> 
> No oops, no nothing. It's just sitting there.

Apparently you have encountered different issue. sysrq with 'l' might be
useful.

> Is this a regression that was introduced in 4.6? Or is there some special
> new config that needs to be turned on first in 4.6?

I think it was like that for looong time... although I did not use
netboot before on that target.

> I've been running
> 4.5.0-rc3 before this, but I can't apply these patches there because there
> is no drivers/regulator/max77686-regulator.c in 4.5.

In that case skip the regulator patch or apply it for
drivers/regulator/max77686.c driver.

Best regards,
Krzysztof
