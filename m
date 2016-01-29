From: marc_gonzalez@sigmadesigns.com (Marc Gonzalez)
Date: Fri, 29 Jan 2016 17:44:04 +0100
Subject: [RESEND PATCH v2] ARM: debug: add support for Palmchip BK-310x
 UART
In-Reply-To: <yw1x1t93lukj.fsf@unicorn.mansr.com>
References: <569CA203.6050001@sigmadesigns.com> <7h60yfn9c6.fsf@baylibre.com>
 <yw1x1t93lukj.fsf@unicorn.mansr.com>
Message-ID: <56AB96D4.9040202@sigmadesigns.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/01/2016 01:44, M?ns Rullg?rd wrote:

> Kevin Hilman <khilman@baylibre.com> writes:
> 
>> Marc Gonzalez <marc_gonzalez@sigmadesigns.com> writes:
>>
>>> From: Mans Rullgard <mans@mansr.com>
>>>
>>> Some SoCs use a Palmchip BK-310x UART which is mostly 16550 compatible
>>> but with a different register layout.
>>
>> ... because UART register layout is where we really need innovation. ;)
>>
>>> While this UART has previously
>>> only been supported in MIPS based chips (Alchemy, Ralink), the ARM based
>>> SMP87xx series from Sigma Designs also uses it.
>>>
>>> This patch allows the debug console to work with this type of UART.
>>>
>>> Signed-off-by: Mans Rullgard <mans@mansr.com>
>>> Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
>>
>> It appears this was previously acked by Arnd also?
>> https://lkml.org/lkml/2015/11/9/116
>>
>>> ---
>>> Peter, this is the patch I've been using on Tango for earlyprintk support.
>>> arm-soc, this is just the Nov 8 patch with my Signed-off-by tag.
>>> ---
>>>  arch/arm/Kconfig.debug            |  9 +++++++++
>>>  arch/arm/include/debug/palmchip.S | 11 +++++++++++
>>>  2 files changed, 20 insertions(+)
>>>  create mode 100644 arch/arm/include/debug/palmchip.S
>>>
>>> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
>>> index 259c0ca9c99a..708aa9150c00 100644
>>> --- a/arch/arm/Kconfig.debug
>>> +++ b/arch/arm/Kconfig.debug
>>> @@ -1304,6 +1304,7 @@ config DEBUG_SIRFSOC_UART
>>>  config DEBUG_LL_INCLUDE
>>>  	string
>>>  	default "debug/sa1100.S" if DEBUG_SA1100
>>> +	default "debug/palmchip.S" if DEBUG_UART_8250_PALMCHIP
>>
>> minor nit: We're trying (not always with great success) to keep various
>> parts of this file sorted alphanumerically.  Can you please insert the
>> new entries accordingly?
> 
> It has to precede the regular 8250 entry so as to take precedence over
> that.

<confused> Are you all talking about these 2 lines:

	default "debug/palmchip.S" if DEBUG_UART_8250_PALMCHIP
	default "debug/8250.S" if DEBUG_LL_UART_8250 || DEBUG_UART_8250

default "debug/palmchip.S" is supposed to come before default "debug/8250.S" ?

Because, in my config, there is no DEBUG_LL_UART_8250 to be seen, and
# CONFIG_DEBUG_UART_8250 is not set

So I don't see how the order might cause a problem in that case?

Regards.
