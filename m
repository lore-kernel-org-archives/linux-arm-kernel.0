From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 30 Aug 2016 16:07:05 +0200
Subject: [RFC PATCH v3 5/5] arm/arm64: vgic-new: Implement
 KVM_DEV_ARM_VGIC_GRP_LEVEL_INFO ioctl
In-Reply-To: <20160830140034.GK10162@cbox>
References: <1472037609-4164-1-git-send-email-vijay.kilari@gmail.com>
 <1472037609-4164-6-git-send-email-vijay.kilari@gmail.com>
 <20160830140034.GK10162@cbox>
Message-ID: <20160830140705.GL10162@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 30, 2016 at 04:00:34PM +0200, Christoffer Dall wrote:
> On Wed, Aug 24, 2016 at 04:50:09PM +0530, vijay.kilari at gmail.com wrote:
> > From: Vijaya Kumar K <Vijaya.Kumar@cavium.com>
> > 
> > Userspace requires to store and restore of line_level for
> > level triggered interrupts. For this ioctl KVM_DEV_ARM_VGIC_GRP_LEVEL_INFO
> > is defined.
> > 
> > Signed-off-by: Vijaya Kumar K <Vijaya.Kumar@cavium.com>
> > ---
> >  arch/arm64/include/uapi/asm/kvm.h   |  6 +++++
> >  virt/kvm/arm/vgic/vgic-kvm-device.c | 44 ++++++++++++++++++++++++++++++++++++-
> >  virt/kvm/arm/vgic/vgic-mmio-v3.c    | 19 ++++++++++++++++
> >  virt/kvm/arm/vgic/vgic-mmio.c       | 34 ++++++++++++++++++++++++++++
> >  virt/kvm/arm/vgic/vgic-mmio.h       |  6 +++++
> >  virt/kvm/arm/vgic/vgic.h            |  3 +++
> >  6 files changed, 111 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
> > index b13c944..45c56d7 100644
> > --- a/arch/arm64/include/uapi/asm/kvm.h
> > +++ b/arch/arm64/include/uapi/asm/kvm.h
> > @@ -209,6 +209,12 @@ struct kvm_arch_memory_slot {
> >  #define KVM_DEV_ARM_VGIC_GRP_CTRL	4
> >  #define KVM_DEV_ARM_VGIC_GRP_REDIST_REGS 5
> >  #define KVM_DEV_ARM_VGIC_CPU_SYSREGS    6
> > +#define KVM_DEV_ARM_VGIC_GRP_LEVEL_INFO 7
> > +#define KVM_DEV_ARM_VGIC_LINE_LEVEL_INFO_SHIFT	9
> 
> This should be 10, bits 0 through 9 gives you 10 to work with.
> 
> > +#define KVM_DEV_ARM_VGIC_LINE_LEVEL_INFO_MASK \
> > +			(0x7fffffULL << KVM_DEV_ARM_VGIC_LINE_LEVEL_INFO_SHIFT)
> 
> this mask is also wrong, 32 - 10 == 22, not 23.
> 
> > +#define KVM_DEV_ARM_VGIC_LINE_LEVEL_INTID_MASK	0x1ff
> 
> this is also wrong, you have 10 bits, not 9 bits.
> 
> Hint: the max SPI number is around 1024.
> 
> > +#define KVM_DEV_ARM_VGIC_LINE_LEVEL_INFO_VAL	1
> 
> This should really be KVM_DEV_ARM_VGIC_GRP_LEVEL_INFO_LEVEL.  Why is 0
> not a valid value?
> 

actually, the API documentation specifies that this should simply be
defined as VGIC_LEVEL_INFO_LINE_LEVEL.

-Christoffer
