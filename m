From: vm.rod25@gmail.com (Victor Rodriguez)
Date: Fri, 3 Dec 2010 11:10:44 -0600
Subject: [PATCH v9 6/6] davinci: USB1.1 support for Omapl138-Hawkboard
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB5930247B9A907@dbde02.ent.ti.com>
References: <1291231949-23835-1-git-send-email-vm.rod25@gmail.com>
	<1291231949-23835-7-git-send-email-vm.rod25@gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB5930247AFDD7E@dbde02.ent.ti.com>
	<AANLkTinMGvRS4N2rSRp43Osnn_Df=JRAJB0iBdZLzrZ-@mail.gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB5930247B9A907@dbde02.ent.ti.com>
Message-ID: <AANLkTinwj27dSdv9Djs9Fv6QN5vv5JY+br4xCHk=8YEu@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 3, 2010 at 5:51 AM, Nori, Sekhar <nsekhar@ti.com> wrote:
> On Fri, Dec 03, 2010 at 06:14:39, Victor Rodriguez wrote:
>> On Thu, Dec 2, 2010 at 12:49 AM, Nori, Sekhar <nsekhar@ti.com> wrote:
>> > On Thu, Dec 02, 2010 at 01:02:29, vm.rod25 at gmail.com wrote:
>> >> +static int hawk_usb_ocic_notify(da8xx_ocic_handler_t handler)
>> >> +{
>> >> + ? ? int irq ? ? ? ? = gpio_to_irq(DA850_USB1_OC_PIN);
>> >> + ? ? int error ? ? ? = 0;
>> >> +
>> >> + ? ? if (handler != NULL) {
>> >> + ? ? ? ? ? ? hawk_usb_ocic_handler = handler;
>> >> +
>> >> + ? ? ? ? ? ? error = request_irq(irq, omapl138_hawk_usb_ocic_irq,
>> >> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? IRQF_DISABLED | IRQF_TRIGGER_RISING |
>> >> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? IRQF_TRIGGER_FALLING,
>> >> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? "OHCI over-current indicator", NULL);
>> >> + ? ? ? ? ? ? if (error)
>> >> + ? ? ? ? ? ? ? ? ? ? pr_err(KERN_ERR "%s: could not request IRQ to watch "
>> >> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? "over-current indicator changes\n", __func__);
>> >
>> > pr_err adds a KERN_ERR already.
>>
>> Changed to this
>>
>> static int hawk_usb_ocic_notify(da8xx_ocic_handler_t handler)
>> {
>> ? ? ? int irq ? ? ? ? = gpio_to_irq(DA850_USB1_OC_PIN);
>> ? ? ? int error ? ? ? = 0;
>>
>> ? ? ? if (handler != NULL) {
>> ? ? ? ? ? ? ? hawk_usb_ocic_handler = handler;
>>
>> ? ? ? ? ? ? ? error = request_irq(irq, omapl138_hawk_usb_ocic_irq,
>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? IRQF_DISABLED | IRQF_TRIGGER_RISING |
>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? IRQF_TRIGGER_FALLING,
>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? "OHCI over-current indicator", NULL);
>> ? ? ? ? ? ? ? if (error)
>> ? ? ? ? ? ? ? ? ? ? ? pr_err("%s: could not request IRQ to watch "
>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? "over-current indicator changes\n", __func__);
>
> Looks good. Thanks. The same error is present elsewhere in the
> patch and other patches too. Please fix those too.

Ok thanks for check it, I am sending the changes in a patch format ,
any way I will resend the series with the correction if it is ok
>>
>> USB part
>>
>> Changed to this
>>
>> ? ? ? if (ret < 0) {
>> ? ? ? ? ? ? ? pr_err("%s: failed to request GPIO for USB 1.1 port "
>> ? ? ? ? ? ? ? ? ? ? ? "power control: %d\n", __func__, ret);
>> ? ? ? ? ? ? ? gpio_free(DA850_USB1_VBUS_PIN);
>> ? ? ? ? ? ? ? return;
>> ? ? ? }
>>
>> ? ? ? ret = gpio_request_one(DA850_USB1_OC_PIN,
>> ? ? ? ? ? ? ? ? ? ? ? GPIOF_DIR_IN, "USB1 OC");
>> ? ? ? if (ret < 0) {
>> ? ? ? ? ? ? ? pr_err("%s: failed to request GPIO for USB 1.1 port "
>> ? ? ? ? ? ? ? ? ? ? ? "over-current indicator: %d\n", __func__, ret);
>> ? ? ? ? ? ? ? gpio_free(DA850_USB1_OC_PIN);
>> ? ? ? ? ? ? ? return;
>> ? ? ? }
>>
>> Patch 4/6
>>
>> ? ? ? ret = gpio_request_one(DA850_HAWK_MMCSD_CD_PIN,
>> ? ? ? ? ? ? ? ? ? ? ? GPIOF_DIR_IN, "MMC CD");
>> ? ? ? if (ret < 0) {
>> ? ? ? ? ? ? ? pr_warning("%s: can not open GPIO %d\n",
>> ? ? ? ? ? ? ? ? ? ? ? __func__, DA850_HAWK_MMCSD_CD_PIN);
>> ? ? ? ? ? ? ? gpio_free(DA850_HAWK_MMCSD_CD_PIN);
>> ? ? ? ? ? ? ? return;
>> ? ? ? }
>>
>> ? ? ? ret = gpio_request_one(DA850_HAWK_MMCSD_WP_PIN,
>> ? ? ? ? ? ? ? ? ? ? ? GPIOF_DIR_IN, "MMC WP");
>> ? ? ? if (ret < 0) {
>> ? ? ? ? ? ? ? pr_warning("%s: can not open GPIO %d\n",
>> ? ? ? ? ? ? ? ? ? ? ? __func__, DA850_HAWK_MMCSD_WP_PIN);
>> ? ? ? ? ? ? ? gpio_free(DA850_HAWK_MMCSD_WP_PIN);
>> ? ? ? ? ? ? ? return;
>> ? ? ? }
>>
>>
>> Is this ok ? or should I free the GPIO on the next section ? Same with USB
>
> Not sure what you mean by "next section"? goto based error recovery is
> more commonly used and probably more preferred as it is easier to extend.

I mean the next if

ret = da8xx_register_usb11(&omapl138_hawk_usb11_pdata);
	if (ret) {
		pr_warning("%s: USB 1.1 registration failed: %d\n",
			__func__, ret);
	}

> You can look at function da850_evm_ui_expander_setup() of
> arch/arm/mach-davinci/board-da850-evm.c for an example.

Thanks for the help I have free  the two gpio on the last registration
request error handler

check it on the next patch

---
 arch/arm/mach-davinci/board-omapl138-hawk.c |   38 ++++++++++++++++++++------
 1 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c
b/arch/arm/mach-davinci/board-omapl138-hawk.c
index da51136..8fc78f2 100644
--- a/arch/arm/mach-davinci/board-omapl138-hawk.c
+++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
@@ -157,7 +157,7 @@ static __init void omapl138_hawk_mmc_init(void)
 	if (ret < 0) {
 		pr_warning("%s: can not open GPIO %d\n",
 			__func__, DA850_HAWK_MMCSD_CD_PIN);
-		return;
+		goto exp_setup_cd_fail;
 	}

 	ret = gpio_request_one(DA850_HAWK_MMCSD_WP_PIN,
@@ -165,13 +165,23 @@ static __init void omapl138_hawk_mmc_init(void)
 	if (ret < 0) {
 		pr_warning("%s: can not open GPIO %d\n",
 			__func__, DA850_HAWK_MMCSD_WP_PIN);
-		return;
+		goto exp_setup_wp_fail;
 	}

 	ret = da8xx_register_mmcsd0(&da850_mmc_config);
-	if (ret)
+	if (ret) {
 		pr_warning("%s: MMC/SD0 registration failed: %d\n",
 			__func__, ret);
+		goto exp_setup_mmcsd_fail;
+	}
+		return;
+
+exp_setup_mmcsd_fail:
+	gpio_free(DA850_HAWK_MMCSD_WP_PIN);
+exp_setup_wp_fail:
+	gpio_free(DA850_HAWK_MMCSD_CD_PIN);
+exp_setup_cd_fail:
+		return;
 }

 static irqreturn_t omapl138_hawk_usb_ocic_irq(int irq, void *dev_id);
@@ -211,7 +221,7 @@ static int
hawk_usb_ocic_notify(da8xx_ocic_handler_t handler)
 					IRQF_TRIGGER_FALLING,
 					"OHCI over-current indicator", NULL);
 		if (error)
-			pr_err(KERN_ERR "%s: could not request IRQ to watch "
+			pr_err("%s: could not request IRQ to watch "
 				"over-current indicator changes\n", __func__);
 	} else {
 		free_irq(irq, NULL);
@@ -256,23 +266,33 @@ static __init void omapl138_hawk_usb_init(void)
 	ret = gpio_request_one(DA850_USB1_VBUS_PIN,
 			GPIOF_DIR_OUT, "USB1 VBUS");
 	if (ret < 0) {
-		pr_err(KERN_ERR "%s: failed to request GPIO for USB 1.1 port "
+		pr_err("%s: failed to request GPIO for USB 1.1 port "
 			"power control: %d\n", __func__, ret);
-		return;
+		goto exp_setup_vbus_fail;
 	}

 	ret = gpio_request_one(DA850_USB1_OC_PIN,
 			GPIOF_DIR_IN, "USB1 OC");
 	if (ret < 0) {
-		pr_err(KERN_ERR "%s: failed to request GPIO for USB 1.1 port "
+		pr_err("%s: failed to request GPIO for USB 1.1 port "
 			"over-current indicator: %d\n", __func__, ret);
-		return;
+		goto exp_setup_oc_fail;
 	}

 	ret = da8xx_register_usb11(&omapl138_hawk_usb11_pdata);
-	if (ret)
+	if (ret) {
 		pr_warning("%s: USB 1.1 registration failed: %d\n",
 			__func__, ret);
+		goto exp_setup_usb11_fail;
+	}
+		return;
+
+exp_setup_usb11_fail:
+	gpio_free(DA850_USB1_OC_PIN);
+exp_setup_oc_fail:
+	gpio_free(DA850_USB1_VBUS_PIN);
+exp_setup_vbus_fail:
+		return;
 }

 static struct davinci_uart_config omapl138_hawk_uart_config __initdata = {
-- 
1.7.0.4


I have already compiled and tested. If it is ok for you I will resend
the patches with the corrections

Thanks a lot for your help

Regards

Victor Rodriguez


> Thanks,
> Sekhar
>
>
