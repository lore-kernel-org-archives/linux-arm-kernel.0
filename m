From: mathieu.desnoyers@efficios.com (Mathieu Desnoyers)
Date: Sun, 28 Mar 2010 20:01:57 -0400
Subject: [RFC PATCH] create generic alignment api (v4)
Message-ID: <20100329000157.GA27379@Krystal>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rather than re-doing the "alignment on a type size" trick all over again at
different levels, import the "ltt_align" from LTTng into kernel.h and make this
available to everyone. Renaming to:

- object_align()
- object_align_floor()
- offset_align()
- offset_align_floor()

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
CC: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Alexander Shishkin <virtuoso@slind.org>,
CC: linux-arm-kernel at lists.infradead.org
CC: Imre Deak <imre.deak@nokia.com>
CC: Jamie Lokier <jamie@shareable.org>
CC: rostedt at goodmis.org
CC: mingo at elte.hu
---
 include/linux/kernel.h |   45 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 41 insertions(+), 4 deletions(-)

Index: linux-2.6-lttng/include/linux/kernel.h
===================================================================
--- linux-2.6-lttng.orig/include/linux/kernel.h	2010-03-27 20:46:07.000000000 -0400
+++ linux-2.6-lttng/include/linux/kernel.h	2010-03-28 19:59:50.000000000 -0400
@@ -37,10 +37,47 @@ extern const char linux_proc_banner[];
 
 #define STACK_MAGIC	0xdeadbeef
 
-#define ALIGN(x,a)		__ALIGN_MASK(x,(typeof(x))(a)-1)
-#define __ALIGN_MASK(x,mask)	(((x)+(mask))&~(mask))
-#define PTR_ALIGN(p, a)		((typeof(p))ALIGN((unsigned long)(p), (a)))
-#define IS_ALIGNED(x, a)		(((x) & ((typeof(x))(a) - 1)) == 0)
+#define ALIGN(x,a)		__ALIGN_MASK((x), (typeof(x)) (a) - 1)
+#define __ALIGN_MASK(x,mask)	(((x) + (mask)) & ~(mask))
+#define PTR_ALIGN(p, a)		((typeof(p)) ALIGN((unsigned long) (p), (a)))
+#define ALIGN_FLOOR(x,a)	__ALIGN_FLOOR_MASK((x), (typeof(x)) (a) - 1)
+#define __ALIGN_FLOOR_MASK(x,mask)	((x) & ~(mask))
+#define PTR_ALIGN_FLOOR(p, a) \
+			((typeof(p)) ALIGN_FLOOR((unsigned long) (p), (a)))
+#define IS_ALIGNED(x, a)	(((x) & ((typeof(x)) (a) - 1)) == 0)
+
+/*
+ * Align pointer on natural object alignment. Object size must be power of two.
+ */
+#define object_align(obj)	PTR_ALIGN(obj, sizeof(*obj))
+#define object_align_floor(obj)	PTR_ALIGN_FLOOR(obj, sizeof(*obj))
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
 
 #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
 
-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
