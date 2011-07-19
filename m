From: b32955@freescale.com (Huang Shijie)
Date: Tue, 19 Jul 2011 10:12:20 +0800
Subject: [i.MX28 GPMI] problem overwriting all-0xff data in NAND
In-Reply-To: <20110718164354.GA3328@S2100-06.ap.freescale.net>
References: <20004.12663.29494.339601@ipc1.ka-ro>
	<20110718164354.GA3328@S2100-06.ap.freescale.net>
Message-ID: <4E24E804.10002@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi  Lothar:
> On Mon, Jul 18, 2011 at 03:13:27PM +0200, Lothar Wa?mann wrote:
>> Hi,
>>
>> with the gpmi-nfc driver for imx28 from Shawn Guo on a TX28 I
> To be clear, the author of gpmi-nfc driver is Huang Shijie (Cc-ed).
>
> Regards,
> Shawn
>
>> encountered some problems with jffs2 when overwriting pages that have
>> been written with 0xff (e.g. from padding from the file system image
>> file).
The GPMI driver now does not support the JFFS2 very well.
The JFFS2 will write the OOB, while the BCH of GPMI will use the OOB too.
So I have to disable the JFFS2 to use the OOB. I have not finish the 
code about it now.

I recommend you use the UBIFS. But the latest version of GPMI driver 
meets a DMA bug.
I am debugging the DMA bug now. and I will send it out when i fix it.

Best Regards
Huang Shijie

>> The problem is that the ECC info for an all-0xff block is not all-0xff
>> and thus a newly erased block is different from a block that has been
>> written with 0xff.
>> If such a block is being altered (jffs2 thinking it can simply
>> overwrite it without erasing first) the ECC information will be
>> corrupted and will produce ECC errors upon read.
>>
>> The only remedy I can think of is to prevent empty pages from actually
>> being written to flash, but leaving them in the erased state instead.
>>
>> Any comments?
>>
>>
>> Lothar Wa?mann
>> -- 
>> ___________________________________________________________
>>
>> Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
>> Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
>> Gesch?ftsf?hrer: Matthias Kaussen
>> Handelsregistereintrag: Amtsgericht Aachen, HRB 4996
>>
>> www.karo-electronics.de | info at karo-electronics.de
>> ___________________________________________________________
>>
