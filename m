Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 894E4C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 09:29:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5137821916
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 09:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="o27FWAyN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5137821916
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=2eL5L5Y7mrJXBO6uAyL8UDaEVMQUkEzUJKN1eaBqbp0=; b=o27FWAyNHm3leLUXn5K4cIoKB
	NSsBMwf6hx8gAOBv+WUfTKJ8N8EJ0u8bOIqs6ygLLA7F+g4fKeB+0FOn39Qq6ve1hVKU9KZYxlri1
	eo+djYKqbdgmJSihL4S/pyeZsRipEG5omgQEm3HQJ/X/u9gCvuc06Hge6+oabztzEmGXTcT/PJCiY
	rPnVM4ehILpClhdmLd+RmS0gLPPwN0NTR984yS5dNC3TGUms6yk7hXF1i6/7qVw0xiBnVbDoxGRSq
	pCzLTjQEf5bSlbYbB5HyO4DaTi3e5PTYyUQ3vqvH3NCzJhMZ1j3NMxDVHLgRbhWQaoP/ve3TblHGm
	zZnszlzsg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs2TJ-00071G-3v; Fri, 08 Feb 2019 09:29:21 +0000
Received: from relay3-d.mail.gandi.net ([217.70.183.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs2TF-00070u-9V
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 09:29:19 +0000
X-Originating-IP: 90.88.22.177
Received: from localhost (aaubervilliers-681-1-80-177.w90-88.abo.wanadoo.fr
 [90.88.22.177]) (Authenticated sender: maxime.ripard@bootlin.com)
 by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 77BBF60010;
 Fri,  8 Feb 2019 09:29:10 +0000 (UTC)
Date: Fri, 8 Feb 2019 10:29:09 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Daniel Vetter <daniel.vetter@intel.com>,
	David Airlie <airlied@linux.ie>
Subject: Re: [PATCH] drm/sun4i: dsi: Fix unitialized variable warning
Message-ID: <20190208092909.mvki6sojxohmumeh@flea>
References: <20190208090540.19626-1-maxime.ripard@bootlin.com>
MIME-Version: 1.0
In-Reply-To: <20190208090540.19626-1-maxime.ripard@bootlin.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_012917_480756_D92E5DEC 
X-CRM114-Status: GOOD (  10.03  )
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
Cc: Sean Paul <seanpaul@chromium.org>, Chen-Yu Tsai <wens@csie.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org
Content-Type: multipart/mixed; boundary="===============0709945041494531976=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============0709945041494531976==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vb7mkydpdm4heef5"
Content-Disposition: inline


--vb7mkydpdm4heef5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 08, 2019 at 10:05:40AM +0100, Maxime Ripard wrote:
> Since the DPHY rework, one error path doesn't set the return error code
> before jumping to its error label, which in turns make gcc (rightfully)
> complain about the variable holding the error code being uninitialized.
>=20
> Fix this.
>=20
> Fixes: bb3b6fcb6849 ("sun6i: dsi: Convert to generic phy handling")
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

Applied with Daniel's Reviewed-by

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--vb7mkydpdm4heef5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXF1L5QAKCRDj7w1vZxhR
xRHXAP96xVRMc7qD/7f8ARuoe7cI3Jt+mdtIB2kMU570TNssUgD/S93HZ8A20oWI
YAycCuFiTC4/3w1U7d+KY448Ff97cQo=
=7iQV
-----END PGP SIGNATURE-----

--vb7mkydpdm4heef5--


--===============0709945041494531976==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0709945041494531976==--

