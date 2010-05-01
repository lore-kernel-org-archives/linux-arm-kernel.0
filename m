From: virtuoso@slind.org (Alexander Shishkin)
Date: Sat,  1 May 2010 22:23:19 +0300
Subject: [PATCH 1/2] create generic alignment api (v6)
In-Reply-To: <20100329000900.GB27379@Krystal>
References: <20100329000900.GB27379@Krystal>
Message-ID: <1272741800-30115-1-git-send-email-virtuoso@slind.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Rather than re-doing the "alignment on a type size" trick all over again at
different levels, import the "ltt_align" from LTTng into kernel.h and make this
available to everyone. Renaming to:

- object_align()
- object_align_floor()
- offset_align()
- offset_align_floor()

Changelog since v5:
- moved alignment apis to a separate header file so that it is possible
  to use them from other header files which are, for example, included
  from kernel.h.

Changelog since v4:
- add missing ( ) around parameters within object_align() and
  object_align_floor().
- More coding style cleanups to ALIGN() (checkpatch.pl is happy now).

Changelog since v3:
- optimize object_align*() so fewer instructions are needed for alignment of
  addresses known dynamically. Use the (already existing) "ALIGN()", and create
  the "ALIGN_FLOOR()" macro.
- While we are there, let's clean up the ALIGN() macros wrt coding style. e.g.
  missing parenthesis around the first use of the "x" parameter in ALIGN().

Changelog since v2:
- Fix object_align*(): should use object size alignment, not pointer alignment.

Changelog since v1:
- Align on the object natural alignment
    (rather than min(arch word alignment, natural alignment))

The advantage of separating the API in "object alignment" and "offset alignment"
is that it gives more freedom to play with offset alignment. Very useful to
implement a tracer ring-buffer alignment. (hint hint)

Typical users will use "object alignment", but infrastructures like tracers
which need to perform alignment of statically known base+offsets will typically
use "offset alignment", because it allows to align with respect to a base rather
than to pass an absolute address.

We use "sizeof(object)" rather than "__alignof__()" object because alignof
returns "recommended" object alignment for the architecture, which can be
sub-optimal on some architectures. By ensuring alignment on the object size, we
are sure to make the right choice.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Alexander Shishkin <virtuoso@slind.org>
CC: Russell King - ARM Linux <linux@arm.linux.org.uk>
CC: linux-arm-kernel at lists.infradead.org
CC: Imre Deak <imre.deak@nokia.com>
CC: Jamie Lokier <jamie@shareable.org>
CC: rostedt at goodmis.org
CC: mingo at elte.hu
---
 include/linux/align.h  |   48 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/kernel.h |    6 +-----
 2 files changed, 49 insertions(+), 5 deletions(-)
 create mode 100644 include/linux/align.h

diff --git a/include/linux/align.h b/include/linux/align.h
new file mode 100644
index 0000000..8aa2967
--- /dev/null
+++ b/include/linux/align.h
@@ -0,0 +1,48 @@
+#ifndef _LINUX_ALIGN_H
+#define _LINUX_ALIGN_H
+
+#include <linux/types.h>
+
+#define ALIGN(x, a)		__ALIGN_MASK((x), (typeof(x)) (a) - 1)
+#define __ALIGN_MASK(x, mask)	(((x) + (mask)) & ~(mask))
+#define PTR_ALIGN(p, a)		((typeof(p)) ALIGN((unsigned long) (p), (a)))
+#define ALIGN_FLOOR(x, a)	__ALIGN_FLOOR_MASK((x), (typeof(x)) (a) - 1)
+#define __ALIGN_FLOOR_MASK(x, mask)	((x) & ~(mask))
+#define PTR_ALIGN_FLOOR(p, a) \
+			((typeof(p)) ALIGN_FLOOR((unsigned long) (p), (a)))
+#define IS_ALIGNED(x, a)	(((x) & ((typeof(x)) (a) - 1)) == 0)
+
+/*
+ * Align pointer on natural object alignment. Object size must be power of two.
+ */
+#define object_align(obj)	PTR_ALIGN((obj), sizeof(*(obj)))
+#define object_align_floor(obj)	PTR_ALIGN_FLOOR((obj), sizeof(*(obj)))
+
+/**
+ * offset_align - Calculate the offset needed to align an object on its natural
+ *                alignment towards higher addresses.
+ * @align_drift:  object offset from an "alignment"-aligned address.
+ * @alignment:    natural object alignment. Must be non-zero, power of 2.
+ *
+ * Returns the offset that must be added to align towards higher
+ * addresses.
+ */
+static inline size_t offset_align(size_t align_drift, size_t alignment)
+{
+	return (alignment - align_drift) & (alignment - 1);
+}
+
+/**
+ * offset_align_floor - Calculate the offset needed to align an object
+ *                      on its natural alignment towards lower addresses.
+ * @align_drift:  object offset from an "alignment"-aligned address.
+ * @alignment:    natural object alignment. Must be non-zero, power of 2.
+ *
+ * Returns the offset that must be substracted to align towards lower addresses.
+ */
+static inline size_t offset_align_floor(size_t align_drift, size_t alignment)
+{
+	return (align_drift - alignment) & (alignment - 1);
+}
+
+#endif
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index f4e3184..81d0d15 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -12,6 +12,7 @@
 #include <linux/stddef.h>
 #include <linux/types.h>
 #include <linux/compiler.h>
+#include <linux/align.h>
 #include <linux/bitops.h>
 #include <linux/log2.h>
 #include <linux/typecheck.h>
@@ -38,11 +39,6 @@ extern const char linux_proc_banner[];
 
 #define STACK_MAGIC	0xdeadbeef
 
-#define ALIGN(x,a)		__ALIGN_MASK(x,(typeof(x))(a)-1)
-#define __ALIGN_MASK(x,mask)	(((x)+(mask))&~(mask))
-#define PTR_ALIGN(p, a)		((typeof(p))ALIGN((unsigned long)(p), (a)))
-#define IS_ALIGNED(x, a)		(((x) & ((typeof(x))(a) - 1)) == 0)
-
 #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
 
 #define FIELD_SIZEOF(t, f) (sizeof(((t*)0)->f))
-- 
1.7.1.1.g15764
