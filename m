From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 2 Mar 2012 18:32:33 +0000
Subject: [PATCH 5/5 v2] ARM: kirkwood: convert orion-wdt to fdt.
In-Reply-To: <e2fe5e97a83fc753559bbb18d5d111ed01b89034.1330709314.git.jason@lakedaemon.net>
References: <cover.1330709314.git.jason@lakedaemon.net>
 <e2fe5e97a83fc753559bbb18d5d111ed01b89034.1330709314.git.jason@lakedaemon.net>
Message-ID: <201203021832.34901.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 02 March 2012, Jason Cooper wrote:
> +       wdt_reg = (void __iomem *)TIMER_VIRT_BASE;
> +
> +       ret = of_address_to_resource(np, 0, &res);
> +       if (ret) {
> +               printk(KERN_ERR "invalid address\n");
> +               return ret;
> +       }
> +
> +       wdt_reg = ioremap(res.start, res.end - res.start);
> +

This will break non-dt uses because you overwrite the wdt_reg value.

As I commented before, I think the best approach would be to
provide a hardcoded resource for the device in the legacy case
and just use platform_get_resource() to get the resource
and ioremap it in either case.

of_address_to_resource() works only for the DT case, while
platform_get_resource() works in either case.

You need to add something like

8<---
diff --git a/arch/arm/plat-orion/common.c b/arch/arm/plat-orion/common.c
index 089899a..d16f43f 100644
--- a/arch/arm/plat-orion/common.c
+++ b/arch/arm/plat-orion/common.c
@@ -568,13 +568,17 @@ void __init orion_spi_1_init(unsigned long mapbase,
  ****************************************************************************/
 static struct orion_wdt_platform_data orion_wdt_data;
 
+static struct resource orion_wdt_resource =
+               DEFINE_RES_MEM(TIMER_PHYS_BASE, 0x28);
+
 static struct platform_device orion_wdt_device = {
        .name           = "orion_wdt",
        .id             = -1,
        .dev            = {
                .platform_data  = &orion_wdt_data,
        },
-       .num_resources  = 0,
+       .resources      = &orion_wdt_resource,
+       .num_resources  = 1,
 };
 
 void __init orion_wdt_init(unsigned long tclk)
---->8

and an appropriate definition for TIMER_PHYS_BASE.


	Arnd
