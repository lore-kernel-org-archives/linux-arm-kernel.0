Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A92C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:14:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 481682087C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TI8kSMZN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 481682087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QRUYh+fSTdGPjxEOgRKBibxTcvS0L3OcEko8ZsxY9Z0=; b=TI8kSMZNz5SOKc
	XNU0qPvdN3noV7bpu0t1Ihm9Uf3gjr1PwCLRYh0Cn0VXjHTt8mwq/RdCZ3p8ieVJtg6bnSmR0Spo+
	M5fheAcDTyPLyiGU67WvBP0X38MUtvW3/RKafQXkjG5PvInMkAlXA8g7Loi6pPfJfCNrwCHVM7uSd
	6YyrpSYS38CckiliuBNG+qjQAFkkbMHLsJnW2djj0my0nkKZIFhGLc9UQxEZepyYgKKAxNOKOHXiV
	6GEMDgQnGpO7DvSyTxRL/M9fcC93H2dXLj0E88Q8015EhjvE0gbaX/ylM4RVKUpmxuXvuIMfjgHbR
	FwNa6j8KTDl6qI9WabyA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gybcq-000879-2V; Tue, 26 Feb 2019 12:14:20 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gybcD-0007XY-7N
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 12:13:58 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0DA7D80D;
 Tue, 26 Feb 2019 04:13:41 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 411C13F5C1;
 Tue, 26 Feb 2019 04:13:39 -0800 (PST)
Date: Tue, 26 Feb 2019 12:13:36 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Julien Thierry <julien.thierry@arm.com>
Subject: Re: [PATCH v5 18/26] KVM: arm64/sve: Add SVE support to register
 access ioctl interface
Message-ID: <20190226121336.GS3567@e103592.cambridge.arm.com>
References: <1550519559-15915-1-git-send-email-Dave.Martin@arm.com>
 <1550519559-15915-19-git-send-email-Dave.Martin@arm.com>
 <f6d9f731-e9f8-a54d-1165-2b188e22b4df@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f6d9f731-e9f8-a54d-1165-2b188e22b4df@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_041341_693734_D07CE9E7 
X-CRM114-Status: GOOD (  40.08  )
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

