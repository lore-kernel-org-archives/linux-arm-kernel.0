Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73186C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 08:13:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FBE020823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 08:13:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NrSJjmI8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VTvOlSzq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FBE020823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:To:In-Reply-To:From:References:
	Message-ID:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iP8CS6/yKWiSmTVowdAbiKX+3vy+FfZKAXxS2TMHjsc=; b=NrSJjmI8m7UchS
	v1JzKuBu4BYQGeQImMCrHRqx7kPdD/KNlrH915d3lV/7tsFzj1VZIfivqVE54a9yg2NrvhETVd5YR
	0RXfaYFMMn09jRdKv2kA/oJ59GX6xPP4ygt9jiZb/AzS6PwIokWfe9FoBuj8NusPMNHlKbZC2PrgK
	UKgnL5GFBIFvudFX7dNdOtg0tsdRAW4MZfdrl0+6JY/c9O2QyLCHDfHqvS5LZyvQgJRMg7etQPESZ
	9pOEYfnmSoWWgXfuve8uCQ4/rMGqWnbBv8wo1afezEVNVuWLfUXjvHZExVEMtWREqOmr3PUBA0r7Y
	uvsTuIx3WHp3p/sgVwZg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gx5xR-0006aU-On; Fri, 22 Feb 2019 08:13:21 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gx5xP-0006aC-Lr
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 08:13:20 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2478120823;
 Fri, 22 Feb 2019 08:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550823199;
 bh=ljvD/aGj+6Hipv0rUE56d5fYerjq/aYHjKYQ9G5T5gA=;
 h=Subject:References:From:In-Reply-To:To:Cc:Date:From;
 b=VTvOlSzqBB5QzLrdkk1Uc5Z8hrhsfHRq3W+a+QyxZFSZX/pM1tnFccoornqJk2S7S
 HtiKbukXqD2Jc42uRtF/un1afpACYWQbk4reVruBhvyYB/7PvGaPw2qTwCntsaQUBe
 jz7sTc/80zB3f0Z+81nA9nn2w2CohYTyRPlR+UIk=
MIME-Version: 1.0
Subject: Re: [PATCH v2] clk: fractional-divider: check parent rate only if
 flag is set
Message-ID: <155082319829.77512.7935951458664373330@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
References: <20190210153806.24201-1-katsuhiro@katsuster.net>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20190210153806.24201-1-katsuhiro@katsuster.net>
To: Katsuhiro Suzuki <katsuhiro@katsuster.net>,
 Michael Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org
Date: Fri, 22 Feb 2019 00:13:18 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_001319_731590_5BD4066A 
X-CRM114-Status: UNSURE (   9.48  )
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
Cc: Katsuhiro Suzuki <katsuhiro@katsuster.net>,
 Heiko Stuebner <heiko@sntech.de>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Katsuhiro Suzuki (2019-02-10 07:38:06)
> Custom approximation of fractional-divider may not need parent clock
> rate checking. For example Rockchip SoCs work fine using grand parent
> clock rate even if target rate is greater than parent.
> 
> This patch checks parent clock rate only if CLK_SET_RATE_PARENT flag
> is set.
> 
> For detailed example, clock tree of Rockchip I2S audio hardware.
>   - Clock rate of CPLL is 1.2GHz, GPLL is 491.52MHz.
>   - i2s1_div is integer divider can divide N (N is 1~128).
>     Input clock is CPLL or GPLL. Initial divider value is N = 1.
>     Ex) PLL = CPLL, N = 10, i2s1_div output rate is
>       CPLL / 10 = 1.2GHz / 10 = 120MHz
>   - i2s1_frac is fractional divider can divide input to x/y, x and
>     y are 16bit integer.
> 
> CPLL --> | selector | ---> i2s1_div -+--> | selector | --> I2S1 MCLK

Applied to clk-next but I made the function into a macro because I don't
see the benefit to exporting such a simple thing.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
