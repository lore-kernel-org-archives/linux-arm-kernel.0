From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Sun, 20 Jan 2013 18:22:31 -0500
Subject: [kvmarm] [PATCH v6 02/13] KVM: ARM: Introduce
 KVM_SET_DEVICE_ADDRESS ioctl
In-Reply-To: <CAFEAcA9rQABRT7ybfn_BSsykMO+OhoPt6y7RhNkdXyUSr4fhtA@mail.gmail.com>
References: <20130116180013.29393.49165.stgit@ubuntu>
 <20130116180028.29393.62418.stgit@ubuntu>
 <CAFEAcA9rQABRT7ybfn_BSsykMO+OhoPt6y7RhNkdXyUSr4fhtA@mail.gmail.com>
Message-ID: <CANM98qLsWzUS=457y-j_TvwVi4RQxx2rbg7GqWCOKqTo05dR2Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 17, 2013 at 12:37 PM, Peter Maydell
<peter.maydell@linaro.org> wrote:
> On 16 January 2013 18:00, Christoffer Dall
> <c.dall@virtualopensystems.com> wrote:
>> KVM: ARM: Introduce KVM_SET_DEVICE_ADDRESS ioctl
>
> Patch subject needs updating with new name of this ioctl
> (KVM_ARM_SET_DEVICE_ADDR)...
>
>> On ARM (and possibly other architectures) some bits are specific to the
>> model being emulated for the guest and user space needs a way to tell
>> the kernel about those bits.  An example is mmio device base addresses,
>> where KVM must know the base address for a given device to properly
>> emulate mmio accesses within a certain address range or directly map a
>> device with virtualiation extensions into the guest address space.
>
> "virtualization", while I'm here.
>
>> --- a/arch/arm/include/uapi/asm/kvm.h
>> +++ b/arch/arm/include/uapi/asm/kvm.h
>> @@ -65,6 +65,19 @@ struct kvm_regs {
>>  #define KVM_ARM_TARGET_CORTEX_A15      0
>>  #define KVM_ARM_NUM_TARGETS            1
>>
>> +/* KVM_SET_DEVICE_ADDRESS ioctl id encoding */
>> +#define KVM_DEVICE_TYPE_SHIFT          0
>> +#define KVM_DEVICE_TYPE_MASK           (0xffff << KVM_DEVICE_TYPE_SHIFT)
>> +#define KVM_DEVICE_ID_SHIFT            16
>> +#define KVM_DEVICE_ID_MASK             (0xffff << KVM_DEVICE_ID_SHIFT)
>
> ...and this comment and I guess these constant names presumably
> should have "ARM" in them?
>
>> +/* Available with KVM_CAP_SET_DEVICE_ADDR */
>
> KVM_CAP_ARM_SET_DEVICE_ADDR.
>
right, thanks:

commit 92c7530ddee0d1e1a0b5c3fbd01aa05457812030
Author: Christoffer Dall <c.dall@virtualopensystems.com>
Date:   Sun Jan 20 18:20:52 2013 -0500

    KVM: ARM: Update comments and defines for KVM_ARM_SET_DEVICE_ADDR

    Update comments and defines to reflect the name change of
    KVM_SET_DEVICE_ADDRESS to KVM_ARM_SET_DEVICE_ADDR.

    Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>

diff --git a/arch/arm/include/uapi/asm/kvm.h b/arch/arm/include/uapi/asm/kvm.h
index 236f528..023bfeb 100644
--- a/arch/arm/include/uapi/asm/kvm.h
+++ b/arch/arm/include/uapi/asm/kvm.h
@@ -65,11 +65,11 @@ struct kvm_regs {
 #define KVM_ARM_TARGET_CORTEX_A15	0
 #define KVM_ARM_NUM_TARGETS		1

-/* KVM_SET_DEVICE_ADDRESS ioctl id encoding */
-#define KVM_DEVICE_TYPE_SHIFT		0
-#define KVM_DEVICE_TYPE_MASK		(0xffff << KVM_DEVICE_TYPE_SHIFT)
-#define KVM_DEVICE_ID_SHIFT		16
-#define KVM_DEVICE_ID_MASK		(0xffff << KVM_DEVICE_ID_SHIFT)
+/* KVM_ARM_SET_DEVICE_ADDR ioctl id encoding */
+#define KVM_ARM_DEVICE_TYPE_SHIFT	0
+#define KVM_ARM_DEVICE_TYPE_MASK	(0xffff << KVM_ARM_DEVICE_TYPE_SHIFT)
+#define KVM_ARM_DEVICE_ID_SHIFT		16
+#define KVM_ARM_DEVICE_ID_MASK		(0xffff << KVM_ARM_DEVICE_ID_SHIFT)

 /* Supported device IDs */
 #define KVM_ARM_DEVICE_VGIC_V2		0
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 9ff7f70..33887e7 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -875,7 +875,7 @@ struct kvm_s390_ucas_mapping {
 #define KVM_ALLOCATE_RMA	  _IOR(KVMIO,  0xa9, struct kvm_allocate_rma)
 /* Available with KVM_CAP_PPC_HTAB_FD */
 #define KVM_PPC_GET_HTAB_FD	  _IOW(KVMIO,  0xaa, struct kvm_get_htab_fd)
-/* Available with KVM_CAP_SET_DEVICE_ADDR */
+/* Available with KVM_CAP_ARM_SET_DEVICE_ADDR */
 #define KVM_ARM_SET_DEVICE_ADDR	  _IOW(KVMIO,  0xab, struct
kvm_arm_device_addr)

 /*
--

-Christoffer
