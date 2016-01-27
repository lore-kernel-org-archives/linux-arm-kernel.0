From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 27 Jan 2016 23:23:57 +0100
Subject: [PATCH 1/2] ARM: l2x0: add three special L210 aux control flags
Message-ID: <1453933437-6666-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds support for setting the flag bits "wrap access disable",
"write allocate override" and "exclusive abort disable" to the L210
variant from the device tree.

The "write allocate override" bit was used on the Nomadik and
necessary to properly make use of the L210 cache on that machine
without sporadic crashes.

I took this oppportunity to add all three flags so we avoid excess
patching for each one.

Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 Documentation/devicetree/bindings/arm/l2c2x0.txt | 10 ++++++++++
 arch/arm/mm/cache-l2x0.c                         | 18 ++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/l2c2x0.txt b/Documentation/devicetree/bindings/arm/l2c2x0.txt
index fe0398c5c77b..975d1ae304d4 100644
--- a/Documentation/devicetree/bindings/arm/l2c2x0.txt
+++ b/Documentation/devicetree/bindings/arm/l2c2x0.txt
@@ -74,6 +74,16 @@ Optional properties:
   or "write through no write allocate" (for writes).
   On systems where this may cause DMA buffer corruption, this property must be
   specified to indicate that such transforms are precluded.
+- arm,wrap-access-disable : (L210 only) if this flag is set, wrap accesses
+  requested on slave ports are converted to linear acesses on master ports.
+- arm,write-allocate-override : (L210 only) normally the L210 will use HPROT
+  attributes, setting this bit overrides that behaviour and cause the cache
+  to make all write-through and write-back accesses into read-write-allocate
+  accesses.
+- arm,exclusive-abort-disable : (L210 only) normally the cache controller sends
+  an ERROR response back to exclusive access in a cacheable, shared memory
+  region with the shared override bit set, but setting this flag disables the
+  abort generation and the access is instead treated as cacheable, non-shared.
 - arm,parity-enable : enable parity checking on the L2 cache (L220 or PL310).
 - arm,parity-disable : disable parity checking on the L2 cache (L220 or PL310).
 - arm,outer-sync-disable : disable the outer sync operation on the L2 cache.
diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 9f9d54271aad..301c3c2dc09f 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -1076,6 +1076,24 @@ static void __init l2x0_of_parse(const struct device_node *np,
 		val |= L2C_AUX_CTRL_SHARED_OVERRIDE;
 	}
 
+	/* L210-specific aux control flags */
+	if (of_device_is_compatible(np, "arm,l210-cache")) {
+		if (of_property_read_bool(np, "arm,wrap-access-disable")) {
+			mask &= ~L210_AUX_CTRL_WRAP_DISABLE;
+			val |= L210_AUX_CTRL_WRAP_DISABLE;
+		}
+
+		if (of_property_read_bool(np, "arm,write-allocate-override")) {
+			mask &= ~L210_AUX_CTRL_WA_OVERRIDE;
+			val |= L210_AUX_CTRL_WA_OVERRIDE;
+		}
+
+		if (of_property_read_bool(np, "arm,exclusive-abort-disable")) {
+			mask &= ~L210_AUX_CTRL_EXCLUSIVE_ABORT;
+			val |= L210_AUX_CTRL_EXCLUSIVE_ABORT;
+		}
+	}
+
 	ret = l2x0_cache_size_of_parse(np, aux_val, aux_mask, &assoc, SZ_256K);
 	if (ret)
 		return;
-- 
2.4.3
