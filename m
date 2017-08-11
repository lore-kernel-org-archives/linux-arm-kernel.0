From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Fri, 11 Aug 2017 08:42:33 -0700
Subject: [RFC/PATCH v4 1/4] Document nexus nodes/specifier remapping
In-Reply-To: <20170811154236.12891-1-stephen.boyd@linaro.org>
References: <20170811154236.12891-1-stephen.boyd@linaro.org>
Message-ID: <20170811154236.12891-2-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document the generic nexus node properties. This can be used by
any specifier that conforms to #<specifier>-cells where they
want to support remapping phandle lists through nexus nodes. This
is similar to interrupt remapping, but slightly different because
we don't consider unit addresses when doing mappings. This is
mostly a copy/paste of the interrupt specification, with the unit
address parts removed and generalized to any specifier. There's
also the addition of a pass through mechanism to make things more
compact if desired in the mapping table.

Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---

I still need to write the blurb about what this is all about, but
I wanted to send this out now to get early feedback. Some starting
points:

 1) Replace child/parent with incoming/outgoing everywhere?
 
 2) Make a pretty picture to describe remapping phandle+specifiers
    similar to the interrupt hierarchy diagram?

 3) Come up with some better name than <specifier>? Kernel-doc uses <list>
    but I'm not sure that's any better.

 source/devicetree-basics.rst | 208 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 208 insertions(+)

diff --git a/source/devicetree-basics.rst b/source/devicetree-basics.rst
index 02696bac15c7..b0571145ee40 100644
--- a/source/devicetree-basics.rst
+++ b/source/devicetree-basics.rst
@@ -1280,3 +1280,211 @@ performed:
 *  That result is looked up in the *interrupt-map* table, which maps to
    the parent interrupt specifier ``<4 1>``.
 
