Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE3BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 15:07:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 201A821720
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 15:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XP6SMQqb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="hWR5FSCH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 201A821720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=S/7bWCZNL5Hp6AhORCNohC6ysjR+6hPB2/LocPxEW1w=; b=XP6SMQqbnhZsgfu4FJXmxMVnL
	V427Zv3XrWXa/EhI2G4c7v7PpV5m3emQGtPG5ujQg6Qa9N+CHFcK862GJ+xLvQvHWhUiMzo/rAERS
	RRmVdBCaJgL5BTI9pchF5Ut5IsJDu8Q2m7RmXXwZjrJ7oD5G8WnSFslKdggwyoxs9H+9LZLigDJI9
	SQqBND9pZ8Jt+yU2P1zhkC1lKieMAjWizEAbzMJIp7IyEiA6PFvvFz2XWixJxLzs7jZct/Nt6l92I
	k23bOmrcu66Wp01bR8Bue184flmCsnFTxv8TeT+a1+jVQ3EvXOY/s/AdUNaD7A8eXiKOG6pOjCluu
	MzTEX3Jiw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZzuz-0004ba-BH; Thu, 20 Dec 2018 15:07:21 +0000
Received: from heliosphere.sirena.org.uk ([2a01:7e01::f03c:91ff:fed4:a3b6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZzus-0004aw-1U
 for linux-arm-kernel@lists.infradead.org; Thu, 20 Dec 2018 15:07:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FTBfCPsDaptKpOmyncTF35ttM7t0jibRMEu63FLnH9I=; b=hWR5FSCHsZnF3tIM++WMIKA8S
 /35E2UOUIeTnJ6g1saZYUrVlhDH6XHVWO5Sbs1+MO0ktb7jBSjkAKLSMR2bx0FZhsSEW6tB6W5ZCv
 b48MAl/d+H7ZWL/rlVZrEkSM0hEYrekXiT+k7AtcYIp88fT7RBw+w6sp5ZU/42necafDw=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=debutante.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1gZzub-0003ix-BD; Thu, 20 Dec 2018 15:06:57 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
 id E074A1121B93; Thu, 20 Dec 2018 15:06:56 +0000 (GMT)
Date: Thu, 20 Dec 2018 15:06:56 +0000
From: Mark Brown <broonie@kernel.org>
To: Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>
Subject: Re: [PATCH 2/3] ASoC: xlnx: add pcm formatter platform driver
Message-ID: <20181220150656.GB9325@sirena.org.uk>
References: <1545239949-112845-1-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
 <1545239949-112845-3-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
MIME-Version: 1.0
In-Reply-To: <1545239949-112845-3-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
X-Cookie: Truth is free, but information costs.
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_070714_238068_EB1FC8A7 
X-CRM114-Status: GOOD (  12.03  )
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
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org,
 Jaroslav Kysela <perex@perex.cz>, Michal Simek <michal.simek@xilinx.com>,
 Vishal Sagar <vsagar@xilinx.com>
Content-Type: multipart/mixed; boundary="===============3192297045399024513=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============3192297045399024513==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="E39vaYmALEf/7YXx"
Content-Disposition: inline


--E39vaYmALEf/7YXx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 19, 2018 at 10:49:08PM +0530, Maruthi Srinivas Bayyavarapu wrote:

This looks mostly good, a few small things but all pretty trivial:

> +	switch (bits_per_sample) {
> +	case 8:
> +		val |= (BIT_DEPTH_8 << AUD_CTRL_DATA_WIDTH_SHIFT);
> +		break;
> +	case 16:
> +		val |= (BIT_DEPTH_16 << AUD_CTRL_DATA_WIDTH_SHIFT);
> +		break;
> +	case 20:
> +		val |= (BIT_DEPTH_20 << AUD_CTRL_DATA_WIDTH_SHIFT);
> +		break;
> +	case 24:
> +		val |= (BIT_DEPTH_24 << AUD_CTRL_DATA_WIDTH_SHIFT);
> +		break;
> +	case 32:
> +		val |= (BIT_DEPTH_32 << AUD_CTRL_DATA_WIDTH_SHIFT);
> +		break;
> +	}

It'd be better to have a default case returning an error for unsupported
sample sizes.

> +		ret = devm_request_irq(dev, aud_drv_data->mm2s_irq,
> +				       xlnx_mm2s_irq_handler, 0,
> +				       "xlnx_formatter_pcm_mm2s_irq", dev);
> +		if (ret) {
> +			dev_err(dev, "xlnx audio mm2s irq request failed\n");
> +			goto clk_err;
> +		}
> +		ret = xlnx_formatter_pcm_reset(aud_drv_data->mmio +
> +					       XLNX_MM2S_OFFSET);
> +		if (ret) {
> +			dev_err(dev, "audio formatter reset failed\n");
> +			goto clk_err;
> +		}
> +		xlnx_formatter_disable_irqs(aud_drv_data->mmio +
> +					    XLNX_MM2S_OFFSET,
> +					    SNDRV_PCM_STREAM_PLAYBACK);

This requests the interrupt before we've reset and quiesced the hardware
meaning the interrupt could fire immediately on request with the
hardware in an unknown state; it'd be better to reset the hardware first
then request the interrupt to minimize the risk that something goes
wrong with the handler.

> +	dev_info(dev, "pcm platform device registered\n");
> +	return 0;

This is just adding noise to the log.

--E39vaYmALEf/7YXx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwbsBAACgkQJNaLcl1U
h9Cpegf/WpTeT0YeDGH0yu/OmjEIpOjD5J8UooYjuzyLJCdKXLgfQy+I8gCQhe2M
Y+gOMrV1HtL2EayxfPee5P00+H/4RfTZ63nDEJY/SAQTRS7CA93lmYVqMAwPSm6/
mzeQmaawJJMPSK2dZFDwU9mafYaJzEiItW/eKFpUPbQSdqhCLHu41yaLGdxouvNv
ZaUOeOkI/y0w//PUWnJFlO2ddPjhC6PcdtkOstzxKzSTVu6tYrHZE0R4nBiAh4+S
SEdqbixMoAnuq9g2MfKzs1jopzMOpNjmcBpEE858EbZyOzG9b1gcHyxu21ldu2VQ
cPdurnYOp1tr986M/Y9yTc8PhxJoAg==
=sW2Y
-----END PGP SIGNATURE-----

--E39vaYmALEf/7YXx--


--===============3192297045399024513==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3192297045399024513==--

