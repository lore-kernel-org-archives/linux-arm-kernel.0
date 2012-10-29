From: vikram186@gmail.com (Vikram Narayanan)
Date: Mon, 29 Oct 2012 22:42:33 +0530
Subject: [PATCH] mfd/syscon: Fix compilation issue when built for imx
Message-ID: <508EB901.1050303@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Compiling for a IMX6Q SoC with imx_v6_v7_defconfig results in the following error

<<<
drivers/mfd/syscon.c:94:15: error: variable 'syscon_regmap_config' has initializer but incomplete type
drivers/mfd/syscon.c:95:2: error: unknown field 'reg_bits' specified in initializer
drivers/mfd/syscon.c:95:2: warning: excess elements in struct initializer [enabled by default]
drivers/mfd/syscon.c:95:2: warning: (near initialization for 'syscon_regmap_config') [enabled by default]
drivers/mfd/syscon.c:96:2: error: unknown field 'val_bits' specified in initializer
drivers/mfd/syscon.c:96:2: warning: excess elements in struct initializer [enabled by default]
drivers/mfd/syscon.c:96:2: warning: (near initialization for 'syscon_regmap_config') [enabled by default]
drivers/mfd/syscon.c:97:2: error: unknown field 'reg_stride' specified in initializer
drivers/mfd/syscon.c:97:2: warning: excess elements in struct initializer [enabled by default]
drivers/mfd/syscon.c:97:2: warning: (near initialization for 'syscon_regmap_config') [enabled by default]
drivers/mfd/syscon.c: In function 'syscon_probe':
drivers/mfd/syscon.c:124:2: error: invalid use of undefined type 'struct regmap_config'
drivers/mfd/syscon.c:125:2: error: implicit declaration of function 'devm_regmap_init_mmio' [-Werror=implicit-function-declaration]
drivers/mfd/syscon.c:125:17: warning: assignment makes pointer from integer without a cast [enabled by default]
cc1: some warnings being treated as errors
>>>

The datastructures are guarded with CONFIG_REGMAP in linux/regmap.h
Selecting REGMAP solves the compilation error.

Signed-off-by: Vikram Narayanan <vikram186@gmail.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
---
I'm not sure whether this is the right way to fix, or this is already fixed.
Please keep me in Cc while replying. I'm not subscribed to the list.

 drivers/mfd/Kconfig |   1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index acab3ef..641d191 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1029,6 +1029,7 @@ config MFD_STA2X11
 config MFD_SYSCON
 	bool "System Controller Register R/W Based on Regmap"
 	depends on OF
+	select REGMAP
 	select REGMAP_MMIO
 	help
 	  Select this option to enable accessing system control registers
--
