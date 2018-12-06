Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B6AC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 20:14:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 192372064D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 20:14:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WSPljm5U";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b="p/9KbTa0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 192372064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ZADnqw3YSlMS6aEtEF/r1cTT9HVOaTKXtrgqj7gEo6Y=; b=WSPljm5UvKOOJy0++jXbZYXb8
	N4TPnABquPakAXhElmYm0J+qk+AbRG/k3UXTiKsT6yOxpYEC3NML8KbN94wVdXo+4IBXuiJuulyK1
	r24+UBzngE9vx7sfnhFLpmSKmVZuOuvh/2gSH4AZt9LHy+jOrNxs5YJSXiHfDOb7LSbx/gapAGV/0
	fE5AjTTFTw/BdC3FccuYnbmaf+1v1E7TCZmMqoxkFD8oHp8jxFtIS66+B3OMQWVj3zh0G4a4STsSE
	2N50uZTykOWnuPP082ixVcuANtpNbklZ49b3MnnmdgDoSSQApH62UaXka4DmuNUyDtqRaul3nKIJg
	ujTHgRcpg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gV02x-0000Bk-0e; Thu, 06 Dec 2018 20:14:55 +0000
Received: from mail-yw1-xc42.google.com ([2607:f8b0:4864:20::c42])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gV02m-0008I5-UW
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 20:14:51 +0000
Received: by mail-yw1-xc42.google.com with SMTP id j6so111662ywj.6
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 12:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=konsulko.com; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=WQT9TIl+tHvmS0nF88yi5bp/fAZa9+3e4IiFgKl0Uxo=;
 b=p/9KbTa09vBqUy32R+24jkyp4DUzv3gDjQgBUpwBHsGvsI3Ro6w8+IBmwSMLw/miBQ
 65hXN77faVnnQw8uoVyNV7AV5/7awon9UsrnbG6jbmm5RrxHB6EbQfOy0uWMpFOWhP+W
 1bipnPbn1r9UPhWxRJ7mQ49jTYnXgBRGAbF1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=WQT9TIl+tHvmS0nF88yi5bp/fAZa9+3e4IiFgKl0Uxo=;
 b=ikSH3a8PvJ93qqKCzYBR6LQEoaZnKA35gwO/Ujl8u6Iv9NH5w63X1xzQMjLU14QCzN
 rpuAG2twvaIPDrISBhWpBvrWaZVuDLKv/pPwdDmCSkQFmG91TnNx0DIdLivUMiFGNakw
 nCeBR0zO6peUxo0zlHmvLzd2+ysvEhbJk/tiv2QUlNNc6QeezF8FKx7+/UhTRFSsJkdH
 LI6sj25XxRaDP0PR/LBEO7J1PyFJ9G/3PjDNEBHxW5huNt8sBt1z9wYkvmJb/gAgepcx
 5Wd1U4SKvXZ8i09XLsh+XF1O/vxyL14MUMsDi5hSMBK0+okq8vC8G1rui5J55DuOVA1Y
 g8wA==
X-Gm-Message-State: AA+aEWZloOdDN/F9/PrrOu4LLmtNq5/RlG3whJ9+gae1C6GCnl1HAPI/
 k0EF2zgvRvsUPKvS/NksAHVTAw==
X-Google-Smtp-Source: AFSGD/XHI7QzAaG/y5hf0awbSEodJ+gDaqlWrbJcZ9eeB2sd53IofELHCKZte7PIkdME3aJgJoROEQ==
X-Received: by 2002:a81:4ac6:: with SMTP id
 x189mr29994253ywa.249.1544127272977; 
 Thu, 06 Dec 2018 12:14:32 -0800 (PST)
Received: from bill-the-cat (cpe-65-184-133-47.ec.res.rr.com. [65.184.133.47])
 by smtp.gmail.com with ESMTPSA id
 z37sm321034ywj.3.2018.12.06.12.14.29
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 06 Dec 2018 12:14:31 -0800 (PST)
Date: Thu, 6 Dec 2018 15:14:27 -0500
From: Tom Rini <trini@konsulko.com>
To: Rob Herring <robh@kernel.org>
Subject: Re: Moving ARM dts files
Message-ID: <20181206201427.GF32109@bill-the-cat>
References: <20181204183649.GA5716@bogus>
 <9c2b5528-679a-928e-3150-aa383a4f0405@suse.de>
 <CAL_JsqKO3v0pgVfNhVNOkpZ4sePrybDgZG0riN-tutvwOZ4zYg@mail.gmail.com>
 <2474284e-8a55-639f-2cfa-f811741099f3@suse.de>
 <CAL_JsqL4WoMqFCQ0vFd6z_i=9imnfVsQjeKOG8zxNwi5caneRQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAL_JsqL4WoMqFCQ0vFd6z_i=9imnfVsQjeKOG8zxNwi5caneRQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_121445_734694_F20C96F3 
