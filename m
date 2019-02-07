Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7345CC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:25:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3658E20844
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:25:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="klnZe4cg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3658E20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=RVSkqnxxAPd9YnXFD5wqd1K45PlvQVW0DoU5u9Hy5Bk=; b=klnZe4cghLu2C9WUScCR9oghs
	5Ira7aYgu+9+E1/5eUtMOwoG4efWl9qxNgpMcJLjsTYuTc4zTcIDDxjL9L95eqx5Ko6yVv6SY5N9i
	R8oIhg6vNQ+IDJbfCFWAPNC9RrivTHnfQywbFepD0veCjU/QnqyadFog9RlOYLVRFMT3FmQlAI3MO
	eUwicH4egDnggAhFITzBczwFvAymv0tpM5nodlmf+6MMoHFmkXeVe3+/1Q6Daajep0x4GAQv63qzr
	JNg8H/2rCtuv4H7Q+GT6slKxfAxY/Bmzir5TUcZtLGOYD8yxvSEhw/P6cU9qNhjMVw7BfX12vKiq3
	njKc2rRpA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grfvz-0002mf-Pa; Thu, 07 Feb 2019 09:25:27 +0000
Received: from relay11.mail.gandi.net ([217.70.178.231])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grfvW-00017R-Dq
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 09:25:07 +0000
Received: from localhost (aaubervilliers-681-1-80-177.w90-88.abo.wanadoo.fr
 [90.88.22.177]) (Authenticated sender: maxime.ripard@bootlin.com)
 by relay11.mail.gandi.net (Postfix) with ESMTPSA id D3DD210000F;
 Thu,  7 Feb 2019 09:24:54 +0000 (UTC)
Date: Thu, 7 Feb 2019 10:24:54 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Yizhuo Zhai <yzhai003@ucr.edu>
Subject: Re: [PATCH] net: stmmac: Variable "val" in function
 sun8i_dwmac_set_syscon() could be uninitialized
Message-ID: <20190207092454.xq5jvnfnuhcp37nm@flea>
References: <20190205221559.17545-1-yzhai003@ucr.edu>
 <20190206.201736.1146228626076916564.davem@davemloft.net>
 <CABvMjLQ6MYtGYeLxwceZsvcyn4oScgMo+BGQMHw7SkZ1uxFmHQ@mail.gmail.com>
 <CABvMjLTymaszPdX5afOHFfFBS1AueVzRVra5_QUr144GahH5gQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CABvMjLTymaszPdX5afOHFfFBS1AueVzRVra5_QUr144GahH5gQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_012458_893508_79FE170C 
X-CRM114-Status: GOOD (  15.29  )
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
Cc: Chengyu Song <csong@cs.ucr.edu>, Alexandre Torgue <alexandre.torgue@st.com>,
 netdev@vger.kernel.org, Zhiyun Qian <zhiyunq@cs.ucr.edu>,
 linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>,
 David Miller <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============8351104720505061843=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============8351104720505061843==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="b2zwkslu724bwfel"
Content-Disposition: inline


--b2zwkslu724bwfel
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 06, 2019 at 09:53:16PM -0800, Yizhuo Zhai wrote:
>=20
>=20
> On Wed, Feb 6, 2019 at 9:52 PM Yizhuo Zhai <yzhai003@ucr.edu> wrote:
> >
> > Thanks, but why initialization matters here? Is performance the main co=
ncern?
> >
> > On Wed, Feb 6, 2019 at 8:17 PM David Miller <davem@davemloft.net> wrote:
> >>
> >> From: Yizhuo <yzhai003@ucr.edu>
> >> Date: Tue,  5 Feb 2019 14:15:59 -0800
> >>
> >> > @@ -639,9 +639,14 @@ static int sun8i_dwmac_set_syscon(struct stmmac=
_priv *priv)
> >> >       struct sunxi_priv_data *gmac =3D priv->plat->bsp_priv;
> >> >       struct device_node *node =3D priv->device->of_node;
> >> >       int ret;
> >> > -     u32 reg, val;
> >> > +     u32 reg, val =3D 0;
> >> > +
> >> > +     ret =3D regmap_read(gmac->regmap, SYSCON_EMAC_REG, &val);
> >> > +     if (ret) {
> >> > +             dev_err(priv->device, "Fail to read SYSCON_EMAC_REG.\n=
");
> >> > +             return ret;
> >> > +     }
> >>
> >> I agree with the other reviewer that since you check 'ret' the initial=
ization of
> >> 'val' is no longer needed.
>
> Thanks, but why initialization matters here? Is performance the main
> concern?

Not really, but if we turn this the other way around, why should we do
something that doesn't bring anything?

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--b2zwkslu724bwfel
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXFv5ZgAKCRDj7w1vZxhR
xbinAQCsh3JO2mI1qvmsvNyCd6VyFGOI43tcOkD82skXiUg9dAD/YvGF3TSHZJKp
cAOI+cr8VR4R3TTVsQD56oQioQFJfQY=
=RDQE
-----END PGP SIGNATURE-----

--b2zwkslu724bwfel--


--===============8351104720505061843==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8351104720505061843==--

