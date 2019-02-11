Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC3FC282CE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:59:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 763BC218D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DprAnVfy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 763BC218D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OFSoFRj5VhKqV/NFGPw09ya7vTv6imIJhKLVn6N7LM8=; b=DprAnVfyiSUAAi
	kjxkbq1Gjjks5ZMnHEECWeLrCVXcpVv3QbntRBhX9N1VJ8YyOwkX+Z856qcSrw7PGYW8sRv7Ei/s9
	BdIhpDyxtMc1yUFzfLxlTdLdnuPwLkl5somH0/AnA1lFHk3kaVGGrSkFpl8eTG1e/EPd0+rnx2cQs
	EQ6CcwBk72IvSKQc5D7UTDOzyYSreFpNe9WOOdprPjuFpCnr76ecpSOu0TnDS7ttRK3Hdn9unq8wE
	2L1bIh/KhS0cz4xP1Jg8NDRtIWJUOoivT3pWvX0NRu+rTT3gdj/V+B9xhVI7gh+Uw7+YxSAsVlIWM
	E0wl9eJOa3jZikaFk6fw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtDz7-0004AA-Aq; Mon, 11 Feb 2019 15:59:05 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtDz3-00049F-MP
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 15:59:03 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B5A8A80D;
 Mon, 11 Feb 2019 07:59:00 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3B9F93F589;
 Mon, 11 Feb 2019 07:58:59 -0800 (PST)
Date: Mon, 11 Feb 2019 15:58:50 +0000
From: Will Deacon <will.deacon@arm.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v2 4/4] arm64: kprobes: Use
 arch_populate_kprobe_blacklist()
Message-ID: <20190211155836.GA2692@fuggles.cambridge.arm.com>
References: <154753341900.31541.8135985235882849464.stgit@devbox>
 <154753353370.31541.14485875717131836689.stgit@devbox>
 <7f840cc8-4e62-e1d7-9035-4361204fc134@arm.com>
 <20190121222558.1ef0abc89a704597d6c3de7f@kernel.org>
 <20190208091519.GB6972@fuggles.cambridge.arm.com>
 <20190211221023.0bb43554647f99afce8dd060@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190211221023.0bb43554647f99afce8dd060@kernel.org>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_075901_753902_171FD682 
X-CRM114-Status: GOOD (  13.60  )
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
Cc: Pratyush Anand <panand@redhat.com>, marc.zyngier@arm.com,
 Catalin Marinas <catalin.marinas@arm.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, James Morse <james.morse@arm.com>,
 "David A . Long" <dave.long@linaro.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

[+Marc]

On Mon, Feb 11, 2019 at 10:10:23PM +0900, Masami Hiramatsu wrote:
> On Fri, 8 Feb 2019 09:15:19 +0000
> Will Deacon <will.deacon@arm.com> wrote:
> > Did you send a new version of this series? I can't seem to spot it in my
> > inbox.
> 
> Ah, OK. I just waited for James' patch series,
> 
> https://patchwork.kernel.org/cover/10779489/
> 
> Are those merged? I'd like to move this series on that.

Patches 2-4 are in mainline:

f7daa9c8fd19 arm64: hibernate: Clean the __hyp_text to PoC after resume
8fac5cbdfe0f arm64: hyp-stub: Forbid kprobing of the hyp-stub
f2b3d8566d81 arm64: kprobe: Always blacklist the KVM world-switch code

Patch 1 is queued via kvm-arm (also for 5.0) but it doesn't seem to have
landed yet.

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
