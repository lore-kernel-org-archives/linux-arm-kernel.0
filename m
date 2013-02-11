From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Mon, 11 Feb 2013 19:17:33 +0000
Subject: [PATCH 12/17] ARM: fix magic for bootloader in BE8
In-Reply-To: <alpine.LFD.2.02.1302082304410.6300@xanadu.home>
References: <1360365467-25056-1-git-send-email-ben.dooks@codethink.co.uk>
 <1360365467-25056-13-git-send-email-ben.dooks@codethink.co.uk>
 <alpine.LFD.2.02.1302082304410.6300@xanadu.home>
Message-ID: <511943CD.6010305@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/02/13 04:06, Nicolas Pitre wrote:
> On Fri, 8 Feb 2013, Ben Dooks wrote:
>
>> If the boot-loader is running little endian and the kernel is compiled
>> big endian then it will not verify the magic number of the front of the
>> kernel.
>>
>> Note, do we need to also reverse the two values after the magic, or are
>> they used later on in the kernel decompressor?
>
> Those value instances are not used by the code.  So for consistency they
> would have to be reversed, yes.  Given those are variable and determined
> by the linker, I don't know how you could manage it.

By breaking it down into parts I think...

I think this patch should be re-worked depending on the outcome of
re-doing the whole ATAG endian configuration so that these are in
the same endian-ness as we expect the ATAGs to be in.

>> Signed-off-by: Ben Dooks<ben.dooks@codethink.co.uk>
>> ---
>>   arch/arm/boot/compressed/head.S |    4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
>> index 39940a7..b6c7ec8 100644
>> --- a/arch/arm/boot/compressed/head.S
>> +++ b/arch/arm/boot/compressed/head.S
>> @@ -129,7 +129,11 @@ start:
>>    THUMB(		adr	r12, BSYM(1f)	)
>>    THUMB(		bx	r12		)
>>
>> +#ifdef CONFIG_CPU_BE8_BOOT_LE
>> +		.word	0x18286f01
>> +#else
>>   		.word	0x016f2818		@ Magic numbers to help the loader
>> +#endif
>>   		.word	start			@ absolute load/run zImage address
>>   		.word	_edata			@ zImage end address
>>    THUMB(		.thumb			)
>> --
>> 1.7.10.4
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
