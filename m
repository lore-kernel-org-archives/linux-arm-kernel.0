From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 02 Oct 2012 12:25:25 +0200
Subject: [PATCH v2 08/10] ARM: KVM: VGIC initialisation code
In-Reply-To: <20121002092412.GB8847@mudshark.cambridge.arm.com>
References: <20121001091244.49503.96318.stgit@ubuntu>
 <20121001091426.49503.94722.stgit@ubuntu>
 <20121002092412.GB8847@mudshark.cambridge.arm.com>
Message-ID: <b4b11d71544812cff978b3457a99b90e@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2 Oct 2012 10:24:13 +0100, Will Deacon <will.deacon@arm.com>
wrote:
> On Mon, Oct 01, 2012 at 10:14:26AM +0100, Christoffer Dall wrote:
>> From: Marc Zyngier <marc.zyngier@arm.com>
>> 
>> Add the init code for the hypervisor, the virtual machine, and
>> the virtual CPUs.
>> 
>> An interrupt handler is also wired to allow the VGIC maintenance
>> interrupts, used to deal with level triggered interrupts and LR
>> underflows.
>> 
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
>> ---
> 
> [...]
> 
>> diff --git a/arch/arm/kvm/vgic.c b/arch/arm/kvm/vgic.c
>> index b52d4c2..fc2a138 100644
>> --- a/arch/arm/kvm/vgic.c
>> +++ b/arch/arm/kvm/vgic.c
>> @@ -20,7 +20,14 @@
>>  #include <linux/kvm_host.h>
>>  #include <linux/interrupt.h>
>>  #include <linux/io.h>
>> +#include <linux/of.h>
>> +#include <linux/of_address.h>
>> +#include <linux/of_irq.h>
>> +
>>  #include <asm/kvm_emulate.h>
>> +#include <asm/hardware/gic.h>
>> +#include <asm/kvm_arm.h>
>> +#include <asm/kvm_mmu.h>
>>  
>>  /*
>>   * How the whole thing works (courtesy of Christoffer Dall):
>> @@ -61,6 +68,13 @@
>>  /* Temporary hacks, need to be provided by userspace emulation */
>>  #define VGIC_DIST_BASE		0x2c001000
>>  #define VGIC_DIST_SIZE		0x1000
>> +#define VGIC_CPU_BASE		0x2c002000
>> +#define VGIC_CPU_SIZE		0x2000
> 
> We really don't want the physical memory map for the guest hardwired in
the
> kernel. Please find a way to parameterise this from userspace.

Yes, this is a known problem. KVM doesn't offer a standard way of passing
the address of an interrupt controller (none of the other architectures
have it memory mapped).

We probably need a separate ioctl for that...

        M.
-- 
Fast, cheap, reliable. Pick two.
