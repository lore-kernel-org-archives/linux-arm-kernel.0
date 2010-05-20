From: ben-linux@fluff.org (Ben Dooks)
Date: Thu, 20 May 2010 10:34:52 +0100
Subject: [PATCH 1/4] ARM: S5P6440: Add locking to GPIO calls
Message-ID: <1274348095-9390-1-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the new locking calls to ensure that these are always exclusively
accessing the GPIO registers.

Fixes a possible race between two threads modifying the same GPIO bank,

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/mach-s5p6440/gpio.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5p6440/gpio.c b/arch/arm/mach-s5p6440/gpio.c
index 262dc75..92efc05 100644
--- a/arch/arm/mach-s5p6440/gpio.c
+++ b/arch/arm/mach-s5p6440/gpio.c
@@ -46,6 +46,7 @@ static int s5p6440_gpiolib_rbank_4bit2_input(struct gpio_chip *chip,
 	void __iomem *base = ourchip->base;
 	void __iomem *regcon = base;
 	unsigned long con;
+	unsigned long flags;
 
 	switch (offset) {
 	case 6:
@@ -63,10 +64,14 @@ static int s5p6440_gpiolib_rbank_4bit2_input(struct gpio_chip *chip,
 		break;
 	}
 
+	s3c_gpio_lock(ourchip, flags);
+
 	con = __raw_readl(regcon);
 	con &= ~(0xf << con_4bit_shift(offset));
 	__raw_writel(con, regcon);
 
+	s3c_gpio_unlock(ourchip, flags);
+
 	return 0;
 }
 
@@ -78,6 +83,7 @@ static int s5p6440_gpiolib_rbank_4bit2_output(struct gpio_chip *chip,
 	void __iomem *regcon = base;
 	unsigned long con;
 	unsigned long dat;
+	unsigned long flags;
 	unsigned con_offset  = offset;
 
 	switch (con_offset) {
@@ -96,6 +102,8 @@ static int s5p6440_gpiolib_rbank_4bit2_output(struct gpio_chip *chip,
 		break;
 	}
 
+	s3c_gpio_lock(ourchip, flags);
+
 	con = __raw_readl(regcon);
 	con &= ~(0xf << con_4bit_shift(con_offset));
 	con |= 0x1 << con_4bit_shift(con_offset);
@@ -109,6 +117,8 @@ static int s5p6440_gpiolib_rbank_4bit2_output(struct gpio_chip *chip,
 	__raw_writel(con, regcon);
 	__raw_writel(dat, base + GPIODAT_OFF);
 
+	s3c_gpio_unlock(ourchip, flags);
+
 	return 0;
 }
 
@@ -117,6 +127,7 @@ int s5p6440_gpio_setcfg_4bit_rbank(struct s3c_gpio_chip *chip,
 {
 	void __iomem *reg = chip->base;
 	unsigned int shift;
+	unsigned long flags;
 	u32 con;
 
 	switch (off) {
@@ -142,11 +153,15 @@ int s5p6440_gpio_setcfg_4bit_rbank(struct s3c_gpio_chip *chip,
 		cfg <<= shift;
 	}
 
+	s3c_gpio_lock(chip, flags);
+
 	con = __raw_readl(reg);
 	con &= ~(0xf << shift);
 	con |= cfg;
 	__raw_writel(con, reg);
 
+	s3c_gpio_unlock(chip, flags);
+
 	return 0;
 }
 
-- 
1.6.3.3
