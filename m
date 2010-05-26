From: marek.vasut@gmail.com (Marek Vasut)
Date: Wed, 26 May 2010 21:11:44 +0200
Subject: [PATCH] sa1111: Prevent deadlock in resume path
Message-ID: <1274901104-22133-1-git-send-email-marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch reorganises the sa1111_resume() function in a manner the spinlock
happens after calling the sa1111_wake(). This fixes two bugs:

1) This function called sa1111_wake() which tried to claim the same spinlock
   the sa1111_resume() already claimed. This would result in certain deadlock.

   Original idea for this part: Russell King <linux@arm.linux.org.uk>

2) The function didn't unlock the spinlock in case the chip didn't report
   correct ID.

   Original idea for this part: Julia Lawall <julia@diku.dk>

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---
 arch/arm/common/sa1111.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/common/sa1111.c b/arch/arm/common/sa1111.c
index a52a27c..6f80665 100644
--- a/arch/arm/common/sa1111.c
+++ b/arch/arm/common/sa1111.c
@@ -951,8 +951,6 @@ static int sa1111_resume(struct platform_device *dev)
 	if (!save)
 		return 0;
 
-	spin_lock_irqsave(&sachip->lock, flags);
-
 	/*
 	 * Ensure that the SA1111 is still here.
 	 * FIXME: shouldn't do this here.
@@ -969,6 +967,13 @@ static int sa1111_resume(struct platform_device *dev)
 	 * First of all, wake up the chip.
 	 */
 	sa1111_wake(sachip);
+
+	/*
+	 * Only lock for write ops. Also, sa1111_wake must be called with
+	 * released spinlock!
+	 */
+	spin_lock_irqsave(&sachip->lock, flags);
+
 	sa1111_writel(0, sachip->base + SA1111_INTC + SA1111_INTEN0);
 	sa1111_writel(0, sachip->base + SA1111_INTC + SA1111_INTEN1);
 
-- 
1.7.0
