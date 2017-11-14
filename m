From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Tue, 14 Nov 2017 17:33:46 +0100
Subject: arm64: next-20171114 GICv4 build failure
In-Reply-To: <e263a122-440f-2d03-1f1e-652057ef73be@arm.com>
References: <0f80d433-1018-6ae5-ec19-47d9af1576e4@suse.de>
 <e263a122-440f-2d03-1f1e-652057ef73be@arm.com>
Message-ID: <03ed026b-3737-bbb6-aa76-fe5f551272fa@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 14.11.2017 um 13:24 schrieb Marc Zyngier:
> On 14/11/17 11:46, Andreas F?rber wrote:
>> Yesterday's and today's linux-next fail to build for me on arm64 with
>> the following warnings and errors:
>>
>>   CC      arch/arm64/kvm/hyp/switch.o
>>   CC      mm/shmem.o
>>   CC      fs/super.o
>>   CC      kernel/ucount.o
>> In file included from ../include/kvm/arm_vgic.h:29:0,
>>                  from ../arch/arm64/include/asm/kvm_host.h:38,
>>                  from ../include/linux/kvm_host.h:37,
>>                  from ../arch/arm64/include/asm/kvm_emulate.h:25,
>>                  from ../arch/arm64/kvm/hyp/switch.c:22:
>> ../include/linux/irqchip/arm-gic-v4.h:112:57: warning: 'struct
>> irq_domain_ops' declared inside parameter list will not be visible
>> outside of this definition or declaration
>>  int its_init_v4(struct irq_domain *domain, const struct irq_domain_ops
>> *ops);
>>                                                          ^~~~~~~~~~~~~~
>> [...]
>>
>>   LD      vmlinux.o
>>   MODPOST vmlinux.o
>> virt/kvm/arm/vgic/vgic-v4.o: In function `vgic_v4_teardown':
>> /home/andreas/MCU/ARM/Bubblegum-96/linux/s900/../arch/arm64/kvm/../../../virt/kvm/arm/vgic/vgic-v4.c:200:
>> undefined reference to `its_free_vcpu_irqs'
>> /home/andreas/MCU/ARM/Bubblegum-96/linux/s900/../arch/arm64/kvm/../../../virt/kvm/arm/vgic/vgic-v4.c:200:(.text+0x80):
>> relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol
[...]
>> /home/andreas/MCU/ARM/Bubblegum-96/linux/Makefile:993: recipe for target
>> 'vmlinux' failed
>> make[1]: *** [vmlinux] Error 1
>> make[1]: Leaving directory '/home/andreas/MCU/ARM/Bubblegum-96/linux/s900'
>> Makefile:146: recipe for target 'sub-make' failed
>> make: *** [sub-make] Error 2
>>
>> I'm guessing there's some Kconfig or guard issue? No GICv4 options
>> popped up during oldconfig. And my arm config still builds fine.
> 
> GICv4 is not optional. You'll get it no matter what... ;-) In your
> cases, it fails because you probably don't have PCI selected (why PCI is
> optional is a different story...).

Confirming:

$ grep PCI s900/.config
# CONFIG_PCI is not set
# CONFIG_PCI_DOMAINS is not set
# CONFIG_PCI_DOMAINS_GENERIC is not set
# CONFIG_PCI_SYSCALL is not set
CONFIG_PCI_LABEL=y
# DesignWare PCI Core Support
# PCI Endpoint
# CONFIG_PCI_ENDPOINT is not set
# CONFIG_I2C_PXA_PCI is not set
# CONFIG_SPI_PXA2XX_PCI is not set
CONFIG_GENERIC_PCI_IOMAP=y

This board's SoC (Actions S900) does not support PCI.

> I've pushed out some fixes yesterday[1], which should reach -next at
> some point. Please give it a go and let me know if that helps.

"irqchip/gic-v4: Add forward definition of struct irq_domain_ops" and
"irqchip/gic-v3-its: Remove artificial dependency on PCI" indeed fix
these issues.

Thanks for the quick response,

Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
