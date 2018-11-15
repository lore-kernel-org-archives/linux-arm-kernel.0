From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 15 Nov 2018 17:11:34 +0000
Subject: [RFC PATCH v2 10/23] KVM: arm64: Extend reset_unknown() to
 handle mixed RES0/UNKNOWN registers
In-Reply-To: <20181102081119.GR12057@e113682-lin.lund.arm.com>
References: <1538141967-15375-1-git-send-email-Dave.Martin@arm.com>
 <1538141967-15375-11-git-send-email-Dave.Martin@arm.com>
 <20181102081119.GR12057@e113682-lin.lund.arm.com>
Message-ID: <20181115171134.GP3505@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 02, 2018 at 09:11:19AM +0100, Christoffer Dall wrote:
> On Fri, Sep 28, 2018 at 02:39:14PM +0100, Dave Martin wrote:
> > The reset_unknown() system register helper initialises a guest
> > register to a distinctive junk value on vcpu reset, to help expose
> > and debug deficient register initialisation within the guest.
> > 
> > Some registers such as the SVE control register ZCR_EL1 contain a
> > mixture of UNKNOWN fields and RES0 bits.  For these,
> > reset_unknown() does not work at present, since it sets all bits to
> > junk values instead of just the wanted bits.
> > 
> > There is no need to craft another special helper just for that,
> > since reset_unknown() almost does the appropriate thing anyway.
> > This patch takes advantage of the ununused val field in struct
> > sys_reg_desc to specify a mask of bits that should be initialised
> > to zero instead of junk.
> > 
> > All existing users of reset_unknown() do not (and should not)
> > define a value for val, so they will implicitly set it to zero,
> > resulting in all bits being made UNKNOWN by this function: thus,
> > this patch makes no functional change for currently defined
> > registers.
> > 
> > Future patches will make use of non-zero val.
> > 
> > Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> > ---
> >  arch/arm64/kvm/sys_regs.h | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/kvm/sys_regs.h b/arch/arm64/kvm/sys_regs.h
> > index cd710f8..24bac06 100644
> > --- a/arch/arm64/kvm/sys_regs.h
> > +++ b/arch/arm64/kvm/sys_regs.h
> > @@ -89,7 +89,9 @@ static inline void reset_unknown(struct kvm_vcpu *vcpu,
> >  {
> >  	BUG_ON(!r->reg);
> >  	BUG_ON(r->reg >= NR_SYS_REGS);
> > -	__vcpu_sys_reg(vcpu, r->reg) = 0x1de7ec7edbadc0deULL;
> > +
> > +	/* If non-zero, r->val specifies which register bits are RES0: */
> > +	__vcpu_sys_reg(vcpu, r->reg) = 0x1de7ec7edbadc0deULL & ~r->val;
> 
> nit: it would be nice to document this feature on the val field in the
> sys_reg_desc structure above as well.

Sure thing, I missed that, but we _do_ want this clearly documented.

I'll add that when I respin.

[...]

Cheers
---Dave
