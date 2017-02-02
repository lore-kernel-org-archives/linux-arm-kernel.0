From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu,  2 Feb 2017 18:05:26 +0000
Subject: [PATCH v2] log2: make order_base_2() behave correctly on const input
 value zero
Message-ID: <1486058726-7262-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The function order_base_2() is defined (according to the comment block)
as returning zero on input zero, but subsequently passes the input into
roundup_pow_of_two(), which is explicitly undefined for input zero.

This has gone unnoticed until now, but optimization passes in GCC 7 may
produce constant folded function instances where a constant value of zero
is passed into order_base_2(), resulting in link errors against the
deliberately undefined '____ilog2_NaN'.

So update order_base_2() to adhere to its own documented interface.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
v2: make __order_base_2() return int to match the prototype of __ilog2_uXX()

This is a followup to Will's message 'Build failure with v4.9-rc1 and GCC
trunk -- compiler weirdness' which can be found here:

  http://marc.info/?l=linux-kernel&m=147672952517795&w=2

 include/linux/log2.h | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/linux/log2.h b/include/linux/log2.h
index fd7ff3d91e6a..d3fe63b12e96 100644
--- a/include/linux/log2.h
+++ b/include/linux/log2.h
@@ -203,6 +203,17 @@ unsigned long __rounddown_pow_of_two(unsigned long n)
  *  ... and so on.
  */
 
-#define order_base_2(n) ilog2(roundup_pow_of_two(n))
+static inline __attribute_const__
+int __order_base_2(unsigned long n)
+{
+	return n > 1 ? ilog2(n - 1) + 1 : 0;
+}
 
+#define order_base_2(n)				\
+(						\
+	__builtin_constant_p(n) ? (		\
+		((n) == 0 || (n) == 1) ? 0 :	\
+		ilog2((n) - 1) + 1) :		\
+	__order_base_2(n)			\
+)
 #endif /* _LINUX_LOG2_H */
-- 
2.7.4
