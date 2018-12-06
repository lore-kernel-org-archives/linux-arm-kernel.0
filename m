Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D2FC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 20:07:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B454520989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 20:07:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Qnsrnn+F";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="tBTCCJ5l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B454520989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=tYKFxfE+WexxuFwzaEWTYtO6cJPREkz4BjmpFMaVPPA=; b=Qnsrnn+FkSvLRjBmvn6TDsQZK
	jkLyU8GAWPquPg8isXTCI9utrvAP9ohcl1dtdxiQ6OOuIzEchiRv1FEZxzLVA/PXxNVAQl2XQwV+H
	VdPVTumOF2nPz4gV3EK3vmSqZ5BaxIejsyPlXLHur49D6P67aeNekPKJ4fuc9CR8x/1yKV0fNl7Tj
	5Zk/EeZVzAnd4qrm0h7DkH1LPhgTBEZHpXcMS9m91TJyZxvsd0BniWP7MqScQqwGFtW3JN925O5GQ
	X0TaZuG3MsNbdqV5OrgcbBf254Z1UD6O7dkCd8Lj1yX5e4HwB9pcfEWMuOFlNgaJ+Qa+nCZiT2PfW
	3qqdYh7iQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUzvc-0005gv-0g; Thu, 06 Dec 2018 20:07:20 +0000
Received: from heliosphere.sirena.org.uk ([2a01:7e01::f03c:91ff:fed4:a3b6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUzvY-0005gC-Up
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 20:07:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=htXt/DfNN+4foCK8i0+WLmgePJeYSBpwFk41Cmiclkg=; b=tBTCCJ5l4UYnvgdpfCrcw8vDn
 GgEnU9omIH8LTbvmMNvv7sgfoEZUgykqXfrIO3StA7IWHbzdLgWMhCjhtw/MdsfKdzJiKooor/zwT
 ePTVmIjupIH+hVKm1+yffGtJ8xWCYzHYzmdOtPs2Ot33dzFUc+uOTK1M3reP2ZYShRkvA=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=debutante.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1gUzvA-0001d9-SW; Thu, 06 Dec 2018 20:06:52 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
 id 5737D11252F7; Thu,  6 Dec 2018 20:06:52 +0000 (GMT)
Date: Thu, 6 Dec 2018 20:06:52 +0000
From: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh@kernel.org>
Subject: Re: Moving ARM dts files
Message-ID: <20181206200652.GB3084@sirena.org.uk>
References: <20181204183649.GA5716@bogus>
 <9c2b5528-679a-928e-3150-aa383a4f0405@suse.de>
 <CAL_JsqKO3v0pgVfNhVNOkpZ4sePrybDgZG0riN-tutvwOZ4zYg@mail.gmail.com>
 <2474284e-8a55-639f-2cfa-f811741099f3@suse.de>
 <CAL_JsqL4WoMqFCQ0vFd6z_i=9imnfVsQjeKOG8zxNwi5caneRQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAL_JsqL4WoMqFCQ0vFd6z_i=9imnfVsQjeKOG8zxNwi5caneRQ@mail.gmail.com>
X-Cookie: You will be successful in love.
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_120717_141548_CC8FBAA8 
X-CRM114-Status: GOOD (  14.09  )
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
Cc: Andrew Lunn <andrew@lunn.ch>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>,
 Liviu Dudau <liviu.dudau@arm.com>, Michal Simek <michal.simek@xilinx.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Thierry Reding <thierry.reding@gmail.com>, Tom Rini <trini@konsulko.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Kevin Hilman <khilman@kernel.org>,
 Gregory CLEMENT <gregory.clement@bootlin.com>, Alexander Graf <agraf@suse.de>,
 Krzysztof Kozlowski <krzk@kernel.org>, ARM-SoC Maintainers <arm@kernel.org>,
 Joel Stanley <joel@jms.id.au>, Andy Gross <andy.gross@linaro.org>,
 devicetree@vger.kernel.org,
 Architecture Mailman List <boot-architecture@lists.linaro.org>,
 Jason Cooper <jason@lakedaemon.net>, Simon Horman <horms@verge.net.au>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, Grant Likely <Grant.Likely@arm.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
 Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
 Daniel Mack <daniel@zonque.org>
Content-Type: multipart/mixed; boundary="===============3299395466157933977=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============3299395466157933977==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="s/l3CgOIzMHHjg/5"
Content-Disposition: inline


--s/l3CgOIzMHHjg/5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 06, 2018 at 01:06:43PM -0600, Rob Herring wrote:
> On Thu, Dec 6, 2018 at 7:32 AM Andreas F=E4rber <afaerber@suse.de> wrote:

> > I'd be okay with distinguishing source vs. install location. Due to the
> > issue I mention below (and more) we can't use install_dtbs for openSUSE
> > and had to reimplement it, which we'd need to (and can) adjust.

> What would be needed for dtbs_install to work? arm64 needs to support
> a flat install? If it doesn't work for Debian or openSUSE, I'm not
> sure why we have it. So I'd like to make it work.

Correct me if I'm wrong but as far as the flat vs directory thing goes
isn't the issue that this winds up being a rename for an existing 32 bit
system?  If you just install the dtbs in the default location then a
bootloader or whatever that is hard coded to look for foo-bar.dtb won't
see the new foo/foo-bar.dtb (or whatever) and will continue to use the
old binary.  It's not the fact that that it's in a directory, it's the
fact that the bootloader sees the name it needs to look for change (if
it's looking on a filesystem at all).  This isn't a problem for arm64 as
the location isn't changing, it's used directories from day one.

The issues with the existing install_dtbs sounded unrelated to this.

--s/l3CgOIzMHHjg/5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwJgVsACgkQJNaLcl1U
h9CqNwf9Gd73ZBcBjAwmF4saOk7WmzgGXQCXdhUUOnAY1Jo8QsooXGgxUqlWuzd8
TVYX6Cyd4QmOYYKZ/X50+s/JTKlKcR2NfAL003qLVxFCuxC2U4xN3O2qytr9PiQU
t+EA7r991KUdwehZKtovl4xahmZX+D+AkXPJJTFZ7cClXzgvTtskN9uECqUdqF+Z
0zwde297uq3FzgYgmLD3AXHqKMThXYM5gdF/D3ttL1tqRIESyJUGPsjVPPZz/pxm
nmHwWzUT5TAjSGCo1dDia+yrpAoeh6qpiWSYuW811jJBJrX1CcphlBYK6BHTZXc8
8q44jLd5ZlvOjJKxcAcyqTB1FhmW7w==
=3s4t
-----END PGP SIGNATURE-----

--s/l3CgOIzMHHjg/5--


--===============3299395466157933977==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3299395466157933977==--

