Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B286BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:31:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81155218A6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZXo8z9oI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81155218A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=YyZXAbGU72kKdttTSbumkwbiPh2O1aRZNbsbueHXBsY=; b=ZXo8z9oI3ubN3zlaJ4EyHeB+a
	O9v2xc2CKxiNd67F1GNyv8MfdOS3GIZ8RqqFvMg0hyXfBAFOrUSAjaJmRu4D9l6p/yPl+JbofQf8X
	2WEbw9txb0+TBPWDLq9zC03DyiFm5m2jJwivZ+P6gn2IR/EkcSpkHmfFv2u3m63TCjhQS/HJLaA3T
	9Y93+8/0QgBLqqeGzQi+lF5jws4bk7F2NpdbTLPY1iICTxUIHGHxfcatKK3qn599IED4goRSM1YGm
	+cqVG06J793+ymtIhg+ApSCTiO86+kreKD5jU/JHeJlkL2Kyu5MZyY1yPMIOq6JyXKA09Ejy32Owq
	6NvPtzzow==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZekw-00046x-CQ; Wed, 19 Dec 2018 16:31:34 +0000
Received: from sauhun.de ([88.99.104.3] helo=pokefinder.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZeks-00045z-5c
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 16:31:31 +0000
Received: from localhost (p54B333DA.dip0.t-ipconnect.de [84.179.51.218])
 by pokefinder.org (Postfix) with ESMTPSA id D85332E3542;
 Wed, 19 Dec 2018 17:31:18 +0100 (CET)
Date: Wed, 19 Dec 2018 17:31:15 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFC/RFT 01/10] i2c: add 'is_suspended' flag for i2c adapters
Message-ID: <20181219163115.fdnl6kivywuxdgmu@ninjato>
References: <20181210210310.12677-1-wsa+renesas@sang-engineering.com>
 <20181210210310.12677-2-wsa+renesas@sang-engineering.com>
 <a4fdd7f1-be79-48fd-0d13-410276962384@axentia.se>
 <20181218233354.pie5i3lvrrhq5q2c@ninjato>
 <CAMuHMdWH-bh=cfZhxrD6MYfqFUYroai5WbyYZ6+H4MQeubN=PA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAMuHMdWH-bh=cfZhxrD6MYfqFUYroai5WbyYZ6+H4MQeubN=PA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_083130_359443_4FFD2337 
X-CRM114-Status: GOOD (  15.09  )
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
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 Hans de Goede <hdegoede@redhat.com>,
 "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
 Peter Rosin <peda@axentia.se>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: multipart/mixed; boundary="===============9083179363208059057=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============9083179363208059057==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qjxzn2xrzruodsqv"
Content-Disposition: inline


--qjxzn2xrzruodsqv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 19, 2018 at 10:39:05AM +0100, Geert Uytterhoeven wrote:
> Hi Wolfram,
>=20
> On Wed, Dec 19, 2018 at 12:34 AM Wolfram Sang <wsa@the-dreams.de> wrote:
> > > > +   unsigned int is_suspended:1;    /* owned by the I2C core */
> > >
> > > When more stuff is added to this bit field (which always happens at
> > > some point) updates to all members of the bit field will have to use
> > > the same root-adapter-locking, or we will suffer from RMW-races. So
> > > this feels like an invitation for future disaster. Maybe a comment
> > > about that to remind our future selves? Or perhaps the bit field
> > > should be avoided altogether?
> >
> > Changed to bool. Thanks!
>=20
> Does that help, given bool is smaller than the CPUs word size?
> Is it Alpha that cannot do atomic operations on bytes?

Yup, I overestimated bools :( I guess good old

unsigned long locked_flags;
#define <PREFIX>_IS_SUSPENDED	0

set_bit(), clear_bit(), and test_bit() is it then.


--qjxzn2xrzruodsqv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwack8ACgkQFA3kzBSg
KbY9JRAAhxm2Kip+tvnMls1hk+/Edk4mmwGCNgQoxQX2AhW3Lw0vyAffaBG7S+eG
UwNg372M5JC8Rva111oTpAVr8MhvAVuJnGFpG0UMJIDWXQGJ2UKcumx7DNHwYjiB
zkDtrdjilgbGSe9SVRco+BbBK6qy/mdNI+GBAnXB9bC+Xbawe+3KTlgGVlFpjS9r
Yb02KmVERIxeBYbzNw23S9Tx3raZVOnGSz2am/n9GGrM/kFtBK1Ge7W+Acq92VoF
9C3AOy0ZoyY8sgz5rR0TRuoVgkXC/8AKsWqS3dVCpR0iZPVG9ZYth5ta7rRojjeJ
C/s1Hgq6oR2zxXLiM/NG7SbdIiVMekYbEDrRx2zsBwg18aynLRuygwnqHkT6WE8A
lfZKa/LEVvP9p5Xw4Lwak0jxtqAJzGIv6ebJRN5tLmcRP9vYRuKk/D5RbWq4U6bZ
fuI6Z589b4nZkWgx52G8RCu3NImmLFxbhJd9RjOm9buE5b3nz4aatviQbno2uJ6s
gC3SMz9p0nG7A0cdEYcXXG2/FrKXl3lQtIU028DFRkkfGARRX5bj6+I7bp/s4Vby
0wsdtXwezh9SQPBiJBbtilD9j6oDZGep3/tLVWacvbn3T819oEfVltn26YHQbuz2
VDmUUE5YtgAdUqjUJ2YM0BOZ+bHAGEzGDY2DJLMSwWs7Clu79FE=
=KkzT
-----END PGP SIGNATURE-----

--qjxzn2xrzruodsqv--


--===============9083179363208059057==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============9083179363208059057==--

