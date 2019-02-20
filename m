Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B920EC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 18:19:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86CA220838
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 18:19:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ozkoiyQf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86CA220838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=4SIoCw74obDw4qv1yQjJlhcaYvKJRIbbAcnh49CUooE=; b=ozkoiyQf/PMWJTYQuqBmHKp/V
	V6wQRyhVjWNwqwfAbBprwg/gBpF6fk0/QxnSTJGv/ie4PUhYAI3+FgvoKg2zk29XkC8F6UmaimwAv
	6jWr0WeH/UmqBnnr91K8WmlfNxNXNtQA8XlNFAl6PAozCCjKXdiPzJ+HMpWO/EscaIEA8wZ9VY2Yz
	Fyz1gSERJmGNKgXiOjVuMEBvoaWryhkiJGm1QZQ2mUHPDbRkVnMldkFnFnIV1MYDzSrcwdrD2El0l
	4lOWrXhucEv4KNjrHlZj1HgMqUczSGpOnqZXh3om9QfbBJi4dSeVC1PTR1C9B49kOgbrJmdfxM+oc
	h5SGJTBgg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwWSV-00053Z-3t; Wed, 20 Feb 2019 18:19:03 +0000
Received: from anholt.net ([50.246.234.109])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwWSS-00052b-DJ; Wed, 20 Feb 2019 18:19:01 +0000
Received: from localhost (localhost [127.0.0.1])
 by anholt.net (Postfix) with ESMTP id 11B7310A2D1A;
 Wed, 20 Feb 2019 10:18:57 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
 by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id twHIuxoTdFbx; Wed, 20 Feb 2019 10:18:55 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
 by anholt.net (Postfix) with ESMTP id B737310A047F;
 Wed, 20 Feb 2019 10:18:55 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
 id 27B912FE464C; Wed, 20 Feb 2019 10:18:55 -0800 (PST)
From: Eric Anholt <eric@anholt.net>
To: Florian Fainelli <f.fainelli@gmail.com>,
 Stefan Wahren <stefan.wahren@i2se.com>,
 Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 2/2] soc: bcm: bcm2835-pm: Fix error paths of
 initialization.
In-Reply-To: <cfe72e6c-4419-9d8a-184b-b0928ab69e11@gmail.com>
References: <20190213003324.15224-1-eric@anholt.net>
 <20190213003324.15224-2-eric@anholt.net>
 <648bbc3e-6690-9b05-cae5-bf81edbec74a@i2se.com> <87tvh7v8yd.fsf@anholt.net>
 <1278623750.602548.1550097191567@email.ionos.de>
 <cfe72e6c-4419-9d8a-184b-b0928ab69e11@gmail.com>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2
 (x86_64-pc-linux-gnu)
