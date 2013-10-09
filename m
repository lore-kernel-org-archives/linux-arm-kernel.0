From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 9 Oct 2013 13:42:04 +0800
Subject: [PATCH] pinctrl: phandle entries will be applied sequentially
Message-ID: <1381297324-19006-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's naturally expected that when there are multiple phandle entries
specified in pinctrl-* property, these entries will be applied
sequentially.  And this is how Linux kernel works.  So let's define
this behavior in the binding doc.

The behavior is useful when people want to reuse a group of predefined
pins with only minor configuration adjustment on one particular pin.
They will only need to add another entry after the predefined one with
needed configuration on that particular pin to overwrite the predefined
configuration.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 .../bindings/pinctrl/pinctrl-bindings.txt          |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
index 1958ca9..404ba32 100644
--- a/Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
+++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
@@ -50,7 +50,13 @@ pinctrl-0:	List of phandles, each pointing at a pin configuration
 		entries may exist in this list so that multiple pin
 		controllers may be configured, or so that a state may be built
 		from multiple nodes for a single pin controller, each
-		contributing part of the overall configuration. See the next
+		contributing part of the overall configuration. These entries
+		will be applied sequentially. If there are multiple entries
+		contributing the configuration of the same pin, the latter
+		will overwrite the former. However, this 'overwrite' mechanism
+		should be used with the caution that it could cause some ill
+		effect, e.g. a glitch on the pin when pull down/up setting
+		gets flipped in this 'overwrite'.  See the next
 		section of this document for details of the format of these
 		pin configuration nodes.
 
-- 
1.7.9.5
