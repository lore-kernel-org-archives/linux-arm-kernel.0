From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 04 Jul 2012 16:29:12 +0100
Subject: [PATCH 04/15] mfd: ab8500: Register devices using the newly DT:ed
 MFD API
In-Reply-To: <20120702151437.GO22065@sortiz-mobl>
References: <1340197011-5435-1-git-send-email-lee.jones@linaro.org>
 <1340197011-5435-5-git-send-email-lee.jones@linaro.org>
 <20120629150924.GG22806@sortiz-mobl> <4FEDD212.4020209@linaro.org>
 <20120629185047.GY22806@sortiz-mobl> <4FF17202.9080106@linaro.org>
 <20120702151437.GO22065@sortiz-mobl>
Message-ID: <4FF46148.9000409@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sam,

> On Mon, Jul 02, 2012 at 11:03:46AM +0100, Lee Jones wrote:
>>>>> This one does not apply properly against my for-next branch. Could you please
>>>>> generate a new one for me ?
>>>>
>>>> Hmm... we have a problem.
>>>>
>>>> I have the new patch based on -next, but I can't test it, as -next
>>>> is broken for Snowball. Hence why I'm still using rc2. Do you want
>>>> it anyway?
>>> Yes. And once Snowball is working with -next, I'll take a patch fix from you
>>> if necessary.
>>
>> Okay, this one applies on -next:
>>
>> From: Lee Jones <lee.jones@linaro.org>
>> Date: Wed, 20 Jun 2012 08:48:33 +0100
>> Subject: [PATCH 1/1] mfd: ab8500: Register devices using the newly DT:ed MFD
>>   API
>>
>> Now the MFD API is Device Tree aware we can use it for platform
>> registration again, even when booting with DT enabled. To aid in
>> Device Node pointer allocation we provide each cell with the
>> associative compatible string.
>>
>> Cc: Samuel Ortiz <sameo@linux.intel.com>
>> Signed-off-by: Lee Jones <lee.jones@linaro.org>
>> ---
>>   arch/arm/mach-ux500/board-mop500.c |    1 -
>>   drivers/mfd/ab8500-core.c          |   64 ++++++++++++++++++++++--------------
>>   drivers/mfd/ab8500-debugfs.c       |    6 ----
>>   drivers/mfd/ab8500-gpadc.c         |    6 ----
>>   drivers/mfd/ab8500-sysctrl.c       |    6 ----
>>   drivers/misc/ab8500-pwm.c          |    6 ----
>>   drivers/regulator/ab8500.c         |    6 ----
>>   drivers/rtc/rtc-ab8500.c           |    7 ----
>>   drivers/usb/otg/ab8500-usb.c       |    6 ----
>>   9 files changed, 39 insertions(+), 69 deletions(-)
> Applied, although rtc-ab8500.c and ab8500-usb.c did not need any changes.
> Please check commit 47e1f40fcb12f976e7769f75c04c65828ed5da75 on my for-next
> branch to see if I missed anything.

Looks like the rtc-ab8500 and ponkey-ab8500 just made it into next. Please use the patch below to complement the one above. Thanks.

From: Lee Jones <lee.jones@linaro.org>
Date: Wed, 20 Jun 2012 08:48:33 +0100
Subject: [PATCH 1/1] mfd: ab8500: Clean-up the last two ab8500 related DT
 match tables

A patch was recently submitted to stop all ab8500 devices from
being registered through Device Tree. Instead, only the db8500
will be DT:ed and the rest will continue to be registered via
the MFD API, as they always were.

Two patches have recently been applied which enable Device Tree
probing; one for rtc-ab8500 and the other for ponkey-ab8500.
These two need to be removed to prevent double-probing these
devices with Device Tree is enabled.

Cc: Samuel Ortiz <sameo@linux.intel.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/input/misc/ab8500-ponkey.c |    8 --------
 drivers/rtc/rtc-ab8500.c           |    6 ------
 2 files changed, 14 deletions(-)

diff --git a/drivers/input/misc/ab8500-ponkey.c b/drivers/input/misc/ab8500-ponkey.c
index 84ec691..5ceb23e 100644
--- a/drivers/input/misc/ab8500-ponkey.c
+++ b/drivers/input/misc/ab8500-ponkey.c
@@ -132,18 +132,10 @@ static int __devexit ab8500_ponkey_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_OF
-static const struct of_device_id ab8500_ponkey_match[] = {
-	{ .compatible = "stericsson,ab8500-ponkey", },
-	{}
-};
-#endif
-
 static struct platform_driver ab8500_ponkey_driver = {
 	.driver		= {
 		.name	= "ab8500-poweron-key",
 		.owner	= THIS_MODULE,
-		.of_match_table = of_match_ptr(ab8500_ponkey_match),
 	},
 	.probe		= ab8500_ponkey_probe,
 	.remove		= __devexit_p(ab8500_ponkey_remove),
diff --git a/drivers/rtc/rtc-ab8500.c b/drivers/rtc/rtc-ab8500.c
index bf3c2f6..2e5970f 100644
--- a/drivers/rtc/rtc-ab8500.c
+++ b/drivers/rtc/rtc-ab8500.c
@@ -462,16 +462,10 @@ static int __devexit ab8500_rtc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id ab8500_rtc_match[] = {
-	{ .compatible = "stericsson,b8500-rtc", },
-	{}
-};
-
 static struct platform_driver ab8500_rtc_driver = {
 	.driver = {
 		.name = "ab8500-rtc",
 		.owner = THIS_MODULE,
-		.of_match_table = ab8500_rtc_match,
 	},
 	.probe	= ab8500_rtc_probe,
 	.remove = __devexit_p(ab8500_rtc_remove),
-- 
1.7.9.5


-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515 
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
