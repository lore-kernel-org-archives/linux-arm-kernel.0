From: dahi@linux.vnet.ibm.com (David Hildenbrand)
Date: Tue, 14 Apr 2015 08:31:57 +0200
Subject: [PATCH v2 04/10] KVM: arm: guest debug, add stub
 KVM_SET_GUEST_DEBUG ioctl
In-Reply-To: <20150413121231.GO6186@cbox>
References: <1427814488-28467-1-git-send-email-alex.bennee@linaro.org>
 <1427814488-28467-5-git-send-email-alex.bennee@linaro.org>
 <20150413121231.GO6186@cbox>
Message-ID: <20150414083157.65733022@thinkpad-w530>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Tue, Mar 31, 2015 at 04:08:02PM +0100, Alex Benn?e wrote:
> > This commit adds a stub function to support the KVM_SET_GUEST_DEBUG
> > ioctl. Currently any operation flag will return EINVAL. Actual
> > functionality will be added with further patches.
> > 
> > Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>.
> > 
> > ---
> > v2
> >   - simplified form of the ioctl (stuff will go into setup_debug)
> > 
> > diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
> > index b112efc..06c5064 100644
> > --- a/Documentation/virtual/kvm/api.txt
> > +++ b/Documentation/virtual/kvm/api.txt
> > @@ -2604,7 +2604,7 @@ handled.
> >  4.87 KVM_SET_GUEST_DEBUG
> >  
> >  Capability: KVM_CAP_SET_GUEST_DEBUG
> > -Architectures: x86, s390, ppc
> > +Architectures: x86, s390, ppc, arm64
> >  Type: vcpu ioctl
> >  Parameters: struct kvm_guest_debug (in)
> >  Returns: 0 on success; -1 on error
> > diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
> > index 5560f74..445933d 100644
> > --- a/arch/arm/kvm/arm.c
> > +++ b/arch/arm/kvm/arm.c
> > @@ -183,6 +183,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
> >  	case KVM_CAP_ARM_PSCI:
> >  	case KVM_CAP_ARM_PSCI_0_2:
> >  	case KVM_CAP_READONLY_MEM:
> > +	case KVM_CAP_SET_GUEST_DEBUG:
> >  		r = 1;
> >  		break;
> 
> shouldn't you wait with advertising this capability until you've
> implemented support for it?
> 

I think this would work for now, however it's not very practical
- in the end one has to sense which debug flags are actually supported.

Question is if he wants to add initial support and extend functionality and
flags with each patch or enable the whole set of features in one shot at the
end.

Doing the latter seems more practicable to me (especially as the debug features
are added in the same patch series).

David
