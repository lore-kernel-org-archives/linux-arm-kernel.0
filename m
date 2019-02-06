Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD75EC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 06:38:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72C9B218A3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 06:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kgR0WrWV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="SD/md96i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72C9B218A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	MIME-Version:References:In-Reply-To:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=zDzJkrBo/e+WB2TItGmuo+KUhnHignHzWfjM3mwZFto=; b=kgR0WrWVUjnb7LanDuKhbYaN/
	3Ry2i0WWoXMqm1nMLbiDUosjuAFVm7SfSdBWNUO2Y4zwc8h6yCVns5AaLJ4RM7/zNnJ0dwFvBV6Tv
	fvzWPYtqD639yEFXmenRW3CThEJJCWDfdFC4+VcTyvrQY34UuWz25M+XtvUgjqsiN2NnXt/90NmwH
	o+JhHx4ngBuovV8wCk3D0KbmKy9eEQHryMjwCNsMGBjT33orBauQ3OWXekrMG0lZ3M/Ju9ktrsQmh
	eRMV2aj2rn6JRcxKMLDYR78XQFqcSqpoH4jHcRiO+eOFTk/zXvGo5XwSexodGx2Ks9ZFmwuUvdXYD
	an8MAZbFg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grGr2-00050w-A8; Wed, 06 Feb 2019 06:38:40 +0000
Received: from mail.andi.de1.cc ([2a01:238:43f3:0:615b:ee97:1f81:cbf2]
 helo=h2641619.stratoserver.net)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grGqx-00050C-8g
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 06:38:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=kemnade.info; s=20180802; h=Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FrQtX3YKMjqeO7Mlc7WoPAYmCTPjSIHznvdUQnD0WXk=; b=SD/md96iiosw67uPg8IU2fElx
 5oO+W59ZgkNTA3sCsWFq8MfcPKoE2fos/TBCpDhIGTfbJnD1J+Vxa7CSOGo5m/Zc4SAdl4qKrb/Ns
 6ieSaGgc3Ve3IiZ0JmOOMdNt9CW5CC6dfk+4yMEnW4cYUgvg4X7Ojbe1MC51h3hBXQS1c=;
Received: from hsvpn34.hotsplots.net ([176.74.57.181] helo=localhost)
 by h2641619.stratoserver.net with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <andreas@kemnade.info>)
 id 1grGql-0007xZ-CI; Wed, 06 Feb 2019 07:38:23 +0100
Received: from [::1] (helo=localhost) by eeepc with esmtp (Exim 4.89)
 (envelope-from <andreas@kemnade.info>)
 id 1grGqi-0001Wv-97; Wed, 06 Feb 2019 07:38:20 +0100
Date: Wed, 6 Feb 2019 07:37:32 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap3: give off mode enable a more prominent place
Message-ID: <20190206073732.35ad315f@kemnade.info>
In-Reply-To: <20190204184317.GO5720@atomide.com>
References: <20190202055827.12956-1-andreas@kemnade.info>
 <20190204155604.GH5720@atomide.com>
 <20190204193311.102a60e6@kemnade.info>
 <20190204184317.GO5720@atomide.com>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; i686-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_223835_605788_14ECE1E7 
X-CRM114-Status: GOOD (  22.52  )
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
Cc: linux-omap@vger.kernel.org, khilman@kernel.org,
 linux-kernel@vger.kernel.org, linux@armlinux.org.uk,
 letux-kernel@openphoenux.org, linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============8620985761611860604=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

--===============8620985761611860604==
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/QwS4Tx=f55MQhMz8gZGszh/"; protocol="application/pgp-signature"

--Sig_/QwS4Tx=f55MQhMz8gZGszh/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 4 Feb 2019 10:43:17 -0800
Tony Lindgren <tony@atomide.com> wrote:

