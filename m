From: hdegoede@redhat.com (Hans de Goede)
Date: Wed,  9 Sep 2015 11:11:23 +0200
Subject: [PATCH 1/4] devicetree: bindings: Update gpio-keys-polled with
 support for abs/rel axis
Message-ID: <1441789886-5868-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The devicetree binding for gpio-keys-polled already allows specifying
what type of events (key / rel / abs) a button generates when pressed.

But for rel / abs axis we also need to specify which value this specific
gpio represents.

One usecase is digital joysticks / direction-pads which are hooked up to
gpio, in this case we've left and right buttons which we want to map to
EV_ABS, ABS_X and we want generate events for left with a value of -1 and
for right with a value of +1 (and similar for up / down and ABS_Y).

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 Documentation/devicetree/bindings/input/gpio-keys-polled.txt | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/input/gpio-keys-polled.txt b/Documentation/devicetree/bindings/input/gpio-keys-polled.txt
index 313abef..ab4b09b 100644
--- a/Documentation/devicetree/bindings/input/gpio-keys-polled.txt
+++ b/Documentation/devicetree/bindings/input/gpio-keys-polled.txt
@@ -13,11 +13,16 @@ Subnode properties:
 
 	- gpios: OF device-tree gpio specification.
 	- label: Descriptive name of the key.
-	- linux,code: Keycode to emit.
+	- linux,code: Key / Axis code to emit.
 
 Optional subnode-properties:
 	- linux,input-type: Specify event type this button/key generates.
 	  If not specified defaults to <1> == EV_KEY.
+	- linux,input-value: If linux,input-type is EV_ABS or EV_REL then this
+	  value is send for events this button generates when pressed.
+	  EV_ABS axis will generate an event with a value of 0 when all
+	  buttons with linux,input-type == EV_ABS and linux,code == axis
+	  are released.
 	- debounce-interval: Debouncing interval time in milliseconds.
 	  If not specified defaults to 5.
 	- gpio-key,wakeup: Boolean, button can wake-up the system.
-- 
2.4.3