X-CRM114-Status: GOOD (  39.86  )
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
Content-Type: multipart/mixed; boundary="===============2574854137044547195=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============2574854137044547195==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qsoMWdMv/ifdm7CC"
Content-Disposition: inline


--qsoMWdMv/ifdm7CC
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 06, 2018 at 01:06:43PM -0600, Rob Herring wrote:
> On Thu, Dec 6, 2018 at 7:32 AM Andreas F=E4rber <afaerber@suse.de> wrote:
> >
> > Am 05.12.18 um 05:17 schrieb Rob Herring:
> > > On Tue, Dec 4, 2018 at 7:22 PM Andreas F=E4rber <afaerber@suse.de> wr=
ote:
> > >>
> > >> Rob,
> > >>
> > >> Am 04.12.18 um 19:36 schrieb Rob Herring:
> > >>> I've put together a script to move the dts files and update the
> > >>> makefiles. It doesn't handle files not following a common prefix wh=
ich
> > >>> isn't many and some includes within the dts files will need some fi=
xups
> > >>> by hand.
> > >>>
> > >>> MAINTAINERS will also need updating.
> > >>>
> > >>> A few questions:
> > >>>
> > >>> Do we want to move absolutely everything to subdirs?
> > >>
> > >> This refactoring is a terrible idea!
> > >
> > > How do you really feel?
> > >
> > >> While it would've been nice to have more structure from the start,
> > >> bootloaders like U-Boot expect a flat structure for arm .dtb files n=
ow.
> > >> If you start installing them into subdirs instead, they won't find t=
he
> > >> files anymore under the hardcoded name.
> > >>
> > >> Doing this only for new platforms would be much less invasive and al=
low
> > >> to prepare bootloaders accordingly.
> > >
> > > That was my suggestion where this started for the new RDA platform.
> > > Olof preferred to move everything and that's my desire too.
> > >
> > >> Alternatively, white-list which ones
> > >> are safe to move around.
> > >
> > > I'd prefer to know which ones the distros don't want moved. That
> > > should be easier to figure out. We also need that anyways in context
> > > of what platforms we care about compatibility.
> > >
> > > Another option is dtbs_install target could flatten the installed
> > > dtbs. That is the only part the distros should depend on.
> >
> > I'd be okay with distinguishing source vs. install location. Due to the
> > issue I mention below (and more) we can't use install_dtbs for openSUSE
> > and had to reimplement it, which we'd need to (and can) adjust.
>=20
> What would be needed for dtbs_install to work? arm64 needs to support
> a flat install? If it doesn't work for Debian or openSUSE, I'm not
> sure why we have it. So I'd like to make it work.
>=20
> > >> But don't just script a refactoring because it
> > >> looks nicer in the source tree, without testing what side effects th=
is
> > >> can have for board/distro users of the compiled files in practice.
> > >> We already had that discussion for arm64 because Debian chose to ign=
ore
> > >> the kernel-installed subdirectories and installed .dtb files into a =
flat
> > >> directory, which collided with openSUSE sticking to the kernel choic=
e.
> > >
> > > So everyone already deals with subdirs or not with arm and arm64
> > > already, seems like they can deal with this. I will raise the topic on
> > > the cross-distro list though.
> >
> > Sounds like you're twisting words... The keyword was "hardcoded" paths -
> > one way or another (not "and") depending on the kernel choices being
> > flat for arm, vendor subdir for arm64.
> >
> > >> This topic becomes even more important with EBBR: There is neither a
> > >> mechanism in place to sync .dts files into U-Boot or EDK2 source tre=
es,
> > >> nor are capsule updates implemented in U-Boot for easily deploying s=
uch
> > >> bootloaders with new .dts sources or paths yet.
> > >
> > > EBBR actually says firmware (including dtbs) goes in directories named
> > > by vendor.
> >
> > Fine, but unrelated.
>=20
> If the distros want dtbs in a flat dir and EBBR says otherwise, then
> it is related.
>=20
> > >> And I can assure you
> > >> that just getting users to dd the right bootloader can be difficult.=
=2E.
> > >> Since DT forward and backward compatibility is often being neglected,
> > >> for example with optional properties or renamed compatibles that bre=
ak
> > >> booting with previous drivers, new kernel versions often need updated
> > >> Device Trees to make use of new/enhanced drivers. Therefore it is
> > >> unfortunately often enough a necessity to load newer kernel-based .d=
tb
> > >> files matching the kernel (as opposed to the dream of kernel-indepen=
dent
> > >> hardware descriptions) when working with the latest -rc or -next ker=
nels
> > >> at least. For examples of DTs needing updates, look no further than
> > >> Linaro's 96boards - in case of hikey960/EDK2 GRUB is another layer w=
here
> > >> .dtb paths may be hardcoded, ditto for arm; and Armada was an example
> > >> where the upstream bindings for the network IP changed incompatibly.
> > >
> > > Compatibility is an issue, yes, but that really has nothing to do wit=
h this.
> > >
> > >> DT overlays are another topic that is not making any progress upstre=
am
> > >> according to the ELCE BoF, so beyond the Raspberry Pi the only known
> > >> working way to apply them is to write a U-Boot boot.scr script, which
> > >> can either reuse $fdtcontroladdr DT or use the filename $fdtfile or
> > >> hardcode one, the latter two of which would break with your renaming.
> > >
> > > DT overlays also have nothing to do with this as there aren't any in
> > > the kernel. I'm not inclined to take any either with a flat tree.
> > > We're already at 1800+ files.
> >
> > Read again: a) Breaking DT changes and b) the desire to use Overlays
> > instead of replacing the bootloaders for each change are _reasons_ why
> > people depend on .dtb filenames from the kernel source tree for their
> > boot flow today. Nothing to do with downstream .dtbo files.
> >
> > For example, remember when I reported that the kernel didn't compile DTs
> > with -@? No reaction except for Frank asking to be CC'ed - was it ever
> > fixed??? Do EDK2's or U-Boot's built-in DTs compile with -@ today?
>=20
> IIRC, Frank objected to changing this globally because it will bloat
> all dtbs. And then no one did the work to make it a per dtb option.
> Maybe that was the same issue in another thread.

