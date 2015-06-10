From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 10 Jun 2015 09:24:05 +0100
Subject: [PATCH 1/6] ARM: kvm: psci: fix handling of unimplemented
 functions
In-Reply-To: <55771FDC.3090800@arm.com>
References: <1432901799-18359-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1432901799-18359-2-git-send-email-lorenzo.pieralisi@arm.com>
 <55771FDC.3090800@arm.com>
Message-ID: <20150610082405.GD8591@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On Tue, Jun 09, 2015 at 06:18:20PM +0100, Marc Zyngier wrote:
> Hi Lorenzo,
> 
> On 29/05/15 13:16, Lorenzo Pieralisi wrote:
> > According to the PSCI specification and the SMC/HVC calling
> > convention, PSCI function_ids that are not implemented must
> > return NOT_SUPPORTED as return value.
> > 
> > Current KVM implementation takes an unhandled PSCI function_id
> > as an error and injects an undefined instruction into the guest
> > if PSCI implementation is called with a function_id that is not
> > handled by the resident PSCI version (ie it is not implemented),
> > which is not the behaviour expected by a guest when calling a
> > PSCI function_id that is not implemented.
> > 
> > This patch fixes this issue by returning NOT_SUPPORTED whenever
> > the kvm PSCI call is executed for a function_id that is not
> > implemented by the PSCI kvm layer.
> > 
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Reported-by: Sudeep Holla <sudeep.holla@arm.com>
> > Cc: Christoffer Dall <christoffer.dall@linaro.org>
> > Cc: Anup Patel <anup.patel@linaro.org>
> > Cc: Marc Zyngier <marc.zyngier@arm.com>
> > ---
> >  arch/arm/kvm/psci.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/arm/kvm/psci.c b/arch/arm/kvm/psci.c
> > index 7e9398c..ec5943b 100644
> > --- a/arch/arm/kvm/psci.c
> > +++ b/arch/arm/kvm/psci.c
> > @@ -273,7 +273,8 @@ static int kvm_psci_0_2_call(struct kvm_vcpu *vcpu)
> >  		ret = 0;
> >  		break;
> >  	default:
> > -		return -EINVAL;
> > +		val = PSCI_RET_NOT_SUPPORTED;
> > +		break;
> >  	}
> >  
> >  	*vcpu_reg(vcpu, 0) = val;
> > @@ -295,10 +296,9 @@ static int kvm_psci_0_1_call(struct kvm_vcpu *vcpu)
> >  		break;
> >  	case KVM_PSCI_FN_CPU_SUSPEND:
> >  	case KVM_PSCI_FN_MIGRATE:
> > +	default:
> >  		val = PSCI_RET_NOT_SUPPORTED;
> >  		break;
> > -	default:
> > -		return -EINVAL;
> >  	}
> >  
> >  	*vcpu_reg(vcpu, 0) = val;
> > 
> 
> Looks good to me. How do you want to proceed with this one? can I take
> it independently from the rest of the series? Or would you prefer it
> being kept as a whole?

I will prepare a v2 to take into account a comment from Sudeep and I
will add a stable tag too, yes it should be merged independently.

Thanks,
Lorenzo
