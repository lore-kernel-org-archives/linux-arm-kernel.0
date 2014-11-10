From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 10 Nov 2014 14:25:35 +0100
Subject: [PATCH v3 19/19] arm/arm64: KVM: allow userland to request a
 virtual GICv3
In-Reply-To: <5460AEF4.3030407@arm.com>
References: <1414776414-13426-1-git-send-email-andre.przywara@arm.com>
 <1414776414-13426-20-git-send-email-andre.przywara@arm.com>
 <20141107161546.GU16132@cbox> <5460AEF4.3030407@arm.com>
Message-ID: <20141110132535.GE7544@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 10, 2014 at 12:26:28PM +0000, Andre Przywara wrote:
> Hej Christoffer,
> 
> On 07/11/14 16:15, Christoffer Dall wrote:
> > On Fri, Oct 31, 2014 at 05:26:54PM +0000, Andre Przywara wrote:
> >> With everything in place we allow userland to request the kernel
> >> using a virtual GICv3 in the guest, which finally lifts the 8 vCPU
> >> limit for a guest.
> > 
> > You're actually not explicitly allowing this in this patch, you're
> > implicitly allowing it because init would fail without the vgic
> > distributor base address being set already.
> > 
> > Either re-arrange your patches or fix the commit message.
> 
> The latter ;-)
> 
> >> Also we provide the necessary support for guests setting the memory
> >> addresses for the virtual distributor and redistributors.
> >> This requires some userland code to make use of that feature and
> >> explicitly ask for a virtual GICv3.
> > 
> > You need to add documentation for this new device type and the userspace
> > ABI.
> 
> Will do.
> 
> >>
> >> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> >> ---
> >>  arch/arm64/include/uapi/asm/kvm.h |    7 ++++++
> >>  include/kvm/arm_vgic.h            |    4 ++--
> >>  virt/kvm/arm/vgic-v3-emul.c       |    3 +++
> >>  virt/kvm/arm/vgic.c               |   46 ++++++++++++++++++++++++++-----------
> >>  4 files changed, 45 insertions(+), 15 deletions(-)
> >>
> >> diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
> >> index 8e38878..2ed873a 100644
> >> --- a/arch/arm64/include/uapi/asm/kvm.h
> >> +++ b/arch/arm64/include/uapi/asm/kvm.h
> >> @@ -78,6 +78,13 @@ struct kvm_regs {
> >>  #define KVM_VGIC_V2_DIST_SIZE		0x1000
> >>  #define KVM_VGIC_V2_CPU_SIZE		0x2000
> >>  
> >> +/* Supported VGICv3 address types  */
> >> +#define KVM_VGIC_V3_ADDR_TYPE_DIST	2
> >> +#define KVM_VGIC_V3_ADDR_TYPE_REDIST	3
> >> +
> >> +#define KVM_VGIC_V3_DIST_SIZE		SZ_64K
> >> +#define KVM_VGIC_V3_REDIST_SIZE		(2 * SZ_64K)
> >> +
> >>  #define KVM_ARM_VCPU_POWER_OFF		0 /* CPU is started in OFF state */
> >>  #define KVM_ARM_VCPU_EL1_32BIT		1 /* CPU running a 32bit VM */
> >>  #define KVM_ARM_VCPU_PSCI_0_2		2 /* CPU uses PSCI v0.2 */
> >> diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
> >> index c303083..e2e432c 100644
> >> --- a/include/kvm/arm_vgic.h
> >> +++ b/include/kvm/arm_vgic.h
> >> @@ -35,8 +35,8 @@
> >>  #define VGIC_MAX_IRQS		1024
> >>  
> >>  /* Sanity checks... */
> >> -#if (KVM_MAX_VCPUS > 8)
> >> -#error	Invalid number of CPU interfaces
> >> +#if (KVM_MAX_VCPUS > 255)
> >> +#error Too many KVM VCPUs, the VGIC only supports up to 255 VCPUs for now
> > 
> > what happens now if you add more vcpus after having created a GICv2 with
> > 8 vcpus?
> 
> On adding a VCPU we check the number of allowed VCPUs for this
> particular guest (see arch/arm/kvm/arm.c:kvm_arch_vcpu_create() in patch
> 09/19). On creating a virtual GICv2 we set the limit to 8, so any
> KVM_VCPU_CREATE afterwards will fail.
> 
> But indeed I found other issues in this sequence of VCPU/VGIC init,
> which dissolved "magically" by the rework around (or actually the drop
> of) init_emul() and friends.
> 
I see, thanks.
-Christoffer
