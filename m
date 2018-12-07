Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC02C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 15:53:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD93620837
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 15:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FOphGoNs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD93620837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3gw2wla2xFkZK/p9MGqVUjB73idLYD+9Vzh4V21eg9c=; b=FOphGoNs1CvR4b
	sECPtOLjTitTXd9sakTM029v52FytLHqDTmbhRPSw3CxFXfqI1DAYaurT2Ol1IHIPvwx59+TX2NH6
	yq/G3fxgBdV5vM35+RarKlgzjFuczU0fnITA7ZjaCXhzLJoWDG8UDxY599Mtb4p+hlgeiwWrXbCI8
	38sVRJ5Nkvpdd7BjtCG4RMphnEy0PguJ/wnO/pF07GqtVabdSAuRViwteE/p7NK+MiIcZF9El8AL+
	hiKkykcAiV1lREtR+RXLs6FN6VDD3cdbYNkiBMXLIsC8iFEf46xv3qWVjPIPUPxAZUynuelWkEXYT
	FW7dWzy+R3d2KfR/dA7w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVIRE-0000Td-NJ; Fri, 07 Dec 2018 15:53:12 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVIRB-0000Sz-9p
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 15:53:10 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A8C715AB;
 Fri,  7 Dec 2018 07:52:57 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.113])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 7AFA73F575; Fri,  7 Dec 2018 07:52:56 -0800 (PST)
Date: Fri, 7 Dec 2018 15:52:53 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] arm64: hibernate: Avoid sending cross-calling with
 interrupts disabled
Message-ID: <20181207155253.GC11961@arrakis.emea.arm.com>
References: <1544186830-27934-1-git-send-email-will.deacon@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1544186830-27934-1-git-send-email-will.deacon@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_075309_347096_4CD4BFF6 
X-CRM114-Status: GOOD (  13.00  )
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
Cc: linux-arm-kernel@lists.infradead.org, james.morse@arm.com,
 hayashi.kunihiko@socionext.com, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 07, 2018 at 12:47:10PM +0000, Will Deacon wrote:
> Since commit 3b8c9f1cdfc50 ("arm64: IPI each CPU after invalidating the
> I-cache for kernel mappings"), a call to flush_icache_range() will use
> an IPI to cross-call other online CPUs so that any stale instructions
> are flushed from their pipelines. This triggers a WARN during the
> hibernation resume path, where flush_icache_range() is called with
> interrupts disabled and is therefore prone to deadlock:
> 
>   | Disabling non-boot CPUs ...
>   | CPU1: shutdown
>   | psci: CPU1 killed.
>   | CPU2: shutdown
>   | psci: CPU2 killed.
>   | CPU3: shutdown
>   | psci: CPU3 killed.
>   | WARNING: CPU: 0 PID: 1 at ../kernel/smp.c:416 smp_call_function_many+0xd4/0x350
>   | Modules linked in:
>   | CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.20.0-rc4 #1
> 
> Since all secondary CPUs have been taken offline prior to invalidating
> the I-cache, there's actually no need for an IPI and we can simply call
> __flush_icache_range() instead.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: 3b8c9f1cdfc50 ("arm64: IPI each CPU after invalidating the I-cache for kernel mappings")
> Reported-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> Tested-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> Tested-by: James Morse <james.morse@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Queued for 4.20. Thanks.

-- 
Catalin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
