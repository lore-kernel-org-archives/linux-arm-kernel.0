From: shankerd@codeaurora.org (Shanker Donthineni)
Date: Fri, 11 Dec 2015 13:11:27 -0600
Subject: [PATCH v12 04/16] arm64: kvm: allows kvm cpu hotplug
In-Reply-To: <566B11C7.6040904@arm.com>
References: <cover.1448403503.git.geoff@infradead.org>
 <23ca498d5e28017549c6076812d60b18e86fa20e.1448403503.git.geoff@infradead.org>
 <CAJ5Y-eYHqQCf=ZQzXb=D_P7VscM=vNc3YpYLJs+UtZLFswiaeQ@mail.gmail.com>
 <56604A6E.60102@arm.com> <566A8404.4020507@linaro.org>
 <566AF9BE.7090806@arm.com> <566B0F39.9070205@codeaurora.org>
 <566B11C7.6040904@arm.com>
Message-ID: <566B1FDF.7080801@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 12/11/2015 12:11 PM, Marc Zyngier wrote:
> On 11/12/15 18:00, Shanker Donthineni wrote:
>>
>> On 12/11/2015 10:28 AM, Marc Zyngier wrote:
>>> On 11/12/15 08:06, AKASHI Takahiro wrote:
>>>> Ashwin, Marc,
>>>>
>>>> On 12/03/2015 10:58 PM, Marc Zyngier wrote:
>>>>> On 02/12/15 22:40, Ashwin Chaugule wrote:
>>>>>> Hello,
>>>>>>
>>>>>> On 24 November 2015 at 17:25, Geoff Levand <geoff@infradead.org> wrote:
>>>>>>> From: AKASHI Takahiro <takahiro.akashi@linaro.org>
>>>>>>>
>>>>>>> The current kvm implementation on arm64 does cpu-specific initialization
>>>>>>> at system boot, and has no way to gracefully shutdown a core in terms of
>>>>>>> kvm. This prevents, especially, kexec from rebooting the system on a boot
>>>>>>> core in EL2.
>>>>>>>
>>>>>>> This patch adds a cpu tear-down function and also puts an existing cpu-init
>>>>>>> code into a separate function, kvm_arch_hardware_disable() and
>>>>>>> kvm_arch_hardware_enable() respectively.
>>>>>>> We don't need arm64-specific cpu hotplug hook any more.
>>>>>>>
>>>>>>> Since this patch modifies common part of code between arm and arm64, one
>>>>>>> stub definition, __cpu_reset_hyp_mode(), is added on arm side to avoid
>>>>>>> compiling errors.
>>>>>>>
>>>>>>> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
>>>>>>> ---
>>>>>>>     arch/arm/include/asm/kvm_host.h   | 10 ++++-
>>>>>>>     arch/arm/include/asm/kvm_mmu.h    |  1 +
>>>>>>>     arch/arm/kvm/arm.c                | 79 ++++++++++++++++++---------------------
>>>>>>>     arch/arm/kvm/mmu.c                |  5 +++
>>>>>>>     arch/arm64/include/asm/kvm_host.h | 16 +++++++-
>>>>>>>     arch/arm64/include/asm/kvm_mmu.h  |  1 +
>>>>>>>     arch/arm64/include/asm/virt.h     |  9 +++++
>>>>>>>     arch/arm64/kvm/hyp-init.S         | 33 ++++++++++++++++
>>>>>>>     arch/arm64/kvm/hyp.S              | 32 ++++++++++++++--
>>>>>>>     9 files changed, 138 insertions(+), 48 deletions(-)
>>>>>> [..]
>>>>>>
>>>>>>>     static struct notifier_block hyp_init_cpu_pm_nb = {
>>>>>>> @@ -1108,11 +1119,6 @@ static int init_hyp_mode(void)
>>>>>>>            }
>>>>>>>
>>>>>>>            /*
>>>>>>> -        * Execute the init code on each CPU.
>>>>>>> -        */
>>>>>>> -       on_each_cpu(cpu_init_hyp_mode, NULL, 1);
>>>>>>> -
>>>>>>> -       /*
>>>>>>>             * Init HYP view of VGIC
>>>>>>>             */
>>>>>>>            err = kvm_vgic_hyp_init();
>>>>>> With this flow, the cpu_init_hyp_mode() is called only at VM guest
>>>>>> creation, but vgic_hyp_init() is called at bootup. On a system with
>>>>>> GICv3, it looks like we end up with bogus values from the ICH_VTR_EL2
>>>>>> (to get the number of LRs), because we're not reading it from EL2
>>>>>> anymore.
>>>> Thank you for pointing this out.
>>>> Recently I tested my kdump code on hikey, and as hikey(hi6220) has gic-400,
>>>> I didn't notice this problem.
>>> Because GIC-400 is a GICv2 implementation, which is entirely MMIO based.
>>> GICv3 uses some system registers that are only available at EL2, and KVM
>>> needs some information contained in these registers before being able to
>>> get initialized.
>>>
>>>>> Indeed, this is completely broken (I just reproduced the issue on a
>>>>> model). I wish this kind of details had been checked earlier, but thanks
>>>>> for pointing it out.
>>>>>
>>>>>> Whats the best way to fix this?
>>>>>> - Call kvm_arch_hardware_enable() before vgic_hyp_init() and disable later?
>>>>>> - Fold the VGIC init stuff back into hardware_enable()?
>>>>> None of that works - kvm_arch_hardware_enable() is called once per CPU,
>>>>> while vgic_hyp_init() can only be called once. Also,
>>>>> kvm_arch_hardware_enable() is called from interrupt context, and I
>>>>> wouldn't feel comfortable starting probing DT and allocating stuff from
>>>>> there.
>>>> Do you think so?
>>>> How about the fixup! patch attached below?
>>>> The point is that, like Ashwin's first idea, we initialize cpus temporarily
>>>> before kvm_vgic_hyp_init() and then soon reset cpus again. Thus,
>>>> kvm cpu hotplug will still continue to work as before.
>>>> Now that cpu_init_hyp_mode() is revived as exactly the same as Marc's
>>>> original code, the change will not be a big jump.
>>> This seems quite complicated:
>>> - init EL2 on  all CPUs
>>> - do some initialization
>>> - tear all CPUs EL2 down
>>> - let KVM drive the vectors being set or not
>>>
>>> My questions are: why do we need to do this on *all* cpus? Can't that
>>> work on a single one?
>>>    
>> Single CPU EL2 initialization should be fine as long as no kernel
>> preemption happens in between init EL2  and  kvm_vgic_hyp_init()
>> execution. The function init_hyp_mode() is called by do_basic_setup()
>> with preemption enabled.
> Indeed. So far, we never needed this since we were executing this code
> with interrupts disabled.
>
>> I don't have deeper knowledge of how scheduler is handled during the
>>   kernel boot time, but initializing all CPUs definitely helps if
>> preemption happens before reading ICH_VTR_EL2 register and after
>> kvm_vgic_hyp_init().
> What is wrong with wrapping the critical path with
> preempt_{enabled,disabled}?

I agree with you nothing wrong implementing your suggestion. It will fix 
the problem.

> Thanks,
>
> 	M.
