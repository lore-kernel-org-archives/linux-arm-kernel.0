From: slash.tmp@free.fr (Mason)
Date: Fri, 13 Mar 2015 18:06:54 +0100
Subject: read_cpuid_id() in arch/arm/kernel/setup.c
In-Reply-To: <20150313164546.GV8656@n2100.arm.linux.org.uk>
References: <55030A68.6070002@free.fr>
 <20150313161953.GS8656@n2100.arm.linux.org.uk> <550312BB.8020902@free.fr>
 <20150313164546.GV8656@n2100.arm.linux.org.uk>
Message-ID: <5503192E.7070704@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/03/2015 17:45, Russell King - ARM Linux wrote:
> On Fri, Mar 13, 2015 at 05:39:23PM +0100, Mason wrote:
>> Good point. I hadn't thought of that.
>>
>> Do you know the latency of an mrc instruction? (compared to a mov)
>
> Not offhand.  It'll be different for different CPUs, but it's probably
> not far off mov.
>
>>> It seems that GCC 4.7.4 optimises better than Linaro's 4.9.3.  In fact,
>>> it looks like Linaro's 4.9.3 is rather buggy as far as optimisation
>>> goes.
>>>
>>> Later compilers aren't always better.
>>
>> I did NOT expect that. Compiler optimizations passes are so fragile.
>
> You're learning :)
>
>> Anyway, here's another proposed nano-improvement ;-)
>> (This one is code factorization)
>>
>> --- setup.c	2015-03-03 18:04:59.000000000 +0100
>> +++ setup.bar.c	2015-03-13 17:29:23.800668429 +0100
>> @@ -246,12 +246,9 @@
>>   		if (cpu_arch)
>>   			cpu_arch += CPU_ARCH_ARMv3;
>>   	} else if ((read_cpuid_id() & 0x000f0000) == 0x000f0000) {
>> -		unsigned int mmfr0;
>> -
>>   		/* Revised CPUID format. Read the Memory Model Feature
>>   		 * Register 0 and check for VMSAv7 or PMSAv7 */
>> -		asm("mrc	p15, 0, %0, c0, c1, 4"
>> -		    : "=r" (mmfr0));
>> +		unsigned int mmfr0 = read_cpuid_ext(CPUID_EXT_MMFR0);
>>   		if ((mmfr0 & 0x0000000f) >= 0x00000003 ||
>>   		    (mmfr0 & 0x000000f0) >= 0x00000030)
>>   			cpu_arch = CPU_ARCH_ARMv7;
>>
>>
>> This one looks good, doesn't it? :-)
>
> Yes, this one I like - and it probably fixes a potential latent bug
> where the compiler was free to re-order that mrc outside of the if()
> statement.
>
> Please wrap it up as a normal submission, thanks.

How exciting, my first kernel patch :-)

I'll take a closer look at other similar refactoring opportunities.

Can I send the patch inline, with "scissors and perforation" delimiter?

Do I have to base it on the latest 4.0 release candidate, or can you
rebase it as needed?

Also, you didn't like "caching" the value of read_cpuid_id() in
a local variable, but it's done in feat_v6_fixup. Do you want me
to submit a patch changing that, or is it not worth it?

Regards.
