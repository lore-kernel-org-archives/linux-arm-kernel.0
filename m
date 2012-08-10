From: p.paneri@samsung.com (Praveen Paneri)
Date: Fri, 10 Aug 2012 11:17:29 +0530
Subject: [PATCH v3 0/5] usb: phy: samsung: Introducing usb phy driver for
 samsung SoCs
In-Reply-To: <502464FE.3000908@samsung.com>
References: <1344411661-17821-1-git-send-email-p.paneri@samsung.com>
 <502464FE.3000908@samsung.com>
Message-ID: <CAD6zSYP33PDrXwifQM=7q+Esk1X7m5+DNG_=A2a-qTENk4zq8w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 10, 2012 at 7:03 AM, Joonyoung Shim <jy0922.shim@samsung.com> wrote:
> Hi, Praveen.
>
>
> On 08/08/2012 04:40 PM, Praveen Paneri wrote:
>>
>> Changes from v2:
>> Changed the driver filenames to samsung-usbphy
>> Changed 's3c' to 'samsung' for platform device as well as platform data
>> Moved platform data structure to a separate file
>> Rectified coding style related errors
>>
>> Changes from v1:
>> Rebased patches to latest usb-next branch
>> Changed the name 'sec_usbphy' to 'samsung_usbphy'
>>
>> This patch set introduces a phy driver for samsung SoCs. It uses the
>> existing
>> transceiver infrastructure to provide phy control functions. Use of this
>> driver
>> can be extended for usb host phy as well.
>
>
> How can you support usb host phy? I cannot choose to use which phy when
> call init or shutdown of phy at current phy framework.
If you are talking about choosing between PHY0 (for device) and PHY1
(for host), I think you can make use of the flags available in usb_phy
to pass that information to phy driver and that can be handled there.
This is just one way I have successfully implement two different phy
control. There might be a better way to do that.

Thanks
Praveen
>
> Thanks.
>
>> Over the period of time all the phy
>> related code for most of the samsung SoCs can be integrated here.
>> Removing the existing phy code from mach-s3c64xx. Same can be done for
>> other SoCs
>> when they start supporting this phy driver.
>> This driver is tested with smdk6410 and Exynos4210(with DT).
>>
>> Praveen Paneri (5):
>>    usb: phy: samsung: Introducing usb phy driver for hsotg
>>    usb: s3c-hsotg: Adding phy driver support
>>    ARM: S3C64XX: Removing old phy setup code
>>    ARM: S3C64XX: Enabling samsung-usbphy driver
>>    ARM: Exynos4210: Enabling samsung-usbphy driver
>>
>>   .../devicetree/bindings/usb/samsung-usbphy.txt     |    9 +
>>   arch/arm/boot/dts/exynos4210.dtsi                  |    5 +
>>   arch/arm/mach-exynos/include/mach/map.h            |    1 +
>>   arch/arm/mach-exynos/mach-exynos4-dt.c             |    8 +
>>   arch/arm/mach-exynos/setup-usb-phy.c               |   13 +
>>   arch/arm/mach-s3c64xx/include/mach/map.h           |    2 +
>>   arch/arm/mach-s3c64xx/mach-crag6410.c              |    7 +-
>>   arch/arm/mach-s3c64xx/mach-smartq.c                |    8 +-
>>   arch/arm/mach-s3c64xx/mach-smdk6410.c              |    7 +-
>>   arch/arm/mach-s3c64xx/setup-usb-phy.c              |   79 +----
>>   arch/arm/plat-samsung/devs.c                       |   33 ++
>>   arch/arm/plat-samsung/include/plat/devs.h          |    1 +
>>   arch/arm/plat-samsung/include/plat/usb-phy.h       |    1 +
>>   drivers/usb/gadget/s3c-hsotg.c                     |   40 ++-
>>   drivers/usb/phy/Kconfig                            |    8 +
>>   drivers/usb/phy/Makefile                           |    1 +
>>   drivers/usb/phy/samsung-usbphy.c                   |  355
>> ++++++++++++++++++++
>>   drivers/usb/phy/samsung-usbphy.h                   |   48 +++
>>   include/linux/platform_data/samsung-usbphy.h       |   27 ++
>>   19 files changed, 562 insertions(+), 91 deletions(-)
>>   create mode 100644
>> Documentation/devicetree/bindings/usb/samsung-usbphy.txt
>>   create mode 100644 drivers/usb/phy/samsung-usbphy.c
>>   create mode 100644 drivers/usb/phy/samsung-usbphy.h
>>   create mode 100644 include/linux/platform_data/samsung-usbphy.h
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc"
> in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
