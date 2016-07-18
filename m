From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Mon, 18 Jul 2016 14:09:46 +0100
Subject: [PATCH 0/7] ARM: KVM: Support for vgic-v3
In-Reply-To: <20160718123941.76xfvhdgxebjqlm6@kamzik.localdomain>
References: <1468838899-34909-1-git-send-email-vladimir.murzin@arm.com>
 <20160718123941.76xfvhdgxebjqlm6@kamzik.localdomain>
Message-ID: <578CD51A.7060303@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/07/16 13:39, Andrew Jones wrote:
> On Mon, Jul 18, 2016 at 11:48:12AM +0100, Vladimir Murzin wrote:
>> Hi,
>>
>> This is an attempt to make use vgic-v3 under arch/arm since save-restore
>> functionality got re-written in C and can be shared between arm/arm64
>> like it has already been done for vgic-v2 and timer.
>>
>> With this patches I'm able to get 32 core ARMv7 guest boot:
>>
>> ...
>> GICv3: CPU31: found redistributor 703 region 0:0x000000003ffd0000
>> CPU31: thread -1, cpu 3, socket 7, mpidr 80000703
>> Brought up 32 CPUs
>> SMP: Total of 32 processors activated (768.00 BogoMIPS).
>> CPU: All CPU(s) started in SVC mode.
>> ...
>>
>> Additionally, quite lightweight test based on Self IPI guest test[1]
>> has been run with up to 255 cpus.
>>
>> [1] http://www.spinics.net/lists/kvm/msg128974.html
> 
> Would you mind also trying my arm/gic branch for kvm-unit-tests?
> 
> Patch series here
> http://www.spinics.net/lists/kvm/msg135692.html
> 
> Branch here
> https://github.com/rhdrjones/kvm-unit-tests/commits/arm/gic
> 
> As it uses QEMU's mach-virt machine type you'll only be able to
> configure a max of 123 cpus, which can be done as follows
> 
>  export QEMU=/path/to/qemu-system-arm
>  $QEMU -machine virt,accel=kvm,gic-version=3 -cpu host \
>   -device virtio-serial-device \
>   -device virtconsole,chardev=ctd -chardev testdev,id=ctd \
>   -display none -serial stdio \
>   -kernel arm/gic.flat \
>   -smp 123 -append ipi
> 
> Build on an arm host with ./configure && make
> 

Thanks for suggestion! Unfortunately, my test environment is
constrained, so I cannot test your branch as is. However, what I did in
a past was "hacking" kvm-unit-test to support gic along with kvmtool to
support testdev... I'm quite limited in bandwidth to look at this again,
but might find some time to come back to it in a future, given that gic
part is already done ;)

Cheers
Vladimir

> Thanks,
> drew
> 
>>
>> Thanks!
>>
>> Vladimir Murzin (7):
>>   arm64: KVM: Move GIC accessors to arch_gicv3.h
>>   arm64: KVM: Move vgic-v3 save/restore to virt/kvm/arm/hyp
>>   KVM: arm: vgic-new: improve compatibility with 32-bit
>>   ARM: update MPIDR accessors macro
>>   ARM: move system register accessors to asm/cp15.h
>>   ARM: KVM: Get ready to use vgic-v3
>>   ARM: KVM: Unlock vgic-v3 support
>>
>>  arch/arm/include/asm/arch_gicv3.h                 |   91 +++++++++++++++++----
>>  arch/arm/include/asm/cp15.h                       |   15 ++++
>>  arch/arm/include/asm/cputype.h                    |    3 +-
>>  arch/arm/include/asm/kvm_asm.h                    |    3 +
>>  arch/arm/include/asm/kvm_host.h                   |    4 +
>>  arch/arm/include/asm/kvm_hyp.h                    |   20 ++---
>>  arch/arm/include/uapi/asm/kvm.h                   |    7 ++
>>  arch/arm/kvm/Makefile                             |    2 +
>>  arch/arm/kvm/coproc.c                             |   36 ++++++++
>>  arch/arm/kvm/hyp/Makefile                         |    1 +
>>  arch/arm/kvm/hyp/switch.c                         |   20 ++++-
>>  arch/arm64/include/asm/arch_gicv3.h               |   13 +++
>>  arch/arm64/kvm/Kconfig                            |    4 -
>>  arch/arm64/kvm/hyp/Makefile                       |    2 +-
>>  include/kvm/arm_vgic.h                            |    8 --
>>  {arch/arm64/kvm => virt/kvm/arm}/hyp/vgic-v3-sr.c |   13 ---
>>  virt/kvm/arm/vgic/vgic-kvm-device.c               |    8 --
>>  virt/kvm/arm/vgic/vgic-mmio-v3.c                  |    6 +-
>>  virt/kvm/arm/vgic/vgic-mmio.c                     |    2 -
>>  virt/kvm/arm/vgic/vgic.h                          |   53 ------------
>>  20 files changed, 186 insertions(+), 125 deletions(-)
>>  rename {arch/arm64/kvm => virt/kvm/arm}/hyp/vgic-v3-sr.c (96%)
>>
>> -- 
>> 1.7.9.5
>>
>> _______________________________________________
>> kvmarm mailing list
>> kvmarm at lists.cs.columbia.edu
>> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> 
