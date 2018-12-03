Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D4ADC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:26:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F45620878
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:26:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OMSbbC5j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F45620878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Mime-Version:References:In-Reply-To:Date:To:From:Subject:Message-ID:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=MJEJjpQBd3uk53jh2UV/6aTtpAH1nmOH1KxheMYOwcI=; b=OMSbbC5j3eBL+snEJbR9v5w8V
	UalRXJF/sawBXubMoFhaAZgywV3rrKA/4xSOQHrCnJmD/qpXHzkLPdVCSsrShgVVD1m5+RRI//suE
	5Dsd2gY46axOpHM5G8oVnwxOoKkx3tmVk3q78zftUHMCCY+uZGqbUgGmA3zFAn8HvLLZddL2ACHu1
	EwrCa67Zg/hzmH5QdoPoJMldX2i0DRuV5S4xUTlw5ulco4IMhWwls9YmliZQZMqQTrnmTpZV5TL5M
	Ck+TsRzQnMfQttf87JbT3SR4yT8eatMyK8P9e8wAKzlm5q9xx9xeUW5yYzAQkbew8/XOhB+TFqPjL
	J0Q1cmq1w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTnIr-0004m0-7s; Mon, 03 Dec 2018 12:26:21 +0000
Received: from mx2.suse.de ([195.135.220.15] helo=mx1.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTnIi-0004lP-TD
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 12:26:19 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id E28E5AFA8;
 Mon,  3 Dec 2018 12:25:57 +0000 (UTC)
Message-ID: <7a75afd030cbd17c986a3ad486aab35ad3418b28.camel@suse.de>
Subject: Re: [PATCH] firmware: arm_sdei: fix wrong of_node_put() in init
 function
From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To: James Morse <james.morse@arm.com>
Date: Mon, 03 Dec 2018 13:25:55 +0100
In-Reply-To: <08d6b9e6-7aa0-9342-193b-1ce6e0417f77@arm.com>
References: <20181126121536.28739-1-nsaenzjulienne@suse.de>
 <08d6b9e6-7aa0-9342-193b-1ce6e0417f77@arm.com>
User-Agent: Evolution 3.30.2 
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_042613_091914_94DC3CB7 
X-CRM114-Status: GOOD (  20.85  )
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
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============4266517354767134616=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============4266517354767134616==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-t7AYbqLg9t8BDYsYLWC5"


--=-t7AYbqLg9t8BDYsYLWC5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi James, thanks for the review!=20

On Fri, 2018-11-30 at 18:31 +0000, James Morse wrote:
> Hi Nicolas,
>=20
> On 26/11/2018 12:15, Nicolas Saenz Julienne wrote:
> > After finding a "firmware" dt node arm_sdei tries to match it's
> > compatible string with it. To do so it's calling
> > of_find_matching_node()
> > which already takes care of decreasing the refcount on the
> > "firmware"
> > node. We are then incorrectly decreasing the refcount on that node
> > again.
> >=20
> > This patch removes the unwarranted call to of_node_put().
> >=20
> > Fixes: ad6eb31ef903 ("firmware: arm_sdei: Add driver for Software
> > Delegated Exceptions")
> > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
>=20
> Thanks!, I agree this is unwarranted.
> Is there a tool that picks these up? I remember sparse giving me a
> headache, but
> I don't remember this one... I probably cargo-culted it from
> somewhere else.

We stumbled upon this one on a test system. TBH I don't really know
much about these tools so I can't tell. That said, I sent 4 more fixes
on this bug (one more in drivers/firmware) so there definitively was
some cargo-culting happening.

Regards,
Nicolas

>=20
> Acked-by: James Morse <james.morse@arm.com>
>=20
>=20
> Thanks,
>=20
> James
>=20
>=20
> > ---
> >  drivers/firmware/arm_sdei.c | 1 -
> >  1 file changed, 1 deletion(-)
> >=20
> > diff --git a/drivers/firmware/arm_sdei.c
> > b/drivers/firmware/arm_sdei.c
> > index 1ea71640fdc2..dffb47c6b480 100644
> > --- a/drivers/firmware/arm_sdei.c
> > +++ b/drivers/firmware/arm_sdei.c
> > @@ -1017,7 +1017,6 @@ static bool __init sdei_present_dt(void)
> >  		return false;
> > =20
> >  	np =3D of_find_matching_node(fw_np, sdei_of_match);
> > -	of_node_put(fw_np);
> >  	if (!np)
> >  		return false;
> > =20
> >=20


--=-t7AYbqLg9t8BDYsYLWC5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAlwFINMACgkQlfZmHno8
x/4MIwgAtHytTe+96hhXYF8/nhxaRJfvz0lYGsmJmhQbfPjpwkDntyvwImjoAvFr
VqJe0LVkzJ9UgcmJfv5dKnhGkMO5Mb2pG1j8HAnOIwDu1l8JFiJdAOpxIIJoPBvJ
0wtuGeAqq01Qu0jAqTCqNjPwUe++Mm+Hq8c/R0IHAKe8LVxNj5nCxp31lutZE1hY
YiqopW+uLORHTBIVVm+K8rg3wYnFf8z5DfmKx/ddwF+exEENo9vt+JxQvTL6/Duk
VdH+5JkPTS6oTMOKpcJIYc7MUnUrF09O6YzUv3RddsKpjtrJo0qXWBllzs+CAvAX
Q4IrhMVAb178QBxt83+YJjE1xhAapQ==
=L/YC
-----END PGP SIGNATURE-----

--=-t7AYbqLg9t8BDYsYLWC5--



--===============4266517354767134616==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4266517354767134616==--


