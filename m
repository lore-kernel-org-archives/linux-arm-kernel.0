From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 12 Dec 2014 16:52:31 +0000
Subject: [PATCH 0/4] GICv3: add 32bit compatibility
In-Reply-To: <548B1A47.7060301@arm.com>
References: <1418307788-17977-1-git-send-email-jean-philippe.brucker@arm.com>
 <548B1A47.7060301@arm.com>
Message-ID: <548B1D4F.4030701@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/12/14 16:39, Andre Przywara wrote:
> Hi Jean-Philippe,
> 
> On 11/12/14 14:23, Jean-Philippe Brucker wrote:
>> This series adds 32bit compatibility to Marc's GICv3 driver. Only SGIs,
>> PPIs and SPIs support is present. No ITS nor virtualisation.
>>
>> It is based on 3.18.
>>
>> Jean-Philippe Brucker (4):
>>   arm64: GICv3: refactor the AArch64 specific parts
>>   arm64: GICv3: change unsigned types for AArch32 compatibility
>>   arm64: GICv3: Specialize readq and writeq accesses
>>   ARM: add 32bit support to GICv3
>>
>>  arch/arm/include/asm/arch_gicv3.h   | 182 ++++++++++++++++++++++++++++++++++++
>>  arch/arm64/include/asm/arch_gicv3.h | 141 ++++++++++++++++++++++++++++
>>  drivers/irqchip/irq-gic-v3.c        |  69 ++++----------
>>  include/linux/irqchip/arm-gic-v3.h  |  95 +++----------------
>>  4 files changed, 356 insertions(+), 131 deletions(-)
>>  create mode 100644 arch/arm/include/asm/arch_gicv3.h
>>  create mode 100644 arch/arm64/include/asm/arch_gicv3.h
> 
> so if I compile this with CONFIG_KVM_ARM_VGIC on, I get a compilation error:
>   LD      init/built-in.o
> arch/arm/kvm/built-in.o: In function `svc_die_str':
> arch_timer.c:(.rodata+0xf7c): undefined reference to `vgic_v3_probe'
> make[2]: *** [vmlinux] Error 1
> 
> The svc_die_str reference is probably bogus, but if I protect the
> vgic_v3_probe reference in virt/kvm/arm/vgic.c with "#ifdef ARM64" it
> compiles fine. Disabling CONFIG_KVM_ARM_VGIC in the .config also fixes
> this also.

That's an absolute no-no. I want to be able to run the exact same kernel
as a KVM host *and* a guest. So disabling the vgic can never be the
right solution.

Either wrapping the vgic_v3_probe reference with CONFIG_ARM64 or having
a non "static inline" vgic_v3_probe for 32bit are acceptable solutions.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
