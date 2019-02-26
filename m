Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13062C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:06:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5E3D21852
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="C1DEpnr8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5E3D21852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KwLN8ePgMcPG8BW08xbh3Zn1yppMaUmmztOmVHHNXLc=; b=C1DEpnr83gpvxH
	q+Yu9qPQ65NBQTCrjn/0B1/Gkm3RIhD8QpZWef+ncZAHJqWzqdkg5O3WnpB2cEGUqCRdlyJCWaw40
	S4q0ZAUFdDNsn7Z5iErcXO/tx0hXESftY8xe/I2sYZavfXXB6IZcgRRJwk9I7dmEy1TZCQd0UIl0d
	oerdWawAehPhCUFkdDA+rfckcrEpcJjx4P5sx5JZD/NkX/bMolOW/zAXLKN4kJ3g4EvCpO/5tGo+y
	+WlFDoD28VARBOeMmC3hN9WKELtSQ0+yJ8VS28NqVyaKwj2A1TqzgIa3+1FOZ2JDu2IhUSRXxzGdN
	7LcTiZHJhyGu9BIK0EfA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gybUz-0008S5-Uh; Tue, 26 Feb 2019 12:06:13 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gybUs-0008OL-SB
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 12:06:08 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3855680D;
 Tue, 26 Feb 2019 04:06:06 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B43A3F71D;
 Tue, 26 Feb 2019 04:06:04 -0800 (PST)
Date: Tue, 26 Feb 2019 12:06:02 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Julien Grall <julien.grall@arm.com>
Subject: Re: [PATCH v5 02/26] arm64: fpsimd: Always set TIF_FOREIGN_FPSTATE
 on task state flush
Message-ID: <20190226120601.GF3567@e103592.cambridge.arm.com>
References: <1550519559-15915-1-git-send-email-Dave.Martin@arm.com>
 <1550519559-15915-3-git-send-email-Dave.Martin@arm.com>
 <7e358d11-4896-1f09-0496-70a78eb60736@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7e358d11-4896-1f09-0496-70a78eb60736@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_040606_925799_C31F94E9 
X-CRM114-Status: GOOD (  18.74  )
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Feb 21, 2019 at 12:39:39PM +0000, Julien Grall wrote:
> Hi Dave,
> =

> On 18/02/2019 19:52, Dave Martin wrote:
> >This patch updates fpsimd_flush_task_state() to mirror the new
> >semantics of fpsimd_flush_cpu_state() introduced by commit
> >d8ad71fa38a9 ("arm64: fpsimd: Fix TIF_FOREIGN_FPSTATE after
> >invalidating cpu regs").  Both functions now implicitly set
> =

> NIT: Double-space before "Both"
> =

> >TIF_FOREIGN_FPSTATE to indicate that the task's FPSIMD state is not
> >loaded into the cpu.
> >
> >As a side-effect, fpsimd_flush_task_state() now sets
> >TIF_FOREIGN_FPSTATE even for non-running tasks.  In the case of
> =

> NIT: Double sppace before "In".
> =

> >non-running tasks this is not useful but also harmless, because the
> >flag is live only while the corresponding task is running.  This
> >function is not called from fast paths, so special-casing this for
> >the task =3D=3D current case is not really worth it.
> >
> >Compiler barriers previously present in restore_sve_fpsimd_context()
> >are pulled into fpsimd_flush_task_state() so that it can be safely
> >called with preemption enabled if necessary.
> >
> >Explicit calls to set TIF_FOREIGN_FPSTATE that accompany
> >fpsimd_flush_task_state() calls and are now redundant are removed
> >as appropriate.
> >
> >fpsimd_flush_task_state() is used to get exclusive access to the
> >representation of the task's state via task_struct, for the purpose
> >of replacing the state.  Thus, the call to this function should
> =

> NIT: Double-space before "Thus".
> =

> >happen before manipulating fpsimd_state or sve_state etc. in
> >task_struct.  Anomalous cases are reordered appropriately in order
> =

> NIT: Double-space before "Anomalous".

A habit rather than a mistake [1], and I don't propose to change it ;)


> >to make the code more consistent, although there should be no
> >functional difference since these cases are protected by
> >local_bh_disable() anyway.
> >
> >Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> >Reviewed-by: Alex Benn=E9e <alex.bennee@linaro.org>
> =

> Reviewed-by: Julien Grall <julien.grall@arm.com>

Thanks for the review
--Dave


[1] https://en.wikipedia.org/wiki/Sentence_spacing

Interestingly around 11% of commits in mainline appear to follow the
two-space convention for their commit messages.  I won't speculate as
to why...

$ git log --oneline --grep=3D'[a-z]\.  [A-Z]' | wc -l
94638
$ git log --oneline | wc -l
812542

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
