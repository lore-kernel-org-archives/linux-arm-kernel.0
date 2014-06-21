From: bay@hackerdom.ru (Alexander Bersenev)
Date: Sat, 21 Jun 2014 17:04:01 +0600
Subject: [PATCH v10 0/5] ARM: sunxi: Add support for consumer infrared devices
Message-ID: <1403348646-31091-1-git-send-email-bay@hackerdom.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch introduces Consumer IR(CIR) support for sunxi boards.

This is based on Alexsey Shestacov's work based on the original driver 
supplied by Allwinner.

Signed-off-by: Alexander Bersenev <bay@hackerdom.ru>
Signed-off-by: Alexsey Shestacov <wingrime@linux-sunxi.org>

---
Changes since version 1: 
 - Fix timer memory leaks 
 - Fix race condition when driver unloads while interrupt handler is active
 - Support Cubieboard 2(need testing)

Changes since version 2:
- More reliable keydown events
- Documentation fixes
- Rename registers accurding to A20 user manual
- Remove some includes, order includes alphabetically
- Use BIT macro
- Typo fixes

Changes since version 3:
- Split the patch on smaller parts
- More documentation fixes
- Add clock-names in DT
- Use devm_clk_get function to get the clocks
- Removed gpios property from ir's DT
- Changed compatible from allwinner,sunxi-ir to allwinner,sun7i-a20-ir in DT
- Use spin_lock_irq instead spin_lock_irqsave in interrupt handler
- Add myself in the copyright ;)
- Coding style and indentation fixes

Changes since version 4:
- Try to fix indentation errors by sending patches with git send-mail

Changes since version 5:
- More indentation fixes
- Make patches pass checkpatch with --strict option
- Replaced magic numbers with defines(patch by Priit Laes)
- Fixed oops on loading(patch by Hans de Goede)

Changes since version 6:
- Removed constants from code
- Better errrors handling on loading
- Renamed sunxi-ir.c to sunxi-cir.c
- Changed description of second commit
- Order entries in dts and dtsi by register address
- Code style fixes

Changes since version 7:
- Removed a couple of blank lines in code
- Delay interrupts init until we are ready to handle them
- Increased the reported duration of each pulse by one
- Refactored defines

Changes since version 8:
- Split the DT patch to three
- Code style fixes

Changes since version 9:
- Rebase patches on 3.16-rc1

Alexander Bersenev (5):
  ARM: sunxi: Add documentation for sunxi consumer infrared devices
  [media] rc: add sunxi-ir driver
  ARM: sunxi: Add pins for IR controller on A20 to dtsi
  ARM: sunxi: Add IR controllers on A20 to dtsi
  ARM: sunxi: Enable IR controller on cubieboard 2 and cubietruck in
    dts

 .../devicetree/bindings/media/sunxi-ir.txt         |   23 ++
 arch/arm/boot/dts/sun7i-a20-cubieboard2.dts        |    6 +
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts         |    6 +
 arch/arm/boot/dts/sun7i-a20.dtsi                   |   32 ++
 drivers/media/rc/Kconfig                           |   10 +
 drivers/media/rc/Makefile                          |    1 +
 drivers/media/rc/sunxi-cir.c                       |  318 ++++++++++++++++++++
 7 files changed, 396 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/sunxi-ir.txt
 create mode 100644 drivers/media/rc/sunxi-cir.c
