From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 03 Jan 2011 22:42:14 +0000
Subject: [PATCH 36/48] ARM: PL08x: ensure pl08x_pre_boundary() works for any
	value of addr
In-Reply-To: <20110103222943.GB4572@n2100.arm.linux.org.uk>
References: <20110103222943.GB4572@n2100.arm.linux.org.uk>
Message-ID: <E1PZt6U-0003Rk-LM@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pl08x_pre_boundary() was unsafe with addresses towards the top of
memory space:

	boundary = ((addr >> PL08X_BOUNDARY_SHIFT) + 1)
			<< PL08X_BOUNDARY_SHIFT;

This can overflow a 32-bit number, producing zero.  When it does:

	if (boundary < addr + len)
		return boundary - addr;
	else
		return len;

results in (boundary - addr) returning either a large positive value.
Also if addr + len overflows, this calculation also fails.

We can fix this trivially as the only thing we're actually interested
in is the value of the least significant PL08X_BOUNDARY_SHIFT bits:

	boundary_len = PL08X_BOUNDARY_SIZE -
		(addr & (PL08X_BOUNDARY_SIZE - 1));

gives us the number of bytes before 'addr' becomes a multiple of
PL08X_BOUNDARY_SIZE.  We can then just take the min() of the two
calculated lengths.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c |   14 +++++---------
 1 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index f619404..7c327c3 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -547,19 +547,15 @@ static void pl08x_fill_lli_for_desc(struct pl08x_driver_data *pl08x,
 }
 
 /*
- * Return number of bytes to fill to boundary, or len
+ * Return number of bytes to fill to boundary, or len.
+ * This calculation works for any value of addr.
  */
 static inline size_t pl08x_pre_boundary(u32 addr, size_t len)
 {
-	u32 boundary;
+	size_t boundary_len = PL08X_BOUNDARY_SIZE -
+			(addr & (PL08X_BOUNDARY_SIZE - 1));
 
-	boundary = ((addr >> PL08X_BOUNDARY_SHIFT) + 1)
-		<< PL08X_BOUNDARY_SHIFT;
-
-	if (boundary < addr + len)
-		return boundary - addr;
-	else
-		return len;
+	return min(boundary_len, len);
 }
 
 /*
-- 
1.6.2.5