Date: Wed, 20 Feb 2019 10:18:54 -0800
Message-ID: <87va1e492p.fsf@anholt.net>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_101900_491608_6F7A2127 
X-CRM114-Status: GOOD (  13.36  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="===============5839595182293335888=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

--===============5839595182293335888==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Florian Fainelli <f.fainelli@gmail.com> writes:

> On 2/13/19 2:33 PM, Stefan Wahren wrote:
>>=20
>>> Eric Anholt <eric@anholt.net> hat am 13. Februar 2019 um 19:28 geschrie=
ben:
>>>
>>>
>>> Stefan Wahren <stefan.wahren@i2se.com> writes:
>>>
>>>> Hi Eric,
>>>>
>>>> Am 13.02.19 um 01:33 schrieb Eric Anholt:
>>>>> The clock driver may probe after ours and so we need to pass the
>>>>> -EPROBE_DEFER out.  Fix the other error path while we're here.
>>>>>
>>>>> Signed-off-by: Eric Anholt <eric@anholt.net>
>>>>> Fixes: 670c672608a1 ("soc: bcm: bcm2835-pm: Add support for power dom=
ains under a new binding.")
>>>>> ---
>>>>>  drivers/soc/bcm/bcm2835-power.c | 30 +++++++++++++++++++++++++-----
>>>>>  1 file changed, 25 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/drivers/soc/bcm/bcm2835-power.c b/drivers/soc/bcm/bcm283=
5-power.c
>>>>> index 4a1b99b773c0..11f9469423f7 100644
>>>>> --- a/drivers/soc/bcm/bcm2835-power.c
>>>>> +++ b/drivers/soc/bcm/bcm2835-power.c
>>>>> @@ -485,7 +485,7 @@ static int bcm2835_power_pd_power_off(struct gene=
ric_pm_domain *domain)
>>>>>  	}
>>>>>  }
>>>>>=20=20
>>>>> -static void
>>>>> +static int
>>>>>  bcm2835_init_power_domain(struct bcm2835_power *power,
>>>>>  			  int pd_xlate_index, const char *name)
>>>>>  {
>>>>> @@ -493,6 +493,12 @@ bcm2835_init_power_domain(struct bcm2835_power *=
power,
>>>>>  	struct bcm2835_power_domain *dom =3D &power->domains[pd_xlate_index=
];
>>>>>=20=20
>>>>>  	dom->clk =3D devm_clk_get(dev->parent, name);
>>>>> +	if (IS_ERR(dom->clk)) {
>>>>> +		int ret =3D PTR_ERR(dom->clk);
>>>>> +
>>>>> +		if (ret =3D=3D -EPROBE_DEFER)
>>>>> +			return ret;
>>>> is it safe to proceed in the other error cases?
>>>> Even it would be more consistent with clk_prepare_enable() to print an
>>>> error here.
>>>
>>> Yes, not all domains have a clk, so we want to ignore the other error.
>>=20
>> But shouldn't we set dom->clk to NULL instead of keeping the error
>> pointer? AFAIK clk_prepare_enable is aware of NULL instead of error
>> pointer.
>
> If the clock is really optional, then yes, this should be the way to go.

Sigh, error pointers.  Fixed, sending a v2.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlxtmg4ACgkQtdYpNtH8
nugrsQ/6AnksEI2djGnvqEdVo5nnWAMKLPElVVqFFDLpApiEGwaMjFjMWZ9EhwMk
cv7LZ9er+jxz8w0uyXxe2e5gzCcbF/5h7zPwUO6J4Rq9IvH0mfTaoWCY594vNroK
NIPSuzrPkThUYetnkItoNiWs02gfeImh/DeLSFs1lJD+uSpyzQa3YAXjKELeII9G
TE/EnWw5kFPLiGNdUJMyQ/il9FitX4Kou6Vk09VvwMc3wIDwgepCkBXekULskcSI
j3Hr4KSApMVH/R8efEW44FEoxHPf8rDCZ9PgBzk/hLTO1UW8hQOEadq4+Y+yFa+Z
8LuoBHQaHbmHewOgYGtymAF3R/k/WfsrSwbQ0ENqPjMYK+qPqyMqTQlvRJRJYxjG
PnPdEChXCUQBFRdbLrqWY9ngvDE06EZ50P9CpYqSB7EpiXJL8K7ffXGarC2HWD1S
Vz8t/lqCpu1n1ZNTygIIHYk5VPyxInbTz0MQrauTzYd6MbjwMM3jUq99+wMlnDW7
iiIlwgsiNE27dhACBWx5R9pcJq5ySoOJ33L493pdhkOeMUtRqwnnyozJ2ijiCpZC
cacYDR86xGVOhCDxTCQc+VgiOSjlPrloVz4wPZsFpIt3iQpM25x3KOr3t821sQc4
EeFdBQKG+Q6VvXxyvfD/AHdPZ9k3h9/LdULQhGDuO+Yuma1l5vQ=
=YqZL
-----END PGP SIGNATURE-----
--=-=-=--


--===============5839595182293335888==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5839595182293335888==--

