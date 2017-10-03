From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 3 Oct 2017 15:03:11 -0700
Subject: [PATCH 0/2] [v5] pinctrl: qcom: add support for sparse GPIOs
In-Reply-To: <255ad0dc-2d16-ae7f-0b45-500e23cff1a4@codeaurora.org>
References: <1504798409-32041-1-git-send-email-timur@codeaurora.org>
 <20170919070422.GI3349@codeaurora.org>
 <CACRpkdZcdLac_wYW+XqtZ=-APo8VmvYL4B1oL-wZyLy8KEs9AA@mail.gmail.com>
 <1ecdf6ee-5098-15d3-f85e-66b39a6c25f9@codeaurora.org>
 <CACRpkdaUV1Mjh7U9bBAgZA5Zq1oqN0HBT=VH5NkvPnY4gHxDVw@mail.gmail.com>
 <d53e67a2-4f69-752f-ba35-53872d9b9760@codeaurora.org>
 <CACRpkdYfAcKrgbgybccurUKTyR0E+tHDyzp7sbXxXxKuyMOGhQ@mail.gmail.com>
 <619f48d2-59c7-c090-4ace-9e8db9f92064@codeaurora.org>
 <CACRpkdZFunwQ=tiQqsapap7Ozz42hr=df5vqbC0S5xy5Wn+ZWw@mail.gmail.com>
 <255ad0dc-2d16-ae7f-0b45-500e23cff1a4@codeaurora.org>
Message-ID: <20171003220311.GU457@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/22, Timur Tabi wrote:
> On 09/22/2017 08:29 AM, Linus Walleij wrote:
> >
> >What is your response to Stephen's comment:
> >
> >>[Stephen Boyd]
> >>Perhaps we can add another hook for our purposes here that
> >>tells gpiolib that the gpio is not usable and to skip it. The
> >>semantics would be clear, it's just about probing availability of
> >>this pin as a gpio and doesn't mux any pins.
> 
> >I think this kind of related to my response (after I realized it
> >was not just about IRQs):
> 
> We already have 95% of this.  We can already specify individual pin
> ranges, and the vast majority of the code recognizes the ranges.
> There is only one small loophole, and that's in gpiochip_add_data().
> The for-loop iterates over all GPIOs:
> 
> 	for (i = 0; i < chip->ngpio; i++) {
> 		struct gpio_desc *desc = &gdev->descs[i];
> 
> 		desc->gdev = gdev;
> 		/*
> 		 * REVISIT: most hardware initializes GPIOs as inputs
> 		 * (often with pullups enabled) so power usage is
> 		 * minimized. Linux code should set the gpio direction
> 		 * first thing; but until it does, and in case
> 		 * chip->get_direction is not set, we may expose the
> 		 * wrong direction in sysfs.
> 		 */
> 
> I believe the real problem is that this for-loop should be moved
> from gpiochip_add_data() into some other function that is called
> *after* the pin ranges are defined.  We can put it in
> gpiochip_add_pin_range(), maybe.
> 
> My patch covers the loophole by adding a check inside
> get_direction(). If we fix gpiochip_add_data(), I can remove that
> patch.
> 
> However, I think that change is risky and will require a lot of
> testing and review.
> 

I've run into this now on our mobile SoCs after I pull in commit
8e51533780ba ("pinctrl: qcom: add get_direction function").
Before that commit we never read each pin of the device. On our
mobile SoCs we have devicetree and it feels like having that
describe which pins are available and not available is
half-duplicating information we would already have via consumers
indicating which pins they care about. I don't see any value
beyond system wide debug in figuring out the default pin
configuration of a pin that doesn't have a consumer in Linux.

Could we remove the pin direction finding part here in
gpiochip_add_pin_range() and lazily resolve the pin direction
when a pin is requested? We would need a similar check in the msm
specific debugfs code where we skip pins that aren't requested.
This is basically a revert of commit 72d320006177 ("gpio: set up
initial state from .get_direction()").

ACPI can still describe only the pin ranges that they care about
exposing, but from the devicetree side it's been working well
enough to not touch pins that aren't used by anything in Linux.

---8<----
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index cd003b74512f..673028823bc5 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1210,16 +1210,7 @@ int gpiochip_add_data(struct gpio_chip *chip, void *data)
 		 * wrong direction in sysfs.
 		 */
 
-		if (chip->get_direction) {
-			/*
-			 * If we have .get_direction, set up the initial
-			 * direction flag from the hardware.
-			 */
-			int dir = chip->get_direction(chip, i);
-
-			if (!dir)
-				set_bit(FLAG_IS_OUT, &desc->flags);
-		} else if (!chip->direction_input) {
+		if (!chip->direction_input) {
 			/*
 			 * If the chip lacks the .direction_input callback
 			 * we logically assume all lines are outputs.
diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index 273badd92561..4a0aeceb42f1 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -24,7 +24,7 @@
 #include <linux/pinctrl/pinconf.h>
 #include <linux/pinctrl/pinconf-generic.h>
 #include <linux/slab.h>
-#include <linux/gpio.h>
+#include <linux/gpio/driver.h>
 #include <linux/interrupt.h>
 #include <linux/spinlock.h>
 #include <linux/reboot.h>
@@ -494,6 +494,12 @@ static void msm_gpio_dbg_show_one(struct seq_file *s,
 	};
 
 	g = &pctrl->soc->groups[offset];
+
+	if (!gpiochip_is_requested(chip, gpio)) {
+		seq_printf(s, " %-8s:", g->name);
+		return;
+	}
+
 	ctl_reg = readl(pctrl->regs + g->ctl_reg);
 
 	is_out = !!(ctl_reg & BIT(g->oe_bit));

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
