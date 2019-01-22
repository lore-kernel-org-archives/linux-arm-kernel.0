Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39071C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 22:50:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0670E20870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 22:50:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="W2r29NyR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0670E20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=9L9kEXIolhak0Z3AXPVKKWRhQrIvvxD81nIy0m3E+9Y=; b=W2r29NyRria7wwXILxGuNjvyt
	zfH1HGDju5KW/zkPF2pFlfYf04+dy+JoQzafv5XWJCYtxyy/KBhMm0xUzbO1yiETk1JQl99R7FJNS
	BL+059cFUreAj7BNXHThLsuVhTmGGd4lo0SG+vVXEK4yRj7kYlZahlFlDALqUOmEAVd48pfCfk9VI
	/HFaggyssteY+44fS689oF0e8zG86BgXctLmm2gAaVy9z/n+WQCzQ7a4x+EdHQzJDPZKSQlR+EMNs
	XgMdA3H8pePlLrhlBjBFT2RbrfXlLeIEFnpvdYXMcek2muPWgxzhDxUniKI9jb8xMeguQN/UEECuP
	Rn8p+MwSA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gm4sR-0003iM-De; Tue, 22 Jan 2019 22:50:39 +0000
Received: from sauhun.de ([88.99.104.3] helo=pokefinder.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gm4sO-0003hu-9w
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 22:50:37 +0000
Received: from localhost (p54B333AA.dip0.t-ipconnect.de [84.179.51.170])
 by pokefinder.org (Postfix) with ESMTPSA id 86BD52C78FF;
 Tue, 22 Jan 2019 23:50:35 +0100 (CET)
Date: Tue, 22 Jan 2019 23:50:35 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH -next] i2c: imx: Fix inconsistent IS_ERR and PTR_ERR in
 i2c_imx_dma_request()
Message-ID: <20190122225035.ppp7njqqwb4nz6pp@ninjato>
References: <1547694894-69589-1-git-send-email-yuehaibing@huawei.com>
 <e8c15a2a-6b59-42bb-0a1f-2ab53c01b0d6@axentia.se>
MIME-Version: 1.0
In-Reply-To: <e8c15a2a-6b59-42bb-0a1f-2ab53c01b0d6@axentia.se>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_145036_495421_0609094B 
X-CRM114-Status: GOOD (  14.48  )
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
Cc: "eha@deif.com" <eha@deif.com>,
 "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 YueHaibing <yuehaibing@huawei.com>,
 "linux@rempel-privat.de" <linux@rempel-privat.de>,
 "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
 "wsa+renesas@sang-engineering.com" <wsa+renesas@sang-engineering.com>,
 "linux-imx@nxp.com" <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
 "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Content-Type: multipart/mixed; boundary="===============1617803924458684109=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============1617803924458684109==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bzf4g6etpjcm7b4b"
Content-Disposition: inline


--bzf4g6etpjcm7b4b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 17, 2019 at 11:03:20AM +0000, Peter Rosin wrote:
> On 2019-01-17 04:14, YueHaibing wrote:
> > Change the call to PTR_ERR to access the value just tested by IS_ERR.
> >=20
> > Fixes: 5b3a23a3cc94 ("i2c: imx: notify about real errors on dma i2c_imx=
_dma_request")
> > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> > ---
> >  drivers/i2c/busses/i2c-imx.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> > index 09b1245..42fed40 100644
> > --- a/drivers/i2c/busses/i2c-imx.c
> > +++ b/drivers/i2c/busses/i2c-imx.c
> > @@ -287,7 +287,7 @@ static int i2c_imx_dma_request(struct imx_i2c_struc=
t *i2c_imx,
> > =20
> >  	dma->chan_tx =3D dma_request_chan(dev, "tx");
> >  	if (IS_ERR(dma->chan_tx)) {
> > -		ret =3D PTR_ERR(dma->chan_rx);
> > +		ret =3D PTR_ERR(dma->chan_tx);
> >  		if (ret !=3D -ENODEV && ret !=3D -EPROBE_DEFER)
> >  			dev_err(dev, "can't request DMA tx channel (%d)\n", ret);
> >  		goto fail_al;
> >=20
> >=20
> >=20
>=20
> You were beaten to it by Laurentiu Tudor, who sent the same patch [1] sho=
rtly
> before you.

Yes, but his Fixes: tag was wrong, so I applied this patch with Uwe's
tag moved to here.


--bzf4g6etpjcm7b4b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxHnjoACgkQFA3kzBSg
KbaUpg//eQX7ebREIrIr4wer9VQip7SotcnGF5RgdbqTHI57lULD8NS0Pal6AqPi
aSxg6Aqr26fRosl5vR0nN15Qxjmn069hR2Kxnb2YPn+j5+D29iopEjHAUdsTqxAB
ZZr9BzYMxGlXxN4Rm8nT4q4+T1KBJ4+ZOqwNKZxELq1EM+4GolCqr3QxZkYfWJVK
kUg0QcKn5sE53OlmAtPi7n+S+bn1XP71dLe+ibvxudL2mFFY2OYuQrT0VuDsbq8Q
JPeE5f0FWZ7kEuIadrN4KYiQ4W9wbv8i2ZkbjS2IJniq2SSDuP8aztDOYiHBsot9
3ZFLhABn0fBcI7UdHXaMtN6oIISZqH8jverqHht5D5iaH+YBfPOo3f6+Fs9rx7UA
P7/lgTE7kGDZJ3YuKwKJUk8sDWIeZnsZrz+2bu7FxEOgUGMSmNtQM8Pv1lS4NYoJ
npiBzmZAEBdWxj4AiH/dbb9UVXlMWKrs5yR4OhprtRZqvUJTCqf1dOtJjG37bY5x
J0n84JHj4nZBtaIXO9DnZd/5w2sQMq25IQG9tlkICV83yHYLOJN6b/PmpFqCyxn7
rlGnTiEP/A3szglwcLqp31b/cIRNJ4Mj2Xrd0ZV6w2QVwI0oaTuwo8Nw7SKL6gp+
NVIt0HUOK0RlO7tlnejxXl+/Ih+w015L9uHam3LSROlG5cA7QDQ=
=yLqc
-----END PGP SIGNATURE-----

--bzf4g6etpjcm7b4b--


--===============1617803924458684109==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1617803924458684109==--

