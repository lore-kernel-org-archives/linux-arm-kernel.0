From: R00091@freescale.com (Nguyen Dinh-R00091)
Date: Thu, 4 Nov 2010 12:21:33 -0700
Subject: [PATCH 2/2] ARM: imx: Add mx53 support to common msl functions.
In-Reply-To: <4CD12833.8060204@eukrea.com>
References: <1288736227-800-1-git-send-email-Dinh.Nguyen@freescale.com>
	<1288736227-800-2-git-send-email-Dinh.Nguyen@freescale.com>
	<4CD12833.8060204@eukrea.com>
Message-ID: <86A0E76937111F4C92FABEC0A20988510523CEC2@az33exm21>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

>-----Original Message-----
>From: Eric B?nard [mailto:eric at eukrea.com]
>Sent: Wednesday, November 03, 2010 4:16 AM
>To: Nguyen Dinh-R00091
>Cc: linux-kernel at vger.kernel.org; amit.kucheria at canonical.com; linux at arm.linux.org.uk;
>s.hauer at pengutronix.de; grant.likely at secretlab.ca; linux-arm-kernel at lists.infradead.org;
>daniel at caiaq.de; u.kleine-koenig at pengutronix.de; Zhang Lily-R58066; valentin.longchamp at epfl.ch
>Subject: Re: [PATCH 2/2] ARM: imx: Add mx53 support to common msl functions.
>
>Hi Dinh,
>
>Le 02/11/2010 23:17, Dinh.Nguyen at freescale.com a ?crit :
>> From: Dinh Nguyen<Dinh.Nguyen@freescale.com>
>>
>> Add mx53 support to cpu.c and mm.c.
>>
>> Signed-off by: Dinh Nguyen<Dinh.Nguyen@freescale.com>
>>   static void query_silicon_parameter(void)
>>   {
>> -	void __iomem *rom = ioremap(MX51_IROM_BASE_ADDR, MX51_IROM_SIZE);
>> +	void __iomem *rom;
>>   	u32 rev;
>>
>> +	if (cpu_is_mx51())
>> +		rom = ioremap(MX51_IROM_BASE_ADDR, MX51_IROM_SIZE);
>> +	else if (cpu_is_mx53())
>> +		rom = ioremap(MX53_IROM_BASE_ADDR, MX53_IROM_SIZE);
>> +
>isn't the correct way to get the silicon revision to read the "Product
>Revision register" and "Silicon Revision register" of the IIM and not from the
>internal ROM ? (page 41-11 of the i.MX51 reference manual).
>
>Eric

Reading the ROM code is probably the most reliable way to get the correct silicon revision. Because the ROM that is on the chip is "most likely" up-to-date with the silicon. "Most likely" means that 95% of the time, when you get a new silicon, the ROM code will get updated. There is still a chance that a new silicon will not require a ROM update.

Also the other reason is that sometimes the fuses that identify the silicon revision that are used by the IIM are sometimes not blown to reflect the correct revision in pre-production parts. MX51 is a post production part, so in theory, the fuses are blown correctly. But since we made MX51 boards available prior to going into production, reading from the IIM is not as reliable as reading the ROM.

Thanks,
Dinh
