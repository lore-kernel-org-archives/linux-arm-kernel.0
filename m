From: chunkeey@gmail.com (Christian Lamparter)
Date: Thu, 05 Apr 2018 18:35:24 +0200
Subject: [PATCH v2] pinctrl: msm: fix gpio-hog related boot issues
In-Reply-To: <20180402150447.GH510@tuxbook-pro>
References: <20180402121005.10080-1-chunkeey@gmail.com>
 <20180402150447.GH510@tuxbook-pro>
Message-ID: <2820412.JxDUeWI2ec@debian64>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Montag, 2. April 2018 17:04:47 CEST Bjorn Andersson wrote:
> On Mon 02 Apr 05:10 PDT 2018, Christian Lamparter wrote:
> > diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
> > index 495432f3341b..258fa357d946 100644
> > --- a/drivers/pinctrl/qcom/pinctrl-msm.c
> > +++ b/drivers/pinctrl/qcom/pinctrl-msm.c
> > @@ -831,11 +831,22 @@ static int msm_gpio_init(struct msm_pinctrl *pctrl)
> >  		return ret;
> >  	}
> >  
> > -	ret = gpiochip_add_pin_range(&pctrl->chip, dev_name(pctrl->dev), 0, 0, chip->ngpio);
> > -	if (ret) {
> > -		dev_err(pctrl->dev, "Failed to add pin range\n");
> > -		gpiochip_remove(&pctrl->chip);
> > -		return ret;
> > +	if (!is_of_node(pctrl->dev->fwnode)) {
> 
> Afaict this still means that if I boot this kernel with yesterday's dtb
> (without gpio-ranges) I will not get any gpios. This isn't okay. 
Ok, fair point. I drop this chunk.
 
> @Linus, I count 24 callers of gpiochip_add_pin_range(). Is this
> suggestion reasonable?
> 
> Can we make gpiochip_add_pin_range() check if there's already a
> gpio-range and return ok in some way?

Looks like Linus is currently really busy updating the gemini
target (a lot of work went into it) for OpenWrt.
<https://lists.openwrt.org/pipermail/openwrt-devel/2018-April/043752.html>
(Kinda funny, because I do help to maintain the apm821xx and the new 
ipq40xx target over there.)

In any case, I implemented your suggestion and it does look reasonable.
The gpiolib already uses the gpio_offset as an ID of some sorts. For
now I went with a simple ID value check, but this could be extended to
a range/intersection check if necessary. But then again, let's not
overengineer it. Comments are welcome, I'll wait around till sometime
next week before I post v3.

Regards,
Christian
---
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index d66de67ef307..21c0f88e1159 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2013,6 +2013,19 @@ int gpiochip_generic_config(struct gpio_chip *chip, unsigned offset,
 }
 EXPORT_SYMBOL_GPL(gpiochip_generic_config);
 
+static struct gpio_pin_range *gpiochip_find_by_id(struct gpio_chip *chip,
+						  unsigned int id)
+{
+	struct gpio_pin_range *pin_range;
+	struct gpio_device *gdev = chip->gpiodev;
+
+	list_for_each_entry(pin_range, &gdev->pin_ranges, node) {
+		if (pin_range->range.id == id)
+			return pin_range;
+	}
+	return NULL;
+}
+
 #ifdef CONFIG_PINCTRL
 
 /**
@@ -2030,6 +2043,20 @@ int gpiochip_add_pingroup_range(struct gpio_chip *chip,
 	struct gpio_device *gdev = chip->gpiodev;
 	int ret;
 
+	/*
+	 * look if a GPIO range with the same ID has already been registered.
+	 * For pinctrls that are set up through devicetree, the GPIO Range
+	 * might be already set by the the gpio-ranges property.
+	 * (see Documentation/devicetree/bindings/gpio/gpio.txt)
+	 */
+	pin_range = gpiochip_find_by_id(chip, gpio_offset);
+	if (pin_range) {
+		chip_dbg(chip, "found existing GPIO range %d->%d - skipping\n",
+				gpio_offset,
+				gpio_offset + pin_range->range.npins - 1);
+		return 0;
+	}
+
 	pin_range = kzalloc(sizeof(*pin_range), GFP_KERNEL);
 	if (!pin_range) {
 		chip_err(chip, "failed to allocate pin ranges\n");
@@ -2083,6 +2110,20 @@ int gpiochip_add_pin_range(struct gpio_chip *chip, const char *pinctl_name,
 	struct gpio_device *gdev = chip->gpiodev;
 	int ret;
 
+	/*
+	 * look if a GPIO range with the same ID has already been registered.
+	 * For pinctrls that are set up through devicetree, the GPIO Range
+	 * might be already set by the the gpio-ranges property.
+	 * (see Documentation/devicetree/bindings/gpio/gpio.txt)
+	 */
+	pin_range = gpiochip_find_by_id(chip, gpio_offset);
+	if (pin_range) {
+		chip_dbg(chip, "found existing GPIO range %d->%d - skipping\n",
+			 gpio_offset,
+			 gpio_offset + pin_range->range.npins - 1);
+		return 0;
+	}
+
 	pin_range = kzalloc(sizeof(*pin_range), GFP_KERNEL);
 	if (!pin_range) {
 		chip_err(chip, "failed to allocate pin ranges\n");
---
