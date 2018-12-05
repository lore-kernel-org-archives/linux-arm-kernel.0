Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32CA6C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:33:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06984206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fnNpsUi5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b="l+AMfmf7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06984206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=uGnxmaNTxMjF2KnMPQpCWbNCcma+7/yZ0UBKhhACIww=; b=fnNpsUi5z1wqJRcsyIFnq/2Qj
	/B96ZTxO3B4uVvX3Cbu0ikjzm4bM/4WgoH9NOOVACVc627zWwF0rmfAruBqhA1CVexqcI848X9xnK
	c83QTsYt1a318gUjw2ggQypS2Rbxd7PFF/6GyI6UGdsV4TqT0RocAH/eAn3F6geb9ofzvZ3niHM2t
	AHFeMSLgwmZt4Kx/Qm/8UtNJ3i7XcQXgnydnXKpPjSeKbmo6zBidRtAUXFuAo7M7yoUuENL7RUuUE
	DxZ+NIrHLSOzmyBiAqqFu7o8lAhyIXBcJOoTpLp1aa9r3oWelyE3TUuVfvYM5fW+QwLyz4FDTpgLD
	rp6cf9xoQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUb3N-00008W-0A; Wed, 05 Dec 2018 17:33:41 +0000
Received: from mail-yb1-xb35.google.com ([2607:f8b0:4864:20::b35])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUb3J-00006q-SZ
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 17:33:39 +0000
Received: by mail-yb1-xb35.google.com with SMTP id f6-v6so8792274ybg.12
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 09:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=konsulko.com; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=FrdbRKtbBgX0vVYNfNPs3yg4k1A/GKri4t+T0PDM7wM=;
 b=l+AMfmf7QKv0xHug5KPpbIAH0Xbk6IpgnmBh5jiitH7Ep5o4X6vKR6rxjJtlx3s15t
 FERxC8v03sSlUwBkFda1IsbkmHPr46jKEMVvnfPsXiGtJI7mmKRVUZJlSlmV8mKXzEXK
 BqjUKBi+3Tsvs+X3H10JjQuMFGTlpKQWHQ3Bo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=FrdbRKtbBgX0vVYNfNPs3yg4k1A/GKri4t+T0PDM7wM=;
 b=ZQkLMSx7aC8TCZ4KAPBFIhNNLCkoIZSV3AfK0xj0BcDhZ+/xPP+GbdtLJQLDZ/6vZI
 V/LapCqPF250NrWfB609xn49nEIONRbV4VDsrfr11ufvS4o9cMu+VCsHIm/KBZVjef/B
 NH54lEdkR/oU/FGNEH8Sg7k7QEYAnwKXb7ByYzZU3tpOnRa7maZE+qip7BXo3ZPHGPqV
 uPs2CZSmwONO5RrvKxUHZAuKgqaaziVmT5p2XEVhjgd3oTtcuaaCWy75Pcz4u9grT4Pw
 zgxklQhHCCSgNK4eiDYxl5pvZRESg7qLyHLPCmsZEHdrO2YA/OkIPqSn0/zmIasiFl41
 CulA==
X-Gm-Message-State: AA+aEWYNlf432ChN1S+f6YRB6SyRvmyj2qKsAFXLDevb2hBqP0iYOrFG
 7F+O9KJBFIMXIaVWlnq15qN/BA==
X-Google-Smtp-Source: AFSGD/U+IlSD5LTbkdGcM+v7OlXL6S2+/nJGa5HXHgj4R+lG6vmL5kkHoGlfxGJ5KI1DidYdIJAwHg==
X-Received: by 2002:a0d:e1d6:: with SMTP id k205mr25246824ywe.78.1544031206149; 
 Wed, 05 Dec 2018 09:33:26 -0800 (PST)
Received: from bill-the-cat (cpe-65-184-133-47.ec.res.rr.com. [65.184.133.47])
 by smtp.gmail.com with ESMTPSA id
 l35sm6788667ywh.48.2018.12.05.09.33.23
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 05 Dec 2018 09:33:24 -0800 (PST)
Date: Wed, 5 Dec 2018 12:33:21 -0500
From: Tom Rini <trini@konsulko.com>
To: Rob Herring <robh@kernel.org>
Subject: Re: Moving ARM dts files
Message-ID: <20181205173321.GL32109@bill-the-cat>
References: <20181204183649.GA5716@bogus>
 <9c2b5528-679a-928e-3150-aa383a4f0405@suse.de>
 <CAL_JsqKO3v0pgVfNhVNOkpZ4sePrybDgZG0riN-tutvwOZ4zYg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKO3v0pgVfNhVNOkpZ4sePrybDgZG0riN-tutvwOZ4zYg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_093337_932480_441F0C9E 
