From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Mon, 29 Aug 2016 11:26:54 +0100
Subject: [PATCH 33/33] ARM: sa1111: remove legacy GPIO interfaces
In-Reply-To: <20160829102328.GA28796@n2100.armlinux.org.uk>
References: <20160829102328.GA28796@n2100.armlinux.org.uk>
Message-ID: <E1beJmI-0000ow-Mp@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have migrated all users of the legacy private SA1111 gpio
interfaces, we can remove these redundant interfaces.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/common/sa1111.c               | 59 ----------------------------------
 arch/arm/include/asm/hardware/sa1111.h |  4 ---
 2 files changed, 63 deletions(-)

diff --git a/arch/arm/common/sa1111.c b/arch/arm/common/sa1111.c
index ac19dca4c258..e23db31fdd29 100644
--- a/arch/arm/common/sa1111.c
+++ b/arch/arm/common/sa1111.c
@@ -1334,65 +1334,6 @@ int sa1111_get_audio_rate(struct sa1111_dev *sadev)
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
-		val = sa1111_readl(port);	\
-		val &= ~(mask);			\
-		val |= (dir) & (mask);		\
-		sa1111_writel(val, port);	\
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
index 7c2bbc7f0be1..cbb29c9c6457 100644
--- a/arch/arm/include/asm/hardware/sa1111.h
+++ b/arch/arm/include/asm/hardware/sa1111.h
@@ -460,10 +460,6 @@ int sa1111_check_dma_bug(dma_addr_t addr);
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
2.1.0
