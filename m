From: p.paneri@samsung.com (Praveen Paneri)
Date: Wed, 14 Nov 2012 09:54:29 +0530
Subject: [PATCH v7 0/5] usb: phy: samsung: Introducing usb phy driver for
 samsung SoCs
In-Reply-To: <CAD6zSYM5-GdGHYH=W-My34oXRfH0M+rfettFa0fiit3-_V1RDA@mail.gmail.com>
References: <1351573057-22249-1-git-send-email-p.paneri@samsung.com>
 <20121109115440.GC8078@arwen.pp.htv.fi>
 <CAH9JG2X1a8MqBpnk8uHRjsGnaD7uob5GBhUh_aS5iCprEvi2XQ@mail.gmail.com>
 <CAD6zSYN6xpHt54d-w=6veb6AErTq6ERQcneo7ewC-qsBoMuThQ@mail.gmail.com>
 <20121109135441.GC8567@arwen.pp.htv.fi>
 <004201cdc08f$fa0fd3d0$ee2f7b70$%kim@samsung.com>
 <CAD6zSYM5-GdGHYH=W-My34oXRfH0M+rfettFa0fiit3-_V1RDA@mail.gmail.com>
Message-ID: <CAD6zSYPv0a3ZAUTVxQB4Ou9kThMLsnv9e0aofWm0kAF_nhS3-A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kukjin, Felipe,

Since the issue is only with arch patches, which I am going to resolve
asap, Will it be possible for you to consider taking only driver
patches? I can resend arch patches separately to linux-samsung after
updating if Kukjin is also fine with that?

Thanks,
Praveen

On Wed, Nov 14, 2012 at 9:38 AM, Praveen Paneri <p.paneri@samsung.com> wrote:
> Hi,
>
> On Mon, Nov 12, 2012 at 10:11 AM, Kukjin Kim <kgene.kim@samsung.com> wrote:
>> Felipe Balbi wrote:
>>>
>>> Hi,
>>>
>> Hi :-)
>>
>> [...]
>>
>>> Sure, but I still need Kukjin's 'say-so' for the arch/arm/plat-samsung
>>> and arch/arm/mach-exynos part.
>>>
>> Basically, this approach looks OK to me.
>>
>> BTW, I have some comments and need to update...
> Thanks! I highly appreciate your comments. It would have been even
> better if I had got these before the closing bell.
>>
>> From 4th patch...
>>
>>> diff --git a/arch/arm/mach-s3c64xx/mach-smdk6410.c b/arch/arm/mach-
>>> s3c64xx/mach-smdk6410.c
>>
>> [...]
>>
>>> @@ -72,6 +73,8 @@
>>>  #include <linux/platform_data/touchscreen-s3c2410.h>
>>>  #include <plat/keypad.h>
>>>  #include <plat/backlight.h>
>>> +#include <plat/regs-fb-v4.h>
> Well it comes from an older state where without this it was giving a
> build error. Although it shouldn't have been here. Will fix it.
>>
>> Why? In addition, this causes build error with s3c6400_defconfig.
>>
>> [...]
>>
>>> diff --git a/arch/arm/plat-samsung/devs.c b/arch/arm/plat-samsung/devs.c
>>> index 03f654d..9cdb666 100644
>>
>> [...]
>>
>>> @@ -1370,6 +1371,30 @@ struct platform_device s5p_device_mixer = {
>>>
>>>  /* USB */
>>>
>>> +#ifdef CONFIG_S3C_DEV_USB_HSOTG
>>> +/* USB PHY*/
>>> +static struct resource samsung_usbphy_resource[] = {
>>> +     [0] = {
>>> +             .start = S3C_PA_USB_PHY,
>>> +             .end   = S3C_PA_USB_PHY + SZ_16 - 1,
>>> +             .flags = IORESOURCE_MEM,
>>> +     },
>>> +};
>>
>> +static struct resource samsung_usbphy_resource[] = {
>> +       [0] = DEFINED_RES_MEM(S3C_PA_USB_PHY, SZ_16),
>> +};
>>
>> [...]
>>
>> Happens build error with s5pv210_defconfig
>>
>> arch/arm/plat-samsung/devs.c:1375: error: 'S3C_PA_USB_PHY' undeclared here
>> (not in a function)
>> make[2]: *** [arch/arm/plat-samsung/devs.o] Error 1
>> make[1]: *** [arch/arm/plat-samsung] Error 2
>> make[1]: *** Waiting for unfinished jobs....
>>
>> And another build error with exynos_defconfig...
> Will check for both the configs and resolve it.
>
> Thanks,
> Praveen
>>
>> arch/arm/mach-exynos/built-in.o: In function `.LANCHOR1':
>> setup-i2c0.c:(.data+0x8080): undefined reference to
>> `s5p_usb_phy_pmu_isolation'
>>
>> From 5th patch....
>>
>> If possible, please to use 'ARM: [sub-arch dir name]: [subject]' format.
>> So I preferred to use 'ARM: EXYNOS: Enabling samsung-usbphy driver for
>> EXYNOS4210' on that.
>>
>> Please make sure your patch has no problem for kernel compilation before
>> submitting...
>>
>> Thanks.
>>
>> Best regards,
>> Kgene.
>> --
>> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
>> SW Solution Development Team, Samsung Electronics Co., Ltd.
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