On Thu, Feb 21, 2019 at 03:23:37PM +0000, Julien Thierry wrote:
> Hi Dave,
> 
> On 18/02/2019 19:52, Dave Martin wrote:
> > This patch adds the following registers for access via the
> > KVM_{GET,SET}_ONE_REG interface:
> > 
> >  * KVM_REG_ARM64_SVE_ZREG(n, i) (n = 0..31) (in 2048-bit slices)
> >  * KVM_REG_ARM64_SVE_PREG(n, i) (n = 0..15) (in 256-bit slices)
> >  * KVM_REG_ARM64_SVE_FFR(i) (in 256-bit slices)
> > 
> > In order to adapt gracefully to future architectural extensions,
> > the registers are logically divided up into slices as noted above:
> > the i parameter denotes the slice index.
> > 
> > This allows us to reserve space in the ABI for future expansion of
> > these registers.  However, as of today the architecture does not
> > permit registers to be larger than a single slice, so no code is
> > needed in the kernel to expose additional slices, for now.  The
> > code can be extended later as needed to expose them up to a maximum
> > of 32 slices (as carved out in the architecture itself) if they
> > really exist someday.
> > 
> > The registers are only visible for vcpus that have SVE enabled.
> > They are not enumerated by KVM_GET_REG_LIST on vcpus that do not
> > have SVE.
> > 
> > Accesses to the FPSIMD registers via KVM_REG_ARM_CORE is not
> > allowed for SVE-enabled vcpus: SVE-aware userspace can use the
> > KVM_REG_ARM64_SVE_ZREG() interface instead to access the same
> > register state.  This avoids some complex and pointless emulation
> > in the kernel to convert between the two views of these aliased
> > registers.
> > 
> > Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> > 
> > ---
> > 
> > Changes since v4:
> > 
> >  * Add "BASE" #defines for the Z-reg and P-reg ranges in the KVM
> >    register ID space, to make the 0x400 magic number a little less
> >    cryptic.
> > 
> >  * Pull KVM_SVE_{Z,P}REG_SIZE defines from "KVM: arm64: Enumerate SVE
> >    register indices for KVM_GET_REG_LIST", since we now use them here.
> > 
> >  * Simplify sve_reg_region(), and give up on the attempt to make
> >    kreg_region a general thing: nothing else will use it for now,
> >    anyway, so let's keep it as simple as possible.
> > 
> >  * Drop support for multiple slices per register.  This functionality
> >    can be added back in later if needed, without ABI breaks.
> > 
> >  * Pull vcpu_sve_state_size() into kvm_host.h, from "KVM: arm64/sve:
> >    Allow userspace to enable SVE for vcpus".  This is needed for use
> >    with array_index_nospec() to determine the applicable buffer bounds.
> >    To avoid circular header deependency issues, the function is also
> >    converted into a macro, but is otherwise equivalent to the original
> >    version.
> > 
> >  * Guard sve_state base offset in kernel memory with
> >    array_index_nospec(), since it is generated from user data that can
> >    put it out of range.
> > 
> >    (sve_state will get allocated with the corresponding size later in
> >    the series.  For now, this code is dormant since no means is
> >    provided for userspace to create SVE-enabled vcpus yet.)
> > ---
> >  arch/arm64/include/asm/kvm_host.h |  14 ++++
> >  arch/arm64/include/uapi/asm/kvm.h |  17 +++++
> >  arch/arm64/kvm/guest.c            | 138 ++++++++++++++++++++++++++++++++++----
> >  3 files changed, 157 insertions(+), 12 deletions(-)
> > 
> 
> [...]
> 
> > diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
> > index f491456..8cfa889 100644
> > --- a/arch/arm64/kvm/guest.c
> > +++ b/arch/arm64/kvm/guest.c
> 
> [...]
> 
> > @@ -211,6 +217,114 @@ static int set_core_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
> >  	return err;
> >  }
> >  
> > +#define SVE_REG_SLICE_SHIFT	0
> > +#define SVE_REG_SLICE_BITS	5
> > +#define SVE_REG_ID_SHIFT	(SVE_REG_SLICE_SHIFT + SVE_REG_SLICE_BITS)
> > +#define SVE_REG_ID_BITS		5
> > +
> > +#define SVE_REG_SLICE_MASK					\
> > +	GENMASK(SVE_REG_SLICE_SHIFT + SVE_REG_SLICE_BITS - 1,	\
> > +		SVE_REG_SLICE_SHIFT)
> > +#define SVE_REG_ID_MASK							\
> > +	GENMASK(SVE_REG_ID_SHIFT + SVE_REG_ID_BITS - 1, SVE_REG_ID_SHIFT)
> > +
> > +#define SVE_NUM_SLICES (1 << SVE_REG_SLICE_BITS)
> > +
> > +#define KVM_SVE_ZREG_SIZE KVM_REG_SIZE(KVM_REG_ARM64_SVE_ZREG(0, 0))
> > +#define KVM_SVE_PREG_SIZE KVM_REG_SIZE(KVM_REG_ARM64_SVE_PREG(0, 0))
> > +
> > +struct sve_state_region {
> 
> This sve_state_region feels a bit too generic too me.
> 
> So far it is only used to access a single (slice of a) register at a
> time. Is there a plan to use it for more?

It's there as a way to factor out security-sensitive range computations
that we otherwise have to do twice -- I'd rather have the (potential)
bugs in one place.  sve_state is particularly awkward because it is
heterogeneous, with variably sized members for which no C declaration
is avaiable (or possible).

Previously it was used in four places, because I tried to emulate the
VFP get/set functions for SVE vcpus.  Now that functionality has been
dropped I agree that this function looks like a bit like overkill.  But
I didn't come up with a good way to split it without duplicating an
undesirable amount of fiddly logic.

"sve_state" in the name comes from the naming of the kernel field(s)
that this computes ranges on: vcpu->arch.sve_state (and thread->
sve_state, which we don't operate on here, but which has the same
format).

So, this struct describes a slice of "sve_state", hence the name.  But
you're right, it is only ever supposed to span a single SVE register
within there.

> Otherwise I'd suggest at least naming it something like sve_reg_region,
> sve_reg_mem_region or sve_reg_mem_desc.

It used to be called struct kreg_region.  The name "sve_state_region"
was an attempt to make it look less generic, which doesn't appear to
have worked too well.

Maybe "sve_state_reg_region" would narrow the apparent scope of this a
little further.

Thoughts?

I'll take a look, and at least add a comment explaining what this
struct is supposed to represent.

> 
> 
> > +	unsigned int koffset;	/* offset into sve_state in kernel memory */
> > +	unsigned int klen;	/* length in kernel memory */
> > +	unsigned int upad;	/* extra trailing padding in user memory */
> > +};
> > +
> > +/* Get sanitised bounds for user/kernel SVE register copy */
> > +static int sve_reg_region(struct sve_state_region *region,
> 
> I feel that sve_reg_to_region or sve_reg_get_region would be a clearer name.

..._reg_to_region() seems a good name.  I'll pick that up, modulo other
changes.

Cheers
---Dave

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
