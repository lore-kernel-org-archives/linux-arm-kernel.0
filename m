Return-Path: <SRS0=wPy5=QC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CDCCC282C7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 11:14:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF6E9218A6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 11:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XsmBd8s+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF6E9218A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=katsuster.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=9oYDwqqqnbyXvvINcvlIfl3vv10jcCnOTzEEXi0egbw=; b=XsmBd8s+dsHNk5mD8gl+yh0UA
	EtQPpiRXSziaTKd8P8VEMvA0yq03PuHKsaxu8htNv/oDgVL/3rM8ftnHZ01BtEZy5LSWHrChtv361
	27X18/5OYDXhF7RgszaZ4r5RwxaTB7xzaQVxr/zh+FIlXnOfcj5AByFXczOE13qdcuOuu6LimU2Aj
	Uh1QjaPjeY0m6aU4Xn1s/3jUZ0MmziXQhfobwtnlmyTXcgshJElWt5gIEOGsmKqOLw9crqglZPXKP
	xU9rFETEJiSvFPbl8ZKfNJnES5rkrcbhJdTTEZrZTnKBbH0nj+WLsKYxE5jd+NjxWiAFZHVh1VEhC
	idgsFQNIQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gnLuW-0005ZS-H9; Sat, 26 Jan 2019 11:14:04 +0000
Received: from www1102.sakura.ne.jp ([219.94.129.142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gnLuT-0005YW-Cb
 for linux-arm-kernel@lists.infradead.org; Sat, 26 Jan 2019 11:14:03 +0000
Received: from fsav302.sakura.ne.jp (fsav302.sakura.ne.jp [153.120.85.133])
 by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x0QBDmWc001322;
 Sat, 26 Jan 2019 20:13:48 +0900 (JST)
 (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav302.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav302.sakura.ne.jp);
 Sat, 26 Jan 2019 20:13:48 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav302.sakura.ne.jp)
Received: from [192.168.1.2] (119.104.232.153.ap.dti.ne.jp [153.232.104.119])
 (authenticated bits=0)
 by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x0QBDmgY001317
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
 Sat, 26 Jan 2019 20:13:48 +0900 (JST)
 (envelope-from katsuhiro@katsuster.net)
Subject: Re: [PATCH] clk: fractional-divider: check parent rate only for
 general approximation
To: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org
References: <20190107132124.27788-1-katsuhiro@katsuster.net>
From: Katsuhiro Suzuki <katsuhiro@katsuster.net>
Message-ID: <063dea80-a13e-3af2-1008-1c0c2bbe2706@katsuster.net>
Date: Sat, 26 Jan 2019 20:13:48 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190107132124.27788-1-katsuhiro@katsuster.net>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190126_031401_656860_C5085892 
X-CRM114-Status: GOOD (  14.60  )
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
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Ping...

On 2019/01/07 22:21, Katsuhiro Suzuki wrote:
> Custom approximation of fractional-divider may not need parent clock
> rate checking. For example Rockchip SoCs work fine using grand parent
> clock rate evne if target rate is greater than parent.
> 
> This patch removes parent clock rate check from custom approximation.
> 
> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
> ---
>   drivers/clk/clk-fractional-divider.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/clk-fractional-divider.c b/drivers/clk/clk-fractional-divider.c
> index 545dceec0bbf..b0fc5509e0ff 100644
> --- a/drivers/clk/clk-fractional-divider.c
> +++ b/drivers/clk/clk-fractional-divider.c
> @@ -79,13 +79,17 @@ static long clk_fd_round_rate(struct clk_hw *hw, unsigned long rate,
>   	unsigned long m, n;
>   	u64 ret;
>   
> -	if (!rate || rate >= *parent_rate)
> +	if (!rate)
>   		return *parent_rate;
>   
> -	if (fd->approximation)
> +	if (fd->approximation) {
>   		fd->approximation(hw, rate, parent_rate, &m, &n);
> -	else
> +	} else {
> +		if (rate >= *parent_rate)
> +			return *parent_rate;
> +
>   		clk_fd_general_approximation(hw, rate, parent_rate, &m, &n);
> +	}
>   
>   	ret = (u64)*parent_rate * m;
>   	do_div(ret, n);
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
