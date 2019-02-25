Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D1B3C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:50:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A78820663
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YNl07Yj0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A78820663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WCGb4uRA3NL6N0bPotC8VhXrapZr5A4zbZuFQuhxIXc=; b=YNl07Yj0T1Cf8o
	IpIB+cnVi7puHWEfOkuDdZNiaqCuooc7LMIbSciX0Y3+EjkT/CKTVDuXeRkU68NMLaWoNrv5OunXg
	RR8olLIRqfVcgOOvtZokbe9ejFgRIfA190L9WhO9+J2DF52u9Z0kNdo0iJdVtxpi6CUFug+JmJtTH
	JEaqoPhb9fx/Nfn635bp0OjxSYEJjfNIvSY7f/9Rk7YtaGUv3yAO8333fiwP0MrvQ1Gkv4FWcA0JJ
	dJKPWY+BG3HTpnJioEWB1UXjBOsJSePLi8xGQlAbWiJs9JXLJU5Sh8+38hi+UrzEWRUANjPlYi0Rj
	8qeJ5cXOwwPtnJ+2L88w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyHZp-0002qL-A4; Mon, 25 Feb 2019 14:49:53 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyHZm-0002q0-44
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 14:49:51 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B843380D;
 Mon, 25 Feb 2019 06:49:49 -0800 (PST)
Received: from [10.163.1.20] (unknown [10.163.1.20])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 590FC3F575;
 Mon, 25 Feb 2019 06:49:47 -0800 (PST)
Subject: Re: [PATCH V2 5/6] arm64/mm: Enable page table page accounting for
 user space
To: Mark Rutland <mark.rutland@arm.com>
References: <1551071039-20192-1-git-send-email-anshuman.khandual@arm.com>
 <1551071039-20192-6-git-send-email-anshuman.khandual@arm.com>
 <20190225111108.GD26236@lakrids.cambridge.arm.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <d6c62e0d-f890-a60d-517c-c0ba1e56e48c@arm.com>
Date: Mon, 25 Feb 2019 20:19:53 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190225111108.GD26236@lakrids.cambridge.arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_064950_163250_D5493D79 
X-CRM114-Status: GOOD (  13.49  )
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
Cc: yuzhao@google.com, Steve.Capper@arm.com, marc.zyngier@arm.com,
 Catalin.Marinas@arm.com, suzuki.poulose@arm.com, will.deacon@arm.com,
 james.morse@arm.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 02/25/2019 04:41 PM, Mark Rutland wrote:
> On Mon, Feb 25, 2019 at 10:33:58AM +0530, Anshuman Khandual wrote:
>> Page table pages created for user space processes must be accounted against
>> their memory control groups if initialized. This just introduces a helper
>> function pgtable_gfp_flags() which returns PGALLOC_GFP for all kernel page
>> table page allocations but adds __GFP_ACCOUNT for user page table pages.
> 
> Can't we have pte_alloc_one_kernel() and pte_alloc_one() explicitly pass
> the GFP flags down to a __pte_alloc_one() helper, and consistently use
> pte_alloc_one_kernel() for kernel mappings?
> 
> That would seem less surprising than hiding that detail in another
> function.

Yes that will work as well. But its better to have this mm_struct based GFP switch
which is used in other archs as well to create generic MM helper functions going
forward.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
