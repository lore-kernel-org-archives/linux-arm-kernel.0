From: phorton@bitbox.co.uk (Peter Horton)
Date: Mon, 06 Dec 2010 09:39:37 +0000
Subject: [PATCH] mx51: add support for FIQ on TZIC
In-Reply-To: <20101206074359.GR6017@pengutronix.de>
References: <20101203161626.GA1149@porta-pete.localdomain>
	<20101206074359.GR6017@pengutronix.de>
Message-ID: <4CFCAF59.7090105@bitbox.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/12/2010 07:43, Sascha Hauer wrote:
> On Fri, Dec 03, 2010 at 04:16:26PM +0000, Peter Horton wrote:
>> Add support for FIQ on mx51 TZIC
>>
>> TZIC changes tested with FIQ audio on an mx51 board
>>
>> AVIC changes build with mx3_defconfig, not tested
>>

[snip]

>>   	}
>> diff --git a/arch/arm/plat-mxc/include/mach/entry-macro.S b/arch/arm/plat-mxc/include/mach/entry-macro.S
>> index aeb0869..c7dd4a9 100644
>> --- a/arch/arm/plat-mxc/include/mach/entry-macro.S
>> +++ b/arch/arm/plat-mxc/include/mach/entry-macro.S
>> @@ -54,8 +54,18 @@
>>   #elif defined CONFIG_MXC_TZIC
>>   	@ Load offset&  priority of the highest priority
>>   	@ interrupt pending.
>> +	@ 0x080 is INTSEC0 register
>>   	@ 0xD80 is HIPND0 register
>>   	mov     \irqnr, #0
>> +#ifdef CONFIG_FIQ
>> +1000:
>> +	add	\irqstat, \base, \irqnr, lsr #3
>> +	ldr	\tmp, [\irqstat, #0xd80]
>> +	ldr	\irqstat, [\irqstat, #0x080]
>> +	ands	\tmp, \tmp, \irqstat
>> +	bne	1001f
>> +	add	\irqnr, \irqnr, #32
>> +#else
>>   	mov     \irqstat, #0x0D80
>>   1000:
>>   	ldr     \tmp,   [\irqstat, \base]
>> @@ -63,6 +73,7 @@
>>   	bne     1001f
>>   	addeq   \irqnr, \irqnr, #32
>>   	addeq   \irqstat, \irqstat, #4
>> +#endif
>
> Can't we skip the #ifdef? The CONFIG_FIQ path should also work without FIQs
> enabled, right?
>

Yes.

P.
