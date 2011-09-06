From: sbabic@denx.de (Stefano Babic)
Date: Tue, 06 Sep 2011 11:13:02 +0200
Subject: [PATCH] ARM: mxs: Add initial support for DENX MX28
In-Reply-To: <20110906083926.GE28816@pengutronix.de>
References: <1314604250-29511-1-git-send-email-sbabic@denx.de>
	<20110906083926.GE28816@pengutronix.de>
Message-ID: <4E65E41E.9000108@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/06/2011 10:39 AM, Uwe Kleine-K?nig wrote:
> Hello Stefano,
> 

Hi Uwe,

> Can you please Cc: kernel at pengutronix for your next mxs patches
> (additional to or instead of s.hauer)? You increase your chances to get
> a reply when Sascha is on vacation.

Yes, thanks ! I am not aware of it, I will do it for V2.


>> +	/*
>> +	 * OCOTP only stores the last 4 octets for each mac address,
>> +	 * so hard-code DENX OUI (C0:E5:4E) here.
>> +	 */
>> +	for (i = 0; i < 2; i++) {
>> +		val = ocotp[i * 4];
>> +		mx28_fec_pdata[i].mac[0] = 0xC0;
>> +		mx28_fec_pdata[i].mac[1] = 0xE5;
>> +		mx28_fec_pdata[i].mac[2] = 0x4E;
>> +		mx28_fec_pdata[i].mac[3] = (val >> 16) & 0xff;
>> +		mx28_fec_pdata[i].mac[4] = (val >> 8) & 0xff;
>> +		mx28_fec_pdata[i].mac[5] = (val >> 0) & 0xff;
>> +	}
>> +
>> +	return 0;
>> +
>> +error:
> As there is only a single place that can produce an error, I'd handle it
> directly there. That is, move the printk and return into the body of the
> if (!ocotp) above.

You are right, I fix in V2.

>> +
> please remove this empty line.

Ok

>> +
>> +	if (m28evk_fec_get_mac())
>> +		pr_warn("%s: failed on fec mac setup\n", __func__);
> I'd suggest to only register the fecs if get_mac() succeeded?

I do not know - if m28evk_fec_get_mac fails (ok, it *should* not fail..)
it should be still possible to add the MAC address via ifconfig (with hw
ethar <mac>, I mean) if the device is present, at least this is what I
supposed in error case.

> Also you might want to skip that pr_warn as m28evk_fec_get_mac already
> prints an error on failure.

Right, I'll do it

Best regards,
Stefano

-- 
=====================================================================
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office at denx.de
=====================================================================
