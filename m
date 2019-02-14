Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 636C5C4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 18:01:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D7BF2089F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 18:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VI+dQ7/4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D7BF2089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kb2kh86DexqkwQSGJDvR7dEVizjPFN1wdUzJrHDGjBs=; b=VI+dQ7/4RnP+p5
	VhEQ65ikCr8odz700+h0xpBPpdJKowBUXx/1xwlM827IjGlLHeiE/SH4rTAyMfxKk+QI6fxdUir/D
	DYTgtnsAYxDan3DM/o4vty4EnDDV9lMLMIHPSH40yanXSb3xGkzMSg8VEnmRfk6pzc6NnLFnm3V9V
	hvSoz/QGQ2PfFc/enqiSIQ6953CqFB9IDYQlP09h+Se0Nh+OtwAypqO/29xX4Bt6XQBWeB4mmcHm2
	21nycY6Kjt8ab7N1heuen3eDgg9KNw7Ev77ctXhia9Q+AIjzaGZdghvcjLiU75vtQwEMJp3wNTsRh
	27emS6APplsRmHCINZow==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guLKM-0003SX-4K; Thu, 14 Feb 2019 18:01:38 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guLKD-0003Qs-Rx
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 18:01:36 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 682D8EBD;
 Thu, 14 Feb 2019 10:01:29 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 348713F589;
 Thu, 14 Feb 2019 10:01:28 -0800 (PST)
Date: Thu, 14 Feb 2019 18:01:25 +0000
From: Will Deacon <will.deacon@arm.com>
To: Qian Cai <cai@lca.pw>
Subject: Re: livelock with KASAN_SW_TAGS
Message-ID: <20190214180125.GH2475@fuggles.cambridge.arm.com>
References: <7ec14ad5-8d64-b842-a819-9d57cc8495e2@lca.pw>
 <20190214163536.GB1825@fuggles.cambridge.arm.com>
 <50ef4f07-af09-5498-2bca-26ced76d9736@lca.pw>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <50ef4f07-af09-5498-2bca-26ced76d9736@lca.pw>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_100129_914375_82D61F20 
X-CRM114-Status: GOOD (  15.05  )
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
Cc: Andrey Konovalov <andreyknvl@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 kasan-dev <kasan-dev@googlegroups.com>, aryabinin@virtuozzo.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Feb 14, 2019 at 11:50:59AM -0500, Qian Cai wrote:
> On 2/14/19 11:35 AM, Will Deacon wrote:
> > On Wed, Feb 13, 2019 at 10:32:11PM -0500, Qian Cai wrote:
> >> Running LTP msgstress03 [1] triggers endless soft lockups below after a few
> >> minutes on a ThunderX2 server. It works fine with KASAN_GENERIC and finish the
> >> test in roughly 11 minutes.
> > 
> > I've not been able to reproduce this failure under KVM, however the test
> > only takes around 18s to complete on the host and the guest, so it feels
> > like something is amiss here. Please could you share more information about
> > how you're triggering this problem? For example:
> > 
> >   - Kernel version and .config
> 
> Latest mainline at 1f947a7a01 ("Merge branch 'akpm' (patches from Andrew)") plus
> a few KASAN_SW_TAGS patches in order to boot.
> 
> https://marc.info/?l=linux-mm&m=155006632110129&w=2 (all 5)
> https://marc.info/?l=linux-mm&m=154968731424637&w=2
> https://marc.info/?l=linux-mm&m=155010395725051&w=2
> 
> https://git.sr.ht/~cai/linux-debug/tree/master/config

I struggled to get this config to boot under KVM :(

> >   - Clang version
> 
> clang-7.0.1

It would be helpful to know if the issue persists with the latest nightly
build of clang.

Anyway, please could you annotate the goto loop in free_debug_processing()
so that the object and tail pointer are printed each time around? It would
be useful to know if we're failing to exit that.

Thanks,

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
