From: sbabic@denx.de (Stefano Babic)
Date: Wed, 25 Jan 2012 17:12:36 +0100
Subject: [PATCH] ARM: mxs: read correct values when setting up MAC
In-Reply-To: <20120125153547.GB8852@pengutronix.de>
References: <1327431447-5031-1-git-send-email-w.sang@pengutronix.de>
 <4F201675.6050308@denx.de> <20120125153547.GB8852@pengutronix.de>
Message-ID: <4F2029F4.7070601@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/01/2012 16:35, Wolfram Sang wrote:
> 
>>> --- a/arch/arm/mach-mxs/mach-m28evk.c +++
>>> b/arch/arm/mach-mxs/mach-m28evk.c @@ -258,7 +258,7 @@ static
>>> int __init m28evk_fec_get_mac(void) * so hard-code DENX OUI
>>> (C0:E5:4E) here. */ for (i = 0; i < 2; i++) { -		val = ocotp[i
>>> * 4]; +		val = ocotp[i];
>> 
>> I can read that HW_OCOTP_CUST0 has the phisycal address
>> 0x8002_C020h, and HW_OCOTP_CUST1 ist at 8002_C030h. So the two
>> registers are not consecutive and there are some reserved fields
>> between the two registers - this is the reason for the i * 4.
>> 
>> HW_OCOTP_CRYPTO0 is at 8002_C060h, so it is not true that the
>> address is currently read from the crypto-key. At least, this is
>> my interpretation...
> 
> Ah, that explains... that you probably never tested the code?

..and that I don't remember very well...

> What about this in ocotp.c?
> 
> 75         for (i = 0; i < OCOTP_WORD_COUNT; i++) 76
> ocotp_words[i] = __raw_readl(ocotp_base + OCOTP_WORD_OFFSET + 77
> i * 0x10);

You are right - and thanks for fixing it !

Stefano

-- 
=====================================================================
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office at denx.de
=====================================================================
