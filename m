From: christoffer.dall@arm.com (Christoffer Dall)
Date: Mon, 16 Jul 2018 11:59:37 +0200
Subject: [PATCH v3 7/9] KVM: arm/arm64: vgic: Permit uaccess writes to
 return errors
In-Reply-To: <08e71965-e39e-430f-3db5-765283ba3a0f@arm.com>
References: <1531587940-2490-1-git-send-email-christoffer.dall@arm.com>
 <1531587940-2490-8-git-send-email-christoffer.dall@arm.com>
 <08e71965-e39e-430f-3db5-765283ba3a0f@arm.com>
Message-ID: <20180716095937.GC30822@e113682-lin.lund.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 16, 2018 at 09:28:00AM +0100, Marc Zyngier wrote:
> On 14/07/18 18:05, Christoffer Dall wrote:
> > Currently we do not allow any vgic mmio write operations to fail, which
> > makes sense from mmio traps from the guest.  However, we should be able
> > to report failures to userspace, if userspace writes incompatible values
> > to read-only registers.  Rework the internal interface to allow errors
> > to be returned on the write side for userspace writes.
> >
> > Signed-off-by: Christoffer Dall <christoffer.dall@arm.com>
> > ---
> >  virt/kvm/arm/vgic/vgic-mmio-v2.c | 26 +++++++++++++++++++++-----
> >  virt/kvm/arm/vgic/vgic-mmio-v3.c | 31 ++++++++++++++++++++++++-------
> >  virt/kvm/arm/vgic/vgic-mmio.c    | 18 +++++++++++++-----
> >  virt/kvm/arm/vgic/vgic-mmio.h    | 19 +++++++++++--------
> >  4 files changed, 69 insertions(+), 25 deletions(-)
> >
> > diff --git a/virt/kvm/arm/vgic/vgic-mmio-v2.c b/virt/kvm/arm/vgic/vgic-mmio-v2.c
> > index 34e36fc..b79de42 100644
> > --- a/virt/kvm/arm/vgic/vgic-mmio-v2.c
> > +++ b/virt/kvm/arm/vgic/vgic-mmio-v2.c
> > @@ -77,11 +77,26 @@ static void vgic_mmio_write_v2_misc(struct kvm_vcpu *vcpu,
> >     }
> >  }
> >
> > -static void vgic_mmio_uaccess_write_v2_group(struct kvm_vcpu *vcpu,
> > -                                        gpa_t addr, unsigned int len,
> > -                                        unsigned long val)
> > +static int vgic_mmio_uaccess_write_v2_misc(struct kvm_vcpu *vcpu,
> > +                                      gpa_t addr, unsigned int len,
> > +                                      unsigned long val)
> > +{
> > +   switch (addr & 0x0c) {
> > +   case GIC_DIST_IIDR:
> > +           if (val != vgic_mmio_read_v2_misc(vcpu, addr, len))
> > +                   return -EINVAL;
> > +   }
> > +
> > +   vgic_mmio_write_v2_misc(vcpu, addr, len, val);
> > +   return 0;
> > +}
> > +
> > +static int vgic_mmio_uaccess_write_v2_group(struct kvm_vcpu *vcpu,
> > +                                       gpa_t addr, unsigned int len,
> > +                                       unsigned long val)
> >  {
> >     /* Ignore writes from userspace */
> > +   return 0;
> >  }
>
> I think it'd make more sense if this patch came before the previous one
> (change the prototype of the userspace accessor, and only then add a new
> accessor that can return an error). It would avoid churn in the above
> function, and you could move vgic_mmio_uaccess_write_v2_misc into patch 6.

The intention was that the first six patches dealt with the basic
interrupt grouping support, pretending that we don't have this
save/restore issue with GICv2, and then let the following patches deal
with the GICv2 problem.

>
> Not a big deal though, as the code is otherwise perfectly fine.
>

That said, I'm happy to try to rework this if you think the git history
will be easier to carry as a result.

Thanks,
-Christoffer
IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
