From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 25 Jul 2018 12:48:12 +0100
Subject: [RFC PATCH 10/16] KVM: arm64: Add a vcpu flag to control SVE
 visibility for the guest
In-Reply-To: <20180719150244.cybuq65qc6pt7hek@kamzik.brq.redhat.com>
References: <1529593060-542-1-git-send-email-Dave.Martin@arm.com>
 <1529593060-542-11-git-send-email-Dave.Martin@arm.com>
 <20180719150244.cybuq65qc6pt7hek@kamzik.brq.redhat.com>
Message-ID: <20180725114812.GI4240@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 19, 2018 at 05:02:44PM +0200, Andrew Jones wrote:
> On Thu, Jun 21, 2018 at 03:57:34PM +0100, Dave Martin wrote:
> > Since SVE will be enabled or disabled on a per-vcpu basis, a flag
> > is needed in order to track which vcpus have it enabled.
> > 
> > This patch adds a suitable flag and a helper for checking it.
> > 
> > Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> > ---
> >  arch/arm64/include/asm/kvm_host.h | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> > index 9671ddd..609d08b 100644
> > --- a/arch/arm64/include/asm/kvm_host.h
> > +++ b/arch/arm64/include/asm/kvm_host.h
> > @@ -308,6 +308,14 @@ struct kvm_vcpu_arch {
> >  #define KVM_ARM64_FP_HOST		(1 << 2) /* host FP regs loaded */
> >  #define KVM_ARM64_HOST_SVE_IN_USE	(1 << 3) /* backup for host TIF_SVE */
> >  #define KVM_ARM64_HOST_SVE_ENABLED	(1 << 4) /* SVE enabled for EL0 */
> > +#define KVM_ARM64_GUEST_HAS_SVE		(1 << 5) /* SVE exposed to guest */
> > +
> > +static inline bool vcpu_has_sve(struct kvm_vcpu_arch const *vcpu_arch)
> 
> Shouldn't this vcpu function take a vcpu instead of a vcpu_arch?

Logically it could.  There was some circular include issue that made it
tricky to get the definition of struct kvm_vcpu here, but I may have
another go at it.

Cheers
---Dave
