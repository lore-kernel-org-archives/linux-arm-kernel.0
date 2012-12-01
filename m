From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Sat, 1 Dec 2012 10:57:41 -0500
Subject: [PATCH v4 05/13] ARM: KVM: VGIC accept vcpu and dist base
 addresses from user space
In-Reply-To: <CANM98qJnobcpkPrro0rMhbONkVEwDE2X3=MK3b-koOT7mnWivA@mail.gmail.com>
References: <20121110154358.3061.16338.stgit@chazy-air>
 <20121110154451.3061.74235.stgit@chazy-air>
 <20121128131139.GG21671@mudshark.cambridge.arm.com>
 <CANM98qJnobcpkPrro0rMhbONkVEwDE2X3=MK3b-koOT7mnWivA@mail.gmail.com>
Message-ID: <CANM98qJsvMEs5563cKMEA-ydihzafP0JWscKk_ziRgJ26n8AMA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 30, 2012 at 9:52 PM, Christoffer Dall
<c.dall@virtualopensystems.com> wrote:
> On Wed, Nov 28, 2012 at 8:11 AM, Will Deacon <will.deacon@arm.com> wrote:
>> On Sat, Nov 10, 2012 at 03:44:51PM +0000, Christoffer Dall wrote:
>>> User space defines the model to emulate to a guest and should therefore
>>> decide which addresses are used for both the virtual CPU interface
>>> directly mapped in the guest physical address space and for the emulated
>>> distributor interface, which is mapped in software by the in-kernel VGIC
>>> support.
>>>
>>> Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
>>> ---
>>>  arch/arm/include/asm/kvm_mmu.h  |    2 +
>>>  arch/arm/include/asm/kvm_vgic.h |    9 ++++++
>>>  arch/arm/kvm/arm.c              |   16 ++++++++++
>>>  arch/arm/kvm/vgic.c             |   61 +++++++++++++++++++++++++++++++++++++++
>>>  4 files changed, 87 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
>>> index 9bd0508..0800531 100644
>>> --- a/arch/arm/include/asm/kvm_mmu.h
>>> +++ b/arch/arm/include/asm/kvm_mmu.h
>>> @@ -26,6 +26,8 @@
>>>   * To save a bit of memory and to avoid alignment issues we assume 39-bit IPA
>>>   * for now, but remember that the level-1 table must be aligned to its size.
>>>   */
>>> +#define KVM_PHYS_SHIFT       (38)
>>
>> Seems a bit small...
>>
>>> +#define KVM_PHYS_MASK        ((1ULL << KVM_PHYS_SHIFT) - 1)
>>>  #define PTRS_PER_PGD2        512
>>>  #define PGD2_ORDER   get_order(PTRS_PER_PGD2 * sizeof(pgd_t))
>>>
>>> diff --git a/arch/arm/include/asm/kvm_vgic.h b/arch/arm/include/asm/kvm_vgic.h
>>> index b444ecf..9ca8d21 100644
>>> --- a/arch/arm/include/asm/kvm_vgic.h
>>> +++ b/arch/arm/include/asm/kvm_vgic.h
>>> @@ -20,6 +20,9 @@
>>>  #define __ASM_ARM_KVM_VGIC_H
>>>
>>>  struct vgic_dist {
>>> +     /* Distributor and vcpu interface mapping in the guest */
>>> +     phys_addr_t             vgic_dist_base;
>>> +     phys_addr_t             vgic_cpu_base;
>>>  };
>>>
>>>  struct vgic_cpu {
>>> @@ -31,6 +34,7 @@ struct kvm_run;
>>>  struct kvm_exit_mmio;
>>>
>>>  #ifdef CONFIG_KVM_ARM_VGIC
>>> +int kvm_vgic_set_addr(struct kvm *kvm, unsigned long type, u64 addr);
>>>  bool vgic_handle_mmio(struct kvm_vcpu *vcpu, struct kvm_run *run,
>>>                     struct kvm_exit_mmio *mmio);
>>>
>>> @@ -40,6 +44,11 @@ static inline int kvm_vgic_hyp_init(void)
>>>       return 0;
>>>  }
>>>
>>> +static inline int kvm_vgic_set_addr(struct kvm *kvm, unsigned long type, u64 addr)
>>> +{
>>> +     return 0;
>>> +}
>>> +
>>>  static inline int kvm_vgic_init(struct kvm *kvm)
>>>  {
>>>       return 0;
>>> diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
>>> index 426828a..3ac1aab 100644
>>> --- a/arch/arm/kvm/arm.c
>>> +++ b/arch/arm/kvm/arm.c
>>> @@ -61,6 +61,8 @@ static atomic64_t kvm_vmid_gen = ATOMIC64_INIT(1);
>>>  static u8 kvm_next_vmid;
>>>  static DEFINE_SPINLOCK(kvm_vmid_lock);
>>>
>>> +static bool vgic_present;
>>> +
>>>  static void kvm_arm_set_running_vcpu(struct kvm_vcpu *vcpu)
>>>  {
>>>       BUG_ON(preemptible());
>>> @@ -825,7 +827,19 @@ int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *log)
>>>  static int kvm_vm_ioctl_set_device_address(struct kvm *kvm,
>>>                                          struct kvm_device_address *dev_addr)
>>>  {
>>> -     return -ENODEV;
>>> +     unsigned long dev_id, type;
>>> +
>>> +     dev_id = (dev_addr->id & KVM_DEVICE_ID_MASK) >> KVM_DEVICE_ID_SHIFT;
>>> +     type = (dev_addr->id & KVM_DEVICE_TYPE_MASK) >> KVM_DEVICE_TYPE_SHIFT;
>>> +
>>> +     switch (dev_id) {
>>> +     case KVM_ARM_DEVICE_VGIC_V2:
>>> +             if (!vgic_present)
>>> +                     return -ENXIO;
>>> +             return kvm_vgic_set_addr(kvm, type, dev_addr->addr);
>>> +     default:
>>> +             return -ENODEV;
>>> +     }
>>>  }
>>>
>>>  long kvm_arch_vm_ioctl(struct file *filp,
>>> diff --git a/arch/arm/kvm/vgic.c b/arch/arm/kvm/vgic.c
>>> index 26ada3b..f85b275 100644
>>> --- a/arch/arm/kvm/vgic.c
>>> +++ b/arch/arm/kvm/vgic.c
>>> @@ -22,6 +22,13 @@
>>>  #include <linux/io.h>
>>>  #include <asm/kvm_emulate.h>
>>>
>>> +#define VGIC_ADDR_UNDEF              (-1)
>>> +#define IS_VGIC_ADDR_UNDEF(_x)  ((_x) == (typeof(_x))VGIC_ADDR_UNDEF)
>>> +
>>> +#define VGIC_DIST_SIZE               0x1000
>>> +#define VGIC_CPU_SIZE                0x2000
>>
>> These defines might be useful to userspace so that they don't request the
>> distributor and the cpu interface to be place too close together (been there,
>> done that :).
>>
>>> +
>>> +
>>>  #define ACCESS_READ_VALUE    (1 << 0)
>>>  #define ACCESS_READ_RAZ              (0 << 0)
>>>  #define ACCESS_READ_MASK(x)  ((x) & (1 << 0))
>>> @@ -136,3 +143,57 @@ bool vgic_handle_mmio(struct kvm_vcpu *vcpu, struct kvm_run *run, struct kvm_exi
>>>  {
>>>       return KVM_EXIT_MMIO;
>>>  }
>>> +
>>> +static bool vgic_ioaddr_overlap(struct kvm *kvm)
>>> +{
>>> +     phys_addr_t dist = kvm->arch.vgic.vgic_dist_base;
>>> +     phys_addr_t cpu = kvm->arch.vgic.vgic_cpu_base;
>>> +
>>> +     if (IS_VGIC_ADDR_UNDEF(dist) || IS_VGIC_ADDR_UNDEF(cpu))
>>> +             return false;
>>> +     if ((dist <= cpu && dist + VGIC_DIST_SIZE > cpu) ||
>>> +         (cpu <= dist && cpu + VGIC_CPU_SIZE > dist))
>>> +             return true;
>>> +     return false;
>>
>> Just return the predicate that you're testing.
>>
>>> +}
>>> +
>>> +int kvm_vgic_set_addr(struct kvm *kvm, unsigned long type, u64 addr)
>>> +{
>>> +     int r = 0;
>>> +     struct vgic_dist *vgic = &kvm->arch.vgic;
>>> +
>>> +     if (addr & ~KVM_PHYS_MASK)
>>> +             return -E2BIG;
>>> +
>>> +     if (addr & ~PAGE_MASK)
>>> +             return -EINVAL;
>>> +
>>> +     mutex_lock(&kvm->lock);
>>> +     switch (type) {
>>> +     case KVM_VGIC_V2_ADDR_TYPE_DIST:
>>> +             if (!IS_VGIC_ADDR_UNDEF(vgic->vgic_dist_base))
>>> +                     return -EEXIST;
>>> +             if (addr + VGIC_DIST_SIZE < addr)
>>> +                     return -EINVAL;
>>
>> I think somebody else pointed out the missing mutex_unlocks on the failure
>> paths.
>>
>>> +             kvm->arch.vgic.vgic_dist_base = addr;
>>> +             break;
>>> +     case KVM_VGIC_V2_ADDR_TYPE_CPU:
>>> +             if (!IS_VGIC_ADDR_UNDEF(vgic->vgic_cpu_base))
>>> +                     return -EEXIST;
>>> +             if (addr + VGIC_CPU_SIZE < addr)
>>> +                     return -EINVAL;
>>> +             kvm->arch.vgic.vgic_cpu_base = addr;
>>> +             break;
>>> +     default:
>>> +             r = -ENODEV;
>>> +     }
>>> +
>>> +     if (vgic_ioaddr_overlap(kvm)) {
>>> +             kvm->arch.vgic.vgic_dist_base = VGIC_ADDR_UNDEF;
>>> +             kvm->arch.vgic.vgic_cpu_base = VGIC_ADDR_UNDEF;
>>> +             return -EINVAL;
>>
>> Perhaps we could put all the address checking in one place, so that the wrapping
>> round zero checks and the overlap checks can be in the same function?
>>
>
> Like this (?):
>
and by this, I mean this:

diff --git a/Documentation/virtual/kvm/api.txt
b/Documentation/virtual/kvm/api.txt
index 7f057a2..0b6b95e 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -2163,6 +2163,7 @@ Errors:
   ENXIO:  Device not supported on current system
   EEXIST: Address already set
   E2BIG:  Address outside guest physical address space
+  EBUSY:  Address overlaps with other device range

 struct kvm_device_address {
 	__u64 id;
diff --git a/arch/arm/kvm/vgic.c b/arch/arm/kvm/vgic.c
index f697c14..c666b95 100644
--- a/arch/arm/kvm/vgic.c
+++ b/arch/arm/kvm/vgic.c
@@ -1230,11 +1230,28 @@ static bool vgic_ioaddr_overlap(struct kvm *kvm)
 	phys_addr_t cpu = kvm->arch.vgic.vgic_cpu_base;

 	if (IS_VGIC_ADDR_UNDEF(dist) || IS_VGIC_ADDR_UNDEF(cpu))
-		return false;
+		return 0;
 	if ((dist <= cpu && dist + VGIC_DIST_SIZE > cpu) ||
 	    (cpu <= dist && cpu + VGIC_CPU_SIZE > dist))
-		return true;
-	return false;
+		return -EBUSY;
+	return 0;
+}
+
+static int vgic_ioaddr_assign(struct kvm *kvm, phys_addr_t *ioaddr,
+			      phys_addr_t addr, phys_addr_t size)
+{
+	int ret;
+
+	if (!IS_VGIC_ADDR_UNDEF(*ioaddr))
+		return -EEXIST;
+	if (addr + size < addr)
+		return -EINVAL;
+
+	ret = vgic_ioaddr_overlap(kvm);
+	if (ret)
+		return ret;
+	*ioaddr = addr;
+	return ret;
 }

 int kvm_vgic_set_addr(struct kvm *kvm, unsigned long type, u64 addr)
@@ -1251,29 +1268,17 @@ int kvm_vgic_set_addr(struct kvm *kvm,
unsigned long type, u64 addr)
 	mutex_lock(&kvm->lock);
 	switch (type) {
 	case KVM_VGIC_V2_ADDR_TYPE_DIST:
-		if (!IS_VGIC_ADDR_UNDEF(vgic->vgic_dist_base))
-			return -EEXIST;
-		if (addr + VGIC_DIST_SIZE < addr)
-			return -EINVAL;
-		kvm->arch.vgic.vgic_dist_base = addr;
+		r = vgic_ioaddr_assign(kvm, &vgic->vgic_dist_base,
+				       addr, VGIC_DIST_SIZE);
 		break;
 	case KVM_VGIC_V2_ADDR_TYPE_CPU:
-		if (!IS_VGIC_ADDR_UNDEF(vgic->vgic_cpu_base))
-			return -EEXIST;
-		if (addr + VGIC_CPU_SIZE < addr)
-			return -EINVAL;
-		kvm->arch.vgic.vgic_cpu_base = addr;
+		r = vgic_ioaddr_assign(kvm, &vgic->vgic_cpu_base,
+				       addr, VGIC_CPU_SIZE);
 		break;
 	default:
 		r = -ENODEV;
 	}

-	if (vgic_ioaddr_overlap(kvm)) {
-		kvm->arch.vgic.vgic_dist_base = VGIC_ADDR_UNDEF;
-		kvm->arch.vgic.vgic_cpu_base = VGIC_ADDR_UNDEF;
-		r = -EINVAL;
-	}
-
 	mutex_unlock(&kvm->lock);
 	return r;
 }
--

Thanks,
-Christoffer
