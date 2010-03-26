From: pjohn@mvista.com (Philby John)
Date: Fri, 26 Mar 2010 18:40:46 +0530
Subject: AACI broken with commit 29a4f2d3
In-Reply-To: <1269608410.807.23.camel@e102109-lin.cambridge.arm.com>
References: <1269438662.29073.121.camel@e102109-lin.cambridge.arm.com>	
	<1269443418.29073.147.camel@e102109-lin.cambridge.arm.com>	
	<s5h39zou023.wl%tiwai@suse.de>	
	<20100325113019.GA6590@n2100.arm.linux.org.uk>	
	<s5hvdckskev.wl%tiwai@suse.de> <4BAB4DE8.1030707@mvista.com>	
	<1269518557.10064.14.camel@e102109-lin.cambridge.arm.com>	
	<20100325121614.GC6590@n2100.arm.linux.org.uk>	
	<1269602911.15413.6.camel@localhost.localdomain>
	<1269608410.807.23.camel@e102109-lin.cambridge.arm.com>
Message-ID: <4BACB256.3020404@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/26/2010 06:30 PM, Catalin Marinas wrote:
> On Fri, 2010-03-26 at 11:28 +0000, Philby John wrote:
>> --- a/sound/arm/aaci.c
>> +++ b/sound/arm/aaci.c
>> @@ -863,7 +863,11 @@ static int __devinit aaci_probe_ac97(struct aaci *aaci)
>>          struct snd_ac97 *ac97;
>>          int ret;
>>
>> -       writel(0, aaci->base + AC97_POWERDOWN);
>> +       /*
>> +        * Fix: ac97 read back fail errors by reading
>> +        * from Power down register
>> +        */
>> +       readw(aaci->base + 0x26);
>
> I still don't understand this. Does aaci->base point to the AACI
> registers? There is no register at offset 0x26 but there is one at 0x24
> (32-bit AACIIE2).
>

I think there is a register at 0x26 for AACI, except that its not 
defined in aaci.h. References in the manual such as "The AC-link signals
can be placed in low-power mode, when the power down control
and status register (0x26) of the CODEC is programmed to the
appropriate value, both AACIBITCLK and AACISDATAIN are brought to, and 
held at 0.", refer to this register IMHO.

Regards,
Philby
