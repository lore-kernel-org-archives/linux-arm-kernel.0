Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF0BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 19:55:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D1A02086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 19:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SDXU/jRZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D1A02086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DTyodyxQM9YlGbTdMwf+7VG/zkPcp9aCbD7aczAMi7I=; b=SDXU/jRZ9SsRZn
	Wqa+kQQcAePxrIaLXM/Vt69rkqvNGU9dyroeWFutjdajnmOduecrFWekhjpu8M5wT8azcdBE/SJoK
	NIgEa7tlt88I3NKIRLTcaZreBoWlMV2NN+81mQSiNEMgwWFy2R8sUtl9d9mbaagRFhrFIiFdei/xv
	ytKeR7zVAMhDEA/nIPvmPamTGVgV2NOyMyJd8gJnfWo7kqnweJF4J7zOAVYNYe3cwICTBN1X7AJeA
	XrER61y73zjOWcowtm9lL7O8zh/Lw1MODoYECMfeu10Ie8AN4lZpU99lorIO/PIwaeFltEZtTo90Q
	Cd4ch9JFvoMTJ/HZ4Rug==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXtYA-0002bk-K3; Fri, 14 Dec 2018 19:55:06 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXtY6-0002EZ-9N
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 19:55:04 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0DE7780D;
 Fri, 14 Dec 2018 11:54:51 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 447713F575;
 Fri, 14 Dec 2018 11:54:50 -0800 (PST)
Date: Fri, 14 Dec 2018 19:54:47 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: kvmarm@lists.cs.columbia.edu
Subject: Re: [PATCH REPOST] KVM: arm64: Treat FPEXC32_EL2 as a regular guest
 system register
Message-ID: <20181214195447.GI3505@e103592.cambridge.arm.com>
References: <1544554096-23451-1-git-send-email-Dave.Martin@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1544554096-23451-1-git-send-email-Dave.Martin@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_115502_374509_928F247D 
X-CRM114-Status: GOOD (  24.66  )
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
Cc: Marc Zyngier <marc.zyngier@arm.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 11, 2018 at 06:48:16PM +0000, Dave Martin wrote:
> Currently FPEXC32_EL2 is handled specially when context-switching.
> 
> However, FPEXC has no architectural effect when running in AArch64.
> The only case where an arm64 host may execute in AArch32 is when
> running compat user code at EL0: the architecture explicitly
> documents FPEXC as having no effect in this case either when the
> kernel (EL2 in the VHE case; otherwise EL1) is AArch64.
> 
> So, we can just handle FPEXC32_EL2 (which is the AArch64 alias for
> this register) as a regular AArch32-only system register and switch
> it without any special handling or synchronisation.
> 
> This allows some gnarly special-case code to be eliminated from
> hyp.  The extra isb() in __activate_traps_fpsimd32() is dropped
> too: for the reasons explained above arm64 never required this
> anyway.
> 
> Note that the comment in the deleted __activate_traps_fpsimd32()
> function about the need to inhibit traps to EL1 is only meaningful
> if the guest's value for FPEXC is not restored (thus potentially
> causing an unexpected trap to EL1 in the guest unless we're careful
> to set the EN bit).  This arises from the treatment of FPEXC32_EL2
> as if it were part of the the FPSIMD state to be switched lazily,
> whereas it is really more natural to consider it as part of the EL1
> system register state to be switched eagerly at the appropriate
> times.
> 
> In fact, we explicitly don't care about seeing any trap until the
> guest accesses the FPSIMD registers for real, provided that the
> guest sees the behaviour it expects.  So ensuring that the guest's
> view of FPEXC is alawys up to date (as implemented by this patch)
> should be sufficient.  Since we always had to write FPEXC32_EL2
> anyway (in order to work around the possibility of not restoring it
> properly for the guest) this should not add significant cost.  In
> any case, this patch moves any cost off the hyp switch critical
> path, to vcpu_load/put().
> 
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Christoffer Dall <christoffer.dall@arm.com>
> Cc: Alexander Graf <agraf@suse.de>
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> 
> ---
> 
> **Build-tested only**

Dang, it turns out that writing FPEXC32_EL2 from EL2 triggers a trap to
EL2 if FPSIMD traps to EL2 are enabled via CPTR_EL2.

This seems illogical, but I've seen it trigger a Hyp panic on Juno
(r0) (non-VHE, but looking at the Arm ARM it appears that something
equivalent happens for VHE too).

So this needs a rethink :|

I think we can still defer the save until vcpu_put(), and save a
sysreg write by not restoring it lazily (since we have to write it once
anyway to set EN bit if we want to trap FPSIMD to EL2).

Anyway, definitely not a priority for v4.21.

[...]

Cheers
---Dave

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
