From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed,  3 May 2017 13:59:54 +0200
Subject: [PATCH v2 17/20] dt-bindings: display: sun4i: Add allwinner,
 tcon-channel property
In-Reply-To: <cover.d697f34bb7b0605c5e76cbc4167a64453e5e0984.1493812478.git-series.maxime.ripard@free-electrons.com>
References: <cover.d697f34bb7b0605c5e76cbc4167a64453e5e0984.1493812478.git-series.maxime.ripard@free-electrons.com>
Message-ID: <2f00be9d75b68090ffed30654be65132a156a317.1493812478.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Allwinner Timings Controller has two, mutually exclusive, channels.
When the binding has been introduced, it was assumed that there would be
only a single user per channel in the system.

While this is likely for the channel 0 which only connects to LCD displays,
it turns out that the channel 1 can be connected to multiple controllers in
the SoC (HDMI and TV encoders for example). And while the simultaneous use
of HDMI and TV outputs cannot be achieved, switching from one to the other
at runtime definitely sounds plausible.

Add an extra property, allwinner,tcon-channel, to specify for a given
endpoint which TCON channel it is connected to, while falling back to the
previous mechanism if that property is missing.

Acked-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt | 11 ++++---
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
index 91ce2c920750..acdc0c17c00e 100644
--- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
+++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
@@ -75,10 +75,13 @@ Required properties:
   Documentation/devicetree/bindings/media/video-interfaces.txt. The
   first port should be the input endpoint, the second one the output
 
-  The output should have two endpoints. The first is the block
-  connected to the TCON channel 0 (usually a panel or a bridge), the
-  second the block connected to the TCON channel 1 (usually the TV
-  encoder)
+  The output may have multiple endpoints. The TCON has two channels,
+  usually with the first channel being used for the panels interfaces
+  (RGB, LVDS, etc.), and the second being used for the outputs that
+  require another controller (TV Encoder, HDMI, etc.). The endpoints
+  will take an extra property, allwinner,tcon-channel, to specify the
+  channel the endpoint is associated to. If that property is not
+  present, the endpoint number will be used as the channel number.
 
 On SoCs other than the A33, there is one more clock required:
    - 'tcon-ch1': The clock driving the TCON channel 1
-- 
git-series 0.8.11
