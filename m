Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A74E8C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 12:31:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 621B32081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 12:31:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZKWIWaQX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 621B32081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Mime-Version:References:In-Reply-To:Date:To:From:Subject:Message-ID:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=vwXXn6v3EydJkJdrpbJW2vre2kyL0RXpKSXYmvZRTUY=; b=ZKWIWaQXx/tJkyL4CusoEdZsd
	plvngJ7M3l3+iq4vySL6x+eLTCosUcL37aHyH+jfvtyUMPGB+rL5Qp4RXSlBbOzn3Xx7tNAA5MynU
	pFwk15XBDhuzs96s1cXivJ4M57Aos2V0giuxlSJu8xEjZwnlittYfG0qW7W2O2gj7S4cAD4dGJdY4
	XkHSN9LjurC5OzudjorkKYPgkFKQr1Qq5t5VUmugVOJZPXeMhl25L62Umj5DsdRcJ5XfFJbRDmuzK
	fFhDdaaqBzsBvFcWxlXREz9IbpVQvFI1Zjogq38D16CyVG+dGxfllBb3tCKinSjuczSqbYasMWVfb
	F4gpUIciA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWhBz-0002tv-0W; Tue, 11 Dec 2018 12:31:15 +0000
Received: from mx2.suse.de ([195.135.220.15] helo=mx1.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWhBw-0002sx-28; Tue, 11 Dec 2018 12:31:13 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 2875CAE3C;
 Tue, 11 Dec 2018 12:31:00 +0000 (UTC)
Message-ID: <64c0fef108dc3bdb137c84714644d770f2008ac5.camel@suse.de>
Subject: Re: [PATCH] staging: vchiq: rework remove_event handling
From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To: Dan Carpenter <dan.carpenter@oracle.com>, Arnd Bergmann <arnd@arndb.de>
Date: Tue, 11 Dec 2018 13:30:55 +0100
In-Reply-To: <20181211100728.GC3116@kadam>
References: <20181210211231.4084251-1-arnd@arndb.de>
 <20181211100728.GC3116@kadam>
User-Agent: Evolution 3.30.2 
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_043112_244981_84112ECA 
X-CRM114-Status: GOOD (  10.28  )
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
Cc: devel@driverdev.osuosl.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Tara Null <tn@fastmail.net>, linux-kernel@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============6245063383574795867=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============6245063383574795867==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-6Xl5zNzwmyTPg82Yk6D2"


--=-6Xl5zNzwmyTPg82Yk6D2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2018-12-11 at 13:07 +0300, Dan Carpenter wrote:
> On Mon, Dec 10, 2018 at 10:11:58PM +0100, Arnd Bergmann wrote:
> > Note that I'm changing it back to 'killable' after the previous
> > patch
> > changed 'killable' to 'interruptible', apparently based on a
> > misunderstanding
> > of the subtle down_interruptible() macro override in
> > vchiq_killable.h.
>=20
> Oh wow...  The non standard down_interruptible() macro is ugly.
>=20

Same reaction here, *_*. I wasn't even aware of it.

Arnd, as long as it you're not doing it already. I'll prepare some
extra fixes for the rest of completions and get rid of that file
altogether.

Regards,
Nicolas

--=-6Xl5zNzwmyTPg82Yk6D2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAlwPrf8ACgkQlfZmHno8
x/70jggAmDlmYkQniQi3bwL3vGHNBDfc5O2Q4qXDuDXUF+Hiaaq2Qdft0V0T7YTE
1/Ex5iP+rk+Rqc3/1XObOtmdwwrrZZ7IWn4VjsLd06f8f/EyWBxghwA4edgrmW18
+AB/ZGnfd7qdAnty+OzTACEN1IZQSRN3vkwGt99uAgH+AtERPKiQbM67Ma6tiH+i
HOuWG+Ge6lDMeE9lSC5yK9sLHAzZu0rRpDddWYpJMmscmG9AOIKFcJsz6ifbt6cM
6GUaJMX33QlI/yZk2pXcFBKqk8IrsLgwmGkVRSaJvC7WNBKFXv8944G70q/1kxfD
6Ls4YS+R9QE99KJqjSdXSHJETV72kw==
=oAA/
-----END PGP SIGNATURE-----

--=-6Xl5zNzwmyTPg82Yk6D2--



--===============6245063383574795867==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6245063383574795867==--


