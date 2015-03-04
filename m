From: alex.bennee@linaro.org (=?UTF-8?q?Alex=20Benn=C3=A9e?=)
Date: Wed,  4 Mar 2015 14:35:50 +0000
Subject: [PATCH v2 3/6] hw/char: pl011 don't keep setting the IRQ if nothing
 changed
In-Reply-To: <1425479753-18349-1-git-send-email-alex.bennee@linaro.org>
References: <1425479753-18349-1-git-send-email-alex.bennee@linaro.org>
Message-ID: <1425479753-18349-4-git-send-email-alex.bennee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While observing KVM traces I can see additional IRQ calls on pretty much
every MMIO access which is just plain inefficient. Only update the QEMU
IRQ level if something has actually changed from last time. Otherwise we
may be papering over other failure modes.

Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>

diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index 0a45115..bb554bc 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -36,6 +36,9 @@ typedef struct PL011State {
     CharDriverState *chr;
     qemu_irq irq;
     const unsigned char *id;
+
+    /* not serialised, prevents pl011_update doing extra set_irqs */
+    uint32_t current_irq;
 } PL011State;
 
 #define PL011_INT_TX 0x20
@@ -53,10 +56,11 @@ static const unsigned char pl011_id_luminary[8] =
 
 static void pl011_update(PL011State *s)
 {
-    uint32_t flags;
-
-    flags = s->int_level & s->int_enabled;
-    qemu_set_irq(s->irq, flags != 0);
+    uint32_t flags = s->int_level & s->int_enabled;
+    if (flags != s->current_irq) {
+        s->current_irq = flags;
+        qemu_set_irq(s->irq, s->current_irq != 0);
+    }
 }
 
 static uint64_t pl011_read(void *opaque, hwaddr offset,
-- 
2.3.1
