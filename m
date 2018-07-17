From: christoffer.dall@arm.com (Christoffer Dall)
Date: Tue, 17 Jul 2018 11:10:50 +0200
Subject: [PATCH v4 07/10] KVM: arm/arm64: vgic: Return error on
 incompatible uaccess GICD_IIDR writes
In-Reply-To: <AM5PR0401MB25455D849AB57AF98A3C91F49A5D0@AM5PR0401MB2545.eurprd04.prod.outlook.com>
References: <1531746387-7033-1-git-send-email-christoffer.dall@arm.com>
 <1531746387-7033-8-git-send-email-christoffer.dall@arm.com>
 <AM5PR0401MB25455D849AB57AF98A3C91F49A5D0@AM5PR0401MB2545.eurprd04.prod.outlook.com>
Message-ID: <20180717091050.GB30570@e113682-lin.lund.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 16, 2018 at 03:43:28PM +0000, Bharat Bhushan wrote:
> Hi Christoffer,
> 
> > -----Original Message-----
> > From: kvmarm-bounces at lists.cs.columbia.edu [mailto:kvmarm-
> > bounces at lists.cs.columbia.edu] On Behalf Of Christoffer Dall
> > Sent: Monday, July 16, 2018 6:36 PM
> > To: kvmarm at lists.cs.columbia.edu; linux-arm-kernel at lists.infradead.org
> > Cc: kvm at vger.kernel.org; Marc Zyngier <marc.zyngier@arm.com>; Andre
> > Przywara <andre.przywara@arm.com>
> > Subject: [PATCH v4 07/10] KVM: arm/arm64: vgic: Return error on
> > incompatible uaccess GICD_IIDR writes
> > 
> > If userspace attempts to write a GICD_IIDR that does not match the
> > kernel version, return an error to userspace.  The intention is to allow
> > implementation changes inside KVM while avoiding silently breaking
> > migration resulting in guests not running without any clear indication
> > of what went wrong.
> > 
> > Signed-off-by: Christoffer Dall <christoffer.dall@arm.com>
> > ---
> >  virt/kvm/arm/vgic/vgic-mmio-v2.c | 21 ++++++++++++++++++---
> >  virt/kvm/arm/vgic/vgic-mmio-v3.c | 21 ++++++++++++++++++---
> >  2 files changed, 36 insertions(+), 6 deletions(-)
> > 
> > diff --git a/virt/kvm/arm/vgic/vgic-mmio-v2.c b/virt/kvm/arm/vgic/vgic-
> > mmio-v2.c
> > index db646f1..4f0f2c4 100644
> > --- a/virt/kvm/arm/vgic/vgic-mmio-v2.c
> > +++ b/virt/kvm/arm/vgic/vgic-mmio-v2.c
> > @@ -75,6 +75,20 @@ static void vgic_mmio_write_v2_misc(struct kvm_vcpu
> > *vcpu,
> >  	}
> >  }
> > 
> > +static int vgic_mmio_uaccess_write_v2_misc(struct kvm_vcpu *vcpu,
> > +					   gpa_t addr, unsigned int len,
> > +					   unsigned long val)
> > +{
> > +	switch (addr & 0x0c) {
> 
> I am just understanding the code, not sure if it make sense to replace hardcoded "0x0c".
> 

We could encode it, but we use the hardcoded value elsewhere so I just
followed the current pattern.

Thanks,
-Christoffer
