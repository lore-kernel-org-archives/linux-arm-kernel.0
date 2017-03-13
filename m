From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 13 Mar 2017 20:56:04 +0100
Subject: [PATCH 4/4] RFT: irqchip: replace moxa with ftintc010
In-Reply-To: <CACmBeS2rNKnJKsFXeqwuCO5YBgfO8Nv=Wr+cG8DS-gfpfsxENg@mail.gmail.com>
References: <20170311231505.16056-1-linus.walleij@linaro.org>
 <CACmBeS2rNKnJKsFXeqwuCO5YBgfO8Nv=Wr+cG8DS-gfpfsxENg@mail.gmail.com>
Message-ID: <CACRpkdYExzp0zRdnYad6XG+58saeCUNNN04-n+hPR-X=1gezOQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 13, 2017 at 5:05 PM, Jonas Jensen <jonas.jensen@gmail.com> wrote:

> Log [1] is with MMC unavailable (another issue that needs a fix in DT)
> and [2] when MMC is there.
>
> I suspect some of the IRQ flags in arch/arm/boot/dts/moxart.dtsi may
> not be set right / they don't match up against the "interrupt-mask"
> property we probably want to get rid of. Any tips on what those flags
> really should be?

Probably the irq trigger setting is wrong indeed.

The old moxa driver does this:

ret = of_property_read_u32(node, "interrupt-mask",
                                  &intc.interrupt_mask);
writel(intc.interrupt_mask, intc.base + IRQ_MODE_REG);
writel(intc.interrupt_mask, intc.base + IRQ_LEVEL_REG);

Then it doesn't implement .set_type() so the flags on the
individual lines get ignored.

In the moxart.dtsi it looks like so:
interrupt-mask = <0x00080000>;

Which means all IRQs get IRQ_TYPE_LEVEL_HIGH
except irq 19 which gets IRQ_TYPE_EDGE_FALLING
which is the same that Gemini is doing.

Can you try the following patch? If it works I will queue
this too.

Flag 8 = LEVEL_LOW seems very weird for the
serial so I adjusted it to LEVEL_HIGH, but if serial stops
working try setting it to IRQ_TYPE_LEVEL_LOW.


>From 3ca61eca2a2fbcdc213443648100908db54913be Mon Sep 17 00:00:00 2001
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 13 Mar 2017 20:50:15 +0100
Subject: [PATCH] ARM: dts: Adjust moxart IRQ controller and flags

The moxart interrupt line flags were not respected in previous
driver: instead of assigning them per-consumer, a fixes mask
was set in the controller.

With the migration to a standard Faraday driver we need to
set up and handle the consumer flags correctly. Also remove
the Moxart-specific flags when switching to using real consumer
flags.

Extend the register window to 0x100 bytes as we may have a few
more registers in there and it doesn't hurt.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/moxart.dtsi | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/moxart.dtsi b/arch/arm/boot/dts/moxart.dtsi
index 10a8184e0ce9..7d10d06ee265 100644
--- a/arch/arm/boot/dts/moxart.dtsi
+++ b/arch/arm/boot/dts/moxart.dtsi
@@ -6,6 +6,7 @@
  */

 /include/ "skeleton.dtsi"
+#include <dt-bindings/interrupt-controller/irq.h>

 / {
     compatible = "moxa,moxart";
@@ -36,11 +37,10 @@
         ranges;

         intc: interrupt-controller at 98800000 {
-            compatible = "moxa,moxart-ic";
-            reg = <0x98800000 0x38>;
+            compatible = "moxa,moxart-ic", "faraday,ftintc010";
+            reg = <0x98800000 0x100>;
             interrupt-controller;
             #interrupt-cells = <2>;
-            interrupt-mask = <0x00080000>;
         };

         clk_pll: clk_pll at 98100000 {
@@ -59,7 +59,7 @@
         timer: timer at 98400000 {
             compatible = "moxa,moxart-timer";
             reg = <0x98400000 0x42>;
-            interrupts = <19 1>;
+            interrupts = <19 IRQ_TYPE_EDGE_FALLING>;
             clocks = <&clk_apb>;
         };

@@ -80,7 +80,7 @@
         dma: dma at 90500000 {
             compatible = "moxa,moxart-dma";
             reg = <0x90500080 0x40>;
-            interrupts = <24 0>;
+            interrupts = <24 IRQ_TYPE_LEVEL_HIGH>;
             #dma-cells = <1>;
         };

@@ -93,7 +93,7 @@
         sdhci: sdhci at 98e00000 {
             compatible = "moxa,moxart-sdhci";
             reg = <0x98e00000 0x5C>;
-            interrupts = <5 0>;
+            interrupts = <5 IRQ_TYPE_LEVEL_HIGH>;
             clocks = <&clk_apb>;
             dmas =  <&dma 5>,
                 <&dma 5>;
@@ -120,7 +120,7 @@
         mac0: mac at 90900000 {
             compatible = "moxa,moxart-mac";
             reg = <0x90900000 0x90>;
-            interrupts = <25 0>;
+            interrupts = <25 IRQ_TYPE_LEVEL_HIGH>;
             phy-handle = <&ethphy0>;
             phy-mode = "mii";
             status = "disabled";
@@ -129,7 +129,7 @@
         mac1: mac at 92000000 {
             compatible = "moxa,moxart-mac";
             reg = <0x92000000 0x90>;
-            interrupts = <27 0>;
+            interrupts = <27 IRQ_TYPE_LEVEL_HIGH>;
             phy-handle = <&ethphy1>;
             phy-mode = "mii";
             status = "disabled";
@@ -138,7 +138,7 @@
         uart0: uart at 98200000 {
             compatible = "ns16550a";
             reg = <0x98200000 0x20>;
-            interrupts = <31 8>;
+            interrupts = <31 IRQ_TYPE_LEVEL_HIGH>;
             reg-shift = <2>;
             reg-io-width = <4>;
             clock-frequency = <14745600>;
-- 
2.9.3


Yours,
Linus Walleij
