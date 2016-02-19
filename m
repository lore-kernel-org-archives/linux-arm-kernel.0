From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Fri, 19 Feb 2016 08:47:47 +0000
Subject: [PATCH 1/9] ARM: ARMv7-M uses BE-8, not BE-32
In-Reply-To: <2702301.CTWUiSsjZR@wuerfel>
References: <1455804123-2526139-1-git-send-email-arnd@arndb.de>
 <1455804123-2526139-2-git-send-email-arnd@arndb.de>
 <alpine.LFD.2.20.1602181102570.13632@knanqh.ubzr>
 <2702301.CTWUiSsjZR@wuerfel>
Message-ID: <56C6D6B3.60605@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/02/16 16:12, Arnd Bergmann wrote:
> On Thursday 18 February 2016 11:06:08 Nicolas Pitre wrote:
>> On Thu, 18 Feb 2016, Arnd Bergmann wrote:
>>
>>> When configuring the kernel for big-endian, we set either BE-8 or BE-32
>>> based on the CPU architecture level. Until linux-4.4, we did not have
>>> any ARMv7-M platform allowing big-endian builds, but now i.MX/Vybrid
>>> is in that category, adn we get a build error because of this:
>>>
>>> arch/arm/kernel/module-plts.c: In function 'get_module_plt':
>>> arch/arm/kernel/module-plts.c:60:46: error: implicit declaration of function '__opcode_to_mem_thumb32' [-Werror=implicit-function-declaration]
>>>
>>> This comes down to picking the wrong default, ARMv7-M uses BE8
>>> like ARMv7-A does. Changing the default gets the kernel to compile
>>> and presumably works.
>>
>> Was it tested without BE8 when it was submitted upstream? I don't think 
>> you can switch this freely on a given hardware platform and expect it to 
>> still work.
>>
>>
> 
> mach-imx contains a number of different SoCs, and one SoC was recently
> tested successfully after a number of endianess bugs got fixed. This was
> an i.mx6 using a Cortex-A9 core, but we are now also able to build
> vybrid vf610 big-endian based on that selection. This SoC supports
> Linux running either on its Cortex-A5 or its Cortex-M3 (or M4?) cores.
> 
> I am rather sure nobody has ever run Linux in big-endian mode on the
> Cortex-M platform, specifically because it was always wrong and could
> not be enabled in Kconfig.

Ah, it explains why my quick attempt to enable BE for MPS2 (M-class
platform) failed. With this patch applied I'm able to see Linux booting
on MPS2 FVP model in BE, not complete boot but it might be due to other
reasons. So this patch definitely improves things for me, if it helps

Tested-by: Vladimir Murzin <vladimir.murzin@arm.com>

Cheers
Vladimir

> 
> 	Arnd
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> 
> 
