From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 18 May 2012 11:12:17 +0000
Subject: [PATCH 12/18] ARM: ux500: Disable platform setup of the ab8500
 when DT is enabled
In-Reply-To: <4FB62BE5.7030003@linaro.org>
References: <1337262323-27692-1-git-send-email-lee.jones@linaro.org>
 <201205181038.36949.arnd@arndb.de> <4FB62BE5.7030003@linaro.org>
Message-ID: <201205181112.17254.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 18 May 2012, Lee Jones wrote:
> > Well, as far as I can tell, you duplicated a lot of functions or
> > data structures so you can remove the parts one by one, but when you
> > duplicated snowball_platform_devs[] you did not also duplicate
> > mop500_platform_devs[].
> 
> That's true, but why would I have done? I would think that whoever 
> writes the DT for that platform would do that?
 
In order to not break them when you add the nodes to their device tree? ;-)

> So I see four ways round this: 1) disable all the nodes in db8500.dtsi 
> and force snowball.dts and mop500.dts et. al to re-enable them as 
> appropriate. 2) duplicate mop500_platform_devs[] for DT booting and 
> strip out the ab8500 entry, essentially only leaving in only
> mop500_gpio_keys_device, 3) DT gpio-keys for the mop500 and do away with 
> platform_add()ing mop500_platform_devs[] in u8500_init_machine() 
> altogether. Or my personal favorite 4) as there is no DT or compatible 
> entry for st-ericsson,mop500 or st-ericsson,hrefv60+ yet, don't worry 
> about it and let whoever enables DT for those platforms (me?) to deal 
> with at a later date.

Well, you've got a point there that no device tree has been written
yet for those boards. I think my preference would be 2), since you can
do that in a way that actually removes code (see below), but it's also
fine if you want to leave it as is for now.

	Arnd

diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index 182dc4e..4ca56615 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -806,8 +806,7 @@ static void __init u8500_init_machine(void)
 
 	parent = u8500_init_devices();
 
-	for (i = 0; i < ARRAY_SIZE(mop500_platform_devs); i++)
-		mop500_platform_devs[i]->dev.parent = parent;
+	mop500_gpio_keys_device.parent = parent;
 	for (i = 0; i < ARRAY_SIZE(snowball_platform_devs); i++)
 		snowball_platform_devs[i]->dev.parent = parent;
 
@@ -816,9 +815,7 @@ static void __init u8500_init_machine(void)
 
 	if (of_machine_is_compatible("st-ericsson,mop500")) {
 		mop500_gpio_keys[0].gpio = GPIO_PROX_SENSOR;
-
-		platform_add_devices(mop500_platform_devs,
-				ARRAY_SIZE(mop500_platform_devs));
+		platform_device_register(&mop500_gpio_keys_device);
 
 		mop500_sdi_init(parent);
 
@@ -839,8 +836,7 @@ static void __init u8500_init_machine(void)
 		 * instead.
 		 */
 		mop500_gpio_keys[0].gpio = HREFV60_PROX_SENSE_GPIO;
-		platform_add_devices(mop500_platform_devs,
-				ARRAY_SIZE(mop500_platform_devs));
+		platform_device_register(&mop500_gpio_keys_device);
 
 		hrefv60_sdi_init(parent);
 
