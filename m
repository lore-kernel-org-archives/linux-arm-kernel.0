Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C092C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 16:37:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BE282184C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 16:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EdJVUdDo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BE282184C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gYyFAejaM3jX7AhPgZYrYQzB9EZsvkZKoo0QsxfxNBI=; b=EdJVUdDoHDGPXA
	lFVxSxJZP15/i42etPGNe7dlST2l+1Mic29gGOOay90aWW8V7Erf7zY5Jq8fJVYsU68csnThXXTSg
	yTvD/1P95QAEAhtOlKCmtAQmXt/R4F0GKeeHJHdWfodF92pUnQeU82LlHLt/QDhpD9J2SvIF9nosA
	PXKvHrS/rJHsqNnykPd3zIyaCedtwA+Q6WoRWvfo2wFfYtfWKqokb3ysKqQqHU1G2liHf3s1K5w4y
	/g2+fJFer/1ThXdGjvHkzPu+tb6ZnbrVZu6R3ilwICWwJ8mK7rghTxiHiT/jpakcW59y1S8N8NeqR
	W1ROqSxRhfv9+R4Vpvmw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmi0l-00012w-9B; Thu, 24 Jan 2019 16:37:51 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmi0i-00012K-DW
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 16:37:49 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 33054A78;
 Thu, 24 Jan 2019 08:37:48 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.113])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 898543F237; Thu, 24 Jan 2019 08:37:46 -0800 (PST)
Date: Thu, 24 Jan 2019 16:37:44 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Shijith Thotton <sthotton@marvell.com>
Subject: Re: [Qestion] Softlockup when send IPI to other CPUs
Message-ID: <20190124163743.GK253679@arrakis.emea.arm.com>
References: <95C141B25E7AB14BA042DCCC556C0E6501620A47@dggeml529-mbx.china.huawei.com>
 <20190119235825.GG26876@brain-police>
 <20190121142127.GD29504@arrakis.emea.arm.com>
 <20190122054400.GB6445@brain-police>
 <20190123181530.GA234790@arrakis.emea.arm.com>
 <DM6PR18MB24607427B3B2BEAD80A75780D99A0@DM6PR18MB2460.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <DM6PR18MB24607427B3B2BEAD80A75780D99A0@DM6PR18MB2460.namprd18.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_083748_462769_194CDF63 
X-CRM114-Status: GOOD (  14.57  )
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
Cc: "Wangkefeng \(Kevin\)" <wangkefeng.wang@huawei.com>,
 Ganapatrao Kulkarni <gkulkarni@marvell.com>,
 "anshuman.khandual@arm.com" <anshuman.khandual@arm.com>,
 Will Deacon <will.deacon@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Jayachandran Chandrasekharan Nair <jnair@marvell.com>,
 chenwandun <chenwandun@huawei.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi  Shijith,

On Thu, Jan 24, 2019 at 07:00:42AM +0000, Shijith Thotton wrote:
> On 01/23/2019 11:45 PM, Catalin Marinas wrote:
> > diff --git a/arch/arm64/mm/flush.c b/arch/arm64/mm/flush.c
> > index 30695a868107..5c9073bace83 100644
> > --- a/arch/arm64/mm/flush.c
> > +++ b/arch/arm64/mm/flush.c
> > @@ -33,7 +33,11 @@ void sync_icache_aliases(void *kaddr, unsigned long len)
> >   		__clean_dcache_area_pou(kaddr, len);
> >   		__flush_icache_all();
> >   	} else {
> > -		flush_icache_range(addr, addr + len);
> > +		/*
> > +		 * Don't issue kick_all_cpus_sync() after I-cache invalidation
> > +		 * for user mappings.
> > +		 */
> > +		__flush_icache_range(addr, addr + len);
> >   	}
> >   }
> 
> We also faced similar issue with LTP test migrate_pages03 in past and this patch 
> fixes the issue.
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2019-January/623574.html

Thanks for confirming. I presume I can add your tested-by.

-- 
Catalin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
