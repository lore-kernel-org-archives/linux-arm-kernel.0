Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E6BC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 09:03:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D01E8214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 09:03:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FCmzpR3S";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="EAR72MtT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D01E8214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=KX9BTVrbzDOZJYuwKr3VrylUQh+DFTMIxNz21imjZwY=; b=FCmzpR3Sn/5pHn85mx+TieuHR
	yN05rS4MgpHc76T1RHsvzHYpz4ut+FxYV4t47ZH9dPL5ULX95nAmk3EP0ogATRakmTF9NVyZXtzs8
	GTjK/4dynOpM5ltz68YQVRJ0doVcJDNpreurYTyKMYRMRd9r4UI53yGzHLtBbhRDb+/cO8eeVRrx9
	k9ModJRgOTpWZFfyoBxuW7kDXoXx03MUT7crFRUM3w1FtUuTv8+Rg4Z7d0t7J5PvzfAbI4Hxkd2ve
	rhFuXubqGttzcmqWYq1Cc664kt5eqwwWIvgRqTL7yp367Tnpeb/Te3/a/3qcMuiYsYjV4OOrR/pW8
	QjrwYq9+Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqa9n-0001WB-Ja; Mon, 04 Feb 2019 09:03:11 +0000
Received: from heliosphere.sirena.org.uk ([2a01:7e01::f03c:91ff:fed4:a3b6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqa9j-0001Vp-Sf
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 09:03:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TJrHOAePs06pCrkVaWMSAlaYoFeXAbWnb2f2XPY0mhM=; b=EAR72MtTkYEKRNnJLKN8QGdET
 zsFSEYCQIfiGzv4ygkZADwGcEyEpGeLDKemDEQk9miQ4mPmZWGSrA9G7/tAuI8Ogy/4DJUZmOyzRB
 l39tIMAF2DFFeEe718UOhESosHuc4P1VT3CBXbAT8W9NGoQj5FcClEm1af+uttIizvJYw=;
Received: from 53.97-247-81.adsl-dyn.isp.belgacom.be ([81.247.97.53]
 helo=finisterre.ee.mobilebroadband)
 by heliosphere.sirena.org.uk with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1gqa9e-0000e7-Qi; Mon, 04 Feb 2019 09:03:02 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
 id 2539F440082; Mon,  4 Feb 2019 09:03:01 +0000 (GMT)
Date: Mon, 4 Feb 2019 10:03:01 +0100
From: Mark Brown <broonie@kernel.org>
To: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Subject: Re: [PATCH 2/3] drivers: regulator: qcom: add PMS405 SPMI regulator
Message-ID: <20190204090301.GC23441@sirena.org.uk>
References: <1548675904-18324-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1548675904-18324-3-git-send-email-jorge.ramirez-ortiz@linaro.org>
MIME-Version: 1.0
In-Reply-To: <1548675904-18324-3-git-send-email-jorge.ramirez-ortiz@linaro.org>
X-Cookie: Murphy was an optimist.
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_010308_099722_8A94D968 
X-CRM114-Status: GOOD (  13.96  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, vinod.koul@linaro.org,
 linux-kernel@vger.kernel.org, khasim.mohammed@linaro.org, lgirdwood@gmail.com,
 bjorn.andersson@linaro.org, robh+dt@kernel.org, linux-arm-msm@vger.kernel.org,
 niklas.cassel@linaro.org, linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============6722056103043022801=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============6722056103043022801==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5QAgd0e35j3NYeGe"
Content-Disposition: inline


--5QAgd0e35j3NYeGe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 28, 2019 at 12:45:03PM +0100, Jorge Ramirez-Ortiz wrote:

> @@ -653,6 +708,10 @@ spmi_regulator_find_range(struct spmi_regulator *vre=
g)
>  	range =3D vreg->set_points->range;
>  	end =3D range + vreg->set_points->count;
> =20
> +	/* we know we only have one range for this type */
> +	if (vreg->logical_type =3D=3D SPMI_REGULATOR_LOGICAL_TYPE_HFS430)
> +		return range;
> +
>  	spmi_vreg_read(vreg, SPMI_COMMON_REG_VOLTAGE_RANGE, &range_sel, 1);
> =20
>  	for (; range < end; range++)

Rather than have special casing for the logical type in here it seems
better to just provide a specific op for this logical type, you could
always make _find_range() call into that one if you really want code
reuse here.  You already have separate ops for this regulator type
anyway.

> +static unsigned int spmi_regulator_hfs430_get_mode(struct regulator_dev =
*rdev)
> +{
> +	struct spmi_regulator *vreg =3D rdev_get_drvdata(rdev);
> +	u8 reg;
> +	int ret;
> +
> +	ret =3D spmi_vreg_read(vreg, SPMI_HFS430_REG_MODE, &reg, 1);
> +	if (ret) {
> +		dev_err(&rdev->dev, "failed to get mode");
> +		return ret;
> +	}
> +
> +	if (reg =3D=3D SPMI_HFS430_MODE_PWM)
> +		return REGULATOR_MODE_NORMAL;
> +
> +	return REGULATOR_MODE_IDLE;
> +}

I'd have expected a switch statement here, ideally flagging a warning or
error if we get a surprising value in there.

> +static int spmi_regulator_hfs430_set_mode(struct regulator_dev *rdev,
> +					  unsigned int mode)
> +{
> +	struct spmi_regulator *vreg =3D rdev_get_drvdata(rdev);
> +	u8 reg =3D mode =3D=3D REGULATOR_MODE_NORMAL ? SPMI_HFS430_MODE_PWM :
> +						 SPMI_HFS430_MODE_AUTO;

Please write a normal if statement (or switch statement) to help
legibility.

--5QAgd0e35j3NYeGe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxX/8IACgkQJNaLcl1U
h9AT0wf9E3UlafXm3pZLIqrY5EIoO+llv9YGhMENRbXSjvSt68YbsVh4naMSDVPF
Esp/LfvSl6S+jEKNRYuofIdqidqnYUQzaPjDAUEV7lVv1PIjZDLeG9HrEJer82rv
c7zmbRz3oEcPD6Ja02FpOdxuCS7AqVdbTOIHUaw5DSlzIQTHEMC+aoCQ0btTerLJ
j/aO8IGVw/Bazyvya3PUnRPIj8foH7msmKQgXpf8+Gl/wPp3X9VfeaHfBdCssxQb
anflPszsQ83skkXShVttyUr4j+N+UgtkhpedP1tuydfI5BlFhquKZD5aMG1K7ebD
0MsgwXc2R1L4P/vf/5OINRuONkd/3A==
=IuR9
-----END PGP SIGNATURE-----

--5QAgd0e35j3NYeGe--


--===============6722056103043022801==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6722056103043022801==--

