From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 28 Mar 2013 12:39:46 +0000
Subject: [PATCH] clocksource: Fix build in non-OF case
In-Reply-To: <1364473805-773-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1364473805-773-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <201303281239.46639.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 28 March 2013, Mark Brown wrote:
> Commit 4d10f054 (clocksource: make CLOCKSOURCE_OF_DECLARE type safe)
> made CLOCKSOURCE_OF_DECLARE reference the function pointer in both the
> OF and non-OF cases. In the non-OF case this is likely to introduce
> build failures as users may reasonably conditionally compile the OF
> specific code, either the macro ought to be used within CONFIG_OF and
> not have a !CONFIG_OF case or the macro ought not to reference its
> arguments in that case.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Hi Mark,

Axel Lin reported the same problem and I fixed the below code earlier
today by using the correct __attribute__((unused)) and dropping the
section magic for the non-OF case. My patch now looks contains the
change below. I also proposed a fix for the clocksource driver
at http://lkml.org/lkml/2013/3/26/103.

	Arnd

----
@@ -332,16 +332,23 @@ extern int clocksource_mmio_init(void __iomem *, const char *,
 
 extern int clocksource_i8253_init(void);
 
+struct device_node;
+typedef void(*clocksource_of_init_fn)(struct device_node *);
 #ifdef CONFIG_CLKSRC_OF
 extern void clocksource_of_init(void);
 
 #define CLOCKSOURCE_OF_DECLARE(name, compat, fn)                       \
        static const struct of_device_id __clksrc_of_table_##name       \
                __used __section(__clksrc_of_table)                     \
-                = { .compatible = compat, .data = fn };
+                = { .compatible = compat,                              \
+                    .data = (fn == (clocksource_of_init_fn)NULL) ? fn : fn }
 #else
 static inline void clocksource_of_init(void) {}
-#define CLOCKSOURCE_OF_DECLARE(name, compat, fn)
+#define CLOCKSOURCE_OF_DECLARE(name, compat, fn)                       \
+       static const struct of_device_id __clksrc_of_table_##name       \
+               __attribute__((unused))                                 \
+                = { .compatible = compat,                              \
+                    .data = (fn == (clocksource_of_init_fn)NULL) ? fn : fn }
 #endif
 
 #endif /* _LINUX_CLOCKSOURCE_H */
