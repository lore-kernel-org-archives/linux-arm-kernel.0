Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F44C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:40:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3E8020823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bUYoII+I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3E8020823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XDI+Y5HotGMaOs/HtJu7GETwK3if690s02n0xB1KiL8=; b=bUYoII+IXsWz7y
	sWnNc/Zi4xrxWsVWLommpyvWMjGshP21UmkPwF5tcDtn/crJNRCx2iArZ5Yusim3XBkREr+DeY57h
	KUhvWot/gSX6NFNQT/5nCb+KvZfAb+Fn4C/yyXCIWkbtXQH4shBHLoLOEjMATPjwyi5P5FCPvq+od
	icXgL/7pmV8qvFCW93pHLcnPFYEJEM4PVzrXT0UqCCh8GjTnQY9CvhQSZ1lV+Pv1Zuic2YhXmyY8K
	r+q1Il7m84yA+700k2YQ77ZpSjDzNi2sawUTxJTLYGsHFVM2TJMs8ykP6leToe1bxJ378nkfmamTj
	FcSOE0H4ekhFX/Q/1oAQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs9CX-0000DU-91; Fri, 08 Feb 2019 16:40:29 +0000
Received: from 8bytes.org ([2a01:238:4383:600:38bc:a715:4b6d:a889]
 helo=theia.8bytes.org)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs9CT-0000BS-M2
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 16:40:27 +0000
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id B359316F; Fri,  8 Feb 2019 17:40:19 +0100 (CET)
Date: Fri, 8 Feb 2019 17:40:19 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH/RFC] driver core: Postpone DMA tear-down until after
 devres release
Message-ID: <20190208164019.GY32526@8bytes.org>
References: <20190207193653.18221-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190207193653.18221-1-geert+renesas@glider.be>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_084026_069242_16ACACEA 
X-CRM114-Status: GOOD (  10.61  )
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
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, iommu@lists.linux-foundation.org,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
 linux-arm-kernel@lists.infradead.org,
 Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Geert,

On Thu, Feb 07, 2019 at 08:36:53PM +0100, Geert Uytterhoeven wrote:
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 8ac10af17c0043a3..d62487d024559620 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -968,9 +968,9 @@ static void __device_release_driver(struct device *dev, struct device *parent)
>  			drv->remove(dev);
>  
>  		device_links_driver_cleanup(dev);
> -		arch_teardown_dma_ops(dev);
>  
>  		devres_release_all(dev);
> +		arch_teardown_dma_ops(dev);
>  		dev->driver = NULL;
>  		dev_set_drvdata(dev, NULL);
>  		if (dev->pm_domain && dev->pm_domain->dismiss)

Thanks for the fix! Should it also be tagged for stable and get a Fixes
tag? I know it only triggers with a fix in v5.0-rc, but still...

Regards,

	Joerg


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
