Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D955C43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 08:13:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1825E2073D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 08:13:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IEDfpOVs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1825E2073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AJOmTSKj15PJEXDRDC52JS7IP+oV/8HGvwmLodT0NiY=; b=IEDfpOVsl19zH3
	D+/fq7Kwe+amSAHjAv8H/Cqq8X6cTHd2EunAVVRYCO7T0sqCP3atdc0e8uEAuB52DPyWrx9be4vPD
	NZF6/M2vaxZkvG5rZk0mthdv6+pNpZO6zQqmVHrE7PDSsnA0jolLlCvTOumV1RNHWLBprXso8MSUk
	6W4t/YaMsg+iOa4K6V+Ay2UDNS1x2RXEysNFtNYfe7lHSCGzqASw15Bn1UIayqMaLvziXRlYqpyJY
	Ph7xqeror1yLTjpbi68zUq/YrTGCIivfsUPwqrOliSCFd45LPh1chb+b47oLKCUH5JX6aeCvK8mfC
	v8My5qD6BgGpKc8SH1bg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gey84-0001kf-Oz; Thu, 03 Jan 2019 08:13:24 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red
 Hat Linux)) id 1gey7u-0001kH-74; Thu, 03 Jan 2019 08:13:14 +0000
Date: Thu, 3 Jan 2019 00:13:14 -0800
From: Christoph Hellwig <hch@infradead.org>
To: huhai <huhai@kylinos.cn>
Subject: Re: [PATCH] arm64/lib: add accelerated do_csum for arm64
Message-ID: <20190103081314.GA31320@infradead.org>
References: <20181228073739.13169-1-huhai@kylinos.cn>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181228073739.13169-1-huhai@kylinos.cn>
User-Agent: Mutt/1.9.2 (2017-12-15)
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
Cc: catalin.marinas@arm.com, liuyun01@kylinos.cn, will.deacon@arm.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

> diff --git a/arch/arm64/lib/checksum.c b/arch/arm64/lib/checksum.c
> new file mode 100644
> index 000000000000..6931ef13ef87
> --- /dev/null
> +++ b/arch/arm64/lib/checksum.c
> @@ -0,0 +1,144 @@
> +/*
> + * arch/arm64/lib/checksum.c
> + *

No need to mention the file name.  On the other hand it really should
have a SPDX tag, and preferably a copyright notice.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
