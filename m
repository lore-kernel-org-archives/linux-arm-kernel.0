From: wuyun.wu@huawei.com (Abel)
Date: Wed, 11 Jun 2014 10:58:49 +0800
Subject: [PATCH v4 00/20] arm64: GICv3 support
In-Reply-To: <5397B5B4.9030601@huawei.com>
References: <1400176719-31275-1-git-send-email-marc.zyngier@arm.com>
 <5397B5B4.9030601@huawei.com>
Message-ID: <5397C5E9.4090406@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014/6/11 9:49, Abel wrote:

> Hi Marc,
> 
> Add:
> Reviewed-by: Yun Wu <wuyun.wu@huawei.com>
> Acked-by: Zhen Lei <thunder.leizhen@huawei.com>

s/Acked/Reviewed/ :)

> 
> for the first 4 patches, that is:
>>   ARM: GIC: move some bits of GICv2 to a library-type file
>>   arm64: initial support for GICv3
>>   arm64: GICv3 device tree binding documentation
>>   arm64: boot protocol documentation update for GICv3
> 
> Cheers,
> Abel.
> 
> On 2014/5/16 1:58, Marc Zyngier wrote:
> 
>> GICv3 is the base for a new generation of interrupt controllers
>> designed to overcome some of the most glaring limitations of GICv2.
>>
>> Some of the features are:
>> - Support for more than 8 CPUs (a lot more...)
>> - System registers for CPU interface access (instead of the memory
>>   mapped GICC, GICV, GICH)
>> - Message based interrupts
>>
>> This patch series currently support:
>> - Affinity Routing
>> - System Registers
>> - Non-Secure Group-1 interrupts only
>> - KVM support (GICv3 host, GICv2 guest)
>>
>> What is *not yet* supported in this series (WIP):
>> - LPI/ITS/MSI
>> - KVM GICv3 guest support
>> - Any form of power management
>> - 32bit systems
>>
>> To be built, this code requires a fairly recent compiler/binutils
>> combo. Linaro 13.06 seems to do the trick. This has been tested on the
>> ARM FVP and Foundation models, with non-regressions run on a VExpress
>> TC-2 and another Cortex-A57 based platform.
>>
>> So far, the level of reviewing has been embarassingly low (my sincere
>> thanks to Christoffer and Will for being the only ones to review
>> it). While the documentation is unfortunately not public yet, it is
>> available to those actively implementing GICv3 in their hardware, and
>> I'm really eager to see reviews and test reports.
>>
>> Without that kind of engagement, it is unlikely that this code will
>> get merged any time soon.
>>
>> Individuals without access to documentation and/or hardware can still
>> review the code (it shares a lot of concepts with GICv2) and test in
>> on the freely available Foundation model (see
>> http://releases.linaro.org/latest/openembedded/aarch64/ for details on
>> how to use the Foundation model).
>>
>> The code is also available at the following location (warning,
>> unstable branch!):
>> git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git kvm-arm64/gicv3
>>
>> * From v3 [3]
>>   - Fixed a lot of issues found by Christoffer (too many to report
>>     here, see the email thread)
>>   - New .sync_lr_elrsr backend
>>   - New probing method
>>   - New irqchip_in_kernel implementation
>>   - Checked full bisectability of the series (hopefully got it right
>>     this time...)
>>   - rebased on top of 3.15-rc5
>>
>> * From v2 [2]
>>   - removed sharing of the xlate method with GICv2 (TI crossbar is now
>>     getting in the way...)
>>   - Switched to a tree domain to accomodate for the LPI space
>>   - Fixed more bisectability
>>
>> * From the initial revision [1]
>>   - Some code sharing with GICv2
>>   - Barrier cleanup/clarification
>>   - Revised boot protocol update
>>   - Consistent use of the MPIDR access macros
>>   - Fixed a number of embarassing bugs
>>   - Fixed DT examples
>>   - Fixed bisectability of the series
>>
>> [1]: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-February/229959.html
>> [2]: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-March/241972.html
>> [3]: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-April/248008.html
>>
>> Marc Zyngier (20):
>>   ARM: GIC: move some bits of GICv2 to a library-type file
>>   arm64: initial support for GICv3
>>   arm64: GICv3 device tree binding documentation
>>   arm64: boot protocol documentation update for GICv3
>>   KVM: arm/arm64: vgic: move GICv2 registers to their own structure
>>   KVM: ARM: vgic: introduce vgic_ops and LR manipulation primitives
>>   KVM: ARM: vgic: abstract access to the ELRSR bitmap
>>   KVM: ARM: vgic: abstract EISR bitmap access
>>   KVM: ARM: vgic: abstract MISR decoding
>>   KVM: ARM: vgic: move underflow handling to vgic_ops
>>   KVM: ARM: vgic: abstract VMCR access
>>   KVM: ARM: vgic: introduce vgic_enable
>>   KVM: ARM: introduce vgic_params structure
>>   KVM: ARM: vgic: split GICv2 backend from the main vgic code
>>   KVM: ARM: vgic: revisit implementation of irqchip_in_kernel
>>   arm64: KVM: remove __kvm_hyp_code_{start,end} from hyp.S
>>   arm64: KVM: split GICv2 world switch from hyp code
>>   arm64: KVM: move HCR_EL2.{IMO,FMO} manipulation into the vgic switch
>>     code
>>   KVM: ARM: vgic: add the GICv3 backend
>>   arm64: KVM: vgic: add GICv3 world switch
>>
>>  Documentation/arm64/booting.txt                  |   6 +
>>  Documentation/devicetree/bindings/arm/gic-v3.txt |  79 +++
>>  arch/arm/include/asm/kvm_host.h                  |   5 +
>>  arch/arm/kernel/asm-offsets.c                    |  14 +-
>>  arch/arm/kvm/Makefile                            |   1 +
>>  arch/arm/kvm/interrupts_head.S                   |  26 +-
>>  arch/arm64/Kconfig                               |   1 +
>>  arch/arm64/include/asm/kvm_arm.h                 |   5 +-
>>  arch/arm64/include/asm/kvm_asm.h                 |  14 +-
>>  arch/arm64/include/asm/kvm_host.h                |  28 +
>>  arch/arm64/include/asm/virt.h                    |   4 +
>>  arch/arm64/kernel/asm-offsets.c                  |  25 +-
>>  arch/arm64/kernel/head.S                         |  18 +
>>  arch/arm64/kernel/hyp-stub.S                     |   1 +
>>  arch/arm64/kvm/Makefile                          |   4 +
>>  arch/arm64/kvm/hyp.S                             | 127 +----
>>  arch/arm64/kvm/vgic-v2-switch.S                  | 133 +++++
>>  arch/arm64/kvm/vgic-v3-switch.S                  | 271 +++++++++
>>  drivers/irqchip/Kconfig                          |   5 +
>>  drivers/irqchip/Makefile                         |   3 +-
>>  drivers/irqchip/irq-gic-common.c                 | 115 ++++
>>  drivers/irqchip/irq-gic-common.h                 |  29 +
>>  drivers/irqchip/irq-gic-v3.c                     | 684 +++++++++++++++++++++++
>>  drivers/irqchip/irq-gic.c                        |  59 +-
>>  include/kvm/arm_vgic.h                           | 115 +++-
>>  include/linux/irqchip/arm-gic-v3.h               | 190 +++++++
>>  virt/kvm/arm/vgic-v2.c                           | 236 ++++++++
>>  virt/kvm/arm/vgic-v3.c                           | 225 ++++++++
>>  virt/kvm/arm/vgic.c                              | 345 ++++++------
>>  29 files changed, 2415 insertions(+), 353 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/arm/gic-v3.txt
>>  create mode 100644 arch/arm64/kvm/vgic-v2-switch.S
>>  create mode 100644 arch/arm64/kvm/vgic-v3-switch.S
>>  create mode 100644 drivers/irqchip/irq-gic-common.c
>>  create mode 100644 drivers/irqchip/irq-gic-common.h
>>  create mode 100644 drivers/irqchip/irq-gic-v3.c
>>  create mode 100644 include/linux/irqchip/arm-gic-v3.h
>>  create mode 100644 virt/kvm/arm/vgic-v2.c
>>  create mode 100644 virt/kvm/arm/vgic-v3.c
>>
> 
> 