Being the author of one of the patches to pass in -@ so we could have
overlays work out of the box, no, there was some other problem with
making it only happen for some sub-set of DTBs.  AFAIK the current
answer is the one of a few years ago that no, if you want symbols for
overlays to work you pass in ..whatever it is.. so that -@ is passed in.
In the end it felt like there was more concern over the core concept
than anything else and I moved along due to other pressing concerns.

--=20
Tom

--qsoMWdMv/ifdm7CC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJcCYMjAAoJEIf59jXTHXZSAlMP+wQRa528Lnj8yKqRVJCmsFIW
okoqhYa/rYA6tuE8wqpnhdkkUJzOmNL5big6N9lmTddyloz2/B5iFX43BahR8l4m
j4lw09VOR0xJ9+Z7SNzSAveJIMPUhNnUjq6B6FDU2vxbfBCpepuOeloVVcJ2Bq4+
N9rIhUg/P/4Y7T0ySLDp8UbzZR+DaUru/p0R1KDnR+dKstTguBYRXUUCzHdv2hIc
AZXDo7UfxRlJ9maQp+w/E8Uu13blybZ5AOJzkMdRmNz183Yypr3tmk5P96znRqkG
f8KI2FzdOb957TmbstAfRP1MWPOdbfR24EjuhjI9aTB1Z9wbuseFQBazzL3fQpk3
NnphH4KGfmKUny9gVfueVmb2gl3qhaJdxrTwOmLDRwju18rz4L7GK+02XRgfLY7L
CZVhaNZNAkyx3p0BD8WCwEnIhjqrlGBhsLVDPLoiozhkAK9QWqxYtD2u7aceOThP
6dut24HMPS0A3XzzWFAjA1bonKHArqH3NracsRMeHtOVqOvfyCe+KCRfdHXbdlaX
MW8sEpcu7pVcZjaIgi9XUGA+8nr0MAFbWwR7zfdWywJxzjQBRRSxzCOCS1egrxU0
kKtz2sgSYnS/95d4HlTa7NEl0xKE84pWeqM2tTyVmLxqfZH0ziyQ5YmdvuMxG1Dx
UsGzl5dEhDXFxCCFEu+z
=G9eu
-----END PGP SIGNATURE-----

--qsoMWdMv/ifdm7CC--


--===============2574854137044547195==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2574854137044547195==--

