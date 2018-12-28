Return-Path: <SRS0=Tyfh=PF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BCFEC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 19:35:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 592ED20861
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 19:35:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kyDNuEZ5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xwh8is97"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 592ED20861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:In-Reply-To:From:Subject:
	References:Message-ID:To:MIME-Version:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ga0kVyVqlwBoCnt0FVIB4aRoGpdW5Ug0S3arIB6MvCo=; b=kyDNuEZ5KbBoxu
	gUl6PdFIuyzymsPu/DDhp9Y86wbdrr5oXc15pExnaIy9t82g+NZPpKKake1Uq0ogOoSbFWi1Nbo26
	KkvMRgbtu07e6CxTX0Crkpl+dLvo/CQQ/NMaKWi2sbG6wZdF1QRxtgKISlIOa31jJpIo3ro2HcCo/
	2JHsLlaGpYz+HmIDwDgZk1303gOM9JFqGpZAO89mudnjMewGvwMOKg8zfGa6ny4pj5HnBbHl2SSps
	eSITBhlkgm8q+4Z1f2MBD0ZFqkeAeK+y3evZ9ZNau6zbPnbVCM+2hx3DkKBW6PjfOwf/X9cZcHp4K
	na72VE5gzGrBzfJ87sGg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gcxul-00085W-Vv; Fri, 28 Dec 2018 19:35:23 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gcxui-00084m-7E
 for linux-arm-kernel@lists.infradead.org; Fri, 28 Dec 2018 19:35:21 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 446D220861;
 Fri, 28 Dec 2018 19:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1546025709;
 bh=fNpO/g3JeoJYQka0od3jblA+B3xDy5AR8CYpND42NeU=;
 h=To:References:Subject:Cc:From:In-Reply-To:Date:From;
 b=xwh8is974BWWa3RkABZ8HzjA3CLTVWRLt3NMO9Xn4ADJizjvqnEsnODudOE8hMW9i
 sFEvV4IJuar0Y60GExe2vnufyIdzPDUNe27edH76aNbvPii3eeAS31LsoMmf+msVWs
 RZhBsCIEnSQW7Cc/D7es7CM+5V96OdicSOFm1LYU=
MIME-Version: 1.0
To: Yangtao Li <tiny.windzz@gmail.com>, cw00.choi@samsung.com, kgene@kernel.org,
 krzk@kernel.org, mturquette@baylibre.com, s.nawrocki@samsung.com,
 tomasz.figa@gmail.com
Message-ID: <154602570854.179992.17215224103148425228@swboyd.mtv.corp.google.com>
References: <20181226133215.4939-1-tiny.windzz@gmail.com>
Subject: Re: [PATCH] clk: samsung: exynos4: fix refcount leak in
 exynos4_get_xom()
From: Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
In-Reply-To: <20181226133215.4939-1-tiny.windzz@gmail.com>
Date: Fri, 28 Dec 2018 11:35:08 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181228_113520_277917_B49622BD 
X-CRM114-Status: UNSURE (   6.49  )
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
Cc: Yangtao Li <tiny.windzz@gmail.com>, linux-samsung-soc@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Yangtao Li (2018-12-26 05:32:15)
> The of_find_compatible_node() returns a node pointer with refcount
> incremented, but there is the lack of use of the of_node_put() when
> done. Add the missing of_node_put() to release the refcount.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---

Applied to clk-next


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
