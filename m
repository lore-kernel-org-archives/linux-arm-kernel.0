From: kesavan.abhilash@gmail.com (Abhilash Kesavan)
Date: Tue, 23 Sep 2014 12:34:26 +0530
Subject: [PATCH] tty/serial: fix config dependencies for samsung serial
In-Reply-To: <10202237.9vbtDF9MIQ@wuerfel>
References: <1409671320-7604-1-git-send-email-ch.naveen@samsung.com>
 <3749760.naNt3fHoTI@wuerfel>
 <CAHfPSqAn5gHjDA75Zf1W5=GH9_W+X6+4oc9rDK7CqeSoF3DURw@mail.gmail.com>
 <10202237.9vbtDF9MIQ@wuerfel>
Message-ID: <CAM4voaky-zin8ikdkLBwpTKy13hz3iON8tmNsd55-kr8po8Qaw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

I will be taking this forward as Naveen is no longer with Samsung.

On Wed, Sep 3, 2014 at 4:26 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 03 September 2014 13:51:56 Naveen Krishna Ch wrote:
>> On 2 September 2014 21:16, Arnd Bergmann <arnd@arndb.de> wrote:
>> > On Tuesday 02 September 2014 20:52:00 Naveen Krishna Chatradhi wrote:
>> >> Make the config symbols SERIAL_SAMSUNG_UARTS_4 and
>> >> SERIAL_SAMSUNG_UARTS depend on SERIAL_SAMSUNG rather than
>> >> PLAT_SAMSUNG.
>> >
>> > Please always describe why you are doing a change. This patch
>> > seems really pointless.

I will re-post the patch with a better commit message once we sort the
below issue.

>>
>> The SERIAL_SAMSUNG_UARTS_4 and SERIAL_SAMSUNG_UARTS config options are
>> meaningful only if SERIAL_SAMSUNG is enabled. Hence the dependency
>> rules were changed. I will repost this patch with better description.
>
> My point is that the options are used by both the uart driver and
> the platform code, e.g. for the purpose of PM debugging which can
> be enabled even when the serial-samsung driver is turned off.

I looked through the code and could find two references to these
symbols in the platform-specific code: arch/arm/plat-samsung/init.c
and arch/arm/mach-s3c64xx/irq-pm.c. The first one is being used to
initialize the uart platform device in non-dt way while the second one
saves and restores the uart irq masks for all channels across a
suspend/resume cycle. Also, the save/restore will get bypassed in case
CONFIG_SERIAL_SAMSUNG_UARTS is not defined. It does not look like
either of these cases would cause any issue with the current patch,
can you please help me understand the problem ?

Regards,
Abhilash
>
>> >>  config SERIAL_SAMSUNG_UARTS_4
>> >>         bool
>> >> -       depends on PLAT_SAMSUNG
>> >> +       depends on SERIAL_SAMSUNG
>> >>         default y if !(CPU_S3C2410 || CPU_S3C2412 || CPU_S3C2440 || CPU_S3C2442)
>> >>         help
>> >>           Internal node for the common case of 4 Samsung compatible UARTs
>> >>
>> >>  config SERIAL_SAMSUNG_UARTS
>> >>         int
>> >> -       depends on PLAT_SAMSUNG
>> >> +       depends on SERIAL_SAMSUNG
>> >>         default 4 if SERIAL_SAMSUNG_UARTS_4 || CPU_S3C2416
>> >>         default 3
>> >>         help
>> >>
>> >
>> > Have you checked that it still builds on all samsung platforms when
>> > SERIAL_SAMSUNG is disabled? We have had build errors in this area
>> > in the past.
>>
>> Yes, it builds for other Samsung platforms.
>
> Ok.
>
>         Arnd
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
