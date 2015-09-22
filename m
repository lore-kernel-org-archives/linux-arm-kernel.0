From: simon.guinot@sequanux.org (Simon Guinot)
Date: Tue, 22 Sep 2015 10:24:04 +0200
Subject: [PATCH v5 0/4] Add DT support for netxbig LEDs
Message-ID: <1442910248-11380-1-git-send-email-simon.guinot@sequanux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch series adds DT support for the LEDs found on the Kirkwood-based
LaCie boards 2Big and 5Big Network v2.

Changes for v2:
- Check timer mode value retrieved from DT.
- In netxbig_leds_get_of_pdata, don't use unsigned long variables to get
  timer delay values from DT with function of_property_read_u32_index.
  Instead, use a temporary u32 variable. This allows to silence a static
  checker warning.
- Make timer property optional in the binding documentation. It is now
  aligned with the driver code.

Changes for v3:
- Fix pointer usage with the temporary u32 variable while calling
  of_property_read_u32_index.

Changes for v4:
- In DT binding document netxbig-gpio-ext.txt, detail byte order for
  registers and latch mechanism for "enable-gpio".
- In leds-netxbig.c, add some error messages.
- In leds-netxbig.c, fix some "sizeof" style issues.
- In leds-netxbig.c, in netxbig_leds_get_of_pdata(), move the
  of_property_read_string() calls after the error-prone checks.
- Add some Acked-by.

Changes for v5:
- Rename DT property "bright-max" into the more common "max-brightness".
- Make use of the "max-brightness" DT property. Instead of counting the
  data pins of the GPIO extension bus, use "max-brightness" to get the
  maximum brightness level.
- Add a patch to convert the leds-netxbig driver to the devm_ functions.

Thanks,

Simon

Simon Guinot (4):
  leds: netxbig: add device tree binding
  ARM: Kirkwood: add LED DT entries for netxbig boards
  ARM: mvebu: remove static LED setup for netxbig boards
  leds: netxbig: convert to use the devm_ functions

 .../devicetree/bindings/gpio/netxbig-gpio-ext.txt  |  22 ++
 .../devicetree/bindings/leds/leds-netxbig.txt      |  92 ++++++
 arch/arm/boot/dts/kirkwood-net5big.dts             |  60 ++++
 arch/arm/boot/dts/kirkwood-netxbig.dtsi            |  80 ++++++
 arch/arm/mach-mvebu/Kconfig                        |   7 -
 arch/arm/mach-mvebu/Makefile                       |   1 -
 arch/arm/mach-mvebu/board.h                        |  21 --
 arch/arm/mach-mvebu/kirkwood.c                     |   4 -
 arch/arm/mach-mvebu/netxbig.c                      | 191 -------------
 drivers/leds/leds-netxbig.c                        | 313 ++++++++++++++++-----
 include/dt-bindings/leds/leds-netxbig.h            |  18 ++
 .../linux/platform_data/leds-kirkwood-netxbig.h    |   1 +
 12 files changed, 514 insertions(+), 296 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/netxbig-gpio-ext.txt
 create mode 100644 Documentation/devicetree/bindings/leds/leds-netxbig.txt
 delete mode 100644 arch/arm/mach-mvebu/board.h
 delete mode 100644 arch/arm/mach-mvebu/netxbig.c
 create mode 100644 include/dt-bindings/leds/leds-netxbig.h

-- 
2.1.4
