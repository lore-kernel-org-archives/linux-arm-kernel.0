From: prylowski@metasoft.pl (Rafal Prylowski)
Date: Wed, 04 Apr 2012 10:41:06 +0200
Subject: [PATCH v2 2/3] ep93xx: IDE driver platform support code
In-Reply-To: <ADE657CA350FB648AAC2C43247A983F0020698409DF4@AUSP01VMBX24.collaborationhost.net>
References: <4F7B0C54.8010804@metasoft.pl> <4F7B0D6C.1010801@metasoft.pl>
 <ADE657CA350FB648AAC2C43247A983F0020698409DF4@AUSP01VMBX24.collaborationhost.net>
Message-ID: <4F7C0922.1070200@metasoft.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2012-04-03 19:41, H Hartley Sweeten wrote:
> On Tuesday, April 03, 2012 7:47 AM, Rafal Prylowski wrote:
>>
>> +int ep93xx_ide_acquire_gpio(struct platform_device *pdev)
>> +{
>> +	int err;
>> +	int i;
>> +
>> +	for (i = 2; i < 8; i++) {
>> +		err = gpio_request(EP93XX_GPIO_LINE_E(i), dev_name(&pdev->dev));
>> +		if (err)
>> +			goto fail_gpio_e;
>> +	}
>> +	for (i = 4; i < 8; i++) {
>> +		err = gpio_request(EP93XX_GPIO_LINE_G(i), dev_name(&pdev->dev));
>> +		if (err)
>> +			goto fail_gpio_g;
>> +	}
>> +	for (i = 0; i < 8; i++) {
>> +		err = gpio_request(EP93XX_GPIO_LINE_H(i), dev_name(&pdev->dev));
>> +		if (err)
>> +			goto fail_gpio_h;
>> +	}
>> +
>> +	/* GPIO ports E[7:2], G[7:4] and H used by IDE */
>> +	ep93xx_devcfg_clear_bits(EP93XX_SYSCON_DEVCFG_EONIDE |
>> +				 EP93XX_SYSCON_DEVCFG_GONIDE |
>> +				 EP93XX_SYSCON_DEVCFG_HONIDE);
>> +	return 0;
>> +
>> +fail_gpio_h:
>> +	for (--i; i >= 0; --i)
>> +		gpio_free(EP93XX_GPIO_LINE_H(i));
>> +	i = 8;
>> +fail_gpio_g:
>> +	for (--i; i >= 4; --i)
>> +		gpio_free(EP93XX_GPIO_LINE_G(i));
>> +	i = 8;
>> +fail_gpio_e:
>> +	for (--i; i >= 2; --i)
>> +		gpio_free(EP93XX_GPIO_LINE_E(i));
>> +	return err;
>> +}
>> +EXPORT_SYMBOL(ep93xx_ide_acquire_gpio);

[not related to my patch, but ep93xx keypad]:
Isn't ep93xx_keypad_acquire_gpio be more correct if we apply the following patch:

Index: linux-2.6/arch/arm/mach-ep93xx/core.c
===================================================================
--- linux-2.6.orig/arch/arm/mach-ep93xx/core.c
+++ linux-2.6/arch/arm/mach-ep93xx/core.c
@@ -734,7 +734,7 @@ int ep93xx_keypad_acquire_gpio(struct pl
 fail_gpio_d:
 	gpio_free(EP93XX_GPIO_LINE_C(i));
 fail_gpio_c:
-	for ( ; i >= 0; --i) {
+	for (--i; i >= 0; --i) {
 		gpio_free(EP93XX_GPIO_LINE_C(i));
 		gpio_free(EP93XX_GPIO_LINE_D(i));
 	}

This way we don't double free EP93XX_GPIO_LINE_C(i), and don't free lines which were not
successfully acquired (I noticed this when writing my patch, which is based on
ep93xx_keypad_acquire/release_gpio).

Thanks,
RP
