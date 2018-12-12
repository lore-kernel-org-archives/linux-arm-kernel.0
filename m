Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CFF1C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 16:25:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F072E20849
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 16:25:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uCRmkQY1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F072E20849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Mime-Version:References:In-Reply-To:Date:To:From:Subject:Message-ID:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=wHR5mmZntTRTEeXL84AFXWnUwfE06NrVhCd/hW/WzXM=; b=uCRmkQY1UmE3JS17szximVGiJ
	0UN9GpZab8Odqc+KSXc7yLdCiUAQNiXWaD7y9w9x2FUG3PZ6m4VIF9g/slkc0rMwryPMd7h3rLyzt
	snodOXswVmF23knuL1zeKkEFZ4ypsAT/qE+cltXBrQBqYltEmhp4b7Yk54wcg/03Dsb7+Aqr7Wa3t
	AlS7sjEDoDbx6w2NhVhkgKT0WmfEofGMpP2zxVcFCenGuI+Qtb0tX5vgkTBqxqIRds/DjZQLZRinD
	TYYYvTmfBA4Ec7HlnjSh4DYZD5mTOHjgKSqzky7fO22Wef5QxYYx2ySRu4HFvpVEDz4dG8SieeFDX
	0ZsRqCD5Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX7Jz-0001e9-SB; Wed, 12 Dec 2018 16:25:15 +0000
Received: from mx2.suse.de ([195.135.220.15] helo=mx1.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX7Jl-0000YR-3I; Wed, 12 Dec 2018 16:25:02 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 70B0AAFAD;
 Wed, 12 Dec 2018 16:24:43 +0000 (UTC)
Message-ID: <05b4e41c294ada256e1b98ca1d833ad7643dc1af.camel@suse.de>
Subject: Re: [PATCH] staging: vchiq: rework remove_event handling
From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 12 Dec 2018 17:24:40 +0100
In-Reply-To: <CAK8P3a1f0hJhZBbj6yf1ZZS3znDOSFK0e7KHveW95zjB1x=+tQ@mail.gmail.com>
References: <20181210211231.4084251-1-arnd@arndb.de>
 <c0348f29fc1bcc73b3f67b740cd3c5c6ad34d07b.camel@suse.de>
 <CAK8P3a1f0hJhZBbj6yf1ZZS3znDOSFK0e7KHveW95zjB1x=+tQ@mail.gmail.com>
User-Agent: Evolution 3.30.2 
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_082501_284865_98044A6A 
X-CRM114-Status: GOOD (  14.72  )
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
Cc: Stefan Wahren <stefan.wahren@i2se.com>,
 driverdevel <devel@driverdev.osuosl.org>, gregkh <gregkh@linuxfoundation.org>,
 tn@fastmail.net, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Eric Anholt <eric@anholt.net>, "moderated
 list:BROADCOM BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: multipart/mixed; boundary="===============8007190746560772532=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============8007190746560772532==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-1v0R/rwR9TzvGupfm1RX"


--=-1v0R/rwR9TzvGupfm1RX
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2018-12-11 at 15:20 +0100, Arnd Bergmann wrote:
> On Tue, Dec 11, 2018 at 1:36 PM Nicolas Saenz Julienne
> <nsaenzjulienne@suse.de> wrote:
> > On Mon, 2018-12-10 at 22:11 +0100, Arnd Bergmann wrote:
> > > @@ -447,26 +444,26 @@ remote_event_wait(VCHIQ_STATE_T *state,
> > > REMOTE_EVENT_T *event)
> > >  }
> > >=20
> > >  static inline void
> > > -remote_event_signal_local(VCHIQ_STATE_T *state, REMOTE_EVENT_T
> > > *event)
> > > +remote_event_signal_local(wait_queue_head_t *wq, REMOTE_EVENT_T
> > > *event)
> > >  {
> > >       event->armed =3D 0;
> > > -     complete((struct completion *)((char *)state + event-
> > > >event));
> > > +     wake_up_all(wq);
> >=20
> > Shouldn't this just be "wake_up(wq)"?
>=20
> I wasn't entirely sure if we could get with more than one thread
> waiting
> for the wakeup. With the semaphore or completion that would already
> be broken because we'd only wake up one of them, but I was hoping
> to stay on the safe side with wake_up_all().

You're right. Had a look at the code and there shouldn't be more than
one thread waiting. wake_up_all() looks OK.

Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

Regards,
Nicolas

--=-1v0R/rwR9TzvGupfm1RX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAlwRNkgACgkQlfZmHno8
x/5e3gf9ELhV5rN+/E711w2YQgWLGcY5sRqhVTPe6zumV+qL522GralshXG0TSSa
eO0WPNhJ1+EQqrkk8PmstzmLAGx02gPJBOArt0CW4mUnYTzciqBFYM3dh3pH4k7T
qDhoXi6JrFJOpodHgZ+SlktcEYKkzwC6nqpt/gbveLzVdNM/K4HhzJr62O9KZKv+
2GRKmOsjGn+4iJOhUcZe6sMTbZ4S9eptk3w8j4YVjykkai8Eok4KTuR2gEk5XUYn
wxMgBRyrXIKfnbhgV41gHEZZnnS1+jvXxlfnpA+NwMt2kVXARQoiB0edVGvwKcjM
6CLxqu/qeAhmC8adpArsbVJFQ65jCw==
=2tTH
-----END PGP SIGNATURE-----

--=-1v0R/rwR9TzvGupfm1RX--



--===============8007190746560772532==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8007190746560772532==--


