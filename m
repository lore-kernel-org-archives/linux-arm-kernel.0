Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37DF0C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 04:17:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA4E0218D3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 04:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cKVKh06F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA4E0218D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	From:Subject:To:Message-Id:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CXXNBylGH97BFJKl5CGzh7xtUP2vS6JGcFIi6iAMMm8=; b=cKVKh06Fs23hKC
	z9193Yvy1GX8R2+K68wu8BxENMHEV+mTZa1z8vZB2G99Uf2rGRJJ+FUiyNMAxCl7W1fpev0gY9pUf
	xlpL89in4fCvhFXFk1G9Eu+VZ1HwOLNRbE2KnHZPLpH6Rq6Rq1vaiJo0RU0jv8aBVPqjVDmTVlY8u
	23UvVedp85dh2WT20R/SP758uti1yfQxaVKaopyIoBlNKUHL/6qjiPIFo0ZD9GMt/FbS0pFFIhdnF
	Bv7BSb+kHjJvArsV0cmsoK01ZxmA6xa9IDkwh38Q56SsMG6zSQ04npIo7wxAUKkUPXhrzF6tCrPbz
	DGkFvYDAEG/qO9nV/dtg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grb89-0003QC-5t; Thu, 07 Feb 2019 04:17:41 +0000
Received: from shards.monkeyblade.net ([2620:137:e000::1:9])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grb86-0003Pr-3H
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 04:17:39 +0000
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: davem-davemloft)
 by shards.monkeyblade.net (Postfix) with ESMTPSA id 1449B1411B0B5;
 Wed,  6 Feb 2019 20:17:37 -0800 (PST)
Date: Wed, 06 Feb 2019 20:17:36 -0800 (PST)
Message-Id: <20190206.201736.1146228626076916564.davem@davemloft.net>
To: yzhai003@ucr.edu
Subject: Re: [PATCH] net: stmmac: Variable "val" in function
 sun8i_dwmac_set_syscon() could be uninitialized
From: David Miller <davem@davemloft.net>
In-Reply-To: <20190205221559.17545-1-yzhai003@ucr.edu>
References: <20190205221559.17545-1-yzhai003@ucr.edu>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12
 (shards.monkeyblade.net [149.20.54.216]);
 Wed, 06 Feb 2019 20:17:37 -0800 (PST)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_201738_143102_3A1AD841 
X-CRM114-Status: UNSURE (   8.16  )
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
Cc: csong@cs.ucr.edu, alexandre.torgue@st.com, netdev@vger.kernel.org,
 zhiyunq@cs.ucr.edu, linux-kernel@vger.kernel.org, wens@csie.org,
 peppe.cavallaro@st.com, maxime.ripard@free-electrons.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Yizhuo <yzhai003@ucr.edu>
Date: Tue,  5 Feb 2019 14:15:59 -0800

> @@ -639,9 +639,14 @@ static int sun8i_dwmac_set_syscon(struct stmmac_priv *priv)
>  	struct sunxi_priv_data *gmac = priv->plat->bsp_priv;
>  	struct device_node *node = priv->device->of_node;
>  	int ret;
> -	u32 reg, val;
> +	u32 reg, val = 0;
> +
> +	ret = regmap_read(gmac->regmap, SYSCON_EMAC_REG, &val);
> +	if (ret) {
> +		dev_err(priv->device, "Fail to read SYSCON_EMAC_REG.\n");
> +		return ret;
> +	}

I agree with the other reviewer that since you check 'ret' the initialization of
'val' is no longer needed.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
