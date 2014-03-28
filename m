From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 28 Mar 2014 15:16:12 +0000
Subject: [PATCH 22/75] ARM: l2c: only write the auxiliary control register if
 required
In-Reply-To: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
References: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
Message-ID: <E1WTYVw-0006Rf-VW@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Avoid unnecessary writes to the auxiliary control register if the
register already contains the required value.  This allows us to
avoid invoking the platforms secure monitor code unnecessarily.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/cache-l2x0.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index fc609550b7fa..1c947b4c7f05 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -92,7 +92,9 @@ static void l2c_enable(void __iomem *base, u32 aux, unsigned num_lock)
 {
 	unsigned long flags;
 
-	writel_relaxed(aux, base + L2X0_AUX_CTRL);
+	/* Only write the aux register if it needs changing */
+	if (readl_relaxed(base + L2X0_AUX_CTRL) != aux)
+		writel_relaxed(aux, base + L2X0_AUX_CTRL);
 
 	l2c_unlock(base, num_lock);
 
-- 
1.8.3.1
