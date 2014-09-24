From: linux@rempel-privat.de (Oleksij Rempel)
Date: Wed, 24 Sep 2014 10:00:48 +0200
Subject: [PATCH v2 1/8] ARM: add mach-asm9260
In-Reply-To: <6072405.iL4RqHeZrt@wuerfel>
References: <1411324904-14881-1-git-send-email-linux@rempel-privat.de>
 <71905861.S3QD6rl7jU@wuerfel> <542136B0.3020305@rempel-privat.de>
 <6072405.iL4RqHeZrt@wuerfel>
Message-ID: <54227A30.7010805@rempel-privat.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 23.09.2014 um 12:19 schrieb Arnd Bergmann:
> On Tuesday 23 September 2014 11:00:32 Oleksij Rempel wrote:
>> Am 22.09.2014 um 17:08 schrieb Arnd Bergmann:
>>> On Sunday 21 September 2014 20:41:37 Oleksij Rempel wrote:
>>>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>>>> index 5918d40..1a71feb 100644
>>>> --- a/arch/arm/Kconfig
>>>> +++ b/arch/arm/Kconfig
>>>> @@ -379,6 +379,20 @@ config ARCH_AT91
>>>>  	  This enables support for systems based on Atmel
>>>>  	  AT91RM9200 and AT91SAM9* processors.
>>>>  
>>>> +config MACH_ASM9260
>>>> +	bool "Alphascale ASM9260"
>>>> +	select ARCH_REQUIRE_GPIOLIB
>>>> +	select COMMON_CLK
>>>> +	select IRQ_DOMAIN
>>>> +	select SPARSE_IRQ
>>>> +	select MULTI_IRQ_HANDLER
>>>> +	select GENERIC_IRQ_CHIP
>>>> +	select GENERIC_CLOCKEVENTS
>>>> +	select CLKSRC_MMIO
>>>> +	select CPU_ARM926T
>>>> +	help
>>>> +	  Support for Alpascale ASM9260 based platform.
>>>
>>> To enable multiplatform support, please move this to its own
>>> arch/arm/mach-asm9260/Kconfig file and make it depend on ARCH_MULTI_V5,
>>> then remove all 'select' statements that are implicitly enabled there
>>> already (most of the above).
>>
>> Should they be only in defconfig or selected by driver?
> 
> The dependencies should match whatever the platform requires. Anything
> that is optional and user-selectable better goes into the defconfig.
> 
>>>> +static struct map_desc asm9260_io_desc[] __initdata = {
>>>> +	{	/* IO space */
>>>> +		.virtual	= (unsigned long)0xf0000000,
>>>> +		.pfn		= __phys_to_pfn(0x80000000),
>>>> +		.length		= 0x00800000,
>>>> +		.type		= MT_DEVICE
>>>> +	},
>>>> +	{	/* LCD IO space	*/
>>>> +		.virtual	= (unsigned long)0xf0a00000,
>>>> +		.pfn		= __phys_to_pfn(0x80800000),
>>>> +		.length		= 0x00009000,
>>>> +		.type		= MT_DEVICE
>>>> +	},
>>>> +	{	/* GPIO IO space */
>>>> +		.virtual	= (unsigned long)0xf0800000,
>>>> +		.pfn		= __phys_to_pfn(0x50000000),
>>>> +		.length		= 0x00100000,
>>>> +		.type		= MT_DEVICE
>>>> +	},
>>>> +	{	/* SRAM space Cacheable */
>>>> +		.virtual	= (unsigned long)0xd0000000,
>>>> +		.pfn		= __phys_to_pfn(0x40000000),
>>>> +		.length		= 0x00100000,
>>>> +#ifdef CONFIG_SRAM_MEM_CACHED
>>>> +		.type		= MT_MEMORY
>>>> +#else
>>>> +		.type		= MT_DEVICE
>>>> +#endif
>>>> +	},
>>>> +};
>>>
>>> This should not be necessary, as all drivers are supposed to
>>> ioremap their own device registers. For large register ranges
>>> that are used a lot, you could use these as an optimization to
>>> get 1 MB sections mapped using a large TLB entry, but usually
>>> the benefit is very small.
>>
>> Do you mean only "SRAM space Cacheable" section?
> 
> No, all of them.

By removing it i triggered one error which i don't really understand. It
will be great if you can help me.

By defaul kernel will do fallowing remapping, which will trigger:
"Unable to handle kernel paging request at virtual address c2802174"

phys addr     ioremap        range size
=======================================
0x80054000 -> c2800000 size: 0x200
0x80040000 -> c2802000 size: 0x204
0x80088000 -> c2808000 size: 0x4000


But if change second range from 0x204 to 0x4000, then it works fine.
0x80054000 -> c2800000 size: 0x200
0x80040000 -> c2808000 size: 0x4000
0x80088000 -> c2810000 size: 0x4000

Why?
-- 
Regards,
Oleksij

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 213 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140924/94c5ab2e/attachment-0001.sig>
