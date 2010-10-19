From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue, 19 Oct 2010 16:38:56 +0200
Subject: [PATCH 01/12] ARM: Convert dma_spin_lock to raw_spinlock
In-Reply-To: <20101019143717.GH11713@pengutronix.de>
References: <20101019143717.GH11713@pengutronix.de>
Message-ID: <1287499147-13846-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Gleixner <tglx@linutronix.de>

dma_spin_lock needs to be a real spinlock on preempt-rt. Convert it to
a raw_spinlock. No change for !RT kernels.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
[ukl: s/  / / on the line declaring dma_spin_lock]
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/include/asm/dma.h |    6 +++---
 arch/arm/kernel/dma.c      |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/dma.h b/arch/arm/include/asm/dma.h
index ca51143..644a160 100644
--- a/arch/arm/include/asm/dma.h
+++ b/arch/arm/include/asm/dma.h
@@ -31,18 +31,18 @@
 #define DMA_MODE_CASCADE 0xc0
 #define DMA_AUTOINIT	 0x10
 
-extern spinlock_t  dma_spin_lock;
+extern raw_spinlock_t dma_spin_lock;
 
 static inline unsigned long claim_dma_lock(void)
 {
 	unsigned long flags;
-	spin_lock_irqsave(&dma_spin_lock, flags);
+	raw_spin_lock_irqsave(&dma_spin_lock, flags);
 	return flags;
 }
 
 static inline void release_dma_lock(unsigned long flags)
 {
-	spin_unlock_irqrestore(&dma_spin_lock, flags);
+	raw_spin_unlock_irqrestore(&dma_spin_lock, flags);
 }
 
 /* Clear the 'DMA Pointer Flip Flop'.
diff --git a/arch/arm/kernel/dma.c b/arch/arm/kernel/dma.c
index 2c4a185..7b829d9 100644
--- a/arch/arm/kernel/dma.c
+++ b/arch/arm/kernel/dma.c
@@ -23,7 +23,7 @@
 
 #include <asm/mach/dma.h>
 
-DEFINE_SPINLOCK(dma_spin_lock);
+DEFINE_RAW_SPINLOCK(dma_spin_lock);
 EXPORT_SYMBOL(dma_spin_lock);
 
 static dma_t *dma_chan[MAX_DMA_CHANNELS];
-- 
1.7.2.3
