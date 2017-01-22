From: f.fainelli@gmail.com (Florian Fainelli)
Date: Sun, 22 Jan 2017 10:42:13 -0800
Subject: [PATCH 00/22] Conversion of ARMv4 Gemini to DT and multiplatform
In-Reply-To: <20170122121506.9995-1-linus.walleij@linaro.org>
References: <20170122121506.9995-1-linus.walleij@linaro.org>
Message-ID: <8e705d3a-ff99-23b2-c4c9-2edccf134cac@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/22/2017 04:15 AM, Linus Walleij wrote:
> I got a Gemini platform from Florian Fainelli over at OpenWRT
> some time back. I finally got around to "future-proofing" the
> platform, which was the idea when he paintakingly sent the box
> over to me.

I would have happily tested that series ;) thanks a lot for making it
happen!

> 
> This is the result: Gemini is converted to device tree and
> multiplatform, all existing drivers are rewritten into their
> proper subsystems and the old board-specific and machine-specific
> code is deleted.
> 
> I would ideally like the irqchip, clocksource, gpio, rtc and MTD
> patches (and bindings) to simply be merged into the respective
> subsystem and the remaining ARM/ARM SoC patches funnelled to the
> ARM SoC tree in a single pull request, lock stock and barrel,
> with changes to board files and DTS additions in one go. But I
> guess I could also switch the DTS files to a separate branch.
> 
> The OpenWRT tree still have a whole bunch of significant out-of
> tree drivers:
> 
> - Watchdog
> - GMAC (ethernet)

Been wondering about the GMAC driver a little bit, and it does not
appear to be neither a Synopsys/Designware core (although not 100%
sure), nor the ftgmac100 either.

This submission does appear to be in a good shape:
https://lwn.net/Articles/437889/

