Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF07C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:56:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AE8521773
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iY2aorBI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AE8521773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=O3FYtjG/9kdZZ7fN9hilmd/mMgGIbQ14BYyTaeY35hQ=; b=iY2aorBIAljnH/9ojnH08m4Z9
	4f8k75nXcvoqgPohxhtQc67i4/nl+t9Vsn2QsPom/Tl4HTyI47vdwYuvDsKFpaeu9K5Pqc2Jr3KkD
	N8B8/I1ljXUASATN0UD7BMVjTIcDu0IHIUB1inQ5DzwaXJmFMzj78hIh2/t9BQre+5tRKO1QuBw2Y
	sTNTNkUvjX5aGyrUo3Q7Vz6i8Ygd1ESpelXyVZxg4Ozb3HzIgd4n+/GJYQtL7jXkH7KdTjV1MrVdv
	H3fXH3qAn0+3vOGnJGpiL+CpNzAdx1MGv2isKmhJBrPbq63s9+9CNuqo4l8D4BsLNQEDMwHccXswm
	HnRc5hsWA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw34J-0006rj-Dw; Tue, 19 Feb 2019 10:56:07 +0000
Received: from relay4-d.mail.gandi.net ([217.70.183.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw34G-0006rJ-4G
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 10:56:06 +0000
X-Originating-IP: 90.88.30.68
Received: from localhost (aaubervilliers-681-1-89-68.w90-88.abo.wanadoo.fr
 [90.88.30.68]) (Authenticated sender: maxime.ripard@bootlin.com)
 by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 0F28EE0005;
 Tue, 19 Feb 2019 10:55:51 +0000 (UTC)
Date: Tue, 19 Feb 2019 11:55:51 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v3 5/7] drm/sun4i: Rely on dma interconnect for our RAM
 offset
Message-ID: <20190219105551.hyq3nefz6iueyjt3@flea>
References: <cover.f2e5fbb4d21384168973fa32377a33d627768146.1549897336.git-series.maxime.ripard@bootlin.com>
 <dfbdedf89c6a36f6fe5564e7c518664fa9e828c0.1549897336.git-series.maxime.ripard@bootlin.com>
 <16cb9f67-6b10-fbc3-6222-5364e718721b@arm.com>
 <20190213154144.5m5qxbfh2qmzwatn@flea>
 <5540eb65-d33c-ddca-8636-f567e84fb24a@arm.com>
MIME-Version: 1.0
In-Reply-To: <5540eb65-d33c-ddca-8636-f567e84fb24a@arm.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_025604_466948_645B6B19 
X-CRM114-Status: GOOD (  35.63  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Yong Deng <yong.deng@magewell.com>, Arnd Bergmann <arnd@arndb.de>,
 Daniel Vetter <daniel.vetter@ffwll.ch>, dri-devel@lists.freedesktop.org,
 Dave Martin <dave.martin@arm.com>,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Frank Rowand <frowand.list@gmail.com>,
 Georgi Djakov <georgi.djakov@linaro.org>, linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============6181538690943101273=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============6181538690943101273==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sc43thmuftfnmekm"
Content-Disposition: inline


--sc43thmuftfnmekm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Robin,

On Wed, Feb 13, 2019 at 04:40:11PM +0000, Robin Murphy wrote:
> On 13/02/2019 15:41, Maxime Ripard wrote:
> > Hi Robin,
> >=20
> > Thanks for your feedback!
> >=20
> > On Tue, Feb 12, 2019 at 06:46:40PM +0000, Robin Murphy wrote:
> > > On 11/02/2019 15:02, Maxime Ripard wrote:
> > > > Now that we can express our DMA topology, rely on those property in=
stead of
> > > > hardcoding an offset from the dma_addr_t which wasn't really great.
> > > >=20
> > > > We still need to add some code to deal with the old DT that would l=
ack that
> > > > property, but we move the offset to the DRM device dma_pfn_offset t=
o be
> > > > able to rely on just the dma_addr_t associated to the GEM object.
> > > >=20
> > > > Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> > > > Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> > > > ---
> > > >    drivers/gpu/drm/sun4i/sun4i_backend.c | 28 +++++++++++++++++++++=
-------
> > > >    1 file changed, 21 insertions(+), 7 deletions(-)
> > > >=20
> > > > diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/dr=
m/sun4i/sun4i_backend.c
> > > > index 9e9255ee59cd..1846a1b30fea 100644
> > > > --- a/drivers/gpu/drm/sun4i/sun4i_backend.c
> > > > +++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
> > > > @@ -383,13 +383,6 @@ int sun4i_backend_update_layer_buffer(struct s=
un4i_backend *backend,
> > > >    	paddr =3D drm_fb_cma_get_gem_addr(fb, state, 0);
> > > >    	DRM_DEBUG_DRIVER("Setting buffer address to %pad\n", &paddr);
> > > > -	/*
> > > > -	 * backend DMA accesses DRAM directly, bypassing the system
> > > > -	 * bus. As such, the address range is different and the buffer
> > > > -	 * address needs to be corrected.
> > > > -	 */
> > > > -	paddr -=3D PHYS_OFFSET;
> > > > -
> > > >    	if (fb->format->is_yuv)
> > > >    		return sun4i_backend_update_yuv_buffer(backend, fb, paddr);
> > > > @@ -835,6 +828,27 @@ static int sun4i_backend_bind(struct device *d=
ev, struct device *master,
> > > >    	dev_set_drvdata(dev, backend);
> > > >    	spin_lock_init(&backend->frontend_lock);
> > > > +	if (of_find_property(dev->of_node, "interconnects", NULL)) {
> > > > +		/*
> > > > +		 * This assume we have the same DMA constraints for all our the
> > > > +		 * devices in our pipeline (all the backends, but also the
> > > > +		 * frontends). This sounds bad, but it has always been the case
> > > > +		 * for us, and DRM doesn't do per-device allocation either, so
> > > > +		 * we would need to fix DRM first...
> > > > +		 */
> > > > +		ret =3D of_dma_configure(drm->dev, dev->of_node, true);
> > >=20
> > > It would be even nicer if we could ensure that drm->dev originates fr=
om a DT
> > > node which has the appropriate interconnects property itself, such th=
at we
> > > can assume it's already configured correctly.
> >=20
> > The thing is drm->dev comes from a node in the DT that is a virtual
> > node, and therefore doesn't have any resources attached, so I'm not
> > sure we have any other way, unfortunately.
>=20
> Right, I appreciate that it may not be feasible to swizzle drm->dev for o=
ne
> of the 'real' component devices, but what I was also thinking was that si=
nce
> the virtual device node effectively represents the aggregation of the oth=
er
> component devices, we could just say that it also has to have its own link
> to the MBUS interconnect (with the ID of the pipeline entrypoint it's
> associated with, I guess). That ought to be enough to get dma_configure()=
 to
> do the job, and in fairness is no *less* accurate a description of the
> hardware, even if might look a little funky to some.

That virtual device however can work with up to 4 devices that can
perform DMA operations, all of them going through a different port of
the MBUS controller that can account for DMA usage on a per-master
basis.

Eventually, we should support that feature as well, but the point is
that from a DT point of view, there's not a single point of DMA access
for that particular device but more likely 2-4 points, each with a
different argument to the phandle.

We could of course have a hack and use only one of them, but that
would be less accurate than what we currently have. Plus, this is
really due to a restriction on the DRM side, that could change in the
future (even though it's unlikely). Fixing that restriction would make
that property completely useless, confusing and wrong from an hardware
PoV.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--sc43thmuftfnmekm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXGvgtwAKCRDj7w1vZxhR
xWfuAP94R9nmIR/vJnK9dIEh18zR45qi1ApMwkbJvajQaIXO1AD/QnxHM7EDW13S
UMFDxSYP7VPkKZcTsO5kZTYJeO8D+wA=
=Jh8h
-----END PGP SIGNATURE-----

--sc43thmuftfnmekm--


--===============6181538690943101273==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6181538690943101273==--

