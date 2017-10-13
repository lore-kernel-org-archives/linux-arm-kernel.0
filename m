From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 13 Oct 2017 16:56:06 +0100
Subject: [PATCH v4 2/3] drivers/irqchip: gic: make quirks matching conditional
 on init return value
In-Reply-To: <20171013155607.5211-1-ard.biesheuvel@linaro.org>
References: <20171013155607.5211-1-ard.biesheuvel@linaro.org>
Message-ID: <20171013155607.5211-3-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As it turns out, the IIDR is not sufficient to distinguish between GICv3
implementations when it comes to enabling quirks. So update the prototype
of the init() hook to return a bool, and interpret a 'false' return value
as no match, in which case the 'enabling workaround' log message should
not be printed.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/irqchip/irq-gic-common.c |  5 +++--
 drivers/irqchip/irq-gic-common.h |  2 +-
 drivers/irqchip/irq-gic-v3-its.c | 12 +++++++++---
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-gic-common.c b/drivers/irqchip/irq-gic-common.c
index 9ae71804b5dd..30017df5b54c 100644
--- a/drivers/irqchip/irq-gic-common.c
+++ b/drivers/irqchip/irq-gic-common.c
@@ -40,8 +40,9 @@ void gic_enable_quirks(u32 iidr, const struct gic_quirk *quirks,
 	for (; quirks->desc; quirks++) {
 		if (quirks->iidr != (quirks->mask & iidr))
 			continue;
-		quirks->init(data);
-		pr_info("GIC: enabling workaround for %s\n", quirks->desc);
+		if (quirks->init(data))
+			pr_info("GIC: enabling workaround for %s\n",
+				quirks->desc);
 	}
 }
 
diff --git a/drivers/irqchip/irq-gic-common.h b/drivers/irqchip/irq-gic-common.h
index 205e5fddf6da..3919cd7c5285 100644
--- a/drivers/irqchip/irq-gic-common.h
+++ b/drivers/irqchip/irq-gic-common.h
@@ -23,7 +23,7 @@
 
 struct gic_quirk {
 	const char *desc;
-	void (*init)(void *data);
+	bool (*init)(void *data);
 	u32 iidr;
 	u32 mask;
 };
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 891de07fd4cc..c34f21c7a38e 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -2728,28 +2728,34 @@ static int its_force_quiescent(void __iomem *base)
 	}
 }
 
-static void __maybe_unused its_enable_quirk_cavium_22375(void *data)
+static bool __maybe_unused its_enable_quirk_cavium_22375(void *data)
 {
 	struct its_node *its = data;
 
 	/* erratum 22375: only alloc 8MB table size */
 	its->device_ids = 0x14;		/* 20 bits, 8MB */
 	its->flags |= ITS_FLAGS_WORKAROUND_CAVIUM_22375;
+
+	return true;
 }
 
-static void __maybe_unused its_enable_quirk_cavium_23144(void *data)
+static bool __maybe_unused its_enable_quirk_cavium_23144(void *data)
 {
 	struct its_node *its = data;
 
 	its->flags |= ITS_FLAGS_WORKAROUND_CAVIUM_23144;
+
+	return true;
 }
 
-static void __maybe_unused its_enable_quirk_qdf2400_e0065(void *data)
+static bool __maybe_unused its_enable_quirk_qdf2400_e0065(void *data)
 {
 	struct its_node *its = data;
 
 	/* On QDF2400, the size of the ITE is 16Bytes */
 	its->ite_size = 16;
+
+	return true;
 }
 
 static const struct gic_quirk its_quirks[] = {
-- 
2.11.0
