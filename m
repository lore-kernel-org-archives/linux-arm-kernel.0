From: gioh.kim@lge.com (Gioh Kim)
Date: Thu, 15 May 2014 14:39:57 +0900
Subject: [RFC PATCH] ARM: cache-l2x0: add setup entry for l2 in non-secure mode
Message-ID: <5374532D.7030602@lge.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

My board is using Trustzone and running kernel is non-secure mode.
But setup function of PL310 driver is only for secure mode kernel.

What about adding an entry for non-secure mode setup function?

I'm sorry for my poor code but I just wanna say what I need .

------------------------------ 8< -------------------------------
>From ee4b03fb2c12038c6bbb9f752558abae8d500c07 Mon Sep 17 00:00:00 2001
From: Gioh Kim <gioh.kim@lge.com>
Date: Thu, 15 May 2014 14:06:36 +0900
Subject: [PATCH] ARM: cache-l2x0: add setup entry for l2 in non-secure mode

For some platforms using Trustzone and running kernel in non-secure mode,
another l2 setup function is necessary.

Signed-off-by: Gioh Kim <gioh.kim@lge.c>
---
 arch/arm/include/asm/hardware/cache-l2x0.h |    9 +++++++++
 arch/arm/mm/cache-l2x0.c                   |   26 +++++++++++++++++++++++++-
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/hardware/cache-l2x0.h b/arch/arm/include/asm/hardware/cache-l2x0.h
index 6dec6da..de31114 100644
--- a/arch/arm/include/asm/hardware/cache-l2x0.h
+++ b/arch/arm/include/asm/hardware/cache-l2x0.h
@@ -21,6 +21,7 @@
 #define __ASM_ARM_HARDWARE_L2X0_H

 #include <linux/errno.h>
+#include <linux/of.h>

 #define L2X0_CACHE_ID                  0x000
 #define L2X0_CACHE_TYPE                        0x004
@@ -110,11 +111,19 @@
 extern void __init l2x0_init(void __iomem *base, u32 aux_val, u32 aux_mask);
 #if defined(CONFIG_CACHE_L2X0) && defined(CONFIG_OF)
 extern int l2x0_of_init(u32 aux_val, u32 aux_mask);
+extern int l2x0_of_set_setup_nonsecure(const char *compatible, size_t len,
+                       void (*fp)(const struct device_node *, u32 *, u32 *));
 #else
 static inline int l2x0_of_init(u32 aux_val, u32 aux_mask)
 {
        return -ENODEV;
 }
+static inline int l2x0_of_set_setup_nonsecure(const char *compatible,
+                                             size_t len,
+                     void (*fp)(const struct device_node *, u32 *, u32 *))
+{
+       return -ENODEV;
+}
 #endif

 struct l2x0_regs {
diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 728d644..582ea37 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -45,6 +45,7 @@ struct l2x0_regs l2x0_saved_regs;
 struct l2x0_of_data {
        void (*setup)(const struct device_node *, u32 *, u32 *);
        void (*save)(void);
+       void (*setup_nonsecure)(const struct device_node *, u32 *, u32 *);
        struct outer_cache_fns outer_cache;
 };

@@ -968,6 +969,23 @@ static const struct of_device_id l2x0_ids[] __initconst = {
        {}
 };

+int l2x0_of_set_setup_nonsecure(const char *compatible, size_t len,
+                       void (*fp)(const struct device_node *, u32 *, u32 *))
+{
+       const struct of_device_id *id;
+
+       for (id = &l2x0_ids[0]; id->compatible != NULL; id++) {
+               if (strncmp(id->compatible, compatible, len) == 0) {
+                       struct l2x0_of_data *data = id->data;
+
+                       data->setup_nonsecure = fp;
+                       return 0;
+               }
+       }
+
+       return -EINVAL;
+}
+
 int __init l2x0_of_init(u32 aux_val, u32 aux_mask)
 {
        struct device_node *np;
@@ -989,8 +1007,14 @@ int __init l2x0_of_init(u32 aux_val, u32 aux_mask)

        /* L2 configuration can only be changed if the cache is disabled */
        if (!(readl_relaxed(l2x0_base + L2X0_CTRL) & L2X0_CTRL_EN)) {
-               if (data->setup)
+
+               if (data->setup_nonsecure)
+                       data->setup_nonsecure(np, &aux_val, &aux_mask);
+               else if (data->setup)
                        data->setup(np, &aux_val, &aux_mask);
+               else
+                       /* no function to enable cache */
+                       return -ENODEV;

                /* For aurora cache in no outer mode select the
                 * correct mode using the coprocessor*/
--
1.7.9.5
