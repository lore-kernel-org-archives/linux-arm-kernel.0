Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB147C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:10:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89F56218B0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:10:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gdD3qwXB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89F56218B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=lrTqJkr72uZbt0AheZdmhXfUwdTXkfu05GxIf26nsAI=; b=gdD3qwXB7xARkmm4uJ+wpiosE
	GbP1JJS2R4uP5kwxqV3rg11+qPSNBe8DbUhLWrRpYIbDwwfZpUxWLcuzdxaR0WxiM+XVfiKUw+VkN
	n/36zqVQcn5yMYBnNgkPNlAo1ngRhAu1DWCpeHh5MO2aI4HuLAZnCSXzUSkA7a6HgiENmAoiE3ick
	lAQP/TkjAdmNbUvHNp0AcJp5Cpe9SENrtFT6CzGXPa5pwd3HOL8hAh4LXFBPWCrkluFnOfWMboTsR
	LEEkPX0NYTSv+xQpjf7Zcht7efc90xJtpAo/2cquxWx5hex3S7x7FNMH6tVeb2S29un40sy1wWLzz
	ZM4cX/6kg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmyR6-0007UH-K9; Fri, 25 Jan 2019 10:10:08 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmyR1-000710-IZ
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 10:10:05 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id D4F8A20798; Fri, 25 Jan 2019 11:10:01 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-87-206.w90-88.abo.wanadoo.fr
 [90.88.29.206])
 by mail.bootlin.com (Postfix) with ESMTPSA id A49B9206A6;
 Fri, 25 Jan 2019 11:10:01 +0100 (CET)
Date: Fri, 25 Jan 2019 11:10:02 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: Re: [PATCH v2 2/2] media: cedrus: Add HEVC/H.265 decoding support
Message-ID: <20190125101002.z5ftls5xo7izygvy@flea>
References: <20181123130209.11696-1-paul.kocialkowski@bootlin.com>
 <20181123130209.11696-3-paul.kocialkowski@bootlin.com>
 <20181127082119.xdemdwgclai7kj3r@flea>
 <4f25de5bbcb7bf196fe4925f54e3335b50670bd2.camel@bootlin.com>
MIME-Version: 1.0
In-Reply-To: <4f25de5bbcb7bf196fe4925f54e3335b50670bd2.camel@bootlin.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_021003_975138_A3EE2D1B 
X-CRM114-Status: GOOD (  22.53  )
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
Cc: devel@driverdev.osuosl.org, Alexandre Courbot <acourbot@chromium.org>,
 Randy Li <ayaka@soulik.info>, linux-kernel@vger.kernel.org,
 Tomasz Figa <tfiga@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>,
 linux-sunxi@googlegroups.com, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Ezequiel Garcia <ezequiel@collabora.com>, linux-arm-kernel@lists.infradead.org,
 linux-media@vger.kernel.org
Content-Type: multipart/mixed; boundary="===============7383120295340314457=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============7383120295340314457==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="z6zsvccsx3aejq2d"
Content-Disposition: inline


--z6zsvccsx3aejq2d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jan 24, 2019 at 02:10:25PM +0100, Paul Kocialkowski wrote:
> On Tue, 2018-11-27 at 09:21 +0100, Maxime Ripard wrote:
> > Hi!
> >=20
> > On Fri, Nov 23, 2018 at 02:02:09PM +0100, Paul Kocialkowski wrote:
> > > This introduces support for HEVC/H.265 to the Cedrus VPU driver, with
> > > both uni-directional and bi-directional prediction modes supported.
> > >=20
> > > Field-coded (interlaced) pictures, custom quantization matrices and
> > > 10-bit output are not supported at this point.
> > >=20
> > > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> >=20
> > Output from checkpatch:
> > total: 0 errors, 68 warnings, 14 checks, 999 lines checked
>=20
> Looks like many of the "line over 80 chars" are due to macros. I don't
> think it would be a good idea to break them down or to change the
> macros names since they are directly inherited from the bitstream
> elements.
>=20
> What do you think?

Yeah, the 80-chars limit can be ignored. But there's more warnings and
checks that should be addressed.

> > > +	/* Output frame. */
> > > +
> > > +	output_pic_list_index =3D V4L2_HEVC_DPB_ENTRIES_NUM_MAX;
> > > +	pic_order_cnt[0] =3D pic_order_cnt[1] =3D slice_params->slice_pic_o=
rder_cnt;
> > > +	mv_col_buf_addr[0] =3D cedrus_h265_frame_info_mv_col_buf_addr(ctx,
> > > +		run->dst->vb2_buf.index, 0) - PHYS_OFFSET;
> > > +	mv_col_buf_addr[1] =3D cedrus_h265_frame_info_mv_col_buf_addr(ctx,
> > > +		run->dst->vb2_buf.index, 1) - PHYS_OFFSET;
> > > +	dst_luma_addr =3D cedrus_dst_buf_addr(ctx, run->dst->vb2_buf.index,=
 0) -
> > > +			PHYS_OFFSET;
> > > +	dst_chroma_addr =3D cedrus_dst_buf_addr(ctx, run->dst->vb2_buf.inde=
x, 1) -
> > > +			PHYS_OFFSET;
> > > +
> > > +	cedrus_h265_frame_info_write_single(dev, output_pic_list_index,
> > > +					    slice_params->pic_struct !=3D 0,
> > > +					    pic_order_cnt, mv_col_buf_addr,
> > > +					    dst_luma_addr, dst_chroma_addr);
> >=20
> > You can only pass the run and slice_params pointers to that function.
>=20
> The point is to make it independent from the context, so that the same
> function can be called with either the slice_params or the dpb info.
> I don't think making two variants or even two wrappers would bring any
> significant benefit.

Then you can still pass directly the vb2 buffer pointer, that would
remove the mv_col_buf_addr, dst_luma_addr and dst_chroma_addr. The
idea here is that the less arguments you have in your function, the
easier it is to understand.

> > > +
> > > +	cedrus_write(dev, VE_DEC_H265_OUTPUT_FRAME_IDX, output_pic_list_ind=
ex);
> > > +
> > > +	/* Reference picture list 0 (for P/B frames). */
> > > +	if (slice_params->slice_type !=3D V4L2_HEVC_SLICE_TYPE_I) {
> > > +		cedrus_h265_ref_pic_list_write(dev, slice_params->ref_idx_l0,
> > > +			slice_params->num_ref_idx_l0_active_minus1 + 1,
> > > +			slice_params->dpb, slice_params->num_active_dpb_entries,
> > > +			VE_DEC_H265_SRAM_OFFSET_REF_PIC_LIST0);
> > > +
> >=20
> > slice_params is enough.
>=20
> The rationale is similar to the one above: being able to use the same
> helper with either L0 or L1, which implies passing the relevant
> elements directly.

The DPB and num_active_dpb_entries will not change from one run to the
other though. And having intermediate functions if that allows to be
clearer is fine as well.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--z6zsvccsx3aejq2d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXErgegAKCRDj7w1vZxhR
xRsaAQC2ViWDkwRbE+VzfnvT6IM2IOggLnD2AO3axObHgVowZwEAsoum8jkX4cu3
0xmBF8qYXaO9qf+KUl0tIhsEPcj2dQA=
=H23o
-----END PGP SIGNATURE-----

--z6zsvccsx3aejq2d--


--===============7383120295340314457==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7383120295340314457==--

