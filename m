From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 06 Sep 2012 20:23:16 -0600
Subject: [PATCH] ARM: add support for BCM2708/BCM2835 and Raspberry Pi
In-Reply-To: <201209060904.14903.arnd@arndb.de>
References: <1346908038-22421-1-git-send-email-swarren@wwwdotorg.org>
 <201209060904.14903.arnd@arndb.de>
Message-ID: <50495A94.2060904@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/06/2012 03:04 AM, Arnd Bergmann wrote:
> On Thursday 06 September 2012, Stephen Warren wrote:
>> The BCM2708 is an ARM SoC from Broadcom. It is the primary SoC in a
>> series which contains the BCM2835 amongst other variants. This patch
>> adds very basic support for this series of SoCs, under the BCM2708 name.

>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig

>> +CONFIG_SERIAL_8250=y
>> +CONFIG_SERIAL_8250_CONSOLE=y
>> +CONFIG_SERIAL_8250_NR_UARTS=48
>> +CONFIG_SERIAL_8250_RUNTIME_UARTS=32
>> +CONFIG_SERIAL_8250_EXTENDED=y
>> +CONFIG_SERIAL_8250_MANY_PORTS=y
>> +CONFIG_SERIAL_8250_SHARE_IRQ=y
>> +CONFIG_SERIAL_AMBA_PL010=y
>> +CONFIG_SERIAL_AMBA_PL010_CONSOLE=y
>> +CONFIG_SERIAL_AMBA_PL011=y
>> +CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
> 
> All three kinds of serial ports really?

The SoC does actually have two types of serial port; a PL011 which we're
using as the primary UART, and a 16C650-alike port. There's no PL010
present. I'll strip this down to just PL011 support since that's all
that's in use right now.

>> diff --git a/arch/arm/mach-bcm2708/common.c b/arch/arm/mach-bcm2708/common.c
>
> I think when this is the only file, we probably want to name this one bcm2708.c,
> same as the platform.

This was originally named bcm2708.c downstream, but I renamed it to
common.c following the example of mach-picoxcell and mach-zynq, which
IIRC you had pointed out as exemplary platforms. Still, I can rename it
back if you want.

>> diff --git a/arch/arm/mach-bcm2708/include/mach/timex.h b/arch/arm/mach-bcm2708/include/mach/timex.h
> 
> Very close to not being required any more, so you probably won't need it in 3.7.

OK. It's required right now though. I assume we should aim to check this
in for 3.7. Should I rebase this patch on top of whatever change removes
the need for timex.h? Such a patch doesn't appear to be in linux-next
right now though.
