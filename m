From: simon.guinot@sequanux.org (Simon Guinot)
Date: Tue, 23 Jun 2015 20:12:03 +0200
Subject: [RESEND PATCH 1/4] leds: leds-ns2: move LED modes mapping
 outside of the driver
In-Reply-To: <55881C85.1050809@samsung.com>
References: <1434640650-28086-1-git-send-email-simon.guinot@sequanux.org>
 <1434640650-28086-2-git-send-email-simon.guinot@sequanux.org>
 <55881C85.1050809@samsung.com>
Message-ID: <20150623181203.GE4853@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 22, 2015 at 04:32:37PM +0200, Jacek Anaszewski wrote:
> Hi Simon,

Hi Jacek,

Thanks for taking care of this patches.

> 
> On 06/18/2015 05:17 PM, Simon Guinot wrote:
> >From: Vincent Donnefort <vdonnefort@gmail.com>
> >
> >On the board n090401 (Seagate NAS 4-Bay), the LED mode mapping (GPIO
> >values to LED mode) is different from the one used on other boards
> >supported by the leds-ns2 driver.
> >
> >With this patch the hardcoded mapping is removed from leds-ns2. Now,
> >it must be defined either in the platform data (if an old-fashion board
> >setup file is used) or in the DT node. In order to allow the later, this
> >patch also introduces a modes-map property for the leds-ns2 DT binding.
> >
> >Signed-off-by: Vincent Donnefort <vdonnefort@gmail.com>
> >---
> >  .../devicetree/bindings/leds/leds-ns2.txt          |   9 ++
> >  drivers/leds/leds-ns2.c                            | 102 +++++++++++----------
> >  include/dt-bindings/leds/leds-ns2.h                |   8 ++
> >  include/linux/platform_data/leds-kirkwood-ns2.h    |  14 +++
> >  4 files changed, 85 insertions(+), 48 deletions(-)
> >  create mode 100644 include/dt-bindings/leds/leds-ns2.h
> >
> >diff --git a/Documentation/devicetree/bindings/leds/leds-ns2.txt b/Documentation/devicetree/bindings/leds/leds-ns2.txt
> >index aef3aca34d2d..9f81258a5b6e 100644
> >--- a/Documentation/devicetree/bindings/leds/leds-ns2.txt
> >+++ b/Documentation/devicetree/bindings/leds/leds-ns2.txt
> >@@ -8,6 +8,9 @@ Each LED is represented as a sub-node of the ns2-leds device.
> >  Required sub-node properties:
> >  - cmd-gpio: Command LED GPIO. See OF device-tree GPIO specification.
> >  - slow-gpio: Slow LED GPIO. See OF device-tree GPIO specification.
> >+- modes-map: A mapping between LED modes (off, on or SATA activity blinking) and
> >+  the corresponding cmd-gpio/slow-gpio values. All the GPIO values combinations
> >+  should be given in order to avoid having an unknown mode at driver probe time.
> >
> >  Optional sub-node properties:
> >  - label: Name for this LED. If omitted, the label is taken from the node name.
> >@@ -15,6 +18,8 @@ Optional sub-node properties:
> >
> >  Example:
> >
> >+#include <dt-bindings/leds/leds-ns2.h>
> >+
> >  ns2-leds {
> >  	compatible = "lacie,ns2-leds";
> >
> >@@ -22,5 +27,9 @@ ns2-leds {
> >  		label = "ns2:blue:sata";
> >  		slow-gpio = <&gpio0 29 0>;
> >  		cmd-gpio = <&gpio0 30 0>;
> >+		modes-map = <NS_V2_LED_OFF  0 1
> >+			     NS_V2_LED_ON   1 0
> >+			     NS_V2_LED_ON   0 0
> >+			     NS_V2_LED_SATA 1 1>;
> >  	};
> >  };
> 
> This looks good to me but please cc devicetree at vger.kernel.org when you
> modify DT bindings.

OK.

> 
> >diff --git a/drivers/leds/leds-ns2.c b/drivers/leds/leds-ns2.c
> >index 1fd6adbb43b7..b0bc03539dbb 100644
> >--- a/drivers/leds/leds-ns2.c
> >+++ b/drivers/leds/leds-ns2.c
> >@@ -33,46 +33,20 @@
> >  #include <linux/of_gpio.h>
> >
> >  /*
> >- * The Network Space v2 dual-GPIO LED is wired to a CPLD and can blink in
> >- * relation with the SATA activity. This capability is exposed through the
> >- * "sata" sysfs attribute.
> >- *
> >- * The following array detail the different LED registers and the combination
> >- * of their possible values:
> >- *
> >- *  cmd_led   |  slow_led  | /SATA active | LED state
> >- *            |            |              |
> >- *     1      |     0      |      x       |  off
> >- *     -      |     1      |      x       |  on
> >- *     0      |     0      |      1       |  on
> >- *     0      |     0      |      0       |  blink (rate 300ms)
> >+ * The Network Space v2 dual-GPIO LED is wired to a CPLD. Three different LED
> >+ * modes are available: off, on and SATA activity blinking. The LED modes are
> >+ * controlled through two GPIOs (command and slow): each combination of values
> >+ * for the command/slow GPIOs corresponds to a LED mode.
> >   */
> >
> >-enum ns2_led_modes {
> >-	NS_V2_LED_OFF,
> >-	NS_V2_LED_ON,
> >-	NS_V2_LED_SATA,
> >-};
> >-
> >-struct ns2_led_mode_value {
> >-	enum ns2_led_modes	mode;
> >-	int			cmd_level;
> >-	int			slow_level;
> >-};
> >-
> >-static struct ns2_led_mode_value ns2_led_modval[] = {
> >-	{ NS_V2_LED_OFF	, 1, 0 },
> >-	{ NS_V2_LED_ON	, 0, 1 },
> >-	{ NS_V2_LED_ON	, 1, 1 },
> >-	{ NS_V2_LED_SATA, 0, 0 },
> >-};
> >-

...

> >+	led = leds;
> >  	for_each_child_of_node(np, child) {
> >  		const char *string;
> >-		int ret;
> >+		int ret, i, num_modes;
> >+		struct ns2_led_modval *modval;
> >
> >  		ret = of_get_named_gpio(child, "cmd-gpio", 0);
> >  		if (ret < 0)
> >  			return ret;
> >-		leds[i].cmd = ret;
> >+		led->cmd = ret;
> >  		ret = of_get_named_gpio(child, "slow-gpio", 0);
> >  		if (ret < 0)
> >  			return ret;
> >-		leds[i].slow = ret;
> >+		led->slow = ret;
> >  		ret = of_property_read_string(child, "label", &string);
> >-		leds[i].name = (ret == 0) ? string : child->name;
> >+		led->name = (ret == 0) ? string : child->name;
> >  		ret = of_property_read_string(child, "linux,default-trigger",
> >  					      &string);
> >  		if (ret == 0)
> >-			leds[i].default_trigger = string;
> >+			led->default_trigger = string;
> >+
> >+		ret = of_property_count_u32_elems(child, "modes-map");
> 
> I think that we shouldn't fail if the property is absent, but default
> to the mapping that is currently hard coded in the driver. Otherwise
> we would break existing users.

I don't think there is a risk of breaking existing users. On platforms
where the leds-ns2 driver is used, DTB will be updated with the kernel
image. Moreover, removing the hard coded mapping is a nice clean-up.

Let me know if you still want me to add a fallback.

Thanks,

Simon
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150623/ba8ccd4d/attachment.sig>