X-CRM114-Status: GOOD (  28.20  )
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
 Thierry Reding <thierry.reding@gmail.com>,
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
Content-Type: multipart/mixed; boundary="===============0754331019140123040=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============0754331019140123040==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SCOJXUq1iwCn05li"
Content-Disposition: inline


--SCOJXUq1iwCn05li
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 04, 2018 at 10:17:15PM -0600, Rob Herring wrote:
> On Tue, Dec 4, 2018 at 7:22 PM Andreas F=E4rber <afaerber@suse.de> wrote:
> >
> > Rob,
> >
> > Am 04.12.18 um 19:36 schrieb Rob Herring:
> > > I've put together a script to move the dts files and update the
> > > makefiles. It doesn't handle files not following a common prefix which
> > > isn't many and some includes within the dts files will need some fixu=
ps
> > > by hand.
> > >
> > > MAINTAINERS will also need updating.
> > >
> > > A few questions:
> > >
> > > Do we want to move absolutely everything to subdirs?
> >
> > This refactoring is a terrible idea!
>=20
> How do you really feel?
>=20
> > While it would've been nice to have more structure from the start,
> > bootloaders like U-Boot expect a flat structure for arm .dtb files now.
> > If you start installing them into subdirs instead, they won't find the
> > files anymore under the hardcoded name.
> >
> > Doing this only for new platforms would be much less invasive and allow
> > to prepare bootloaders accordingly.
>=20
> That was my suggestion where this started for the new RDA platform.
> Olof preferred to move everything and that's my desire too.

I think we might really be stuck with "new stuff only in subdirs".
There's a whole huge world out there that depends on these layouts and
it's almost but not quite like the API vs ABI thing.  You can change the
kernel API at whim but this is something with a lot of external users,
and those folks aren't supposed to get broken.

> > Alternatively, white-list which ones
> > are safe to move around.
>=20
> I'd prefer to know which ones the distros don't want moved. That
> should be easier to figure out. We also need that anyways in context
> of what platforms we care about compatibility.
>=20
> Another option is dtbs_install target could flatten the installed
> dtbs. That is the only part the distros should depend on.

But it's not just "the distros" that'll get bit by this too.  Or rather,
it's the "big distros" and all the OpenEmbedded/buildroot/etc ones too
that follow off the built-in logic to find the DTB that'll get bit too
with a rename.

[snip]
> > DT overlays are another topic that is not making any progress upstream
> > according to the ELCE BoF, so beyond the Raspberry Pi the only known
> > working way to apply them is to write a U-Boot boot.scr script, which
> > can either reuse $fdtcontroladdr DT or use the filename $fdtfile or
> > hardcode one, the latter two of which would break with your renaming.
>=20
> DT overlays also have nothing to do with this as there aren't any in
> the kernel. I'm not inclined to take any either with a flat tree.
> We're already at 1800+ files.

I'm going to do my best to not hijack the thread to be about overlays
but that's a whole chicken and egg type problem too.  But yes, it's not
exactly related to moving or not existing dts/dtb files but something
about where / how those are to be stored and maintained really does need
to be done.

--=20
Tom

--SCOJXUq1iwCn05li
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJcCAvhAAoJEIf59jXTHXZSBDkQALPsGn2VgmtrjhQ3YBThdwnC
2UBQNGp7KNhYXT65ENfzLCbTsS8BG7ADszYJaeb98idjG0DijRTIVPLEE7tsKW3v
MjWMOn77VHQtYmI03zrb+u79/OFCIO0SyeAlLuXUgzdptAPawZ4HFebrx3EYLb5O
XLduIttU1faQ4Y1gUjlkgrY8BC7VQRSGT83NlZhVSs6LKU3O1eTcips72IQEKwTU
wyhCHyZN8P/qnSHa9+rPO0cOS8MYcxZteHgTbRVPArml+Lu9pMishKGJ5QbMdL7+
Sn3gOb5Cu5/0x0aoe07LdAiGCOksHfUL21IXwvYwSaUepM9OG24Qv6VT54PZVbwa
YRHyFNpPbF2SBYZm0vkWyvhtW4jKISmF5HKXm3caacsmcDP4jqBTzeGCsp5MBlVK
lYlyYcs3OW/tHpr1/kVCXoRftU7xXRgu4MPwwur/LVUlLkuwJiqvKgyXdFIesneK
yqZotyLzQnWzp7WpzY8sLSN1vGmsurTTHlTO3kMHvl198A9TDkXxO4u87e3uHlRo
R2V6AQbEKZRpxTJOfJ9+vtVNPipzQ0Fd57oFnBp8OaGpAM5klkH49JD6IlZpm4Lw
WRH/+bowLv4u4rmtbJMkW4yINONFwaHM/zzFQDdq+j0nxuQZHKYZXwofbSOR33af
cj8w5aF8D2kKSo0Nki3+
=+3KH
-----END PGP SIGNATURE-----

--SCOJXUq1iwCn05li--


--===============0754331019140123040==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0754331019140123040==--

