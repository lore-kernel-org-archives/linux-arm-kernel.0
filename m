From: wangzhou1@hisilicon.com (Zhou Wang)
Date: Mon, 12 Jan 2015 15:28:52 +0800
Subject: [PATCH v6 0/2] mtd: hisilicon: add a new driver for NAND controller
 of hisilicon hip04 Soc
Message-ID: <1421047734-30818-1-git-send-email-wangzhou1@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a repeated version patchset with E-mail address changed in signed-off-by.

This patchset adds the support for NAND controller of hisilicon hip04 Soc.
The NAND controller IP was developed by hisilicon and needs a new driver to
support it. This patchset is based on l2-mtd/master.

I have tested this NAND flash controller driver in Hip04 D01 board using MTD
test modules. All testes passed except mtd_nandbiterrs. The reason is that this
NAND controller doesn't support to write raw page in ECC mode. In the test of
mtd_nandbiterrs, when rewriting raw page(with some bits changed) back, this NAND
controller will also produce ECC codes and write into NAND flash OOB area. As
ECC codes in OOB area have been broken, read error comes out as follow.

Changes in v6:
- Change E-mail address in signed-off-by to "wangzhou1 at hisilicon.com"

Changes in v5:
- Make modifications according to the comments from Brian, thanks a lot.
- Add hisi_nand_read_oob callback function.

Changes in v4:
- Add mtd->dev.parent = &pdev->dev, thanks Frans Klaver.  

Changes in v3:
- Modify code to eliminate some code style warnings.
- Add ecc-bits input check.
- Avoid using waterfall style in hisi_nfc_cmdfunc().

Changes in v2:
- Remove the patch for device tree, now patchset only has the driver and its

device tree binding documentation.
- Change the file name: hisi_nand.c to hisi504_nand.c.

Changes in v1:
- Remove callback functions out of struct hinfc_host, and call them directly
  in relative functions.
- Change hinfc_read and hinfc_write from macros to inline functions.
- Instead of putting pointers, embed struct nand_chip and struct mtd_info
  in struct hinfc_host directly.
- rewrite some unclear lines in device tree binding document, correct
  some code style error.

Link on v4:
- https://lkml.org/lkml/2014/11/4/377
Link on v3:
- https://lkml.org/lkml/2014/10/28/386
Link on v2:
- https://www.mail-archive.com/linux-kernel at vger.kernel.org/msg750071.html
Link on v1:
- https://lkml.org/lkml/2014/7/15/198

Zhou Wang (2):
  mtd: hisilicon: add a new NAND controller driver for hisilicon hip04 Soc
  mtd: hisilicon: add device tree binding documentation

 .../devicetree/bindings/mtd/hisi504-nand.txt       |  48 ++
 drivers/mtd/nand/Kconfig                           |   5 +
 drivers/mtd/nand/Makefile                          |   1 +
 drivers/mtd/nand/hisi504_nand.c                    | 907 +++++++++++++++++++++
 4 files changed, 961 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/hisi504-nand.txt
 create mode 100644 drivers/mtd/nand/hisi504_nand.c

-- 
1.9.1
