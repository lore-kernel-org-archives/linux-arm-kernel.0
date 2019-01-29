Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B22AC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 21:55:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBBC021473
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 21:55:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lzg7MnCh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="U9UxA0cy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBBC021473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:To:Message-ID:In-Reply-To:From:
	References:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KfiFfY1oHFs865ROvpRfKSccuQ32GF9gezOVL/hnp+4=; b=lzg7MnCh/Z/OzV
	CLb98WqZDn92L9L1FgaRpfpYOmJM6eHKqhQIIxTBgr/9PLXTuAex2iufR2fqHbl1Bq6PRiIcbWj6K
	hGLJ2ljyKuFPdM3wrWQtDamnx033rSBDS7t6XzBzZjJPtYfyerYwP5ZC4J9X6SsKow3RcxWlK7sC3
	42HlIR4XR/i5MhF2wbIrjCeOy7ya+DOMqQyeuILX2FJseQp9Ve+76poWGv+lt6M9BRFmC3zRaYNX1
	YA/H1fIf3QYe8rY3I/tJJaKF5na1IXbx7BMz3R89ZyLhuj+gOoIyy3lZNf5jxsvrsDRuctA15vjUf
	+9X2jyls1QTqYfVar5jQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gobLw-000448-D6; Tue, 29 Jan 2019 21:55:32 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gobLt-00043l-8Z
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 21:55:30 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6F66D2082F;
 Tue, 29 Jan 2019 21:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548798928;
 bh=vrxCJaOOpOwcogcgyECS3v0aknQ9iQrGQguScjUaK1M=;
 h=Subject:References:Cc:From:In-Reply-To:To:Date:From;
 b=U9UxA0cyUrMxiTYxpM3wnnFBmKrfWWxFDHwv/B3kUtMTwSm0zNfd1QcP56IT+Oj9f
 xI3WbrqQOMvOqqDu5iVfsV6GWAgT5DC3rsliyyqgBmQ0RuhknDkh5tnU3eO/Fhw2vI
 t1Kw9jsxJWpxw7811NP5A6jM2tLFkDnmsitOtbBc=
MIME-Version: 1.0
Subject: Re: [PATCH] clk: fractional-divider: check parent rate only for
 general approximation
References: <20190107132124.27788-1-katsuhiro@katsuster.net>
User-Agent: alot/0.8
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20190107132124.27788-1-katsuhiro@katsuster.net>
Message-ID: <154879892760.136743.9274469856102314518@swboyd.mtv.corp.google.com>
To: Katsuhiro Suzuki <katsuhiro@katsuster.net>,
 Michael Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org
Date: Tue, 29 Jan 2019 13:55:27 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_135529_322367_B2D95549 
X-CRM114-Status: GOOD (  12.19  )
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
Cc: Katsuhiro Suzuki <katsuhiro@katsuster.net>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Katsuhiro Suzuki (2019-01-07 05:21:24)
> Custom approximation of fractional-divider may not need parent clock
> rate checking. For example Rockchip SoCs work fine using grand parent
> clock rate evne if target rate is greater than parent.
> 
> This patch removes parent clock rate check from custom approximation.
> 
> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
> ---
>  drivers/clk/clk-fractional-divider.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/clk-fractional-divider.c b/drivers/clk/clk-fractional-divider.c
> index 545dceec0bbf..b0fc5509e0ff 100644
> --- a/drivers/clk/clk-fractional-divider.c
> +++ b/drivers/clk/clk-fractional-divider.c
> @@ -79,13 +79,17 @@ static long clk_fd_round_rate(struct clk_hw *hw, unsigned long rate,
>         unsigned long m, n;
>         u64 ret;
>  
> -       if (!rate || rate >= *parent_rate)
> +       if (!rate)

Is your fraction multiplying the rate up? If it's a divider it shouldn't
be increasing the rate more than whatever the parent is supplying so
this looks odd. How does the grandparent matter here? Maybe you can show
the example in the commit text so we can all understand what's going on
here.

>                 return *parent_rate;
>  

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
