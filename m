From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Fri, 13 Jan 2017 15:35:36 +0800
Subject: [PATCH v3 0/3] media: rc: add support for IR receiver on MT7623 SoC
Message-ID: <1484292939-9454-1-git-send-email-sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

This patchset introduces consumer IR (CIR) support on MT7623 SoC 
that also works on other similar SoCs and implements raw mode for
more compatibility with different protocols. The driver simply
reports the duration of pulses and spaces to rc-core logic to
decode.

Changes since v1:
- change compatible string from "mediatek,mt7623-ir" into 
"mediatek,mt7623-cir"
- use KBUILD_MODNAME to provide consistent device name used in driver.
- remove unused fields in struct mtk_ir.
- use synchronize_irq to give protection between IRQ handler and 
remove handler.
- use devm_rc_allocate_device based on Andi Shyti's work.
- simplify error handling patch with devm_rc_register_device and devm_rc_allocate_device.
- remove unused spinlock.
- add comments about hardware limitation and related workarounds.
- enhance the caculation of sampling period for easiler assigned specific 
value.
- refine git description.
- fix IR message handling between IR hardware and rc-core.

Changes since v2:
- remove extra rc_unregister_device to avoid double frees issue
since rc_unregister_device was used.
- enhance comments description
- remove redundant mtk irq disable/enable pair inside the IRQ handler
- move keymap table property document into a common place

Sean Wang (3):
  Documentation: devicetree: move shared property used by rc into a
    common place
  Documentation: devicetree: Add document bindings for mtk-cir
  media: rc: add driver for IR remote receiver on MT7623 SoC

 .../devicetree/bindings/media/gpio-ir-receiver.txt |   3 +-
 .../devicetree/bindings/media/hix5hd2-ir.txt       |   2 +-
 .../devicetree/bindings/media/mtk-cir.txt          |  23 ++
 Documentation/devicetree/bindings/media/rc.txt     | 116 ++++++++
 .../devicetree/bindings/media/sunxi-ir.txt         |   2 +-
 drivers/media/rc/Kconfig                           |  11 +
 drivers/media/rc/Makefile                          |   1 +
 drivers/media/rc/mtk-cir.c                         | 330 +++++++++++++++++++++
 8 files changed, 485 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/mtk-cir.txt
 create mode 100644 Documentation/devicetree/bindings/media/rc.txt
 create mode 100644 drivers/media/rc/mtk-cir.c

-- 
1.9.1
