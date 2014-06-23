From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 23 Jun 2014 19:17:03 +0200
Subject: Regression on Integrator after commit 07e461cd7
Message-ID: <CACRpkdZ_4xcfAjuOY7izwMvYg+zqA4stJ3gv_EdTiALmc1go3w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Grant,

The Integrators are not booting after commit
07e461cd7e73a84f0e3757932b93cc80976fd749
"of: Ensure unique names without sacrificing determinism"

i.e. these device trees:
arch/arm/boot/dts/integratorap.dts
arch/arm/boot/dts/integratorcp.dts

It hangs very early boot at one time with the message:
Error: unrecognized/unsupported processor variant (0x41069262).

Reverting that patch (manually) makes the platform boot again,
so it's definately caused by that.

Can you see what is wrong with these device trees, like if it's
something obvious that the code is not expecting? It's like
it cannot build the tree or something.

My revert does not look very nice but looks like this:

commit be15147f12a72b7bc63a8e18a2edd74123bcb5f0
Author: Linus Walleij <linus.walleij@linaro.org>
Date:   Mon Jun 23 18:59:58 2014 +0200

    Revert "of: Ensure unique names without sacrificing determinism"

    This reverts commit 07e461cd7e73a84f0e3757932b93cc80976fd749.

    Conflicts:
        drivers/of/platform.c

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 6c48d73a7fd7..71581921c1f3 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -64,35 +64,37 @@ EXPORT_SYMBOL(of_find_device_by_node);
  * of_device_make_bus_id - Use the device node data to assign a unique name
  * @dev: pointer to device structure that is linked to a device tree node
  *
- * This routine will first try using the translated bus address to
- * derive a unique name. If it cannot, then it will prepend names from
- * parent nodes until a unique name can be derived.
+ * This routine will first try using either the dcr-reg or the reg property
+ * value to derive a unique name.  As a last resort it will use the node
+ * name followed by a unique number.
  */
 void of_device_make_bus_id(struct device *dev)
 {
+       static atomic_t bus_no_reg_magic;
        struct device_node *node = dev->of_node;
        const __be32 *reg;
        u64 addr;
+       int magic;

-       /* Construct the name, using parent nodes if necessary to
ensure uniqueness */
-       while (node->parent) {
-               /*
-                * If the address can be translated, then that is as much
-                * uniqueness as we need. Make it the first component and return
-                */
-               reg = of_get_property(node, "reg", NULL);
-               if (reg && (addr = of_translate_address(node, reg)) !=
OF_BAD_ADDR) {
-                       dev_set_name(dev, dev_name(dev) ? "%llx.%s:%s"
: "%llx.%s",
-                                    (unsigned long long)addr, node->name,
-                                    dev_name(dev));
+       /*
+        * For MMIO, get the physical address
+        */
+       reg = of_get_property(node, "reg", NULL);
+       if (reg) {
+               addr = of_translate_address(node, reg);
+               if (addr != OF_BAD_ADDR) {
+                       dev_set_name(dev, "%llx.%s",
+                                    (unsigned long long)addr, node->name);
                        return;
                }
-
-               /* format arguments only used if dev_name() resolves to NULL */
-               dev_set_name(dev, dev_name(dev) ? "%s:%s" : "%s",
-                            strrchr(node->full_name, '/') + 1, dev_name(dev));
-               node = node->parent;
        }
+
+       /*
+        * No BusID, use the node name and add a globally incremented
+        * counter (and pray...)
+        */
+       magic = atomic_add_return(1, &bus_no_reg_magic);
+       dev_set_name(dev, "%s.%d", node->name, magic - 1);
 }

 /**


I have no real idea of how the OF core works so I'm a bit in the blue
here :-/

Any help appreciated!

Yours,
Linus Walleij
