From: jianxin.pan@amlogic.com (Jianxin Pan)
Date: Fri, 2 Nov 2018 00:42:19 +0800
Subject: [PATCH v6 0/2] mtd: rawnand: meson: add Amlogic NAND driver support
Message-ID: <1541090542-19618-1-git-send-email-jianxin.pan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These two patches try to add initial NAND driver support for Amlogic Meson
SoCs, current it has been tested on GXL(p212) and AXG(s400) platform.

Changes since v5 at [6]:
 - use instr->delay_ns in exec_op() to caculate the delay cycle
 - delete struct meson_nfc_info_format and use macros instead
 - delete "is_scramble" in struct meson_nfc_nand_chip
 - add WARN_ON_ONCE() for chip > MAX_CE_NUM
 - drop param *mtd* or struct *nfc* if param *nand exist
 - substitute set_data_oob and get_data_oob for prase_data_oob and format_data_oob
 - split timings caculating and setting timings
 - move info_buf and data_buf to struct meson_nfc_nand_chip

Changes since v4 at [5]:
 - remove the initial default divider(CLK_DIV_MASK) in meson_nfc_clk_init()
 - dt-bindings: remove staus, add "rx" and "tx" clock, and node rename

Changes since v3 at [4]:
 - remove partition table and some used props from dt-bindings 

Changes since v2 at [3]:
 - remove some hardcode time value, like twb
 - use dev wait R/B instead of nand_soft_waitrdy
 - implement nfc ecc init by ecc helper
 - rework nfc buffer init to register the maximun buffer when several chips
 - free nfc buffer when error and cleanup
 - add variable to teack all the already assigned CS lines
 - fix mtd->name use the first cs line only
 - remove dt "nand-enable-scrambler" and use NAND_NEED_SCRAMBLING instead.
 - move setuping ECC fileds after the identification phase
 - use nand_scan() and attach_chip()
 - check one event to return IRQ_NONE
 - delete cast when of_device_get_match_data
 - use nand_controller_init() helper
 - remove nfc driver complains when calling devm_ioremap_resource
 - clear irqs before setting up irq handler

Changes since v1 at [1]:
  - adopt property amlogic,nand-enable-scrambler - thanks Martin
  - drop nand pins in DT
  - convert clk access to emmc clkc model 
  - fix regiser field definition alignment
  - drop nand-user-mode 
  - parse cs id from DT
  - rework n2m, m2n function
  - explain why insert two "IDLE" command
  - implement exec_op()
  - drop meson_nfc_get_nand_chip_dts()
  - release resource once error occur in meson_nfc_nand_chips_init(), 
  - call nand_cleanup(nand) once mtd_device_register fail

Items not addressed ( or confirmed ) in this version:
  - convert to ECC conf helper() 
  - convert to dma coherent API
  - how to construct mtd->name

[1] https://lkml.kernel.org/r/20180613161314.14894-1-yixun.lan at amlogic.com
[2] https://lkml.kernel.org/r/20180712211244.11428-1-yixun.lan at amlogic.com
[3] https://lkml.kernel.org/r/20180719094612.5833-1-yixun.lan at amlogic.com
[4] https://lkml.kernel.org/r/1536317831-58056-1-git-send-email-jianxin.pan at amlogic.com/
[5] https://lore.kernel.org/r/1537433449-65213-2-git-send-email-jianxin.pan at amlogic.com/
[6] https://lore.kernel.org/r/1539839345-14021-1-git-send-email-jianxin.pan at amlogic.com
Liang Yang (2):
  dt-bindings: nand: meson: add Amlogic NAND controller driver
  mtd: rawnand: meson: add support for Amlogic NAND flash controller

 .../devicetree/bindings/mtd/amlogic,meson-nand.txt |   60 +
 drivers/mtd/nand/raw/Kconfig                       |   10 +
 drivers/mtd/nand/raw/Makefile                      |    1 +
 drivers/mtd/nand/raw/meson_nand.c                  | 1360 ++++++++++++++++++++
 4 files changed, 1431 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
 create mode 100644 drivers/mtd/nand/raw/meson_nand.c

-- 
1.9.1
