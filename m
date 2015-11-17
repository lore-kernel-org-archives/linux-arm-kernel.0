From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 17 Nov 2015 17:21:50 +0900
Subject: [PATCH] ARM: sunxi: Re-enable SID driver in multi_v7_defconfig
In-Reply-To: <1447747294.6274.8.camel@silentcreek.de>
References: <1447724947-4851-1-git-send-email-public_timo.s@silentcreek.de>
 <564A8CAD.8050004@samsung.com>
 <1447747294.6274.8.camel@silentcreek.de>
Message-ID: <CAJKOXPdBnMcoFDuVMm3zgDcZwDVfeotySvAbO+bvzDX0T-AX4g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-11-17 17:01 GMT+09:00 Timo Sigurdsson <public_timo.s@silentcreek.de>:
> Hi,
>
> Am Dienstag, den 17.11.2015, 11:10 +0900 schrieb Krzysztof Kozlowski:
>> On 17.11.2015 10:49, Timo Sigurdsson wrote:
>> > Commit 3d0b16a66c8a ("nvmem: sunxi: Move the SID driver to the nvmem
>> > framework") moved the the sunxi SID driver to a new framework, but left
>> > multi_v7_defconfig with the deprecated config symbol EEPROM_SUNXI_SID
>> > instead of the new symbold NVMEM_SUNXI_SID. Hence, re-enable the driver
>> > in multi_v7_defconfig.
>> >
>> > While at it, clean up multi_v7_defconfig by generating a fresh file via
>> >   make multi_v7_defconfig
>> >   make savedefconfig
>> > While this moves around a few lines and removes unnecessary symbols,
>> > it doesn't introduce any functional changes.
>>
>> Split it per change. One change is savedefconfig and second is removing
>> or enabling other drivers.
> Ok, I can do that.
>
>>
>> On which tree you generated the defconfig? There is a minor nit below
>> (at least for Exynos platform, I did not checked the others).
>
> The patch was based on torvalds/master (at v4.4-rc1), but I checked
> and it applies on linux-next/master just fine.

You cannot base such patch on mainline because you can overwrite (or
disregard) other people's patches already waiting in next. Although we
are just after rc1 so there shouldn't be much new stuff in linux-next
but still - please base on next.

>
>>
>> >
>> > Signed-off-by: Timo Sigurdsson <public_timo.s@silentcreek.de>
>> >
>> > diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
>> > index 69a22fd..f712ea3 100644
>> > --- a/arch/arm/configs/multi_v7_defconfig
>> > +++ b/arch/arm/configs/multi_v7_defconfig
>>
>> (...)
>>
>> > @@ -450,8 +431,7 @@ CONFIG_MEDIA_CAMERA_SUPPORT=y
>> >  CONFIG_MEDIA_CONTROLLER=y
>> >  CONFIG_VIDEO_V4L2_SUBDEV_API=y
>> >  CONFIG_MEDIA_USB_SUPPORT=y
>> > -CONFIG_USB_VIDEO_CLASS=y
>> > -CONFIG_USB_GSPCA=y
>> > +CONFIG_USB_VIDEO_CLASS=m
>> >  CONFIG_V4L_PLATFORM_DRIVERS=y
>> >  CONFIG_SOC_CAMERA=m
>> >  CONFIG_SOC_CAMERA_PLATFORM=m
>> > @@ -465,28 +445,25 @@ CONFIG_DRM=y
>> >  CONFIG_DRM_I2C_ADV7511=m
>> >  # CONFIG_DRM_I2C_CH7006 is not set
>> >  # CONFIG_DRM_I2C_SIL164 is not set
>> > -CONFIG_DRM_NXP_PTN3460=m
>> > -CONFIG_DRM_PARADE_PS8622=m
>> >  CONFIG_DRM_NOUVEAU=m
>> >  CONFIG_DRM_EXYNOS=m
>> > -CONFIG_DRM_EXYNOS_DSI=y
>> >  CONFIG_DRM_EXYNOS_FIMD=y
>> > -CONFIG_DRM_EXYNOS_HDMI=y
>>
>> I would prefer leaving the EXYNOS_HDMI. Dependencies are now not enabled
>> but we are fixing it in:
>> http://www.spinics.net/lists/dri-devel/msg93299.html
>
> I think the problem here is that I don't see this patch in linux-next
> yet.
>

Indeed... and I don't know when it will go there so actually maybe it
should be removed... but in the same time removing DRM_EXYNOS_HDMI
will probably make some conflicts because mentioned patch will go
through Exynos DRM tree or Samsung SoC.

Best regards,
Krzysztof