+.. _sect-nexus:
+
+Nexus Nodes and Specifier Mapping
+---------------------------------
+
+TODO: Write blurb here about nexus nodes and remapping them
+
+Nexus Node Properties
+~~~~~~~~~~~~~~~~~~~~~
+
+A nexus node shall have a *#<specifier>-cells* property, where <specifier> is
+some specifier space like 'gpio', 'clock', 'reset', etc.
+
+<specifier>-map
+^^^^^^^^^^^^^^^
+
+Property: ``<specifier>-map``
+
+Value type: ``<prop-encoded-array>`` encoded as an arbitrary number of
+specifier mapping entries.
+
+Description:
+
+   A *<specifier>-map* is a property in a nexus node that bridges one
+   specifier domain with a set of parent specifier domains and describes
+   how specifiers in the child domain are mapped to their respective parent
+   domains.
+
+   The map is a table where each row is a mapping entry
+   consisting of three components: *child specifier*, *specifier parent*, and
+   *parent specifier*.
+
+   child specifier
+       The specifier of the child node being mapped. The number
+       of 32-bit cells required to specify this component is described by
+       the *#<specifier>-cells* property of this node?the nexus node
+       containing the *<specifier>-map* property.
+
+   specifier parent
+       A single *<phandle>* value that points to the specifier parent to
+       which the child domain is being mapped.
+
+   parent specifier
+       The specifier in the parent domain. The number of 32-bit
+       cells required to specify this component is described by the
+       *#<specifier>-cells* property of the specifier parent node.
+
+   Lookups are performed on the mapping table by matching a specifier against
+   the child specifier in the map. Because some fields in the specifier may
+   not be relevant or need to be modified, a mask is applied before the lookup
+   is done. This mask is defined in the *<specifier>-map-mask* property (see
+   section :ref:`sect-specifier-map-mask`).
+
+   Similarly, when the specifier is mapped some fields in the unit specifier
+   may need to be kept unmodified and passed through from the child node to the
+   parent node. In this case, a *<specifier>-map-pass-thru* property (see
+   section :ref:`sect-specifier-map-pass-thru`) may be specified to apply
+   a mask to the incoming specifier and copy any bits that match to the outgoing
+   unit specifier.
+
+.. _sect-specifier-map-mask:
+
+<specifier>-map-mask
+^^^^^^^^^^^^^^^^^^^^
+
+Property: ``<specifier>-map-mask``
+
+Value type: ``<prop-encoded-array>`` encoded as a bit mask
+
+Description:
+
+   A *<specifier>-map-mask* property may be specified for a nexus node.
+   This property specifies a mask that is applied to the incoming unit
+   specifier being looked up in the table specified in the *<specifier>-map*
+   property. If this property is not specified, the mask is assumed to be
+   a mask with all bits set.
+
+.. _sect-specifier-map-pass-thru:
+
+<specifier>-map-pass-thru
+^^^^^^^^^^^^^^^^^^^^^^^^^
+
+Property: ``<specifier>-map-pass-thru``
+
+Value type: ``<prop-encoded-array>`` encoded as a bit mask
+
+Description:
+
+   A *<specifier>-map-pass-thru* property may be specified for a nexus node.
+   This property specifies a mask that is applied to the incoming unit
+   specifier being looked up in the table specified in the *<specifier>-map*
+   property. Any matching bits in the incoming unit specifier are copied over
+   to the outgoing specifier. If this property is not specified, the mask is
+   assumed to be a mask with no bits set.
+
+#<specifier>-cells
+^^^^^^^^^^^^^^^^^^
+
+Property: ``#<specifier>-cells``
+
+Value type: ``<u32>``
+
+Description:
+
+   The *#<specifier>-cells* property defines the number of cells required to
+   encode a specifier for a domain.
+
+Specifier Mapping Example
+~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The following shows the representation of a fragment of a devicetree with
+two GPIO controllers and a sample specifier map for describing the
+GPIO routing of a few gpios on both of the controllers through a connector
+on a board to a device. The expansion device node is one one side of the
+connector node and the SoC with the two GPIO controllers is on the other
+side of the connector.
+
+.. _example-specifier-mapping:
+
+.. code-block:: dts
+
+        soc {
+                soc_gpio1: gpio-controller1 {
+                        #gpio-cells = <2>;
+                };
+
+                soc_gpio2: gpio-controller2 {
+                        #gpio-cells = <2>;
+                };
+        };
+
+        connector: connector {
+                #gpio-cells = <2>;
+                gpio-map = <0 0 &soc_gpio1 1 0>,
+                           <1 0 &soc_gpio2 4 0>,
+                           <2 0 &soc_gpio1 3 0>,
+                           <3 0 &soc_gpio2 2 0>;
+                gpio-map-mask = <0xf 0x0>;
+                gpio-map-pass-thru = <0x0 0x1>;
+        };
+
+        expansion_device {
+                reset-gpios = <&connector 2 GPIO_ACTIVE_LOW>;
+        };
+
+
+Each row in the gpio-map table consists of three parts: a child unit
+specifier, which is mapped to a *gpio-controller*
+node with a parent specifier.
+
+* For example, the first row of the specifier-map table specifies the
+  mapping for GPIO 0 of the connector. The components of that row are shown
+  here
+
+  | child specifier: ``0 0``
+  | specifier parent: ``&soc_gpio1``
+  | parent specifier: ``1 0``
+
+  * The child specifier is ``<0 0>``, which specifies GPIO 0 in the connector
+    with a *flags* field of ``0``. This takes two 32-bit cells as specified
+    by the *#gpio-cells* property of the connector node, which is the
+    child specifier domian.
+
+  * The specifier parent is specified by a phandle which points to the
+    specifier parent of the connector, the first GPIO controller in the SoC.
+
+  * The parent specifier is ``<1 0>``. The number of cells to
+    represent the gpio specifier (two cells) is determined by the
+    *#gpio-cells* property on the specifier parent, the soc_gpio1
+    node.
+
+    * The value ``<1 0>`` is a value specified by the device binding for
+      the GPIO controller. The value ``<1>`` specifies the
+      GPIO pin number on the GPIO controller to which GPIO 0 on the connector
+      is wired. The value ``<0>`` specifies the flags (active low,
+      active high, etc.).
+
+In this example, the *gpio-map-mask* property has a value of ``<0xf 0>``.
+This mask is applied to a child unit specifier before performing a lookup in
+the *gpio-map* table. Similarly, the *gpio-map-pass-thru* property has a value
+of ``<0x0 0x1>``. This mask is applied to a child unit specifier when mapping
+it to the parent unit specifier. Any bits set in the mask are cleared out of
+the parent unit specifier and copied over from the child unit specifier
+to the parent unit specifier.
+
+To perform a lookup of the connector's specifier source number for GPIO 2
+from the expansion device's reset-gpios property, the following steps would be
+performed:
+
+*  The child specifier forms the value
+   ``<2 GPIO_ACTIVE_LOW>``.
+
+   *  The specifier is encoding GPIO 2 with active low flags per the GPIO
+      binding.
+
+*  The *gpio-map-mask* value ``<0xf 0x0>`` is applied, giving a
+   result of ``<0x2 0>``.
+
+*  That result is looked up in the *gpio-map* table, which maps to
+   the parent specifier ``<3 0>`` and &soc_gpio1 *phandle*.
+
+*  That *gpio-map-pass-thru* value ``<0x0 0x1>`` is applied to child specifier,
+   forming ``<0 GPIO_ACTIVE_LOW>`` which is then ORed with the parent
+   specifier ``<3 0>`` ANDed with the inverse of the pass-thru mask
+   ``<0xffffffff 0xffffffe>`` resulting in ``<3 GPIO_ACTIVE_LOW>``.
+
+*  That specifier is combined with the mapped *phandle* &soc_gpio1 resulting
+   in ``<&soc_gpio1 3 GPIO_ACTIVE_LOW>``.
-- 
2.7.4
