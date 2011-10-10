From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Mon, 10 Oct 2011 18:05:54 +0530
Subject: [PATCH 2/3] ARM: plat-samsung: use Kconfig choice for debug UART
	selection
In-Reply-To: <20111010122319.GE2451@mudshark.cambridge.arm.com>
References: <1313530873-24961-1-git-send-email-will.deacon@arm.com>
	<1313530873-24961-2-git-send-email-will.deacon@arm.com>
	<CAJuYYwRPwALAQcvsMPuz8XYsDicCmB52HzZehppUnKqv5itPEQ@mail.gmail.com>
	<20111010122319.GE2451@mudshark.cambridge.arm.com>
Message-ID: <CAJuYYwQiXSSOQ_FvOn41NSUJ6F4axNbYgV-LfOxhhLvbUz-bMQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 October 2011 17:53, Will Deacon <will.deacon@arm.com> wrote:
> On Mon, Oct 10, 2011 at 12:56:24PM +0100, Thomas Abraham wrote:
>> Hi Will,
>
> Hi Thomas,
>>
>> What is your opinion about the following diff instead of the above one?
>>
>>
>> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
>> index 65cf8c6..035f5cd 100644
>> --- a/arch/arm/Kconfig.debug
>> +++ b/arch/arm/Kconfig.debug
>> @@ -120,6 +120,15 @@ choice
>> ? ? ? ? ? ? ? ? Say Y here if you want the debug print routines to direct
>> ? ? ? ? ? ? ? ? their output to the second serial port on these devices.
>>
>> + ? ? config DEBUG_SAMSUNG_UART
>> + ? ? ? ? ? ? bool "Kernel low-level debugging messages via samsung serial port"
>> + ? ? ? ? ? ? depends on PLAT_SAMSUNG
>> + ? ? ? ? ? ? help
>> + ? ? ? ? ? ? ? Say Y here if you want the debug print routines to direct
>> + ? ? ? ? ? ? ? their output to the serial port for Samsung platforms. Choose
>> + ? ? ? ? ? ? ? the uart port with the "S3C UART to use for low-level debug"
>> + ? ? ? ? ? ? ? config option.
>> +
>> ?endchoice
>>
>> ?config EARLY_PRINTK
>> @@ -139,7 +148,7 @@ config OC_ETM
>> ? ? ? ? kernel code.
>>
>> ?config DEBUG_S3C_UART
>> - ? ? depends on PLAT_SAMSUNG
>> + ? ? depends on DEBUG_SAMSUNG_UART
>> ? ? ? int "S3C UART to use for low-level debug"
>> ? ? ? default "0"
>> ? ? ? help
>
> Well, it's smaller so that's always a plus. However, I don't think the extra
> level of indirection helps (that is, the "Kernel low-level debugging UART")
> choice should be where the UART is specified, rather than pointing you at
> another (platform-specific) option).
>
> Did your suggestion come purely out of aesthetics or are you running into
> difficulties with the original patch?

There are no difficulties with the original patch. But that was not
how Samsung boards have been selecting the low level debug uart port
number. The proposed patch tried to maintain the old style.

Another point is that Samsung's Exynos4 (and few other SoC's) has a
fourth UART port as well. Not that it is used as a debug port
currently, but there is no technical limitation in using that as a
console port. So that might need 'DEBUG_S3C_UART3' as well.

Thanks,
Thomas.

>
> Will
>