> - FOT2G USB EHCI host
> - PATA
> - PCI
> 
> But I do not see any big obstacle in porting these over to be
> probed from the device tree and upstreamed on top of this patch
> series. I might tinker with it if I get time.
> 
> The out-of-tree code can be found here:
> http://git.openwrt.org/?p=openwrt.git;a=tree;f=target/linux/gemini;h=b74c3d8f0100e2ac8a4d71c4d23c082db2993e63;hb=HEAD
> 
> Linus Walleij (22):
>   ARM: gemini: convert to MULTI_IRQ_HANDLER
>   irqchip: DT bindings for Cortina Gemini irqchip
>   irqchip: add a driver for Cortina Gemini
>   clocksource: add DT bindings for Cortina Gemini
>   clocksource: Add driver for the Cortina Gemini
>   gpio: add DT bindings for Cortina Gemini GPIO
>   gpio: Add a driver for Cortina Systems Gemini GPIO
>   rtc: Add device tree probing to the Gemini driver
>   mtd: add DT bindings for the Cortina Systems Gemini Flash
>   mtd: physmap_of: add a hook for Gemini flash probing
>   ARM: dts: add top-level DT bindings for Cortina Gemini
>   ARM: gemini: DT for the Cortina Gemini SoC platforms
>   ARM: dts: add device tree for Gemini SoC and SQ201
>   ARM: dts: add a devicetree for Raidsonic NAS IB-4220-B
>   ARM: dts: add a devicetree for Teltonika RUT1xx
>   ARM: dts: add a devicetree for Wiliboard WBD-111
>   ARM: dts: add a devicetree for Wiliboard WBD-222
>   ARM: gemini: delete all boardfiles
>   ARM: gemini: switch to sparse IRQs
>   ARM: gemini: select ARM_PATCH_PHYS_VIRT and AUTO_ZRELADDR
>   ARM: gemini: convert to ARMv4 multiplatform
>   ARM: configs: add a gemini defconfig
> 
>  Documentation/devicetree/bindings/arm/gemini.txt   |  58 +++++
>  .../bindings/gpio/cortina,gemini-gpio.txt          |  24 ++
>  .../cortina,gemini-interrupt-controller.txt        |  22 ++
>  .../bindings/mtd/cortina,gemini-flash.txt          |  24 ++
>  .../devicetree/bindings/rtc/cortina,gemini.txt     |  14 ++
>  .../bindings/timer/cortina,gemini-timer.txt        |  22 ++
>  arch/arm/Kconfig                                   |   9 -
>  arch/arm/boot/dts/Makefile                         |   6 +
>  arch/arm/boot/dts/gemini-nas4220b.dts              |  68 +++++
>  arch/arm/boot/dts/gemini-rut1xx.dts                |  63 +++++
>  arch/arm/boot/dts/gemini-sq201.dts                 |  94 +++++++
>  arch/arm/boot/dts/gemini-wbd111.dts                | 101 ++++++++
>  arch/arm/boot/dts/gemini-wbd222.dts                | 101 ++++++++
>  arch/arm/boot/dts/gemini.dtsi                      |  96 +++++++
>  arch/arm/configs/gemini_defconfig                  |  63 +++++
>  arch/arm/mach-gemini/Kconfig                       |  52 +---
>  arch/arm/mach-gemini/Makefile                      |  15 +-
>  arch/arm/mach-gemini/Makefile.boot                 |   9 -
>  arch/arm/mach-gemini/board-dt.c                    |  62 +++++
>  arch/arm/mach-gemini/board-nas4220b.c              | 106 --------
>  arch/arm/mach-gemini/board-rut1xx.c                |  92 -------
>  arch/arm/mach-gemini/board-wbd111.c                | 133 ----------
>  arch/arm/mach-gemini/board-wbd222.c                | 133 ----------
>  arch/arm/mach-gemini/common.h                      |  33 ---
>  arch/arm/mach-gemini/devices.c                     | 118 ---------
>  arch/arm/mach-gemini/gpio.c                        | 231 -----------------
>  arch/arm/mach-gemini/idle.c                        |  31 ---
>  arch/arm/mach-gemini/include/mach/entry-macro.S    |  33 ---
>  arch/arm/mach-gemini/include/mach/global_reg.h     | 278 ---------------------
>  arch/arm/mach-gemini/include/mach/hardware.h       |  71 ------
>  arch/arm/mach-gemini/include/mach/irqs.h           |  53 ----
>  arch/arm/mach-gemini/include/mach/uncompress.h     |  42 ----
>  arch/arm/mach-gemini/irq.c                         | 105 --------
>  arch/arm/mach-gemini/mm.c                          |  82 ------
>  arch/arm/mach-gemini/reset.c                       |  25 --
>  drivers/clocksource/Kconfig                        |  10 +
>  drivers/clocksource/Makefile                       |   1 +
>  .../time.c => drivers/clocksource/timer-gemini.c   | 168 ++++++++-----
>  drivers/gpio/Kconfig                               |   9 +
>  drivers/gpio/Makefile                              |   1 +
>  drivers/gpio/gpio-gemini.c                         | 236 +++++++++++++++++
>  drivers/irqchip/Makefile                           |   1 +
>  drivers/irqchip/irq-gemini.c                       | 190 ++++++++++++++
>  drivers/mtd/maps/Kconfig                           |  10 +
>  drivers/mtd/maps/Makefile                          |   3 +
>  drivers/mtd/maps/physmap_of.c                      |   9 +-
>  drivers/mtd/maps/physmap_of_gemini.c               | 120 +++++++++
>  drivers/mtd/maps/physmap_of_gemini.h               |  16 ++
>  drivers/rtc/rtc-gemini.c                           |   7 +
>  49 files changed, 1545 insertions(+), 1705 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/gemini.txt
>  create mode 100644 Documentation/devicetree/bindings/gpio/cortina,gemini-gpio.txt
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/cortina,gemini-interrupt-controller.txt
>  create mode 100644 Documentation/devicetree/bindings/mtd/cortina,gemini-flash.txt
>  create mode 100644 Documentation/devicetree/bindings/rtc/cortina,gemini.txt
>  create mode 100644 Documentation/devicetree/bindings/timer/cortina,gemini-timer.txt
>  create mode 100644 arch/arm/boot/dts/gemini-nas4220b.dts
>  create mode 100644 arch/arm/boot/dts/gemini-rut1xx.dts
>  create mode 100644 arch/arm/boot/dts/gemini-sq201.dts
>  create mode 100644 arch/arm/boot/dts/gemini-wbd111.dts
>  create mode 100644 arch/arm/boot/dts/gemini-wbd222.dts
>  create mode 100644 arch/arm/boot/dts/gemini.dtsi
>  create mode 100644 arch/arm/configs/gemini_defconfig
>  delete mode 100644 arch/arm/mach-gemini/Makefile.boot
>  create mode 100644 arch/arm/mach-gemini/board-dt.c
>  delete mode 100644 arch/arm/mach-gemini/board-nas4220b.c
>  delete mode 100644 arch/arm/mach-gemini/board-rut1xx.c
>  delete mode 100644 arch/arm/mach-gemini/board-wbd111.c
>  delete mode 100644 arch/arm/mach-gemini/board-wbd222.c
>  delete mode 100644 arch/arm/mach-gemini/common.h
>  delete mode 100644 arch/arm/mach-gemini/devices.c
>  delete mode 100644 arch/arm/mach-gemini/gpio.c
>  delete mode 100644 arch/arm/mach-gemini/idle.c
>  delete mode 100644 arch/arm/mach-gemini/include/mach/entry-macro.S
>  delete mode 100644 arch/arm/mach-gemini/include/mach/global_reg.h
>  delete mode 100644 arch/arm/mach-gemini/include/mach/hardware.h
>  delete mode 100644 arch/arm/mach-gemini/include/mach/irqs.h
>  delete mode 100644 arch/arm/mach-gemini/include/mach/uncompress.h
>  delete mode 100644 arch/arm/mach-gemini/irq.c
>  delete mode 100644 arch/arm/mach-gemini/mm.c
>  delete mode 100644 arch/arm/mach-gemini/reset.c
>  rename arch/arm/mach-gemini/time.c => drivers/clocksource/timer-gemini.c (55%)
>  create mode 100644 drivers/gpio/gpio-gemini.c
>  create mode 100644 drivers/irqchip/irq-gemini.c
>  create mode 100644 drivers/mtd/maps/physmap_of_gemini.c
>  create mode 100644 drivers/mtd/maps/physmap_of_gemini.h
> 

-- 
Florian
