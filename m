From: ext-mika.1.westerberg@nokia.com (Mika Westerberg)
Date: Thu, 26 Aug 2010 15:02:27 +0300
Subject: [PATCH v2 1/6] crash: update IRQ flags
In-Reply-To: <cover.1282822832.git.ext-mika.1.westerberg@nokia.com>
References: <cover.1282822832.git.ext-mika.1.westerberg@nokia.com>
Message-ID: <4b6e952577b1de7540e2b0c56692839a735a9e45.1282822832.git.ext-mika.1.westerberg@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jan Karlsson <jan.karlsson@sonyericsson.com>

There was a change in IRQ flags starting from 2.6.17. This change updates crash
to use those depending on kernel version.

Signed-off-by: Jan Karlsson <jan.karlsson@sonyericsson.com>
Signed-off-by: Thomas F?nge <thomas.fange@sonyericsson.com>
Signed-off-by: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
---
 defs.h |  105 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 97 insertions(+), 8 deletions(-)

diff --git a/defs.h b/defs.h
index 65cb429..3d34b8e 100755
--- a/defs.h
+++ b/defs.h
@@ -2872,15 +2872,104 @@ struct efi_memory_desc_t {
 
 /*
  * IRQ line status.
+ * For kernels up to and including 2.6.17
  */
-#define IRQ_INPROGRESS  1       /* IRQ handler active - do not enter! */
-#define IRQ_DISABLED    2       /* IRQ disabled - do not enter! */
-#define IRQ_PENDING     4       /* IRQ pending - replay on enable */
-#define IRQ_REPLAY      8       /* IRQ has been replayed but not acked yet */
-#define IRQ_AUTODETECT  16      /* IRQ is being autodetected */
-#define IRQ_WAITING     32      /* IRQ not yet seen - for autodetection */
-#define IRQ_LEVEL       64      /* IRQ level triggered */
-#define IRQ_MASKED      128     /* IRQ masked - shouldn't be seen again */
+#define IRQ_INPROGRESS_2_6_17  1       /* IRQ handler active - do not enter! */
+#define IRQ_DISABLED_2_6_17    2       /* IRQ disabled - do not enter! */
+#define IRQ_PENDING_2_6_17     4       /* IRQ pending - replay on enable */
+#define IRQ_REPLAY_2_6_17      8       /* IRQ has been replayed but not acked yet */
+#define IRQ_AUTODETECT_2_6_17  16      /* IRQ is being autodetected */
+#define IRQ_WAITING_2_6_17     32      /* IRQ not yet seen - for autodetection */
+#define IRQ_LEVEL_2_6_17       64      /* IRQ level triggered */
+#define IRQ_MASKED_2_6_17      128     /* IRQ masked - shouldn't be seen again */
+
+/*
+ * For kernel 2.6.21 and later
+ */
+#define IRQ_TYPE_NONE_2_6_21		0x00000000	/* Default, unspecified type */
+#define IRQ_TYPE_EDGE_RISING_2_6_21	0x00000001	/* Edge rising type */
+#define IRQ_TYPE_EDGE_FALLING_2_6_21	0x00000002	/* Edge falling type */
+#define IRQ_TYPE_EDGE_BOTH_2_6_21 	(IRQ_TYPE_EDGE_FALLING | IRQ_TYPE_EDGE_RISING)
+#define IRQ_TYPE_LEVEL_HIGH_2_6_21	0x00000004	/* Level high type */
+#define IRQ_TYPE_LEVEL_LOW_2_6_21	0x00000008	/* Level low type */
+#define IRQ_TYPE_SENSE_MASK_2_6_21	0x0000000f	/* Mask of the above */
+#define IRQ_TYPE_PROBE_2_6_21		0x00000010	/* Probing in progress */
+
+#define IRQ_INPROGRESS_2_6_21		0x00000100	/* IRQ handler active - do not enter! */
+#define IRQ_DISABLED_2_6_21		0x00000200	/* IRQ disabled - do not enter! */
+#define IRQ_PENDING_2_6_21		0x00000400	/* IRQ pending - replay on enable */
+#define IRQ_REPLAY_2_6_21		0x00000800	/* IRQ has been replayed but not acked yet */
+#define IRQ_AUTODETECT_2_6_21		0x00001000	/* IRQ is being autodetected */
+#define IRQ_WAITING_2_6_21		0x00002000	/* IRQ not yet seen - for autodetection */
+#define IRQ_LEVEL_2_6_21		0x00004000	/* IRQ level triggered */
+#define IRQ_MASKED_2_6_21		0x00008000	/* IRQ masked - shouldn't be seen again */
+#define IRQ_PER_CPU_2_6_21		0x00010000	/* IRQ is per CPU */
+#define IRQ_NOPROBE_2_6_21		0x00020000	/* IRQ is not valid for probing */
+#define IRQ_NOREQUEST_2_6_21		0x00040000	/* IRQ cannot be requested */
+#define IRQ_NOAUTOEN_2_6_21		0x00080000	/* IRQ will not be enabled on request irq */
+#define IRQ_WAKEUP_2_6_21		0x00100000	/* IRQ triggers system wakeup */
+#define IRQ_MOVE_PENDING_2_6_21		0x00200000	/* need to re-target IRQ destination */
+#define IRQ_NO_BALANCING_2_6_21		0x00400000	/* IRQ is excluded from balancing */
+#define IRQ_SPURIOUS_DISABLED_2_6_21	0x00800000	/* IRQ was disabled by the spurious trap */
+#define IRQ_MOVE_PCNTXT_2_6_21		0x01000000	/* IRQ migration from process context */
+#define IRQ_AFFINITY_SET_2_6_21		0x02000000	/* IRQ affinity was set from userspace*/
+
+/*
+ * Select proper IRQ value depending on kernel version
+ */
+#define IRQ_TYPE_NONE		\
+	(THIS_KERNEL_VERSION >= LINUX(2,6,21) ? IRQ_TYPE_NONE_2_6_21 : 0)
+#define IRQ_TYPE_EDGE_RISING	\
+	(THIS_KERNEL_VERSION >= LINUX(2,6,21) ? IRQ_TYPE_EDGE_RISING_2_6_21 : 0)
+#define IRQ_TYPE_EDGE_FALLING	\
+	(THIS_KERNEL_VERSION >= LINUX(2,6,21) ? IRQ_TYPE_EDGE_FALLING_2_6_21 : 0)
+#define IRQ_TYPE_EDGE_BOTH	\
+	(THIS_KERNEL_VERSION >= LINUX(2,6,21) ? IRQ_TYPE_EDGE_BOTH_2_6_21 : 0)
+#define IRQ_TYPE_LEVEL_HIGH	\
+	(THIS_KERNEL_VERSION >= LINUX(2,6,21) ? IRQ_TYPE_LEVEL_HIGH_2_6_21 : 0)
+#define IRQ_TYPE_LEVEL_LOW	\
+	(THIS_KERNEL_VERSION >= LINUX(2,6,21) ? IRQ_TYPE_LEVEL_LOW_2_6_21 : 0)
+#define IRQ_TYPE_SENSE_MASK	\
+	(THIS_KERNEL_VERSION >= LINUX(2,6,21) ? IRQ_TYPE_SENSE_MASK_2_6_21 : 0)
+#define IRQ_TYPE_PROBE		\
+	(THIS_KERNEL_VERSION >= LINUX(2,6,21) ? IRQ_TYPE_PROBE_2_6_21 : 0)
+
+#define IRQ_INPROGRESS		\
+	(THIS_KERNEL_VERSION >= LINUX(2,6,21) ? IRQ_INPROGRESS_2_6_21 : IRQ_INPROGRESS_2_6_17)
+#define IRQ_DISABLED		\
+	(THIS_KERNEL_VERSION >= LINUX(2,6,21) ? IRQ_DISABLED_2_6_21 : IRQ_DISABLED_2_6_17)
+#define IRQ_PENDING		\
+	(THIS_KERNEL_VERSION >= LINUX(2,6,21) ? IRQ_PENDING_2_6_21 : IRQ_PENDING_2_6_17)
+#define IRQ_REPLAY		\
+	(THIS_KERNEL_VERSION >= LINUX(2,6,21) ? IRQ_REPLAY_2_6_21 : IRQ_REPLAY_2_6_17)
+#define IRQ_AUTODETECT		\
+	(THIS_KERNEL_VERSION >= LINUX(2,6,21) ? IRQ_AUTODETECT_2_6_21 : IRQ_AUTODETECT_2_6_17)
+#define IRQ_WAITING		\
+	(THIS_KERNEL_VERSION >= LINUX(2,6,21) ? IRQ_WAITING_2_6_21 : IRQ_WAITING_2_6_17)
+#define IRQ_LEVEL		\
+	(THIS_KERNEL_VERSION >= LINUX(2,6,21) ? IRQ_LEVEL_2_6_21 : IRQ_LEVEL_2_6_17)
+#define IRQ_MASKED		\
+	(THIS_KERNEL_VERSION >= LINUX(2,6,21) ? IRQ_MASKED_2_6_21 : IRQ_MASKED_2_6_17)
+#define IRQ_PER_CPU		\
+	(THIS_KERNEL_VERSION >= LINUX(2,6,21) ? IRQ_PER_CPU_2_6_21 : 0)
+#define IRQ_NOPROBE		\
+	(THIS_KERNEL_VERSION >= LINUX(2,6,21) ? IRQ_NOPROBE_2_6_21 : 0)
+#define IRQ_NOREQUEST		\
+	(THIS_KERNEL_VERSION >= LINUX(2,6,21) ? IRQ_NOREQUEST_2_6_21 : 0)
+#define IRQ_NOAUTOEN		\
+	(THIS_KERNEL_VERSION >= LINUX(2,6,21) ? IRQ_NOAUTOEN_2_6_21 : 0)
+#define IRQ_WAKEUP		\
+	(THIS_KERNEL_VERSION >= LINUX(2,6,21) ? IRQ_WAKEUP_2_6_21 : 0)
+#define IRQ_MOVE_PENDING	\
+	(THIS_KERNEL_VERSION >= LINUX(2,6,21) ? IRQ_MOVE_PENDING_2_6_21 : 0)
+#define IRQ_NO_BALANCING	\
+	(THIS_KERNEL_VERSION >= LINUX(2,6,21) ? IRQ_NO_BALANCING_2_6_21 : 0)
+#define IRQ_SPURIOUS_DISABLED	\
+	(THIS_KERNEL_VERSION >= LINUX(2,6,21) ? IRQ_SPURIOUS_DISABLED_2_6_21 : 0)
+#define IRQ_MOVE_PCNTXT		\
+	(THIS_KERNEL_VERSION >= LINUX(2,6,21) ? IRQ_MOVE_PCNTXT_2_6_21 : 0)
+#define IRQ_AFFINITY_SET	\
+	(THIS_KERNEL_VERSION >= LINUX(2,6,21) ? IRQ_AFFINITY_SET_2_6_21 : 0)
 
 #ifdef X86
 #define SA_PROBE                SA_ONESHOT
-- 
1.5.6.5
