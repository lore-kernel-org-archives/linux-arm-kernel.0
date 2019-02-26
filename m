Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF9D3C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 15:58:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A726A217F9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 15:58:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LiA0y/Wl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A726A217F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tmsCTGmTp3KUWTdLy72F72crrYEoTROcGXrhLCGEAbk=; b=LiA0y/WlSE2zl8
	y+kAXTSNqXbraWRDV4uluigAWgFOLPMzvp8CGVDfShXLeUCRt8u5OWZU68ErdYBPIuIjmk9L+/0Se
	hwZXl+TnK/SkzAaLhrKVkVheWLnjDswDv3ZYMyvvl7uRLhzxjvW1nWpEWO8X7Uj3AIYGRYihhKo8B
	ePFGrZCitXGV1inb4+WMQdzAHyiEMI1G7PVL97+EZLGgLaNotIW95wH8q42xkJ9/HZ83btXcVBQ+3
	nrnHAyNQaaFOL8/8Uj2UbEKkiEqPZrrepzrzRF9AKfvuGi5acrfefUIDkfS0s7JYqvcqnvqginpBM
	5wa1peY5qWUsBlRT+GDQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyf7f-0006h4-OB; Tue, 26 Feb 2019 15:58:23 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyf7c-0006gk-QH
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 15:58:22 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D10D80D;
 Tue, 26 Feb 2019 07:58:20 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 403073F575;
 Tue, 26 Feb 2019 07:58:18 -0800 (PST)
Date: Tue, 26 Feb 2019 15:58:15 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Julien Grall <julien.grall@arm.com>
Subject: Re: [PATCH v5 08/26] arm64/sve: Enable SVE state tracking for
 non-task contexts
Message-ID: <20190226155815.GZ3567@e103592.cambridge.arm.com>
References: <1550519559-15915-1-git-send-email-Dave.Martin@arm.com>
 <1550519559-15915-9-git-send-email-Dave.Martin@arm.com>
 <dc379691-ab3a-79a6-b760-59a02aa40717@arm.com>
 <20190226120713.GL3567@e103592.cambridge.arm.com>
 <b1d64e84-1c59-d1a6-7893-212b5cd3a7ac@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b1d64e84-1c59-d1a6-7893-212b5cd3a7ac@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_075820_854192_4997097A 
X-CRM114-Status: GOOD (  16.43  )
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
Cc: Okamoto Takayuki <tokamoto@jp.fujitsu.com>,
 Christoffer Dall <cdall@kernel.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Zhang Lei <zhang.lei@jp.fujitsu.com>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 26, 2019 at 03:49:00PM +0000, Julien Grall wrote:
> Hi Dave,
> 
> On 26/02/2019 12:07, Dave Martin wrote:
> >On Fri, Feb 22, 2019 at 03:26:51PM +0000, Julien Grall wrote:
> >>Hi Dave,
> >>
> >>On 18/02/2019 19:52, Dave Martin wrote:
> >>>The current FPSIMD/SVE context handling support for non-task (i.e.,
> >>>KVM vcpu) contexts does not take SVE into account.  This means that
> >>
> >>NIT: Double-space before "This".
> >
> >See patch 2...
> >
> >[...]
> >
> >Does the code look reasonable to you?  This interacts with FPSIMD/SVE
> >context switch in the host, so it would be good to have your view on it.
> 
> I wanted to look at the rest before giving my reviewed-by tag.
> FWIW, this patch looks reasonable to me.

OK, does that amount to a Reviewed-by, or do you have other comments?

Cheers
---Dave

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
