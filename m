From: josh.wu@atmel.com (Josh Wu)
Date: Fri, 29 Jun 2012 17:47:53 +0800
Subject: [PATCH v13 0/2] MTD: at91: Add PMECC support for at91 nand flash
 driver
Message-ID: <1340963275-32104-1-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Those patches is based on the l2-mtd.git three.

Changes
since v12,
	fix compile warning.
	fix compile error for sparse compiler:
		drivers/mtd/nand/atmel_nand.c:480:32: error: bad constant expression [sparse]
		drivers/mtd/nand/atmel_nand.c:488:35: error: bad constant expression [sparse]
		drivers/mtd/nand/atmel_nand.c:633:32: error: bad constant expression [sparse]
		drivers/mtd/nand/atmel_nand.c:635:35: error: bad constant expression [sparse]
	   the error is caused by the dynamic 2d array: smu[cap + 2][2 * cap + 1].
           since the smu is allocated when driver is probed, and the length of the smu depend on PMECC correction capablity.
	   so when I declare the type of smu by following line: (cap is declared as const type)
		 int16_t (*smu)[2 * cap + 1];
	   Sparse compiler reports above errors.
	   for fixing this compile error, I use one dimention array instead of 2d array, for instance: all smu[i][j] changes to smu[i * num + j]. num equal to 2 * cap + 1.
	   I tested it in sparse 0.4.4

since v11,
	add documentation for atmel nand reg parameter and one example for PMECC support.
	fix the bug: no error reported when fail to get resoures of PMECC ERRLOC or ROM.
	fix the bug: no correction when ecc data has bit flipped.
	add clearer debug information for data correction.

Josh Wu (2):
  MTD: at91: add dt parameters for Atmel PMECC
  MTD: at91: atmel_nand: Update driver to support Programmable Multibit
    ECC controller

 .../devicetree/bindings/mtd/atmel-nand.txt         |   40 +-
 drivers/mtd/nand/atmel_nand.c                      |  799 +++++++++++++++++++-
 drivers/mtd/nand/atmel_nand_ecc.h                  |  114 ++-
 3 files changed, 949 insertions(+), 4 deletions(-)

-- 
1.7.9.5
