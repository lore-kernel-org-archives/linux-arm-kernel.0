Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D092C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:04:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F023B2082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DUU9oP92"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F023B2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Zo1dxbNU6u4GlLht5lb/pCXp+m2vsED3XML9ADI8nUo=; b=DUU9oP92zkjCby
	nRJjXjiu/biKRL3BzR+dMsk+Mwzlq0GhGc3qY91maVvvWomYjuYPPvJZKwhDt9lqGCXei2uwDdomX
	C1DfGVt5dAlz04PQFG2JL0PirAesTLqfZPtZDFtVlemk56iIf2hPzYU48MsVackASlnItkmctG0HM
	sXZO5mFe5J9u8fEDS9L64PBqfyhP8R4ey0O+R9pN/cG+qNwZ8Arqh/G+lcvKlhCdnbdw6EnoSSK39
	4jAaDsYSiamdHU1PAJ1dWA6ZTIwzwseg+CL15IK1fWp0GIjyAk4c/KH3H8IYhcAS/D/uHhr1tm8/H
	QuyKcNNfxpSa1MXBtiaw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWjaN-00046m-Dp; Tue, 11 Dec 2018 15:04:35 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWjaD-00045Y-Ty
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 15:04:32 +0000
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id 8F57F8027;
 Tue, 11 Dec 2018 15:04:18 +0000 (UTC)
Date: Tue, 11 Dec 2018 07:04:12 -0800
From: Tony Lindgren <tony@atomide.com>
To: Russell King <rmk+kernel@armlinux.org.uk>
Subject: Re: [PATCH] mmc: omap_hsmmc: fix DMA API warning
Message-ID: <20181211150412.GP6707@atomide.com>
References: <E1gWjE3-0006mG-2S@rmk-PC.armlinux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <E1gWjE3-0006mG-2S@rmk-PC.armlinux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_070425_999456_BF7E145C 
X-CRM114-Status: UNSURE (   9.79  )
X-CRM114-Notice: Please train this message.
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
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, linux-omap@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

* Russell King <rmk+kernel@armlinux.org.uk> [181211 14:41]:
> @@ -1939,6 +1938,17 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
>  		goto err_irq;
>  	}
>  
> +	/*
> +	 * Limit the maximum segment size to the lower of the request size
> +	 * and the DMA engine device segment size limits.  In reality, with
> +	 * 32-bit transfers, the DMA engine can do longer segments than this
> +	 * but there is no way to represent that in the DMA model - if we
> +	 * increase this figure here, we get warnings from the DMA API debug.
> +	 */
> +	mmc->max_seg_size = min(mmc->max_req_size,
> +				min(dma_get_max_seg_size(host->rx_chan->device->dev),
> +				    dma_get_max_seg_size(host->tx_chan->device->dev)));
> +

Looks like using min3() here would be handy?

Regards,

Tony

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
