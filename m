Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE4FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 22:34:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE10620873
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 22:34:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="U5GJMTQb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE10620873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=I35eCqRWvrUKpegfkOxf92oszDQxBIn4ceOx3nv7hsQ=; b=U5GJMTQbgBaBEdeA1FXwtIJro
	VyPIV3W9wyEUbp3VlCoSdI36BAMQpC/B5O3YxNz3ToOIQOBSVmaDLU4pAaodxokj84MKsANMyZQDr
	y4Ot967jkCtulr4Ghv0MwiYeiGiR+kziEfR+NNEeJNJmHfMj1piFCDePPwvVW1QFLSZVFjs1vwVrW
	8030eWPn2KZ27feAroaOuzw1OKKQ1K1B+wVUfBTEZc2X0Mip9z6Nvv2AZGsc8mwop4PygAVCWxbcs
	9okQUHD8ttefKQBHL3onqRWl6BbR2Uru4D8nHdbCDiR5J85v9M8PnEYJJeXcHsSMy6LW63aFabR/b
	0EXoQ6FEQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZkPd-0006VB-Rk; Wed, 19 Dec 2018 22:33:57 +0000
Received: from sauhun.de ([88.99.104.3] helo=pokefinder.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZkPa-0006UK-PD
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 22:33:56 +0000
Received: from localhost (p54B333DA.dip0.t-ipconnect.de [84.179.51.218])
 by pokefinder.org (Postfix) with ESMTPSA id 349E82E3542;
 Wed, 19 Dec 2018 23:33:42 +0100 (CET)
Date: Wed, 19 Dec 2018 23:33:41 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 01/10] i2c: add suspended flag and accessors for i2c
 adapters
Message-ID: <20181219223341.GA998@kunai>
References: <20181219164827.20985-1-wsa+renesas@sang-engineering.com>
 <20181219164827.20985-2-wsa+renesas@sang-engineering.com>
 <20181219172250.ytronxeq2yc4vp4r@wunner.de>
 <83b17734-2437-5a04-8843-e18ccf7ad398@redhat.com>
MIME-Version: 1.0
In-Reply-To: <83b17734-2437-5a04-8843-e18ccf7ad398@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_143354_963414_4475763D 
X-CRM114-Status: GOOD (  16.08  )
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
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Lukas Wunner <lukas@wunner.de>, linux-i2c@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============6179250923752238852=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============6179250923752238852==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Lukas, Hans,

On Wed, Dec 19, 2018 at 07:36:54PM +0100, Hans de Goede wrote:
> Hi,
>=20
> On 19-12-18 18:22, Lukas Wunner wrote:
> > On Wed, Dec 19, 2018 at 05:48:17PM +0100, Wolfram Sang wrote:
> > > +static inline void i2c_mark_adapter_suspended(struct i2c_adapter *ad=
ap)
> > > +{
> > > +	i2c_lock_bus(adap, I2C_LOCK_ROOT_ADAPTER);
> > > +	set_bit(I2C_ALF_IS_SUSPENDED, &adap->locked_flags);
> > > +	i2c_unlock_bus(adap, I2C_LOCK_ROOT_ADAPTER);
> > > +}
> >=20
> > This looks like a duplication of the is_suspended flag in struct dev_pm=
_info.
> > Any reason why you can't use that?  If so, it would be good to document=
 the
> > reason in the commit message.
>=20
> Oh, that is a very good point and that one only gets set on system suspend
> and not on resume suspend, working around the problems with the i2c-desig=
nware

Just to make it clear: you mean runtime suspend, not resume suspend, or?

> driver.
>=20
> I think this might be as simple as adding:
>=20
> 	if (WARN_ON(adap->dev.parent->power.is_suspended))
> 		return -ESHUTDOWN;

I have seen this flag but decided against it. One reason is because it
is marked as "PM core only". The other reason is that it doesn't know
about the adapter lock. It might get set while a transfer is on going.
Or even right after the suggested if-block above. The code from this
series gets the mutex first which ensures that on going transfers are
completed and no new ones are started in parallel.

Unless I am totally overlooking something...

Thanks,

   Wolfram


--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwax0EACgkQFA3kzBSg
KbZnhg/8C3yO6aH4r7ho2ge6VCdCHgidjIZUJUeKIhoL4fSUTvqNLhA4WgnbjkGX
5BIu4LZOdh5v8QAwNLiflt2UK81dUMYT2OplQkyO866VyZuFTXojh6+ZR2niBl2l
lfZNcM3F7Rl7Ec/MV5/0ltSA4Z2zfRQBB+nSQ79R2coFpJCBeAPz4Lqs3Tk/zyeT
htEIu2frSmvsNJVxZaJiG/qrM8H39xoDiPkiix4Lz72HhYMjL82ql/ZPn4iNUyuk
9+58s2LnnzDbime66NGKjZN2pYElYv6aoO62TJyLoxbOkod82+bqdLiFucz7Ssn/
A/006EUTdma5Tl7gbgZtW8SOJSdI3Emf+vU0vQ+MKzjHcmvWuNO+UmSJOlBbqDrO
dDbeAtOcus/p3nCneIu6H9VyYPRwntb66BEyu1wb0wNi4L2L12Ooi9W2fGPTM2cT
bj0hi7Q3SYkhcUarDdDAjgcNmZIdRu2FTYa9x33YGb39rpq+EnEVeyAhDBw36eH3
TPGsoknpPXEIecUQZSJOP8ZOoZ3HXf/4bjx0JuTM0yZY1J6kXrlkM5d36qw5Y811
eE96Xxx+VDuQB72keu5jLsTWuQFjARCW5frFN550cub/p0Ss7kTq925kUeGMQVL0
eggU8pBpQpeD0IklxMsub7vN6Nv3RGiKmbVaTmh81MeiivC+smk=
=CxxX
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--


--===============6179250923752238852==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6179250923752238852==--

