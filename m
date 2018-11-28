From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Wed, 28 Nov 2018 11:12:13 +0000
Subject: [PATCH 8/8] ARM: sa1111: remove legacy GPIO interfaces
In-Reply-To: <20181128111041.GG30658@n2100.armlinux.org.uk>
Message-ID: <E1gRxlN-0001vq-Lm@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have migrated all users of the legacy private SA1111 gpio
interfaces, we can remove these redundant GPIO interfaces.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/common/sa1111.c               | 59 ----------------------------------
 arch/arm/include/asm/hardware/sa1111.h |  4 ---
 2 files changed, 63 deletions(-)

diff --git a/arch/arm/common/sa1111.c b/arch/arm/common/sa1111.c
index a2c878769eaf..45412d21aa6b 100644
--- a/arch/arm/common/sa1111.c
+++ b/arch/arm/common/sa1111.c
@@ -1282,65 +1282,6 @@ int sa1111_get_audio_rate(struct sa1111_dev *sadev)
 }
 EXPORT_SYMBOL(sa1111_get_audio_rate);
 
-void sa1111_set_io_dir(struct sa1111_dev *sadev,
-		       unsigned int bits, unsigned int dir,
-		       unsigned int sleep_dir)
-{
-	struct sa1111 *sachip = sa1111_chip_driver(sadev);
-	unsigned long flags;
-	unsigned int val;
-	void __iomem *gpio = sachip->base + SA1111_GPIO;
-
-#define MODIFY_BITS(port, mask, dir)		\
-	if (mask) {				\
-		val = readl_relaxed(port);	\
-		val &= ~(mask);			\
-		val |= (dir) & (mask);		\
-		writel_relaxed(val, port);	\
-	}
-
-	spin_lock_irqsave(&sachip->lock, flags);
-	MODIFY_BITS(gpio + SA1111_GPIO_PADDR, bits & 15, dir);
-	MODIFY_BITS(gpio + SA1111_GPIO_PBDDR, (bits >> 8) & 255, dir >> 8);
-	MODIFY_BITS(gpio + SA1111_GPIO_PCDDR, (bits >> 16) & 255, dir >> 16);
-
-	MODIFY_BITS(gpio + SA1111_GPIO_PASDR, bits & 15, sleep_dir);
-	MODIFY_BITS(gpio + SA1111_GPIO_PBSDR, (bits >> 8) & 255, sleep_dir >> 8);
-	MODIFY_BITS(gpio + SA1111_GPIO_PCSDR, (bits >> 16) & 255, sleep_dir >> 16);
-	spin_unlock_irqrestore(&sachip->lock, flags);
-}
-EXPORT_SYMBOL(sa1111_set_io_dir);
-
-void sa1111_set_io(struct sa1111_dev *sadev, unsigned int bits, unsigned int v)
-{
-	struct sa1111 *sachip = sa1111_chip_driver(sadev);
-	unsigned long flags;
-	unsigned int val;
-	void __iomem *gpio = sachip->base + SA1111_GPIO;
-
-	spin_lock_irqsave(&sachip->lock, flags);
-	MODIFY_BITS(gpio + SA1111_GPIO_PADWR, bits & 15, v);
-	MODIFY_BITS(gpio + SA1111_GPIO_PBDWR, (bits >> 8) & 255, v >> 8);
-	MODIFY_BITS(gpio + SA1111_GPIO_PCDWR, (bits >> 16) & 255, v >> 16);
-	spin_unlock_irqrestore(&sachip->lock, flags);
-}
-EXPORT_SYMBOL(sa1111_set_io);
-
-void sa1111_set_sleep_io(struct sa1111_dev *sadev, unsigned int bits, unsigned int v)
-{
-	struct sa1111 *sachip = sa1111_chip_driver(sadev);
-	unsigned long flags;
-	unsigned int val;
-	void __iomem *gpio = sachip->base + SA1111_GPIO;
-
-	spin_lock_irqsave(&sachip->lock, flags);
-	MODIFY_BITS(gpio + SA1111_GPIO_PASSR, bits & 15, v);
-	MODIFY_BITS(gpio + SA1111_GPIO_PBSSR, (bits >> 8) & 255, v >> 8);
-	MODIFY_BITS(gpio + SA1111_GPIO_PCSSR, (bits >> 16) & 255, v >> 16);
-	spin_unlock_irqrestore(&sachip->lock, flags);
-}
-EXPORT_SYMBOL(sa1111_set_sleep_io);
-
 /*
  * Individual device operations.
  */
diff --git a/arch/arm/include/asm/hardware/sa1111.h b/arch/arm/include/asm/hardware/sa1111.h
index 798e520e8a49..d134b9a5ff94 100644
--- a/arch/arm/include/asm/hardware/sa1111.h
+++ b/arch/arm/include/asm/hardware/sa1111.h
@@ -433,10 +433,6 @@ int sa1111_check_dma_bug(dma_addr_t addr);
 int sa1111_driver_register(struct sa1111_driver *);
 void sa1111_driver_unregister(struct sa1111_driver *);
 
-void sa1111_set_io_dir(struct sa1111_dev *sadev, unsigned int bits, unsigned int dir, unsigned int sleep_dir);
-void sa1111_set_io(struct sa1111_dev *sadev, unsigned int bits, unsigned int v);
-void sa1111_set_sleep_io(struct sa1111_dev *sadev, unsigned int bits, unsigned int v);
-
 struct sa1111_platform_data {
 	int	irq_base;	/* base for cascaded on-chip IRQs */
 	unsigned disable_devs;
-- 
2.7.4
