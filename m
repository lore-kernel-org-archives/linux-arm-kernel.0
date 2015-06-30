From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 30 Jun 2015 11:34:59 +0100
Subject: Regular oops on shutdown of KVM/ARM64 machines with VGA device
In-Reply-To: <CAL5wTH7EUh0ciutXKs2s-4VjKnRM65QmrUQQiRdM=R+_VXi6DA@mail.gmail.com>
References: <CAL5wTH4MtybHBk22r593HmVX+2jqCDm4fb2MyT2L0TMkHrD7pg@mail.gmail.com>	<20150629100304.GB18931@leverpostej>	<55914033.5060008@arm.com>
 <CAL5wTH7EUh0ciutXKs2s-4VjKnRM65QmrUQQiRdM=R+_VXi6DA@mail.gmail.com>
Message-ID: <559270D3.8030305@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/06/15 08:54, Dirk M?ller wrote:
> Hi Marc,
> 
>> Also, care to provide some hints about your kernel configuration?
> 
> I believe the relevant parameters are:
> 
> CONFIG_PGTABLE_LEVELS=4
> # CONFIG_ARM64_64K_PAGES is not set
> # CONFIG_ARM64_VA_BITS_39 is not set
> CONFIG_ARM64_VA_BITS_48=y
> CONFIG_ARM64_VA_BITS=48
> CONFIG_KVM_MMIO=y
> CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
> CONFIG_KVM_COMPAT=y
> CONFIG_VIRTUALIZATION=y
> CONFIG_KVM=y
> CONFIG_KVM_ARM_HOST=y
> CONFIG_KVM_ARM_MAX_VCPUS=4
> 
> 
> the full config is here: http://pastebin.com/raw.php?i=GKAaVLYE
> 
>> What is the VGA device you mention in $subject?
>> A QEMU command line so that we can try and reproduce the issue you're
>> seeing?
> 
> with qemu 2.3.0:
> 
> qemu-system-aarch64 --enable-kvm -M virt -cpu host -vnc :4 -bios
> /usr/share/qemu/qemu-uefi-aarch64.bin -m 1G -device VGA
> 
> then connecting to the vnc to cause the VGA device to be initialized,
> and then simply ctrl-c'ing the qemu process, you'll get this crash
> 100% of each and every time. If you want additional debug output or
> try out something, just let me know and I'll be happy to provide you
> with it.

Can try the following patch?

diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index 7b42012..d902a53 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -109,7 +109,7 @@ static void kvm_flush_dcache_pud(pud_t pud)
  */
 static void stage2_dissolve_pmd(struct kvm *kvm, phys_addr_t addr, pmd_t *pmd)
 {
-	if (!kvm_pmd_huge(*pmd))
+	if (pmd_none(*pmd) || !kvm_pmd_huge(*pmd))
 		return;
 
 	pmd_clear(pmd);


It seems to fix the issue for me, though with a relatively different
configuration.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
