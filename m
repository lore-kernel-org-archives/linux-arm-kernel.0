Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C88C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:57:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 712C6206BB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IKggp8GP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="sfXCxRNH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 712C6206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=zQvDSWlCSrfx+o2STCNQ9xdFZcvd2Hi2UN2BEfI+ZYg=; b=IKggp8GPObe/7T4lBIO6yf8hr
	uWRvMJ5v4VrMPUMXIwMsT/ru7cTp1vDmVPibYkv9rN6i0q0o9Doneczf23GfmRdv98svYEAH/jiyT
	SIQsf+qfPNJiQ3IYUUdKwh/Pp4QeWVxzgV6o7eRjwzwiPGSaOS8N0T6mTjQlX/8HgFlWCIhETuqT/
	NFKpuik8JyjHOz7exFUN5O/tJhhOc03dSviR8xp7EK9ub0OJN9ytSj2eC/AbAeKwRxH6x/QVpPEdH
	0/FwFkDWVPp7dSj6iBj9fB30qb0I7cH67uta5rTmTj7fb7R+50fDn0q2j1h6mBi42BVLFo15GGjZ4
	O6CvQkVTQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghHAT-0006H3-0q; Wed, 09 Jan 2019 16:57:25 +0000
Received: from heliosphere.sirena.org.uk ([2a01:7e01::f03c:91ff:fed4:a3b6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghHAQ-0006Gl-62
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 16:57:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GvYq4vyRjqFQymgiui7P+XqGYvBX6YU3Js1Sl+P4P8Q=; b=sfXCxRNHaZrSJ5ywr7tXNaRp2
 iPb7mhy5LZSpXOuZzqUuq4CskicaTM+3BPwgalfUPkdw7F9L5QbgyL9zQNi9BgsDIXz5nOhzzdaWt
 0/DuPqVeFRYz2GsZN2bAyd/GteJo6FnVlqjVtxYz9pgnFhLOKp6Ma6V+Dzq7cW1lRS6zg=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=debutante.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1ghHAB-00009u-EC; Wed, 09 Jan 2019 16:57:07 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
 id D8D831127528; Wed,  9 Jan 2019 16:57:06 +0000 (GMT)
Date: Wed, 9 Jan 2019 16:57:06 +0000
From: Mark Brown <broonie@kernel.org>
To: Claudiu.Beznea@microchip.com
Subject: Re: [PATCH v2 2/3] regulator: core: add helper to check if regulator
 is disabled in suspend
Message-ID: <20190109165706.GG10405@sirena.org.uk>
References: <1546944944-13911-1-git-send-email-claudiu.beznea@microchip.com>
 <1546944944-13911-3-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
In-Reply-To: <1546944944-13911-3-git-send-email-claudiu.beznea@microchip.com>
X-Cookie: VMS version 2.0 ==>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_085722_370435_DB44DA24 
X-CRM114-Status: UNSURE (   9.34  )
X-CRM114-Notice: Please train this message.
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
Cc: len.brown@intel.com, alexandre.belloni@bootlin.com,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
 lgirdwood@gmail.com, Ludovic.Desroches@microchip.com, pavel@ucw.cz,
 linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============4827744518063021447=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============4827744518063021447==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KR/qxknboQ7+Tpez"
Content-Disposition: inline


--KR/qxknboQ7+Tpez
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 08, 2019 at 10:56:32AM +0000, Claudiu.Beznea@microchip.com wrot=
e:
> From: Claudiu Beznea <claudiu.beznea@microchip.com>
>=20
> Add helper to check if regulator will be disabled in suspend.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>

This feels like it's the wrong way round - if this is configurable I'd
expect something to configure the suspend mode and then for that to
arrange to configure the regulator appropriately (along with anything
else that needs doing) rather than to infer the configuration from the
regulator state which feels fragile.  But based on the cover letter
that's kind of like what the initial proposal about target states was so
perhaps this is the way we end up going...  this certainly looks a lot
less impactful that the target state stuff though.

--KR/qxknboQ7+Tpez
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlw2J+IACgkQJNaLcl1U
h9DcRQf/f2syn6A2vAA52taqMOX2yicco2vyAygNn47KH3gVlPg1zONPpEQpIgbA
bLBFQrcsF6qDNKhaFtuyoAf6OhTW0Zhx7GMGpiUAeGO1MhG4YH1KYw+bGMG6BxW6
QwaIOK15x1wagCtuI+837xmUUaWDHESLog4uvgpg7lEjZxfeXgsiPc9pCkLlrI2o
2ed96DyT4s/wHdwz61gi5INpScrynAEfzkyHhluYnHVES+6yS52E3NhipLgqbIj8
EhunSZJQFh+QpM3AG5ithO237q3mvPsKV0tUmBjWRZsuL/xrUlqd26J7iDye/52r
CZzk8FIhWeH/0fODpyARFAjqacYa5Q==
=Oh5J
-----END PGP SIGNATURE-----

--KR/qxknboQ7+Tpez--


--===============4827744518063021447==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4827744518063021447==--

