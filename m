Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFDD6C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 19:40:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC25F2080D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 19:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TBIw4v/N";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dCbjH+X+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC25F2080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:From:References:Message-ID:Subject
	:In-Reply-To:To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qZd5EsBIUz2GYECIot67swVGCykvmZJoY2uf+TlZ0Tc=; b=TBIw4v/NJ1QWky
	D4fjfgOkHMRgWKSbYMdYv5QwVkl137AIszxtDKaoZTzGcsl/dOfZQ0/b9vnpVQ/DfrWvHnFSU2Yqk
	eJrufZezgDNvk7JT3RhlYJmpzxQsTDSgyzJo/gXHirkpnP4eGd4NuveVI5X66VlAaHZO23Kumuwtz
	jTJrrJaFrgMOGFPozFyfxUHDKN8ejQtqOGp7usWhQAEjmQN1qcsRoW2CSrFpXWXLedlBrIIvJyoCG
	6NZq67i2eVgA5UWQTsDEjGIWomNxAZGewvzk9kYEyjGxCVeJ78q1kPkyVKP57Pv3JBHzMSHTFtreh
	0lUnvU/2sNELPInKxgxw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grT3N-0002lx-VD; Wed, 06 Feb 2019 19:40:13 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grT3K-0002lG-92
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 19:40:11 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 965A12080D;
 Wed,  6 Feb 2019 19:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549482009;
 bh=XopYzYf3s1Zy0ZBiBCEL0/QigrtYkhisrvuFBbSdzG8=;
 h=To:In-Reply-To:Subject:References:Cc:From:Date:From;
 b=dCbjH+X+tGQ8v/v5Vcgm8mY8bOmgVDL83jTqX6b0vApkIwUmi+LkQ9ScYqJZFaP0z
 MM1ffw5o+eLE3kyLzX3SLEi2xTDijbTCIsdDdhleP1o8/3NstQs124xaop7uyZRUTz
 nflV+3jtIkgSkqkFIHJ6ACkEKD7A6IbldTcLc4tg=
MIME-Version: 1.0
To: Katsuhiro Suzuki <katsuhiro@katsuster.net>,
 Michael Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org
In-Reply-To: <20190130235022.21949-1-katsuhiro@katsuster.net>
User-Agent: alot/0.8
Subject: Re: [PATCH] clk: fractional-divider: check parent rate only for
 general approximation
Message-ID: <154948200879.115909.2117234752247335645@swboyd.mtv.corp.google.com>
References: <20190130235022.21949-1-katsuhiro@katsuster.net>
From: Stephen Boyd <sboyd@kernel.org>
Date: Wed, 06 Feb 2019 11:40:08 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_114010_353873_BBA3F702 
X-CRM114-Status: GOOD (  19.06  )
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
 linux-arm-kernel@lists.infradead.org, Heiko Stuebner <heiko@sntech.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

+Heiko because it mentions Rockchip

Quoting Katsuhiro Suzuki (2019-01-30 15:50:22)
> Custom approximation of fractional-divider may not need parent clock
> rate checking. For example Rockchip SoCs work fine using grand parent
> clock rate even if target rate is greater than parent.
> 
> This patch removes parent clock rate check from custom approximation.
> 
> For detailied example, clock tree of Rockchip I2S audio hardware.

s/detailied/detailed/

>   - A i2s1_div is integer divider can divide input clock 1/1 ~ 1/16.
>     Initialize divider value is 1.

s/Initialize/Initial/

>   - A i2s1_frac is fractional divider can divide input to x/y, x and
>     y are 16bit integer.
>   - Clock rate of CPLL is 1.2GHz, GPLL is 491.52MHz.
> 
> CPLL --> | selector | ---> i2s1_div -+--> | selector | --> I2S1 MCLK
> GPLL --> |          | ,--------------'    |          |
>                       `--> i2s1_frac ---> |          |
> 
> Clock mux system try to choose suitable one from i2s1_div and
> i2s1_frac for master clock (MCLK) of I2S1.
> 
> Bad scenario as follows:
>   - Try to set MCLK to 8.192MHz (32kHz audio replay)
>     Candidate setting is
>     - i2s1_div : GPLL / 60           = 8.192MHz
>     i2s1_div is same as target clock rate, so mux choose this.
>     i2s1_div output rate is changed 491.52MHz -> 8.192MHz
> 
>   - After that try to set to 11.2896MHz (44.1kHz audio replay)
>     Candidate settings are
>     - i2s1_div : CPLL / 107 = 11.214945MHz
>     - i2s1_frac: i2s1_div   = 8.192MHz
>       This is because clk_fd_round_rate() thinks target rate
>       (11.2896MHz) is higher than parent rate (i2s1_div = 8.192MHz)
>       and returns parent clock rate.
>     Clock mux system choose i2s1_div, but this clock rate is not
>     acceptable for I2S driver, so users cannot replay audio.
> 
> Expected behavior is:
>   - Try to set master clock to 11.2896MHz (44.1kHz audio replay)
>     Candidate settings are
>     - i2s1_div : CPLL / 107          = 11.214945MHz
>     - i2s1_frac: i2s1_div * 147/6400 = 11.2896MHz
>                  (change i2s1_div to GPLL / 1 = 491.52MHz)
>       If apply this commit, clk_fd_round_rate() calls custom
>       approximate function of Rockchip even if target rate is higher
>       than parent. Custom function changes both grand parent
>       (i2s1_div) and parent (i2s_frac) settings at same time.

Can you indicate what that function is? Is this merged upstream or
something you're developing now?

>     Clock mux system can choose i2s1_frac and audio works fine.

I think this last paragraph from "If apply this commit" can be
unindented from the expected behavior section.

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
>                 return *parent_rate;

Ok. I think it would be clearer if we had

	unsigned long flags = clk_hw_get_flags()

	if (!rate ||
	    !(flags & CLK_SET_PARENT_RATE) && rate >= *parent_rate)

indicating that the parent of the clk isn't expected to change rate so
we can only achieve that much frequency. Plus some sort of comment to
this effect would be helpful too.

We could also introduce macros to check clk flags. Then it would read
nicer:

	if (!rate || clk_hw_can_set_parent_rate(hw) && rate >= ...)


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
