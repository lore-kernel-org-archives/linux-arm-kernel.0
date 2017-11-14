From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 14 Nov 2017 12:24:30 +0000
Subject: arm64: next-20171114 GICv4 build failure
In-Reply-To: <0f80d433-1018-6ae5-ec19-47d9af1576e4@suse.de>
References: <0f80d433-1018-6ae5-ec19-47d9af1576e4@suse.de>
Message-ID: <e263a122-440f-2d03-1f1e-652057ef73be@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[please keep me on cc for anything GIC or KVM related, thanks]

On 14/11/17 11:46, Andreas F?rber wrote:
> Hello,
> 
> Yesterday's and today's linux-next fail to build for me on arm64 with
> the following warnings and errors:
> 
>   CC      arch/arm64/kvm/hyp/switch.o
>   CC      mm/shmem.o
>   CC      fs/super.o
>   CC      kernel/ucount.o
> In file included from ../include/kvm/arm_vgic.h:29:0,
>                  from ../arch/arm64/include/asm/kvm_host.h:38,
>                  from ../include/linux/kvm_host.h:37,
>                  from ../arch/arm64/include/asm/kvm_emulate.h:25,
>                  from ../arch/arm64/kvm/hyp/switch.c:22:
> ../include/linux/irqchip/arm-gic-v4.h:112:57: warning: 'struct
> irq_domain_ops' declared inside parameter list will not be visible
> outside of this definition or declaration
>  int its_init_v4(struct irq_domain *domain, const struct irq_domain_ops
> *ops);
>                                                          ^~~~~~~~~~~~~~
> [...]
> 
>   LD      vmlinux.o
>   MODPOST vmlinux.o
> virt/kvm/arm/vgic/vgic-v4.o: In function `vgic_v4_teardown':
> /home/andreas/MCU/ARM/Bubblegum-96/linux/s900/../arch/arm64/kvm/../../../virt/kvm/arm/vgic/vgic-v4.c:200:
> undefined reference to `its_free_vcpu_irqs'
> /home/andreas/MCU/ARM/Bubblegum-96/linux/s900/../arch/arm64/kvm/../../../virt/kvm/arm/vgic/vgic-v4.c:200:(.text+0x80):
> relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol
> `its_free_vcpu_irqs'
> virt/kvm/arm/vgic/vgic-v4.o: In function `vgic_v4_init':
> /home/andreas/MCU/ARM/Bubblegum-96/linux/s900/../arch/arm64/kvm/../../../virt/kvm/arm/vgic/vgic-v4.c:139:
> undefined reference to `its_alloc_vcpu_irqs'
> /home/andreas/MCU/ARM/Bubblegum-96/linux/s900/../arch/arm64/kvm/../../../virt/kvm/arm/vgic/vgic-v4.c:139:(.text+0x178):
> relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol
> `its_alloc_vcpu_irqs'
> virt/kvm/arm/vgic/vgic-v4.o: In function `vgic_v4_sync_hwstate':
> /home/andreas/MCU/ARM/Bubblegum-96/linux/s900/../arch/arm64/kvm/../../../virt/kvm/arm/vgic/vgic-v4.c:211:
> undefined reference to `its_schedule_vpe'
> /home/andreas/MCU/ARM/Bubblegum-96/linux/s900/../arch/arm64/kvm/../../../virt/kvm/arm/vgic/vgic-v4.c:211:(.text+0x2b8):
> relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol
> `its_schedule_vpe'
> virt/kvm/arm/vgic/vgic-v4.o: In function `vgic_v4_flush_hwstate':
> /home/andreas/MCU/ARM/Bubblegum-96/linux/s900/../arch/arm64/kvm/../../../virt/kvm/arm/vgic/vgic-v4.c:232:
> undefined reference to `its_schedule_vpe'
> /home/andreas/MCU/ARM/Bubblegum-96/linux/s900/../arch/arm64/kvm/../../../virt/kvm/arm/vgic/vgic-v4.c:232:(.text+0x338):
> relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol
> `its_schedule_vpe'
> virt/kvm/arm/vgic/vgic-v4.o: In function `kvm_vgic_v4_set_forwarding':
> /home/andreas/MCU/ARM/Bubblegum-96/linux/s900/../arch/arm64/kvm/../../../virt/kvm/arm/vgic/vgic-v4.c:302:
> undefined reference to `its_map_vlpi'
> /home/andreas/MCU/ARM/Bubblegum-96/linux/s900/../arch/arm64/kvm/../../../virt/kvm/arm/vgic/vgic-v4.c:302:(.text+0x464):
> relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol
> `its_map_vlpi'
> virt/kvm/arm/vgic/vgic-v4.o: In function `kvm_vgic_v4_unset_forwarding':
> /home/andreas/MCU/ARM/Bubblegum-96/linux/s900/../arch/arm64/kvm/../../../virt/kvm/arm/vgic/vgic-v4.c:341:
> undefined reference to `its_unmap_vlpi'
> /home/andreas/MCU/ARM/Bubblegum-96/linux/s900/../arch/arm64/kvm/../../../virt/kvm/arm/vgic/vgic-v4.c:341:(.text+0x56c):
> relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol
> `its_unmap_vlpi'
> virt/kvm/arm/vgic/vgic-its.o: In function `update_lpi_config':
> /home/andreas/MCU/ARM/Bubblegum-96/linux/s900/../arch/arm64/kvm/../../../virt/kvm/arm/vgic/vgic-its.c:304:
> undefined reference to `its_prop_update_vlpi'
> /home/andreas/MCU/ARM/Bubblegum-96/linux/s900/../arch/arm64/kvm/../../../virt/kvm/arm/vgic/vgic-its.c:304:(.text+0x338):
> relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol
> `its_prop_update_vlpi'
> virt/kvm/arm/vgic/vgic-its.o: In function `its_free_ite':
> /home/andreas/MCU/ARM/Bubblegum-96/linux/s900/../arch/arm64/kvm/../../../virt/kvm/arm/vgic/vgic-its.c:656:
> undefined reference to `its_unmap_vlpi'
> /home/andreas/MCU/ARM/Bubblegum-96/linux/s900/../arch/arm64/kvm/../../../virt/kvm/arm/vgic/vgic-its.c:656:(.text+0x390):
> relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol
> `its_unmap_vlpi'
> virt/kvm/arm/vgic/vgic-its.o: In function `update_affinity':
> /home/andreas/MCU/ARM/Bubblegum-96/linux/s900/../arch/arm64/kvm/../../../virt/kvm/arm/vgic/vgic-its.c:356:
> undefined reference to `its_get_vlpi'
> /home/andreas/MCU/ARM/Bubblegum-96/linux/s900/../arch/arm64/kvm/../../../virt/kvm/arm/vgic/vgic-its.c:356:(.text+0x128c):
> relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol
> `its_get_vlpi'
> /home/andreas/MCU/ARM/Bubblegum-96/linux/s900/../arch/arm64/kvm/../../../virt/kvm/arm/vgic/vgic-its.c:362:
> undefined reference to `its_map_vlpi'
> /home/andreas/MCU/ARM/Bubblegum-96/linux/s900/../arch/arm64/kvm/../../../virt/kvm/arm/vgic/vgic-its.c:362:(.text+0x12a4):
> relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol
> `its_map_vlpi'
> virt/kvm/arm/vgic/vgic-its.o: In function `vgic_its_cmd_handle_invall':
> /home/andreas/MCU/ARM/Bubblegum-96/linux/s900/../arch/arm64/kvm/../../../virt/kvm/arm/vgic/vgic-its.c:1165:
> undefined reference to `its_invall_vpe'
> /home/andreas/MCU/ARM/Bubblegum-96/linux/s900/../arch/arm64/kvm/../../../virt/kvm/arm/vgic/vgic-its.c:1165:(.text+0x1d48):
> additional relocation overflows omitted from the output
> /home/andreas/MCU/ARM/Bubblegum-96/linux/Makefile:993: recipe for target
> 'vmlinux' failed
> make[1]: *** [vmlinux] Error 1
> make[1]: Leaving directory '/home/andreas/MCU/ARM/Bubblegum-96/linux/s900'
> Makefile:146: recipe for target 'sub-make' failed
> make: *** [sub-make] Error 2
> 
> I'm guessing there's some Kconfig or guard issue? No GICv4 options
> popped up during oldconfig. And my arm config still builds fine.

GICv4 is not optional. You'll get it no matter what... ;-) In your
cases, it fails because you probably don't have PCI selected (why PCI is
optional is a different story...).

I've pushed out some fixes yesterday[1], which should reach -next at
some point. Please give it a go and let me know if that helps.

Thanks,

	M.

[1]:
https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/log/?h=irq/irqchip-4.15
-- 
Jazz is not dead. It just smells funny...
