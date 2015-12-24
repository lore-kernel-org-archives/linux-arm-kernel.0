From: contact@paulk.fr (Paul Kocialkowski)
Date: Thu, 24 Dec 2015 19:12:53 +0100
Subject: [PATCH 4/6] regulator: lp872x: Add enable GPIO pin support
In-Reply-To: <20151223115632.GS16023@sirena.org.uk>
References: <1450868319-20513-1-git-send-email-contact@paulk.fr>
 <1450868319-20513-5-git-send-email-contact@paulk.fr>
 <20151223115632.GS16023@sirena.org.uk>
Message-ID: <1450980773.11913.3.camel@collins>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le mercredi 23 d?cembre 2015 ? 11:56 +0000, Mark Brown a ?crit :
> On Wed, Dec 23, 2015 at 11:58:37AM +0100, Paul Kocialkowski wrote:
> 
> > +	gpio = lp->pdata->enable_gpio;
> > +	if (!gpio_is_valid(gpio))
> > +		return 0;
> > +
> > +	/* Always set enable GPIO high. */
> > +	ret = devm_gpio_request_one(lp->dev, gpio, GPIOF_OUT_INIT_HIGH, "LP872X EN");
> > +	if (ret) {
> > +		dev_err(lp->dev, "gpio request err: %d\n", ret);
> > +		return ret;
> > +	}
> 
> This isn't really adding support for the enable GPIO as the changelog
> suggests, it's requesting but not managing the GPIO.  Since there is
> core support for manging enable GPIOs this seems especially silly,
> please tell the core about the GPIO and then it will work at runtime
> too.

It looks like the core bindings for GPIO can only be used instead of the
rdev->desc->ops->enable callback, not jointly, which doesn't fit my use
case, where both the GPIO and register write have to be used to enable
regulators.

I think it would be worth making it possible to use both in core, since
that situation is probably shared with other regulators. I suggest the
following diff (that would be split into a separate patch in v2 of this
series):

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index e92f344..dd0674f 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1963,7 +1963,6 @@ static int regulator_ena_gpio_ctrl(struct
regulator_dev *rdev, bool enable)
 		if (pin->enable_count == 0)
 			gpiod_set_value_cansleep(pin->gpiod,
 						 !pin->ena_gpio_invert);
-
 		pin->enable_count++;
 	} else {
 		if (pin->enable_count > 1) {
@@ -2063,6 +2062,14 @@ static int _regulator_do_enable(struct
regulator_dev *rdev)
 		}
 	}
 
+	if (rdev->desc->ops->enable) {
+		ret = rdev->desc->ops->enable(rdev);
+		if (ret < 0)
+			return ret;
+	} else if (!rdev->ena_pin) {
+		return -EINVAL;
+	}
+
 	if (rdev->ena_pin) {
 		if (!rdev->ena_gpio_state) {
 			ret = regulator_ena_gpio_ctrl(rdev, true);
@@ -2070,10 +2077,6 @@ static int _regulator_do_enable(struct
regulator_dev *rdev)
 				return ret;
 			rdev->ena_gpio_state = 1;
 		}
-	} else if (rdev->desc->ops->enable) {
-		ret = rdev->desc->ops->enable(rdev);
-		if (ret < 0)
-			return ret;
 	} else {
 		return -EINVAL;
 	}
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151224/1f3f065a/attachment.sig>
