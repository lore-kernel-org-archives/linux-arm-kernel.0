From: eric@eukrea.com (=?ISO-8859-1?Q?Eric_B=E9nard?=)
Date: Tue, 05 Oct 2010 21:31:27 +0200
Subject: [PATCH v2] i.MX31 and i.MX35 : fix errate TLSbo65953
	and	ENGcm09472
In-Reply-To: <20101005183308.GX11737@pengutronix.de>
References: <20101005094510.GJ28242@pengutronix.de>	<1286280012-19809-1-git-send-email-eric@eukrea.com>
	<20101005183308.GX11737@pengutronix.de>
Message-ID: <4CAB7D0F.9020600@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

Le 05/10/2010 20:33, Uwe Kleine-K?nig a ?crit :
>> +			/* invalidate I cache */
>> +			"mov %0, #0\n"
>> +			"mcr p15, 0, %0, c7, c5, 0\n"
>> +			/* clear and invalidate D cache */
>> +			"mov %0, #0\n"
> mcr doesn't change the value of %0, does it?  Then there's no need to
> set it to 0 once more.
>
>> +			"mcr p15, 0, %0, c7, c14, 0\n"
>> +			/* WFI */
>> +			"mov %0, #0\n"
> ditto
>
>> +			"mcr p15, 0, %0, c7, c0, 4\n"
>> +			"nop\n" "nop\n" "nop\n" "nop\n"
>> +			"nop\n" "nop\n" "nop\n"
>> +			/* enable I and D cache */
>> +			"mrc p15, 0, %0, c1, c0, 0\n"
> If you spend two registers there is no need to reread this register.
>
>> +			"orr %0, %0, #0x00001000\n"
>> +			"orr %0, %0, #0x00000004\n"
>> +			"mcr p15, 0, %0, c1, c0, 0\n"
>> +			:: "r" (reg));
> ... and the s/:: "/: "=/ as I suggested earlier.
>
well, this code comes from Freescale and if everything was perfect it 
wouldn't be necessary as this is an errata fix so I'm not sure this can 
be considered as a code to optimize.

Moreover it follows exactly what is suggested in the workaround 
described on page 8 of this PDF : 
http://cache.freescale.com/files/32bit/doc/errata/MCIMX31CE.pdf so I'm 
not sure we should modify it.

The other function they sent me had even more duplicated lines than this 
one so it's difficult to know what is necessary and what isn't.

I can test it with your suggestions but the extra mov & mrc may be there 
to add instructions cycle between each mcr to be sure the workaround 
does its job.

Best regards,
Eric