> * Andreas Kemnade <andreas@kemnade.info> [190204 18:33]:
> > On Mon, 4 Feb 2019 07:56:04 -0800
> > Tony Lindgren <tony@atomide.com> wrote:
> >  =20
> > > * Andreas Kemnade <andreas@kemnade.info> [190202 06:01]: =20
> > > > Enabling off mode was only reachable deeply hidden
> > > > in the debugfs. As powersaving is an important feature,
> > > > move the option out of its shady place.   =20
> > >=20
> > > How about let's enable always if we have the twl4030
> > > configured to allow it? You can just check if the dts has
> > > "ti,twl4030-power-idle" or "ti,twl4030-power-idle-osc-off"
> > > properties set.
> > >=20
> > > In order to enable deeper idle states, the user space still
> > > needs to idle the UARTs and possibly other hardware blocking
> > > idle. So we should be safe there.
> > >  =20
> > Let us not mix up runtime pm and system pm. The uarts need
> > to be idled for runtime suspend, but they are off/ret for
> > system suspend without userspace intervention, so allowing off mode
> > will have an influence even without uart runtime suspend,
> > and also probably for other powerdomains (non-core/per).
> > So we still need to be sure to handle at least some erratas and
> > context save/restore correctly. =20
>=20
> True that's a good point.
>=20
> > Your Idea seems to be in pseudocode
> > if (powersaving_wanted)
> > 	enable_off_mode()
> >=20
> > I had something in mind like
> > if (system_is_trusted_to_handle_offmode()
> > 	enable_off_mode() =20
>=20
> For omap3, the properties for "ti,twl4030-power-idle" or
> "ti,twl4030-power-idle-osc-off" mean just that.
>=20
Hmm, system =3D software + hardware. At least that I had in mind
when writing this text.
So for the software part: I guess off mode is on our all test
schedule, so it should be reliable.
dt describes the hardware, so there should be any MODE7 quirks
defined if they are required and the proper pmic setting.

But wait... twl4030-power.c is to a big part about switching regulators
on and off. But how does that connect to hwmods going to ret or off
mode? That is imho slightly another topic.
Ok, looking a bit closer, there is the sys_off_mode line
which needs to be used.
So we have to derive that from the devicetree.

> The PMIC is wired and configured for off mode, and those
> properties should not be set unless the system is truly capable
> of entering off mode. If not set, we should not enable off
> idle by default.
>=20
> Otherwise the boards should be already using just
> "ti,twl4030-power" or "ti,twl4030-power-reset".
>=20
We have also
ti,twl4030-power-omap3-sdp,
ti,twl4030-power-omap3-ldp,
ti,twl4030-power-omap3-evm

so we have to maintain a list, especially if we want to allow another
pmic.

But since it is about connecting the soc to the pmic, we could also add a
flag in the dtb on the soc side, so we are prepared if someone uses another
pmic. It feels a bit strange to query something from devicetree for another
device.

Regards,
Andreas
PS: I hope my omap-gta04.dtsi-related patches have made their way into
your review queue and are not starving in a generic lkml fallback folder

--Sig_/QwS4Tx=f55MQhMz8gZGszh/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEPIWxmAFyOaBcwCpFl4jFM1s/ye8FAlxagKwACgkQl4jFM1s/
ye8JpA//Vy8EZmxtbWYxWOLs6fx2ndOI9EJF+SaPmSputIA/qyvt0Y49LTQi1shg
XmlBJd8EjYlpw5/JhnZr14U0KjDOd3YjRE1xgAmI/yCfBLiBl7DsabpzMJ2r+F4y
TLncKjw6fqKWUeca06JM94maMkTx8jRmoeRAWfa0Nc3vzTprC5ZZ4ydKaMDY5Wfb
DYVTcr1oaRpiFtG9tARgXPl5bbvs8iDxAIMLUy9m+fbfTPcF9POOdDRzPLL1bBdD
J3g6jW80nDfJABGAhl/25JsvqmrKNA96i6C0mdpF04XauHCMW6+e5V1j/bD06zXX
Q5WvpsK8SRht1kKga8KrZHj3Y4MNsz8nhbG5v9wxmBNH+yd74Of28pIGUQ6hXEz2
TpappPFApC279urffdpJR2A8etxF8RxSWyHOYmt68wiCpuPmEqaSKCoyjnrgyKpu
0FP1kJovxgil3tZuVpaCroSr5GGuvzVVzc9snKdE2igAriYknbwQtYF3GHYpXnPi
ZX+ptcGC4OCAxgpcy02uvYMJKt9ys2YLS7KctmNhBizvN2GF4lmkTlVBBc1PCIlK
7CEMpL+GyEiOSuPBBawpQA4jkRZep+HYnNEOf5vbVWHnfNfC9DDYJX4A1d5k7feJ
PCXS5gKmX1q9k8h580rPLrr0WAnu9oALixQ1z/seiFVXrtUPeq0=
=UHHl
-----END PGP SIGNATURE-----

--Sig_/QwS4Tx=f55MQhMz8gZGszh/--


--===============8620985761611860604==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8620985761611860604==--

