Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA55C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 06:13:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7944A20844
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 06:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PPt0T0K0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7944A20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	From:Subject:To:Message-Id:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BdPUJoNOMjJWaZPiiprhHrUZU9oz7rY/0dzYQxyBsH4=; b=PPt0T0K0GWLlI8
	AoXfNwrkE26UzopnOr1m1H9qPEgBPe40kFo+RVY26ZC9LtGa8JxEzrmzvGJ5KY4i2r4bmPh3l++K6
	MRGnlp9ulmxZ6/pPNmek4GjqW1ZrSIt/V53M0yzp09MEr1+vgGYmIvKd9AHvaltCF3lFomqiEi0Bn
	IseFzsDe/eJzCPqbqxXHhAgFgDu4YA3oqH/OO6pbwxnWwjDvf9TcUiatkmp68lZEzQM2FLVcw824M
	HR5D/UB8LGQ88EfBzhALcYedTl5CCEbAfZRgdeeE465axwBRoFY0dWVOaJlzdkgsi/QbccvOea+pS
	l+jvOmtXoVfA8OVf2CdA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmukV-0004hJ-GX; Fri, 25 Jan 2019 06:13:55 +0000
Received: from shards.monkeyblade.net ([2620:137:e000::1:9])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmukR-0004gp-9S
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 06:13:52 +0000
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: davem-davemloft)
 by shards.monkeyblade.net (Postfix) with ESMTPSA id 415F014398926;
 Thu, 24 Jan 2019 22:13:48 -0800 (PST)
Date: Thu, 24 Jan 2019 22:13:47 -0800 (PST)
Message-Id: <20190124.221347.1855347214634112498.davem@davemloft.net>
To: weiyongjun1@huawei.com
Subject: Re: [PATCH net-next] net: stmmac: Fix return value check in
 qcom_ethqos_probe()
From: David Miller <davem@davemloft.net>
In-Reply-To: <1548224358-83281-1-git-send-email-weiyongjun1@huawei.com>
References: <1548224358-83281-1-git-send-email-weiyongjun1@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12
 (shards.monkeyblade.net [149.20.54.216]);
 Thu, 24 Jan 2019 22:13:48 -0800 (PST)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_221351_334109_4052CE93 
X-CRM114-Status: UNSURE (   6.38  )
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
Cc: alexandre.torgue@st.com, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org, vkoul@kernel.org, joabreu@synopsys.com,
 mcoquelin.stm32@gmail.com, niklas.cassel@linaro.org, peppe.cavallaro@st.com,
 linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Wei Yongjun <weiyongjun1@huawei.com>
Date: Wed, 23 Jan 2019 06:19:18 +0000

> In case of error, the function devm_clk_get() returns ERR_PTR() and
> never returns NULL. The NULL test in the return value check should be
> replaced with IS_ERR().
> 
> Fixes: a7c30e62d4b8 ("net: stmmac: Add driver for Qualcomm ethqos")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Applied, thanks.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
