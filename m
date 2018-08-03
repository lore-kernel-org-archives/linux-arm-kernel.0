From: drjones@redhat.com (Andrew Jones)
Date: Fri, 3 Aug 2018 17:11:09 +0200
Subject: [RFC PATCH 14/16] KVM: arm64/sve: Add SVE support to register
 access ioctl interface
In-Reply-To: <20180803145757.GC4240@e103592.cambridge.arm.com>
References: <1529593060-542-1-git-send-email-Dave.Martin@arm.com>
 <1529593060-542-15-git-send-email-Dave.Martin@arm.com>
 <20180719130433.mfqqnxxlmvhduqri@kamzik.brq.redhat.com>
 <20180803145757.GC4240@e103592.cambridge.arm.com>
Message-ID: <20180803151109.j5fztbai2nuqhzbv@kamzik.brq.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 03, 2018 at 03:57:59PM +0100, Dave Martin wrote:
> On Thu, Jul 19, 2018 at 03:04:33PM +0200, Andrew Jones wrote:
> > On Thu, Jun 21, 2018 at 03:57:38PM +0100, Dave Martin wrote:
> > > This patch adds the following registers for access via the
> > > KVM_{GET,SET}_ONE_REG interface:
> > > 
> > >  * KVM_REG_ARM64_SVE_ZREG(n, i) (n = 0..31) (in 2048-bit slices)
> > >  * KVM_REG_ARM64_SVE_PREG(n, i) (n = 0..15) (in 256-bit slices)
> > >  * KVM_REG_ARM64_SVE_FFR(i) (in 256-bit slices)
> > > 
> > > In order to adapt gracefully to future architectural extensions,
> > > the registers are divided up into slices as noted above:  the i
> > > parameter denotes the slice index.
> > > 
> > > For simplicity, bits or slices that exceed the maximum vector
> > > length supported for the vcpu are ignored for KVM_SET_ONE_REG, and
> > > read as zero for KVM_GET_ONE_REG.
> > > 
> > > For the current architecture, only slice i = 0 is significant.  The
> > > interface design allows i to increase to up to 31 in the future if
> > > required by future architectural amendments.
> > > 
> > > The registers are only visible for vcpus that have SVE enabled.
> > > They are not enumerated by KVM_GET_REG_LIST on vcpus that do not
> > > have SVE.  In all cases, surplus slices are not enumerated by
> > > KVM_GET_REG_LIST.
> > > 
> > > Accesses to the FPSIMD registers via KVM_REG_ARM_CORE are
> > > redirected to access the underlying vcpu SVE register storage as
> > > appropriate.  In order to make this more straightforward, register
> > > accesses that straddle register boundaries are no longer guaranteed
> > > to succeed.  (Support for such use was never deliberate, and
> > > userspace does not currently seem to be relying on it.)
> > > 
> > > Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> 
> [...]
> 
> > > diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
> 
> [...]
> 
> > > +static int sve_reg_bounds(struct reg_bounds_struct *b,
> > > +			  const struct kvm_vcpu *vcpu,
> > > +			  const struct kvm_one_reg *reg)
> > > +{
> 
> [...]
> 
> > > +	b->kptr += start;
> > > +
> > > +	if (copy_limit < start)
> > > +		copy_limit = start;
> > > +	else if (copy_limit > limit)
> > > +		copy_limit = limit;
> > 
> >  copy_limit = clamp(copy_limit, start, limit)
> 
> Hmmm, having looked in detail in the definition of clamp(), I'm not sure
> I like it that much -- it can introduce type issues that are not readily
> apparent to the reader.
> 
> gcc can warn about signed/unsigned comparisons, which is the only issue
> where clamp() genuinely helps AFAICT, but this requires -Wsign-compare
> (which is not enabled by default, nor with -Wall).  Great.
> 
> I can use clamp() if you feel strongly about it, but otherwise I tend
> prefer my subtleties to be in plain sight rather than buried inside a
> macro, unless there is a serious verbosity impact from not using the
> macro (here, I would say there isn't, since it's just a single
> instance).
>

Would clamp_t, with an appropriate type, satisfy your concerns?

Thanks,
drew
