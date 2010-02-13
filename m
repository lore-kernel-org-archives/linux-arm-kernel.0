From: roel.kluin@gmail.com (Roel Kluin)
Date: Sat, 13 Feb 2010 15:54:03 +0100
Subject: [PATCH] iop-adma: redundant/wrong tests in iop_*_count()?
Message-ID: <4B76BD0B.2010307@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When we reach the loop, len is at least 1, we only stay in the loop when
len is at least MAX_BYTE_COUNT + 1, MAX_BYTE_COUNT is subtracted in each
iteration. So when we leave the loop, or didn't take it, len is at least 1.
Testing whether len is non-zero appears redundant.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
Or are the tests off by one? Then we'll need a different patch...

diff --git a/arch/arm/include/asm/hardware/iop3xx-adma.h b/arch/arm/include/asm/hardware/iop3xx-adma.h
index 1a8c727..9b28f12 100644
--- a/arch/arm/include/asm/hardware/iop3xx-adma.h
+++ b/arch/arm/include/asm/hardware/iop3xx-adma.h
@@ -366,8 +366,7 @@ static inline int iop_chan_xor_slot_count(size_t len, int src_cnt,
 		slot_cnt += *slots_per_op;
 	}
 
-	if (len)
-		slot_cnt += *slots_per_op;
+	slot_cnt += *slots_per_op;
 
 	return slot_cnt;
 }
@@ -389,8 +388,7 @@ static inline int iop_chan_zero_sum_slot_count(size_t len, int src_cnt,
 		slot_cnt += *slots_per_op;
 	}
 
-	if (len)
-		slot_cnt += *slots_per_op;
+	slot_cnt += *slots_per_op;
 
 	return slot_cnt;
 }
@@ -737,10 +735,8 @@ iop_desc_set_zero_sum_byte_count(struct iop_adma_desc_slot *desc, u32 len)
 			i += slots_per_op;
 		} while (len > IOP_ADMA_ZERO_SUM_MAX_BYTE_COUNT);
 
-		if (len) {
-			iter = iop_hw_desc_slot_idx(hw_desc, i);
-			iter->byte_count = len;
-		}
+		iter = iop_hw_desc_slot_idx(hw_desc, i);
+		iter->byte_count = len;
 	}
 }
 
