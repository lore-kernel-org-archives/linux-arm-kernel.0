Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68180C282CE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:29:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F8FD2086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Gpt1vfLu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F8FD2086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=DRQIqZNCrUon0FJ4Apd4uxMZo1Hc/DgQFHbRMK3D3hs=; b=Gpt1vfLu/b9jLqWU/ZfFlFEbJ
	3xaNE4SVtJ0RI2BMQ88fm1SOLYjVNPFrbH1BPpUcRwuR6x2USpaOFz721JCIzhKiZ9YeRbwDJK4uw
	C6kyQTvkfiG0Pq9lPmRXB+qWp+mvVLN2K6EAxLWc7Tt3Yq3dlTdSHmg0PC72vaBZCmt/6bB5xApg9
	Xm8ajj/B7+sLxMxCegTz7hcBSEPfJ2fxgK2xKtrRoWbQVVfisnNyCpqYSz+/E/EouxHAezIyGo63D
	+BsyzjuQbIPWSJ/YmwJfdAzhy7IeZwI8jloE5An03yDda31zoDAgOgHn62hspygGwSUT/PJWkuPgj
	eBsQPAkYg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtzHy-00088g-74; Wed, 13 Feb 2019 18:29:42 +0000
Received: from anholt.net ([50.246.234.109])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtzHL-000784-Jv; Wed, 13 Feb 2019 18:29:07 +0000
Received: from localhost (localhost [127.0.0.1])
 by anholt.net (Postfix) with ESMTP id 3475710A2C82;
 Wed, 13 Feb 2019 10:29:01 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
 by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id hdbGv0NGadzd; Wed, 13 Feb 2019 10:28:59 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
 by anholt.net (Postfix) with ESMTP id DE28610A2A32;
 Wed, 13 Feb 2019 10:28:59 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
 id 6BC1E2FE464C; Wed, 13 Feb 2019 10:28:59 -0800 (PST)
From: Eric Anholt <eric@anholt.net>
To: Stefan Wahren <stefan.wahren@i2se.com>,
 Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 2/2] soc: bcm: bcm2835-pm: Fix error paths of
 initialization.
In-Reply-To: <648bbc3e-6690-9b05-cae5-bf81edbec74a@i2se.com>
References: <20190213003324.15224-1-eric@anholt.net>
 <20190213003324.15224-2-eric@anholt.net>
 <648bbc3e-6690-9b05-cae5-bf81edbec74a@i2se.com>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2
 (x86_64-pc-linux-gnu)
Date: Wed, 13 Feb 2019 10:28:58 -0800
Message-ID: <87tvh7v8yd.fsf@anholt.net>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_102903_945889_BBD845D8 
X-CRM114-Status: GOOD (  12.65  )
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
Content-Type: multipart/mixed; boundary="===============2396400292239737261=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

--===============2396400292239737261==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Stefan Wahren <stefan.wahren@i2se.com> writes:

> Hi Eric,
>
> Am 13.02.19 um 01:33 schrieb Eric Anholt:
>> The clock driver may probe after ours and so we need to pass the
>> -EPROBE_DEFER out.  Fix the other error path while we're here.
>>
>> Signed-off-by: Eric Anholt <eric@anholt.net>
>> Fixes: 670c672608a1 ("soc: bcm: bcm2835-pm: Add support for power domain=
s under a new binding.")
>> ---
>>  drivers/soc/bcm/bcm2835-power.c | 30 +++++++++++++++++++++++++-----
>>  1 file changed, 25 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/soc/bcm/bcm2835-power.c b/drivers/soc/bcm/bcm2835-p=
ower.c
>> index 4a1b99b773c0..11f9469423f7 100644
>> --- a/drivers/soc/bcm/bcm2835-power.c
>> +++ b/drivers/soc/bcm/bcm2835-power.c
>> @@ -485,7 +485,7 @@ static int bcm2835_power_pd_power_off(struct generic=
_pm_domain *domain)
>>  	}
>>  }
>>=20=20
>> -static void
>> +static int
>>  bcm2835_init_power_domain(struct bcm2835_power *power,
>>  			  int pd_xlate_index, const char *name)
>>  {
>> @@ -493,6 +493,12 @@ bcm2835_init_power_domain(struct bcm2835_power *pow=
er,
>>  	struct bcm2835_power_domain *dom =3D &power->domains[pd_xlate_index];
>>=20=20
>>  	dom->clk =3D devm_clk_get(dev->parent, name);
>> +	if (IS_ERR(dom->clk)) {
>> +		int ret =3D PTR_ERR(dom->clk);
>> +
>> +		if (ret =3D=3D -EPROBE_DEFER)
>> +			return ret;
> is it safe to proceed in the other error cases?
> Even it would be more consistent with clk_prepare_enable() to print an
> error here.

Yes, not all domains have a clk, so we want to ignore the other error.
And we shouldn't print for defers, generally.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlxkYesACgkQtdYpNtH8
nuj6YQ/+OhOzNEN9E3pEImKm3B4WL05UYLLa9M2P4TqsnIjKehEPo4zm8Kj46oNG
B7VtJqh/Tm9z6UiLTgnUmmBm9cXWFac2qB5VV2eQcg5waDa33MkpAvXjaDsj/UeJ
m7Ky8X/bvmVKvKmGulcw2qyLnuu4kp0Rhswf8C4LfHkHZ/xDy0EXDk89A82EqnAy
YmKLhte/nlxzCNuUz/itxNI2aeJ8g/sWoSgZuffTZAYqrnzs7M7CNX6sgqsNrV2R
SQJ/moNMhPnj2pv7FaV9Tz226XCRb9Lqy8BDDkVePDV9biqJc0oTRREVWmJtFdKQ
o+5gt7v5BJt3LNnJKsE2PY+j4HmX+WB3et4VhxKWFis4rVjpBEm9ZSDVcu+AEPgM
cg3tO6I1KvJXBZN6RNWDLfZWRJSEQLIJMyienZfF56OMQDda0RRtBe9Vx2UTLQ3h
XfEKVGsDLprQo3t1ZxIxe0dmPZbb6nj3YWlpeWEw0pLrmJOWtqUV4YamvKo39v+1
jjzKmeVodo0eX/BCldfG7UzmwclOEvbmz7PmVTTcuNB+Pnu24W6zsvjNYewh9eAX
jaVnEnQsE5vxfMjZcYSvW2ZcbS/RFq07MW3WoCBfMaZxDMoSuGRrWYBalkduv4/s
1Kf63SO2s6Q7pIh2J16WQCGlmLhcJoeCfOuWrRI8nSKYypfU1pY=
=r9eC
-----END PGP SIGNATURE-----
--=-=-=--


--===============2396400292239737261==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2396400292239737261==--

