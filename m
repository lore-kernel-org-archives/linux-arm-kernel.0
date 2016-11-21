From: vijay.kilari@gmail.com (Vijay Kilari)
Date: Mon, 21 Nov 2016 19:02:36 +0530
Subject: [PATCH v8 6/7] arm/arm64: vgic: Implement VGICv3 CPU interface
 access
In-Reply-To: <20161120132005.GC23588@cbox>
References: <1478258013-6669-1-git-send-email-vijay.kilari@gmail.com>
 <1478258013-6669-7-git-send-email-vijay.kilari@gmail.com>
 <20161116185232.GF3811@cbox>
 <CALicx6t5D5n3dDQzeKZNUWdS-q5LNiSq-UrP4HdmbdUCj1tF1g@mail.gmail.com>
 <20161117160951.GB23588@cbox>
 <CALicx6uxU8nC+gayWAxf_BX7JrZ9twsFr4YfMr64bNUSneqZow@mail.gmail.com>
 <20161120132005.GC23588@cbox>
Message-ID: <CALicx6sxchAbDJ2rioTytwFG1C0tD-Fnr4HC-DweSdkkCF7BFw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 20, 2016 at 6:50 PM, Christoffer Dall
<christoffer.dall@linaro.org> wrote:
> On Sat, Nov 19, 2016 at 12:18:53AM +0530, Vijay Kilari wrote:
>> On Thu, Nov 17, 2016 at 9:39 PM, Christoffer Dall
>> <christoffer.dall@linaro.org> wrote:
>> > On Thu, Nov 17, 2016 at 09:25:59PM +0530, Vijay Kilari wrote:
>> >> On Thu, Nov 17, 2016 at 12:22 AM, Christoffer Dall
>> >> <christoffer.dall@linaro.org> wrote:
>> >> > On Fri, Nov 04, 2016 at 04:43:32PM +0530, vijay.kilari at gmail.com wrote:
>> >> >> From: Vijaya Kumar K <Vijaya.Kumar@cavium.com>
>> >> >>
>> >> >> VGICv3 CPU interface registers are accessed using
>> >> >> KVM_DEV_ARM_VGIC_CPU_SYSREGS ioctl. These registers are accessed
>> >> >> as 64-bit. The cpu MPIDR value is passed along with register id.
>> >> >> is used to identify the cpu for registers access.
>> >> >>
>> >> >> The version of VGIC v3 specification is define here
>> >> >> http://lists.infradead.org/pipermail/linux-arm-kernel/2016-July/445611.html
>> >> >>
>> >> >> Signed-off-by: Pavel Fedin <p.fedin@samsung.com>
>> >> >> Signed-off-by: Vijaya Kumar K <Vijaya.Kumar@cavium.com>
>> >> >> ---
>> >> >>  arch/arm64/include/uapi/asm/kvm.h   |   3 +
>> >> >>  arch/arm64/kvm/Makefile             |   1 +
>> >> >>  include/kvm/arm_vgic.h              |   9 +
>> >> >>  virt/kvm/arm/vgic/vgic-kvm-device.c |  27 +++
>> >> >>  virt/kvm/arm/vgic/vgic-mmio-v3.c    |  19 +++
>> >> >>  virt/kvm/arm/vgic/vgic-sys-reg-v3.c | 324 ++++++++++++++++++++++++++++++++++++
>> >> >>  virt/kvm/arm/vgic/vgic-v3.c         |   8 +
>> >> >>  virt/kvm/arm/vgic/vgic.h            |   4 +
>> >> >>  8 files changed, 395 insertions(+)
>> >> >>
>> >> >> diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
>> >> >> index 56dc08d..91c7137 100644
>> >> >> --- a/arch/arm64/include/uapi/asm/kvm.h
>> >> >> +++ b/arch/arm64/include/uapi/asm/kvm.h
>> >> >> @@ -206,9 +206,12 @@ struct kvm_arch_memory_slot {
>> >> >>                       (0xffffffffULL << KVM_DEV_ARM_VGIC_V3_MPIDR_SHIFT)
>> >> >>  #define   KVM_DEV_ARM_VGIC_OFFSET_SHIFT      0
>> >> >>  #define   KVM_DEV_ARM_VGIC_OFFSET_MASK       (0xffffffffULL << KVM_DEV_ARM_VGIC_OFFSET_SHIFT)
>> >> >> +#define   KVM_DEV_ARM_VGIC_SYSREG_INSTR_MASK (0xffff)
>> >> >>  #define KVM_DEV_ARM_VGIC_GRP_NR_IRQS 3
>> >> >>  #define KVM_DEV_ARM_VGIC_GRP_CTRL    4
>> >> >>  #define KVM_DEV_ARM_VGIC_GRP_REDIST_REGS 5
>> >> >> +#define KVM_DEV_ARM_VGIC_CPU_SYSREGS    6
>> >> >> +
>> >> >>  #define   KVM_DEV_ARM_VGIC_CTRL_INIT 0
>> >> >>
>> >> >>  /* Device Control API on vcpu fd */
>> >> >> diff --git a/arch/arm64/kvm/Makefile b/arch/arm64/kvm/Makefile
>> >> >> index d50a82a..1a14e29 100644
>> >> >> --- a/arch/arm64/kvm/Makefile
>> >> >> +++ b/arch/arm64/kvm/Makefile
>> >> >> @@ -32,5 +32,6 @@ kvm-$(CONFIG_KVM_ARM_HOST) += $(KVM)/arm/vgic/vgic-mmio-v3.o
>> >> >>  kvm-$(CONFIG_KVM_ARM_HOST) += $(KVM)/arm/vgic/vgic-kvm-device.o
>> >> >>  kvm-$(CONFIG_KVM_ARM_HOST) += $(KVM)/arm/vgic/vgic-its.o
>> >> >>  kvm-$(CONFIG_KVM_ARM_HOST) += $(KVM)/irqchip.o
>> >> >> +kvm-$(CONFIG_KVM_ARM_HOST) += $(KVM)/arm/vgic/vgic-sys-reg-v3.o
>> >> >
>> >> > Thi is making me wonder:  Are we properly handling GICv3 save/restore
>> >> > for AArch32 now that we have GICv3 support for AArch32?  By properly I
>> >> > mean that either it is clearly only supported on AArch64 systems or it's
>> >> > supported on both AArch64 and AArch32, but it shouldn't break randomly
>> >> > on AArch32.
>> >>
>> >> It supports both AArch64 and AArch64 in handling of system registers
>> >> save/restore.
>> >> All system registers that we save/restore are 32-bit for both aarch64
>> >> and aarch32.
>> >> Though opcode op0 should be zero for aarch32, the remaining Op and CRn codes
>> >> are same. However the codes sent by qemu is matched and register
>> >> are handled properly irrespective of AArch32 or AArch64.
>> >>
>> >> I don't have platform which support AArch32 guests to verify.
>> >
>> > Actually this is not about the guest, it's about an ARMv8 AArch32 host
>> > that has a GICv3.
>> >
>> > I just tried to do a v7 compile with your patches, and it results in an
>> > epic failure, so there's something for you to look at.
>> >
>>
>> Could you please share you config file?. I tried with multi_v7 defconfig with
>> CONFIG KVM and CONFIG_KVM_ARM_HOST enabled. it compiled for me.
>
> I think this has to do with which branch you apply your patches to.
> When applied to kvmarm/next, it fails.
>
> Here's the integration I did:
> https://git.linaro.org/people/christoffer.dall/linux-kvm-arm.git tmp-gicv3-migrate-v8
>
> Here's the config:
> https://transfer.sh/xkAxp/.config
>

Thanks for shareing the details, I could reproduce them.
However virt/kvm/arm/vgic/vgic-sys-reg-v3.c is written with
sys_regs_desc for AArch64.
For AArch32/v7, it has be to coproc_reg. I propose to add separate file for arm
which handles ICC* reg save/restore using coproc_reg.

> Here's the compile output:
>
> /home/christoffer/src/kvmarm/linux/arch/arm/kvm/../../../virt/kvm/arm/vgic/vgic-mmio-v3.c:26:22: fatal error: sys_regs.h: No such file or directory
>  #include "sys_regs.h"
>                       ^
> compilation terminated.
> make[2]: *** [arch/arm/kvm/../../../virt/kvm/arm/vgic/vgic-mmio-v3.o] Error 1
> make[2]: *** Waiting for unfinished jobs....
> /home/christoffer/src/kvmarm/linux/arch/arm/kvm/../../../virt/kvm/arm/vgic/vgic-kvm-device.c: In function ?vgic_v3_parse_attr?:
> /home/christoffer/src/kvmarm/linux/arch/arm/kvm/../../../virt/kvm/arm/vgic/vgic-kvm-device.c:438:29: error: ?KVM_DEV_ARM_VGIC_V3_MPIDR_MASK? undeclared (first use in this function)
>   vgic_mpidr = (attr->attr & KVM_DEV_ARM_VGIC_V3_MPIDR_MASK) >>
>                              ^
> /home/christoffer/src/kvmarm/linux/arch/arm/kvm/../../../virt/kvm/arm/vgic/vgic-kvm-device.c:438:29: note: each undeclared identifier is reported only once for each function it appears in
> /home/christoffer/src/kvmarm/linux/arch/arm/kvm/../../../virt/kvm/arm/vgic/vgic-kvm-device.c:439:9: error: ?KVM_DEV_ARM_VGIC_V3_MPIDR_SHIFT? undeclared (first use in this function)
>          KVM_DEV_ARM_VGIC_V3_MPIDR_SHIFT;
>          ^
> /home/christoffer/src/kvmarm/linux/arch/arm/kvm/../../../virt/kvm/arm/vgic/vgic-kvm-device.c:441:2: error: implicit declaration of function ?MPIDR_LEVEL_SHIFT? [-Werror=implicit-function-declaration]
>   mpidr_reg = VGIC_TO_MPIDR(vgic_mpidr);
>   ^
> /home/christoffer/src/kvmarm/linux/arch/arm/kvm/../../../virt/kvm/arm/vgic/vgic-kvm-device.c: In function ?vgic_v3_attr_regs_access?:
> /home/christoffer/src/kvmarm/linux/arch/arm/kvm/../../../virt/kvm/arm/vgic/vgic-kvm-device.c:497:7: error: ?KVM_DEV_ARM_VGIC_GRP_REDIST_REGS? undeclared (first use in this function)
>   case KVM_DEV_ARM_VGIC_GRP_REDIST_REGS:
>        ^
> /home/christoffer/src/kvmarm/linux/arch/arm/kvm/../../../virt/kvm/arm/vgic/vgic-kvm-device.c:505:7: error: ?KVM_DEV_ARM_VGIC_CPU_SYSREGS? undeclared (first use in this function)
>   case KVM_DEV_ARM_VGIC_CPU_SYSREGS: {
>        ^
> /home/christoffer/src/kvmarm/linux/arch/arm/kvm/../../../virt/kvm/arm/vgic/vgic-kvm-device.c:508:25: error: ?KVM_DEV_ARM_VGIC_SYSREG_INSTR_MASK? undeclared (first use in this function)
>    regid = (attr->attr & KVM_DEV_ARM_VGIC_SYSREG_INSTR_MASK);
>                          ^
> /home/christoffer/src/kvmarm/linux/arch/arm/kvm/../../../virt/kvm/arm/vgic/vgic-kvm-device.c:513:7: error: ?KVM_DEV_ARM_VGIC_GRP_LEVEL_INFO? undeclared (first use in this function)
>   case KVM_DEV_ARM_VGIC_GRP_LEVEL_INFO: {
>        ^
> /home/christoffer/src/kvmarm/linux/arch/arm/kvm/../../../virt/kvm/arm/vgic/vgic-kvm-device.c:516:24: error: ?KVM_DEV_ARM_VGIC_LINE_LEVEL_INFO_MASK? undeclared (first use in this function)
>    info = (attr->attr & KVM_DEV_ARM_VGIC_LINE_LEVEL_INFO_MASK) >>
>                         ^
> /home/christoffer/src/kvmarm/linux/arch/arm/kvm/../../../virt/kvm/arm/vgic/vgic-kvm-device.c:517:4: error: ?KVM_DEV_ARM_VGIC_LINE_LEVEL_INFO_SHIFT? undeclared (first use in this function)
>     KVM_DEV_ARM_VGIC_LINE_LEVEL_INFO_SHIFT;
>     ^
> /home/christoffer/src/kvmarm/linux/arch/arm/kvm/../../../virt/kvm/arm/vgic/vgic-kvm-device.c:518:15: error: ?VGIC_LEVEL_INFO_LINE_LEVEL? undeclared (first use in this function)
>    if (info == VGIC_LEVEL_INFO_LINE_LEVEL) {
>                ^
> /home/christoffer/src/kvmarm/linux/arch/arm/kvm/../../../virt/kvm/arm/vgic/vgic-kvm-device.c:522:5: error: ?KVM_DEV_ARM_VGIC_LINE_LEVEL_INTID_MASK? undeclared (first use in this function)
>      KVM_DEV_ARM_VGIC_LINE_LEVEL_INTID_MASK;
>      ^
> /home/christoffer/src/kvmarm/linux/arch/arm/kvm/../../../virt/kvm/arm/vgic/vgic-kvm-device.c: In function ?vgic_v3_set_attr?:
> /home/christoffer/src/kvmarm/linux/arch/arm/kvm/../../../virt/kvm/arm/vgic/vgic-kvm-device.c:554:7: error: ?KVM_DEV_ARM_VGIC_GRP_REDIST_REGS? undeclared (first use in this function)
>   case KVM_DEV_ARM_VGIC_GRP_REDIST_REGS: {
>        ^
> /home/christoffer/src/kvmarm/linux/arch/arm/kvm/../../../virt/kvm/arm/vgic/vgic-kvm-device.c:565:7: error: ?KVM_DEV_ARM_VGIC_CPU_SYSREGS? undeclared (first use in this function)
>   case KVM_DEV_ARM_VGIC_CPU_SYSREGS: {
>        ^
> /home/christoffer/src/kvmarm/linux/arch/arm/kvm/../../../virt/kvm/arm/vgic/vgic-kvm-device.c:574:7: error: ?KVM_DEV_ARM_VGIC_GRP_LEVEL_INFO? undeclared (first use in this function)
>   case KVM_DEV_ARM_VGIC_GRP_LEVEL_INFO: {
>        ^
> /home/christoffer/src/kvmarm/linux/arch/arm/kvm/../../../virt/kvm/arm/vgic/vgic-kvm-device.c: In function ?vgic_v3_get_attr?:
> /home/christoffer/src/kvmarm/linux/arch/arm/kvm/../../../virt/kvm/arm/vgic/vgic-kvm-device.c:600:7: error: ?KVM_DEV_ARM_VGIC_GRP_REDIST_REGS? undeclared (first use in this function)
>   case KVM_DEV_ARM_VGIC_GRP_REDIST_REGS: {
>        ^
> /home/christoffer/src/kvmarm/linux/arch/arm/kvm/../../../virt/kvm/arm/vgic/vgic-kvm-device.c:611:7: error: ?KVM_DEV_ARM_VGIC_CPU_SYSREGS? undeclared (first use in this function)
>   case KVM_DEV_ARM_VGIC_CPU_SYSREGS: {
>        ^
> /home/christoffer/src/kvmarm/linux/arch/arm/kvm/../../../virt/kvm/arm/vgic/vgic-kvm-device.c:620:7: error: ?KVM_DEV_ARM_VGIC_GRP_LEVEL_INFO? undeclared (first use in this function)
>   case KVM_DEV_ARM_VGIC_GRP_LEVEL_INFO: {
>        ^
> /home/christoffer/src/kvmarm/linux/arch/arm/kvm/../../../virt/kvm/arm/vgic/vgic-kvm-device.c: In function ?vgic_v3_has_attr?:
> /home/christoffer/src/kvmarm/linux/arch/arm/kvm/../../../virt/kvm/arm/vgic/vgic-kvm-device.c:647:7: error: ?KVM_DEV_ARM_VGIC_GRP_REDIST_REGS? undeclared (first use in this function)
>   case KVM_DEV_ARM_VGIC_GRP_REDIST_REGS:
>        ^
> /home/christoffer/src/kvmarm/linux/arch/arm/kvm/../../../virt/kvm/arm/vgic/vgic-kvm-device.c:648:7: error: ?KVM_DEV_ARM_VGIC_CPU_SYSREGS? undeclared (first use in this function)
>   case KVM_DEV_ARM_VGIC_CPU_SYSREGS:
>        ^
> /home/christoffer/src/kvmarm/linux/arch/arm/kvm/../../../virt/kvm/arm/vgic/vgic-kvm-device.c:652:7: error: ?KVM_DEV_ARM_VGIC_GRP_LEVEL_INFO? undeclared (first use in this function)
>   case KVM_DEV_ARM_VGIC_GRP_LEVEL_INFO: {
>        ^
> /home/christoffer/src/kvmarm/linux/arch/arm/kvm/../../../virt/kvm/arm/vgic/vgic-kvm-device.c:653:22: error: ?KVM_DEV_ARM_VGIC_LINE_LEVEL_INFO_MASK? undeclared (first use in this function)
>    if (((attr->attr & KVM_DEV_ARM_VGIC_LINE_LEVEL_INFO_MASK) >>
>                       ^
> /home/christoffer/src/kvmarm/linux/arch/arm/kvm/../../../virt/kvm/arm/vgic/vgic-kvm-device.c:654:9: error: ?KVM_DEV_ARM_VGIC_LINE_LEVEL_INFO_SHIFT? undeclared (first use in this function)
>          KVM_DEV_ARM_VGIC_LINE_LEVEL_INFO_SHIFT) ==
>          ^
> /home/christoffer/src/kvmarm/linux/arch/arm/kvm/../../../virt/kvm/arm/vgic/vgic-kvm-device.c:655:9: error: ?VGIC_LEVEL_INFO_LINE_LEVEL? undeclared (first use in this function)
>          VGIC_LEVEL_INFO_LINE_LEVEL)
>          ^
> cc1: some warnings being treated as errors
> make[2]: *** [arch/arm/kvm/../../../virt/kvm/arm/vgic/vgic-kvm-device.o] Error 1
> make[1]: *** [arch/arm/kvm] Error 2
> make[1]: *** Waiting for unfinished jobs....
> make: *** [sub-make] Error 2
>
> Thanks,
> -Christoffer
