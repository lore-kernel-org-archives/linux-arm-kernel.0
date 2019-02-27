Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA7A9C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 13:50:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83B4720C01
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 13:50:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NFUzrjYi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83B4720C01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mibmrThsFeSF9Iwr3CvaiVn7i0NqDUH1sDmSZYw1myM=; b=NFUzrjYidJwzYp
	3j7QvTiaqSNtDhA/FqBQt45r9D7hGUipE0PNDUSZDVMxqboK0rN7HgTz6KIzhfFm0hpEK2vFNnLvX
	ASWfOFuiQHdBDjZIBI/WwANH5uQE5jziVNHRy8DbzpOQTQ9QmhrbPirAjLHnEG667UJg5LcmbPGo3
	9jqNYbyAF+LNRjTJth3yRW3K/5eR5Pe+TUzV2NEWEiZp1KTY3iWweW7VIG5FALNINSzDh6E+WX/UR
	61daVzWxGYYYdbpiZDQKH+/MFmn/pGYppSqKKX93a9DAh+9fXzLxiLutk0MX6w8bcKJqHi4gjehUy
	U9rRua8JKa38cV7jC26w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyzba-0007IH-RY; Wed, 27 Feb 2019 13:50:38 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyzbX-0007Hs-PC
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 13:50:37 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 246FE374;
 Wed, 27 Feb 2019 05:50:35 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 56DA63F5C1;
 Wed, 27 Feb 2019 05:50:33 -0800 (PST)
Date: Wed, 27 Feb 2019 13:50:30 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Julien Grall <julien.grall@arm.com>
Subject: Re: [PATCH v5 13/26] KVM: arm64/sve: System register context switch
 and access support
Message-ID: <20190227135030.GE3567@e103592.cambridge.arm.com>
References: <1550519559-15915-1-git-send-email-Dave.Martin@arm.com>
 <1550519559-15915-14-git-send-email-Dave.Martin@arm.com>
 <8a0e6089-b77b-151b-eacd-34ad13f39ac6@arm.com>
 <20190226170105.GB3567@e103592.cambridge.arm.com>
 <5a7dc2f4-a6e7-28bb-64d7-4f64424eb5c2@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5a7dc2f4-a6e7-28bb-64d7-4f64424eb5c2@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190227_055035_818036_90B0F5CA 
X-CRM114-Status: GOOD (  22.02  )
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

On Wed, Feb 27, 2019 at 12:02:46PM +0000, Julien Grall wrote:
> Hi Dave,
> 
> On 2/26/19 5:01 PM, Dave Martin wrote:
> >On Tue, Feb 26, 2019 at 04:32:30PM +0000, Julien Grall wrote:
> >>On 18/02/2019 19:52, Dave Martin wrote:
> >>We seem to already have code for handling invariant registers as well as
> >>reading ID register. I guess the only reason you can't use them is because
> >>of the check the vcpu is using SVE.
> >>
> >>However, AFAICT the restrictions callback would prevent you to enter the
> >>{get, set}_id if the vCPU does not support SVE. So the check should not be
> >>reachable.
> >
> >Hmmm, those checks were inherited from before this refactoring.
> >
> >You're right: the checks are now done a common place, so the checks in
> >the actual accessors should be redundant.
> >
> >I could demote them to WARN(), but it may make sense simply to delete
> >them.
> 
> I think removing the WARN() would be best as it would avoid to introduce
> most of the wrappers for the registers.
> 
> >
> >The access_id_aa64zfr0_el1() should still be reachable, since we don't
> >have REG_NO_GUEST for this.
> 
> __access_id_reg is taking a boolean to tell whether the register is RAZ or
> not. So you probably could re-use it passing !vcpu_has_sve(vcpu).
> 
> It feels to me we would introduce a new restriction to tell whether the
> register should be RAZ. Anyway, the new restriction is probably for a
> follow-up patch.

It's true that we should be able to handle these as regular ID regs in
the get()/set() case, when SVE is enabled for the vcpu.  I'll have a
think about how to reduce the amount of special-case code here maybe
we can indeed get of some of these accessors entitely now that access
is rejected earlier, in a more generic way.

The access() case for this register still has to be custom though; I
don't see a trivial solution for that.

Cheers
---Dave

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
