From: riel@redhat.com (riel at redhat.com)
Date: Fri, 19 May 2017 17:26:32 -0400
Subject: [PATCH 1/5] random, stackprotect: introduce get_random_canary function
In-Reply-To: <20170519212636.30440-1-riel@redhat.com>
References: <20170519212636.30440-1-riel@redhat.com>
Message-ID: <20170519212636.30440-2-riel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rik van Riel <riel@redhat.com>

Introduce the get_random_canary function, which provides a random
unsigned long canary value with the first byte zeroed out on 64
bit architectures, in order to mitigate non-terminated C string
overflows.

Inspired by the "ascii armor" code in the old execshield patches,
and the current PaX/grsecurity code base.

Signed-off-by: Rik van Riel <riel@redhat.com>
---
 include/linux/random.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/linux/random.h b/include/linux/random.h
index ed5c3838780d..765a992c6774 100644
--- a/include/linux/random.h
+++ b/include/linux/random.h
@@ -57,6 +57,26 @@ static inline unsigned long get_random_long(void)
 #endif
 }
 
+/*
+ * On 64 bit architectures, protect against non-terminated C string overflows
+ * by zeroing out the first byte of the canary; this leaves 56 bits of entropy.
+ */
+#ifdef CONFIG_64BIT
+#ifdef __LITTLE_ENDIAN
+#define CANARY_MASK 0xffffffffffffff00UL
+#else /* big endian 64 bits */
+#define CANARY_MASK 0x00ffffffffffffffUL
+#endif
+#else /* 32 bits */
+#define CANARY_MASK 0xffffffffUL
+#endif
+static inline unsigned long get_random_canary(void)
+{
+	unsigned long val = get_random_long();
+
+	return val & CANARY_MASK;
+}
+
 unsigned long randomize_page(unsigned long start, unsigned long range);
 
 u32 prandom_u32(void);
-- 
2.9.3
