Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D692C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 17:05:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A5D7206BB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 17:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="i9H5fDy+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A5D7206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HN2zzT2wF1iNW05EFJs4kYrz/JijxaTBZMfsoBefW9U=; b=i9H5fDy+AShElJ
	DmtRbqp+zBIw4rfnF66uH9EaaPCsYkdUpIvHIQq79TqKz9i67m6BKjM3DO7KmuC9Tlegn11nqq1Km
	Zd194wxPXLSjWkv6Ro1xP0z4AKg0vu9cHDK+teBxBQ2hAm5wR2vdnrFH+EmAHCB0QGrCSI3IYPbK2
	g50eJSIiz5Ot/Emi9nWw3GTwJ+3orGXPSuiE4/KX6K7vEtwypbAgb8rarWA3KAm4/j9IKpsXvQFLj
	O49msiWNBawQfPv345v8F1nZ968toCxxcv0pvTcOIfutiQEdQC5DhcRRkTR9meEgkgKo6cmsQ7sN2
	m1bU8GMxUt8+TbY8i6Ng==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw8pe-000414-PT; Tue, 19 Feb 2019 17:05:22 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw8pb-00040h-U7
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 17:05:21 +0000
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id 8FD1680B6;
 Tue, 19 Feb 2019 17:05:29 +0000 (UTC)
Date: Tue, 19 Feb 2019 09:05:16 -0800
From: Tony Lindgren <tony@atomide.com>
To: Peng Hao <peng.hao2@zte.com.cn>
Subject: Re: [PATCH]  arm/mach-omap2/display: fix possible object reference
 leak
Message-ID: <20190219170516.GL15711@atomide.com>
References: <1550071969-86286-1-git-send-email-peng.hao2@zte.com.cn>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1550071969-86286-1-git-send-email-peng.hao2@zte.com.cn>
User-Agent: Mutt/1.11.2 (2019-01-07)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_090520_020969_2C51F64F 
X-CRM114-Status: GOOD (  14.27  )
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
Cc: devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
 linux-kernel@vger.kernel.org, Julia Lawall <Julia.Lawall@lip6.fr>,
 Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

Adding devicetree list, Julia, Rob and Tomi to Cc.

* Peng Hao <peng.hao2@zte.com.cn> [190212 23:11]:
> of_find_device_by_node() takes a reference to the struct device
> when it finds a match via get_device.When returning error we should
> call put_device.
> 
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> ---
>  arch/arm/mach-omap2/display.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
> index f86b72d..c6aa9ed 100644
> --- a/arch/arm/mach-omap2/display.c
> +++ b/arch/arm/mach-omap2/display.c
> @@ -258,6 +258,7 @@ static int __init omapdss_init_of(void)
>  	r = of_platform_populate(node, NULL, NULL, &pdev->dev);
>  	if (r) {
>  		pr_err("Unable to populate DSS submodule devices\n");
> +		put_device(&pdev->dev);
>  		return r;
>  	}

In general, if the device tree node is never used afterwards,
should this be just:

	r = of_platform_populate(node, NULL, NULL, &pdev->dev);
	of_node_put(dev_node);
	if (r) {
		...
	}

If so, Julia might have a Coccinelle recpipe for it?

Regards,

Tony

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
