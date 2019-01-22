Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09ED8C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 22:52:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEBA220870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 22:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZDr1iN18"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEBA220870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Gi+9Q/RHT1OvUd/pGyDBQFJNYaOtg0FzoTw2ZxIyofI=; b=ZDr1iN18fUknEoQs/fzybP6B2
	Sk0cKIgN8TR3D+c1+cVVLaPgfQW8Rfy39sqAN3X/YQUtfnnSz3iy1CQVJDllMRq85StSc24sCJJz8
	JUrM+G5J2dDqcnrmk5bK7uMxbl0XItduwmDEtfBJVF8V3e3u8UpP/ckr2uKj1fjqFohm68fU+TcFN
	/++KiXYIsQrnQwVmlhBLpQq3ikk/m6UQBZZ4EXMKvfWigD4XHQOvFkMKmrZxT/SMyzjV5h82WicGb
	gxR0T9AbXv6OFHt2svc/Rcd38TnidfEJiwDRQCXQv6UpdvAtl0CHkvFhdfShisZRDCxc+hnt/Pi58
	+bythjXvg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gm4tj-0004G7-QB; Tue, 22 Jan 2019 22:51:59 +0000
Received: from sauhun.de ([88.99.104.3] helo=pokefinder.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gm4tg-0004Fm-Sq
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 22:51:58 +0000
Received: from localhost (p54B333AA.dip0.t-ipconnect.de [84.179.51.170])
 by pokefinder.org (Postfix) with ESMTPSA id D6CBE2C78FF;
 Tue, 22 Jan 2019 23:51:55 +0100 (CET)
Date: Tue, 22 Jan 2019 23:51:55 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: Re: [PATCH v2 1/2] i2c: imx: fix dma_request_chan error handling
Message-ID: <20190122225155.vfy37bfuikzzymao@ninjato>
References: <20190116112855.13824-1-laurentiu.tudor@nxp.com>
MIME-Version: 1.0
In-Reply-To: <20190116112855.13824-1-laurentiu.tudor@nxp.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_145157_074442_2C0FAAC4 
X-CRM114-Status: GOOD (  13.95  )
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
Cc: s.hauer@pengutronix.de, linux-kernel@vger.kernel.org, leoyang.li@nxp.com,
 linux-i2c@vger.kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com,
 shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com
Content-Type: multipart/mixed; boundary="===============4844185681117744804=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============4844185681117744804==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tzp54if5hd3it573"
Content-Disposition: inline


--tzp54if5hd3it573
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 16, 2019 at 01:28:54PM +0200, Laurentiu Tudor wrote:
> Use the correct error pointer when extracting the error code.
>=20
> Fixes: ea1e5f176e97 ("i2c: imx: notify about real errors on dma i2c_imx_d=
ma_request")

This is not the sha1 in my tree. Maybe you rebased? I applied another
patch meanwhile fixing the same issue. Still thanks!

> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> ---
>  drivers/i2c/busses/i2c-imx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> index 09b124547669..42fed40198a0 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -287,7 +287,7 @@ static int i2c_imx_dma_request(struct imx_i2c_struct =
*i2c_imx,
> =20
>  	dma->chan_tx =3D dma_request_chan(dev, "tx");
>  	if (IS_ERR(dma->chan_tx)) {
> -		ret =3D PTR_ERR(dma->chan_rx);
> +		ret =3D PTR_ERR(dma->chan_tx);
>  		if (ret !=3D -ENODEV && ret !=3D -EPROBE_DEFER)
>  			dev_err(dev, "can't request DMA tx channel (%d)\n", ret);
>  		goto fail_al;
> --=20
> 2.17.1
>=20

--tzp54if5hd3it573
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxHnosACgkQFA3kzBSg
KbZMgA//cFlQRC8UbygfeKRp1djCuNi+hrVDWQ3uHwvIO54srWtH/93QcngYpDo3
zPaJY+syS3Hl22XvtZDgSMljAiN2JXGv0UsxjcTRxU60A4TQaY/UUYuDIF6PcPbN
kiLGbHmZ+LaT/bSTH6k+c7l7nx/ffqxHrlcy5VOgp9pcOdTsvidJlVV/tsQ5QApJ
I4c+7xWzr5CztMci10Dq5p3wRClQNpbA28AVWpufJ78yDxf1yMS2q1F84Qbvg1Wd
XjJESQdlkAXs0e9Ujjwg1mHzAO7lwkF8oj2QN38E94ebyx2t3uoyrv8cbRi/ivCR
UUwE5Aa72Yhk+h5sTPo3MnAXv9V2gYXkjuinzHwibOxC+B4PQu/oItW4xmGvihh3
LO88WNnsBgK0M3ZGzWcKYubyYp+zF6a3Z3U47lN1zc2BzS1Ba8svDmQeoeuxItWc
QRjYtymm/2daqJh7s+2PLjbXHckuw7BsiA9j42YsWiGNMxll88mEPGpg3+F1Fzhh
0tTJ0zUuSm+99wJO1NanBnGE8vzGb9yjPKqf8xID+1W7q+EjwlNGsHQXb5YchWAe
R+VmyaoTXoDFytH8LotU628o4WAEFFpJjJjV1hyeC/gev+N/gcWoE1p1W1Gzwvxd
BxYwAedHrPXztHDfMi9p2EUtXOMyJsm4bIM2ToQ4Clh70xQBl8k=
=gB2m
-----END PGP SIGNATURE-----

--tzp54if5hd3it573--


--===============4844185681117744804==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4844185681117744804==--

