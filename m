From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Mon, 16 Mar 2015 12:28:42 +0100
Subject: [PATCH 3/3] ARM: dts: Define stdout-path property for Spring board
In-Reply-To: <5506B908.1060007@suse.de>
References: <1426501710-24177-1-git-send-email-javier.martinez@collabora.co.uk>
 <1426501710-24177-4-git-send-email-javier.martinez@collabora.co.uk>
 <5506B908.1060007@suse.de>
Message-ID: <CABxcv=mmr-WWXY7-KUJe-3EP8FHRBzv-SabJma9VwGRPiHio3Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Andreas,

>> index f02775487cd4..b9ec763a5602 100644
>> --- a/arch/arm/boot/dts/exynos5250-spring.dts
>> +++ b/arch/arm/boot/dts/exynos5250-spring.dts
>> @@ -25,6 +25,7 @@
>>
>>       chosen {
>>               bootargs = "console=tty1";
>> +             stdout-path = "serial3:115200n8";
>
> Is this a guess or did you verify that against some schematics?
>

I don't have access to the Spring schematics but it is based on what
is defined in the vendor u-boot for Spring [0].

There isn't a Spring specific configuration file but only a
chromeos_daisy.h which is shared by Snow, Spring and Kate (not yet in
mainline):

#define CONFIG_DIRECT_BOOTARGS \
"console=ttySAC3," STRINGIFY(CONFIG_BAUDRATE) " debug earlyprintk"

So I assumed that all daisy-based Chromebooks use the same UART for debug.

>>       };
>>
>>       gpio-keys {
>
> Assuming that bootargs still work,
>

Yes, the semantics are not changed. The std-out property is only used
as a default if no console= parameter is passed so if you already are
passing one in your bootloader or using the one defined in the /chosen
bootargs by enabling CONFIG_ARM_ATAG_DTB_COMPAT_CMDLINE_EXTEND, that
will be used instead of std-out.

> Reviewed-by: Andreas F?rber <afaerber@suse.de>
>
> I do wonder why this mechanism could not point to the same location as
> bootargs? ("dp-controller"?) The device does not even have screws for

I did wonder the same indeed but I don't know if you can use a display
as std-out or only works for serial consoles.

> opening it, so accessing the serial port is highly theoretical.
>

I see, in that case I think we could just drop this patch if is not
possible to have a serial console even with some soldering like is the
case in Snow, Peach Pit and Peach Pi.

> Regards,
> Andreas
>

Best regards,
Javier

[0]: https://chromium.googlesource.com/chromiumos/third_party/u-boot/+/firmware-spring-3824.B/include/configs/chromeos_daisy.h
