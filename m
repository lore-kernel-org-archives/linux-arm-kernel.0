From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 21 Dec 2017 12:02:30 +0100
Subject: [PATCH v5 04/12] dt-bindings: display: sun4i-drm: Add A83T pipeline
In-Reply-To: <cover.e5a47cc96ec5274dd932daa2bde47df073087da9.1513854122.git-series.maxime.ripard@free-electrons.com>
References: <cover.e5a47cc96ec5274dd932daa2bde47df073087da9.1513854122.git-series.maxime.ripard@free-electrons.com>
Message-ID: <2702a5c1d224af1c51743492ad1b917966f2ad43.1513854122.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A83T has two video pipelines in parallel that looks quite similar to
the other SoCs.

The video planes are handled through a controller called the mixer, and the
video signal is then passed to the timing controller (TCON).

And while there is two instances of the mixers and TCONs, they have a
significant number of differences. The TCONs are quite easy to deal with,
one is supposed to generate TV (in the broader term, so including things
like HDMI) signals, the other one LCD (so RGB, LVDS, DSI) signals. And
while they are called TCON0 and TCON1 in the A83t datasheet, newer SoCs
call them TCON-TV and TCON-LCD, which seems more appropriate.

However, the mixers differ mostly by their capabilities, with some features
being available only in the first one, or the number of planes they expose,
but also through their register layout. And while the capabilities could be
represented as properties, the register layout differences would need to
express all the registers offsets as properties, which is usually quite
bad. Especially since documentation on that hardware block is close to
non-existant and we don't even have the list of all those registers in the
first place.

So let's call them mixer 0 and 1 in our compatibles, even though the name
is pretty bad...

At the moment, we only have tested the code on a board that has a single
display output, so we're leaving the tcon-tv and mixer1 out.

Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
index 1e21cfaac9e2..9f073af4c711 100644
--- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
+++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
@@ -93,6 +93,7 @@ Required properties:
    * allwinner,sun6i-a31s-tcon
    * allwinner,sun7i-a20-tcon
    * allwinner,sun8i-a33-tcon
+   * allwinner,sun8i-a83t-tcon-lcd
    * allwinner,sun8i-v3s-tcon
  - reg: base address and size of memory-mapped region
  - interrupts: interrupt associated to this IP
@@ -225,6 +226,7 @@ supported.
 
 Required properties:
   - compatible: value must be one of:
+    * allwinner,sun8i-a83t-de2-mixer-0
     * allwinner,sun8i-v3s-de2-mixer
   - reg: base address and size of the memory-mapped region.
   - clocks: phandles to the clocks feeding the mixer
@@ -254,6 +256,7 @@ Required properties:
     * allwinner,sun6i-a31s-display-engine
     * allwinner,sun7i-a20-display-engine
     * allwinner,sun8i-a33-display-engine
+    * allwinner,sun8i-a83t-display-engine
     * allwinner,sun8i-v3s-display-engine
 
   - allwinner,pipelines: list of phandle to the display engine
-- 
git-series 0.9.1
