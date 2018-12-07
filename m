Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F913C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 11:21:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E7E920989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 11:21:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="b7UCLm91"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E7E920989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=I7hbLfBq3m0/HpistcFMW/ZAhnLxfpJEfkHEJE3ewDY=; b=b7UCLm91v9ID2/
	4fGv+XFCeZPPxqzvkbSaMm4rFwng/JTBIY2KKAmP87xHQUqcXpAIqqpOr4md3phI3+8p7PdCOh3EY
	sIyVzDzXpVDrSp2UoijZBsYPa7sG1XEhmBPpBbUksD3xYSQhMcrUdXfzwuNynz3mHo8a0NOcp2LW4
	x18ynvMtHz53KJMJrkwD4wYMdDVroUG8QXThJv0figr/3byf7uY5/kIvEbhYNwIqi/+KwPEPBDfeu
	RUT1/FX7miepouG9tillH3nnggOV3uVcjtajm6Y7Kpf/lVcX2Vkk+xBj05fCKb5xRMu+TkPtEpL1N
	Y3QZk5k6wPFg+IH7rDJQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVECA-00032u-2Q; Fri, 07 Dec 2018 11:21:22 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVEC7-00032Q-Hp
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 11:21:20 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6011FEBD;
 Fri,  7 Dec 2018 03:21:07 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.113])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 0955D3F5AF; Fri,  7 Dec 2018 03:21:05 -0800 (PST)
Date: Fri, 7 Dec 2018 11:21:03 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Steve Capper <steve.capper@arm.com>
Subject: Re: [PATCH V5 4/7] arm64: mm: Offset TTBR1 to allow 52-bit
 PTRS_PER_PGD
Message-ID: <20181207112102.GB23085@arrakis.emea.arm.com>
References: <20181206225042.11548-1-steve.capper@arm.com>
 <20181206225042.11548-5-steve.capper@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181206225042.11548-5-steve.capper@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_032119_603442_97276C64 
X-CRM114-Status: GOOD (  13.95  )
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
Cc: suzuki.poulose@arm.com, jcm@redhat.com, ard.biesheuvel@linaro.org,
 will.deacon@arm.com, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 06, 2018 at 10:50:39PM +0000, Steve Capper wrote:
> Enabling 52-bit VAs on arm64 requires that the PGD table expands from 64
> entries (for the 48-bit case) to 1024 entries. This quantity,
> PTRS_PER_PGD is used as follows to compute which PGD entry corresponds
> to a given virtual address, addr:
> 
> pgd_index(addr) -> (addr >> PGDIR_SHIFT) & (PTRS_PER_PGD - 1)
> 
> Userspace addresses are prefixed by 0's, so for a 48-bit userspace
> address, uva, the following is true:
> (uva >> PGDIR_SHIFT) & (1024 - 1) == (uva >> PGDIR_SHIFT) & (64 - 1)
> 
> In other words, a 48-bit userspace address will have the same pgd_index
> when using PTRS_PER_PGD = 64 and 1024.
> 
> Kernel addresses are prefixed by 1's so, given a 48-bit kernel address,
> kva, we have the following inequality:
> (kva >> PGDIR_SHIFT) & (1024 - 1) != (kva >> PGDIR_SHIFT) & (64 - 1)
> 
> In other words a 48-bit kernel virtual address will have a different
> pgd_index when using PTRS_PER_PGD = 64 and 1024.
> 
> If, however, we note that:
> kva = 0xFFFF << 48 + lower (where lower[63:48] == 0b)
> and, PGDIR_SHIFT = 42 (as we are dealing with 64KB PAGE_SIZE)
> 
> We can consider:
> (kva >> PGDIR_SHIFT) & (1024 - 1) - (kva >> PGDIR_SHIFT) & (64 - 1)
>  = (0xFFFF << 6) & 0x3FF - (0xFFFF << 6) & 0x3F	// "lower" cancels out
>  = 0x3C0
> 
> In other words, one can switch PTRS_PER_PGD to the 52-bit value globally
> provided that they increment ttbr1_el1 by 0x3C0 * 8 = 0x1E00 bytes when
> running with 48-bit kernel VAs (TCR_EL1.T1SZ = 16).
> 
> For kernel configuration where 52-bit userspace VAs are possible, this
> patch offsets ttbr1_el1 and sets PTRS_PER_PGD corresponding to the
> 52-bit value.
> 
> Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Steve Capper <steve.capper@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
