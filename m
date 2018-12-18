Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 164A5C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 10:58:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7BCC217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 10:58:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FOZnidzs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7BCC217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3NtVwBsNZ8Pk1/o7SbCYKRo4xYaEp3HeOTCSXwIVUPs=; b=FOZnidzsJO7/Fr
	qyhImiFHfuOybeFBX3FbtUceBYkOZLYNFTwCoZ1Vo1MXRQOXvH/CXUAj2i8/hw60Du+UF2MPkRTKy
	m+8RuT4VDr0bhnp0+1V5r4NPzHGZ8TsqN79GZaKa0JWF0kQXl6kl7Xvi8SrhSLLe/z1uZobCfXfHD
	X+glIVkFKeC201xOMDySM5C7MMACGwofJNnaaC8NcHVxFVxRss7W9sc+U8UnS1YMJMm/w+y8juBWW
	zckNezjYdXn6sKX10kZleQ7d7+fDyyHg0v5i9HZXwA2abY++Up+5JBj9a6rUTvrGeIxd8u9l/kb0i
	9KhRMJOGWVCCMTpaWJ+w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZD4f-0000iv-1s; Tue, 18 Dec 2018 10:58:05 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZD4c-0000hv-66
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 10:58:03 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 426C4A78;
 Tue, 18 Dec 2018 02:57:49 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com
 [10.1.197.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BA19E3F5C0;
 Tue, 18 Dec 2018 02:57:47 -0800 (PST)
Date: Tue, 18 Dec 2018 10:57:42 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] PCI: imx: Fix an IS_ERR() vs NULL bug
Message-ID: <20181218105742.GA22156@e107981-ln.cambridge.arm.com>
References: <20181218082329.GB440@kadam>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181218082329.GB440@kadam>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_025802_233050_C19838F7 
X-CRM114-Status: GOOD (  17.67  )
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
Cc: Richard Zhu <hongxing.zhu@nxp.com>, linux-pci@vger.kernel.org,
 kernel-janitors@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 Leonard Crestez <leonard.crestez@nxp.com>,
 linux-arm-kernel@lists.infradead.org, Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 18, 2018 at 11:23:29AM +0300, Dan Carpenter wrote:
> The device_link_add() function doesn't return error pointers, it returns
> NULL if there is an error.
> 
> Fixes: 7a6991159bcd ("PCI: imx: Add multi-pd support")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Thanks Dan, if you do not mind I will squash this in the initial
commit given that it is not upstream yet.

Lorenzo

> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index b54b4590ccf9..8e7956224a5f 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -326,9 +326,9 @@ static int imx6_pcie_attach_pd(struct device *dev)
>  			DL_FLAG_STATELESS |
>  			DL_FLAG_PM_RUNTIME |
>  			DL_FLAG_RPM_ACTIVE);
> -	if (IS_ERR(link)) {
> -		dev_err(dev, "Failed to add device_link to pcie pd: %ld\n", PTR_ERR(link));
> -		return PTR_ERR(link);
> +	if (!link) {
> +		dev_err(dev, "Failed to add device_link to pcie pd.\n");
> +		return -EINVAL;
>  	}
>  
>  	imx6_pcie->pd_pcie_phy = dev_pm_domain_attach_by_name(dev, "pcie_phy");
> -- 
> 2.17.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
