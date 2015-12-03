From: ashwin.chaugule@linaro.org (Ashwin Chaugule)
Date: Thu, 3 Dec 2015 08:55:32 -0500
Subject: [PATCH v12 04/16] arm64: kvm: allows kvm cpu hotplug
In-Reply-To: <CAJ5Y-eYHqQCf=ZQzXb=D_P7VscM=vNc3YpYLJs+UtZLFswiaeQ@mail.gmail.com>
References: <cover.1448403503.git.geoff@infradead.org>
 <23ca498d5e28017549c6076812d60b18e86fa20e.1448403503.git.geoff@infradead.org>
 <CAJ5Y-eYHqQCf=ZQzXb=D_P7VscM=vNc3YpYLJs+UtZLFswiaeQ@mail.gmail.com>
Message-ID: <CAJ5Y-eaxSAHQon2A1yP6mChsxcqPsU9Y1L1=-Lh8cF337H2pBQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2 December 2015 at 17:40, Ashwin Chaugule <ashwin.chaugule@linaro.org> wrote:
> Hello,
>
> On 24 November 2015 at 17:25, Geoff Levand <geoff@infradead.org> wrote:
>> From: AKASHI Takahiro <takahiro.akashi@linaro.org>
>>
>> The current kvm implementation on arm64 does cpu-specific initialization
>> at system boot, and has no way to gracefully shutdown a core in terms of
>> kvm. This prevents, especially, kexec from rebooting the system on a boot
>> core in EL2.
>>
>> This patch adds a cpu tear-down function and also puts an existing cpu-init
>> code into a separate function, kvm_arch_hardware_disable() and
>> kvm_arch_hardware_enable() respectively.
>> We don't need arm64-specific cpu hotplug hook any more.
>>
>> Since this patch modifies common part of code between arm and arm64, one
>> stub definition, __cpu_reset_hyp_mode(), is added on arm side to avoid
>> compiling errors.
>>
>> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
>> ---
>>  arch/arm/include/asm/kvm_host.h   | 10 ++++-
>>  arch/arm/include/asm/kvm_mmu.h    |  1 +
>>  arch/arm/kvm/arm.c                | 79 ++++++++++++++++++---------------------
>>  arch/arm/kvm/mmu.c                |  5 +++
>>  arch/arm64/include/asm/kvm_host.h | 16 +++++++-
>>  arch/arm64/include/asm/kvm_mmu.h  |  1 +
>>  arch/arm64/include/asm/virt.h     |  9 +++++
>>  arch/arm64/kvm/hyp-init.S         | 33 ++++++++++++++++
>>  arch/arm64/kvm/hyp.S              | 32 ++++++++++++++--
>>  9 files changed, 138 insertions(+), 48 deletions(-)
>
> [..]
>
>>
>>
>>  static struct notifier_block hyp_init_cpu_pm_nb = {
>> @@ -1108,11 +1119,6 @@ static int init_hyp_mode(void)
>>         }
>>
>>         /*
>> -        * Execute the init code on each CPU.
>> -        */
>> -       on_each_cpu(cpu_init_hyp_mode, NULL, 1);
>> -
>> -       /*
>>          * Init HYP view of VGIC
>>          */
>>         err = kvm_vgic_hyp_init();
>
> With this flow, the cpu_init_hyp_mode() is called only at VM guest
> creation, but vgic_hyp_init() is called at bootup. On a system with
> GICv3, it looks like we end up with bogus values from the ICH_VTR_EL2
> (to get the number of LRs), because we're not reading it from EL2
> anymore.

..or more likely, that the function to read the ICH_VTR_EL2 is not
mapped in EL2, because we deferred the cpu_init_hyp_mode() calls. In
any case, this ends up breaking KVM and manifests as a guest console
which is stuck.

>
> Whats the best way to fix this?
> - Call kvm_arch_hardware_enable() before vgic_hyp_init() and disable later?
> - Fold the VGIC init stuff back into hardware_enable()?
> - Read the VGIC number of LRs from the hyp stub?
> - ..
>
> Regards,
> Ashwin.
