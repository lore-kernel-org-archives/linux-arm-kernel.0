Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46879C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:18:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1523C2087E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XwckMaqb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zl49vcoq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1523C2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=+arrqS5XtPc7ui+UL0vvfim8R1+SSzlpGrFl88rwK/c=; b=XwckMaqbp+8NNv1uiXsyYoLnI
	zOKW3qotpxt+Pk9VmzlGIpxg2e4FZf06JASh0ErL2zxxj8Z7mtAqdx/AXocZSVup1zWYdmjswm+4s
	dOCqVzT1iKvhYPYqSipQTuyPaxTv4PuQ5nqX9YnqqBms6mPIYblLF49/Ln+vcdDmpehXyPKjY9zqy
	hQgtKys2yUjMYROWuE6hFrwooOiiomo65qqW4RO4qjCJu3dV5iTGDnN8DIbZQQbwqo9MMwDlAiK5S
	ygUwl77VhHt7rnvcC3NoYfrnJg6m2E4Jz+8M7DYQAOrTuBSL7I2jjKctiwbW+H+IHoxNH2zQT8zzd
	4s5QJJUNg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goX2C-00084N-J8; Tue, 29 Jan 2019 17:18:52 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goX29-00083f-LU
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 17:18:51 +0000
Received: from earth.universe (dyndsl-091-248-209-252.ewe-ip-backbone.de
 [91.248.209.252])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id AACE72087E;
 Tue, 29 Jan 2019 17:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548782327;
 bh=aHcUSrfNQOiE45arHspE14mKaGaiYpAOhDSpRRREifg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=zl49vcoq27xt712Ww+Il5anGsgEtFqy1+6hvWMACwlCuAaijh/sLElIY4Et5riSGR
 e4NqfZ8L1UYhUcI9mD5Vs6UGE9caKqQn0mxoCAOoFolrafZhBoj52wUizqPjtuHKLO
 mWMmyBo3XC4oan9+mVILGeNys2mZ93sxPgFfJPuA=
Received: by earth.universe (Postfix, from userid 1000)
 id ECCEA3C08DE; Tue, 29 Jan 2019 18:18:44 +0100 (CET)
Date: Tue, 29 Jan 2019 18:18:44 +0100
From: Sebastian Reichel <sre@kernel.org>
To: Tony Lindgren <tony@atomide.com>
Subject: Re: New underflow of regulator enable count warnings in v5.0-rc1
Message-ID: <20190129171844.n6wflw4ehfdy3izs@earth.universe>
References: <20190129164813.GA5720@atomide.com>
MIME-Version: 1.0
In-Reply-To: <20190129164813.GA5720@atomide.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_091849_721060_1D9274BF 
X-CRM114-Status: GOOD (  11.66  )
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
Cc: linux-omap@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 Douglas Anderson <dianders@chromium.org>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="===============6575854593146050020=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============6575854593146050020==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nxdsms3oudxktwtr"
Content-Disposition: inline


--nxdsms3oudxktwtr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jan 29, 2019 at 08:48:13AM -0800, Tony Lindgren wrote:
> Looks like commit 5451781dadf8 ("regulator: core: Only count load for
> enabled consumers") started showing new warnings with v5.0-rc cycle:
>=20
> regulator-dummy: Underflow of regulator enable count
>=20
> I'm seeing this at least with my pwm-vibra test case:
>=20
> # rumble-test /dev/input/by-path/platform-vibrator-event 0xffff
> pwm-vibrator vibrator: vibrator supply vcc not found, using dummy regulat=
or
> input: pwm-vibrator as /devices/platform/vibrator/input/input4
> regulator-dummy: Underflow of regulator enable count
> Upload rumble effect... id=3D0
> regulator-dummy: Underflow of regulator enable count
>=20
> Are these bogus warnings for dummy regulator or do we have
> real unpaired regulator calls or somewhere?

There are real unpaired regulator calls in the pwm-vibrator driver,
that I did not notice when I wrote the driver :(. Good news is, that
Pawe=C5=82 Chmiel and Jonathan Bakker are already working on fixing my mess:

https://lore.kernel.org/patchwork/patch/1032759/

On Droid 4 it's a dummy regulator, since I did not know what
regulator is being used to supply the vibrator. Probably directly
=66rom the battery.

-- Sebastian

--nxdsms3oudxktwtr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlxQivIACgkQ2O7X88g7
+prOCw/+OTUVuiiDL1E9MnpFholjz2hyATTT2hLR5GIbulVgaypDSmK9lj/D+3Lh
m6XSToHBxskFyx4ZEbxmijxtF15l7wIzBzhDUzoFjzkAiAiSFoRVzfxG638lGULs
2X+ZOVpKv2fURtknjO2OUA7XavVl/XQLY5Ry3gCHYQm3W0V8gC/6fEtNBOvE4/nw
SJ3Y3cIzZ7OktP5sVp7bfXuPuHmc5XqnBR4GUMtjkds4fdRonyPW8rEPQkMxkIT6
kAGxT2v8bElbCb4DWz4CD+eYbX286ino5gjcOIOeJd0lVjaDZzT3vKy+Q9oTyhhr
OY2KRiuYxTJbz8qCAgK+DCnAIy/ev1t6wJRdH5SGfqHk6/Sp5WWi7fOLkzCclolp
qWOD0fG7fKVD5/PCwi7HjHuCa5A6QSJkB3eBu4YIayQF2x5miBDlIpmu3pISWaxc
3LX5pUDxrUW3qbM33uVTMPO++tm3ZxauYTkJSZTMnogYOeNtthh/9AkuTkJpPBhn
Rnve1dkHLNZrKA/3JtJWj6JVVP6Sy3j/2NXkeX2xnreYYYqcN19OQMchD19ogPVn
3rdvfuoOMDpB4RjoN87D7bIgbsBVWJJIvLtvtvdy09u0qn6ztgpq0SX7f4Z01tg2
rEjKoeBi54HCEr38Ti6uxAPh3rl83BmgWJ4qDVnd0tMhBUOCNiQ=
=l1E0
-----END PGP SIGNATURE-----

--nxdsms3oudxktwtr--


--===============6575854593146050020==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6575854593146050020==--

