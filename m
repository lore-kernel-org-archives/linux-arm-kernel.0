Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B08C312E2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 00:06:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CF6321741
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 00:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="O/FZuAHG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BwziozCq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CF6321741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=CieJyBqkfieRoLShAfMI5Nixi1ZjE27IJclLxxXRZyc=; b=O/FZuAHGKdOAIJqJfRMdQqStK
	xkyyALLPKKYQqMfazA8knMaAFMVlbGj2h0O8kEBD0hp87Tv3CT81/8818/a/tCRqy/yF7LvM/TAJJ
	qkiZNVzc+Lm7NEJOB0PWZpFRg2KERCo4U/mKs5mbRGJMLUjtTkgypXfZJOMk9d8l/f/eROXfBIvK9
	01PFv6Ef+3ffrkypUb16DM7JzaWq/w8VMGcE9hlU6wZzUCHOp1b0HJ6tDxld8FyyS8UJyAmclIUCk
	GWPCvPWMCKMFZATZ1boLd2QOUziFsDoaaJUM22ifxWvG6Voa6+pkKBEjKQkDxAkEr9+fJ2om11xJj
	vI8WbSUOQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glN6q-0003vo-J2; Mon, 21 Jan 2019 00:06:36 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glN6m-0003vU-Ss
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 00:06:34 +0000
Received: from earth.universe (unknown [194.136.232.109])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 93502214DA;
 Mon, 21 Jan 2019 00:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548029191;
 bh=fYPq9sDIcxuXj2oJeKKmDJtZAaGnP2MKcLuIoeufuXk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BwziozCqczajUflZPoLAeZOyamMhL1ETYu/dYCmGCQK5TjJdVHyOW28UW0zO5xHm9
 d2rT4GufPmoAeNUH+uALga7MlMxLzjUco12ORfD51Ghr6ade9KRzKjGbPNSqPevUAn
 YOYKSAuyBg7gQIrITQi/Ri1NFMDIPTlZFMp1mVU8=
Received: by earth.universe (Postfix, from userid 1000)
 id 71D543C08EA; Sun, 20 Jan 2019 22:41:07 +0100 (CET)
Date: Sun, 20 Jan 2019 22:41:07 +0100
From: Sebastian Reichel <sre@kernel.org>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: cpcap-charger: generate events for userspace
Message-ID: <20190120214107.n2ot5mvggub4aehn@earth.universe>
References: <20181227195221.GA11920@amd>
MIME-Version: 1.0
In-Reply-To: <20181227195221.GA11920@amd>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190120_160632_960264_095246C0 
X-CRM114-Status: GOOD (  15.05  )
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
Cc: mpartap@gmx.net, linux-pm@vger.kernel.org, tony@atomide.com,
 merlijn@wizzup.org, kernel list <linux-kernel@vger.kernel.org>,
 nekit1000@gmail.com, linux-omap@vger.kernel.org,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: multipart/mixed; boundary="===============5246124651533996246=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============5246124651533996246==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="byreiu6z4ngijxep"
Content-Disposition: inline


--byreiu6z4ngijxep
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Dec 27, 2018 at 08:52:21PM +0100, Pavel Machek wrote:
> The driver doesn't generate uevents on charger connect/disconnect.
> This leads to UPower not detecting when AC is on or off... and that is
> bad.
>    =20
> Reported by Arthur D. on github (
> https://github.com/maemo-leste/bugtracker/issues/206 ), thanks to
> Merlijn Wajer for suggesting a fix.
>    =20
> Cc: stable@kernel.org
> Signed-off-by: Pavel Machek <pavel@ucw.cz>

Thanks, queued to power-supply-next.

-- Sebastian

> diff --git a/drivers/power/supply/cpcap-charger.c b/drivers/power/supply/=
cpcap-charger.c
> index 9e8ff5c..7d8b4d5 100644
> --- a/drivers/power/supply/cpcap-charger.c
> +++ b/drivers/power/supply/cpcap-charger.c
> @@ -576,6 +576,7 @@ static void cpcap_usb_detect(struct work_struct *work)
>  			goto out_err;
>  	}
> =20
> +	power_supply_changed(ddata->usb);
>  	return;
> =20
>  out_err:
>=20
> --=20
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/b=
log.html



--byreiu6z4ngijxep
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlxE6vMACgkQ2O7X88g7
+prkABAApFEELQA6AnpA5CNX/WpKDkKWb7dVv+2gvum+GwIZR/+c4idPzHOzHHLr
MTDkNE4AoTi/GA06Q7Ed2PE8NNgrLtDKC8edu8KMDM4TW4oo3d1RIS4JPvBDpewy
8KkeHBEPgBT0PDzFc379lAfXYr6V38GhMOR3b/Jqcu81F9jAeOk/gmOLIgdIXjIL
BS/CJMABO3yX5zoFdxiOYM1pkoKGf+bw+un7NW0RSkrSCaxUiDHvfl7+Et0N7ouI
zTSL54vGGvyXGmUE0PXujLrgUQ9jYPedxotL8GlA5uHsIa4mma36My6I4ldowppa
Y5Ys2+bglHbYnk0onp3GbpP4obdXaugsyPs18wpk6lVfxpYQ1hcY33v/E6hhKpLk
rM6urwQ4Fin81txDMMHIuhnXdf4V+BfVQH02B0+iDYjF/0FUs4n9jmHY6nuezXAq
RMMgMZ8sgTtllr4M7OxL2f9ZRrliqb3fAfSXgq7YFYqHQvgjAJUuSuP8OrCHvxUO
woFPWgjhxEjrreS9mzWFQp0EWlfSqGWA2WDbVzwvOMXrZAYnavr5Sjw+4jz9gS/v
yjLJyebiKu1k0558op7GbgwYJkdZO3CSPRvsRv1dnzuMf7cWYhUT5BH5UuUVmXaa
n/Bvcb2knDgaybIWF9gd8nodRBnBbrIwjRsBSj9I+DBOqDiSx+c=
=h22h
-----END PGP SIGNATURE-----

--byreiu6z4ngijxep--


--===============5246124651533996246==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5246124651533996246==--

