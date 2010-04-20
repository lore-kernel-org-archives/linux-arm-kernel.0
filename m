From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 20 Apr 2010 14:58:53 +0800
Subject: zaurus spitz suspend/resume issue
In-Reply-To: <20100419133540.GA1191@ucw.cz>
References: <i2i1f96a3531004181200ve1f71c03ydb7b4328cbcc6e26@mail.gmail.com>
	<20100419133540.GA1191@ucw.cz>
Message-ID: <i2pf17812d71004192358hd49d803nf82b44d5f3585212@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 19, 2010 at 9:35 PM, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
>> ? ?Since resuming my spitz from a suspended state doesn't work in 2.6.34-rc3
>> ? ?at the moment, I've tried to find out what the problem is with
>> ? ?suspend/resume. Using CONFIG_PM_DEBUG I tried to test this by setting
>> ? ?/sys/power/pm_test to "core" and switching the device off with the power
>> ? ?button. This indeed suspends and resumes the device, but shows following
>> ? ?in the system log:
>
> It works here.
>

Or maybe we should allow these GPIOs to wakeup the system when either
configured as generic GPIOs or keypad GPIOs.

Cortez,

Could you give the following patch a try?

commit a510268069ed9ad0931339d6dc835ef4f1588876
Author: Eric Miao <eric.y.miao@gmail.com>
Date:   Tue Apr 20 14:52:50 2010 +0800

    [ARM] pxa: allow keypad GPIOs to wakeup when configured as generic

    Signed-off-by: Eric Miao <eric.y.miao@gmail.com>

diff --git a/arch/arm/mach-pxa/mfp-pxa2xx.c b/arch/arm/mach-pxa/mfp-pxa2xx.c
index cf6b720..29301d2 100644
--- a/arch/arm/mach-pxa/mfp-pxa2xx.c
+++ b/arch/arm/mach-pxa/mfp-pxa2xx.c
@@ -178,8 +178,17 @@ int gpio_set_wake(unsigned int gpio, unsigned int on)
 	if (!d->valid)
 		return -EINVAL;

-	if (d->keypad_gpio)
-		return -EINVAL;
+	/* Allow keypad GPIOs to wakeup system when
+	 * configured as generic GPIOs.
+	 */
+	if (d->keypad_gpio && (MFP_AF(d->config) == 0) &&
+	    (d->config & MFP_LPM_CAN_WAKEUP)) {
+		if (on)
+			PKWR |= d->mask;
+		else
+			PKWR &= ~d->mask;
+		return 0;
+	}

 	mux_taken = (PWER & d->mux_mask) & (~d->mask);
 	if (on && mux_taken)
@@ -239,21 +248,25 @@ static int pxa27x_pkwr_gpio[] = {
 int keypad_set_wake(unsigned int on)
 {
 	unsigned int i, gpio, mask = 0;
-
-	if (!on) {
-		PKWR = 0;
-		return 0;
-	}
+	struct gpio_desc *d;

 	for (i = 0; i < ARRAY_SIZE(pxa27x_pkwr_gpio); i++) {

 		gpio = pxa27x_pkwr_gpio[i];
+		d = &gpio_desc[gpio];

-		if (gpio_desc[gpio].config & MFP_LPM_CAN_WAKEUP)
+		/* skip if configured as generic GPIO */
+		if (MFP_AF(d->config) == 0)
+			continue;
+
+		if (d->config & MFP_LPM_CAN_WAKEUP)
 			mask |= gpio_desc[gpio].mask;
 	}

-	PKWR = mask;
+	if (on)
+		PKWR |= mask;
+	else
+		PKWR &= ~mask;
 	return 0;
 }
