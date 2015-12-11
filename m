From: shankerd@codeaurora.org (Shanker Donthineni)
Date: Fri, 11 Dec 2015 07:00:28 -0600
Subject: [PATCH v12 04/16] arm64: kvm: allows kvm cpu hotplug
In-Reply-To: <566A8404.4020507@linaro.org>
References: <cover.1448403503.git.geoff@infradead.org>
 <23ca498d5e28017549c6076812d60b18e86fa20e.1448403503.git.geoff@infradead.org>
 <CAJ5Y-eYHqQCf=ZQzXb=D_P7VscM=vNc3YpYLJs+UtZLFswiaeQ@mail.gmail.com>
 <56604A6E.60102@arm.com> <566A8404.4020507@linaro.org>
Message-ID: <566AC8EC.4050907@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 12/11/2015 02:06 AM, AKASHI Takahiro wrote:
> Ashwin, Marc,
>
> On 12/03/2015 10:58 PM, Marc Zyngier wrote:
>> On 02/12/15 22:40, Ashwin Chaugule wrote:
>>> Hello,
>>>
>>> On 24 November 2015 at 17:25, Geoff Levand <geoff@infradead.org> wrote:
>>>> From: AKASHI Takahiro <takahiro.akashi@linaro.org>
>>>>
>>>> The current kvm implementation on arm64 does cpu-specific
> initialization
>>>> at system boot, and has no way to gracefully shutdown a core in terms
> of
>>>> kvm. This prevents, especially, kexec from rebooting the system on a
> boot
>>>> core in EL2.
>>>>
>>>> This patch adds a cpu tear-down function and also puts an existing
> cpu-init
>>>> code into a separate function, kvm_arch_hardware_disable() and
>>>> kvm_arch_hardware_enable() respectively.
>>>> We don't need arm64-specific cpu hotplug hook any more.
>>>>
>>>> Since this patch modifies common part of code between arm and arm64,
> one
>>>> stub definition, __cpu_reset_hyp_mode(), is added on arm side to avoid
>>>> compiling errors.
>>>>
>>>> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
>>>> ---
>>>>   arch/arm/include/asm/kvm_host.h   | 10 ++++-
>>>>   arch/arm/include/asm/kvm_mmu.h    |  1 +
>>>>   arch/arm/kvm/arm.c                | 79
> ++++++++++++++++++---------------------
>>>>   arch/arm/kvm/mmu.c                | 5 +++
>>>>   arch/arm64/include/asm/kvm_host.h | 16 +++++++-
>>>>   arch/arm64/include/asm/kvm_mmu.h  |  1 +
>>>>   arch/arm64/include/asm/virt.h     |  9 +++++
>>>>   arch/arm64/kvm/hyp-init.S         | 33 ++++++++++++++++
>>>>   arch/arm64/kvm/hyp.S              | 32 ++++++++++++++--
>>>>   9 files changed, 138 insertions(+), 48 deletions(-)
>>>
>>> [..]
>>>
>>>>
>>>>
>>>>   static struct notifier_block hyp_init_cpu_pm_nb = {
>>>> @@ -1108,11 +1119,6 @@ static int init_hyp_mode(void)
>>>>          }
>>>>
>>>>          /*
>>>> -        * Execute the init code on each CPU.
>>>> -        */
>>>> -       on_each_cpu(cpu_init_hyp_mode, NULL, 1);
>>>> -
>>>> -       /*
>>>>           * Init HYP view of VGIC
>>>>           */
>>>>          err = kvm_vgic_hyp_init();
>>>
>>> With this flow, the cpu_init_hyp_mode() is called only at VM guest
>>> creation, but vgic_hyp_init() is called at bootup. On a system with
>>> GICv3, it looks like we end up with bogus values from the ICH_VTR_EL2
>>> (to get the number of LRs), because we're not reading it from EL2
>>> anymore.
>
> Thank you for pointing this out.
> Recently I tested my kdump code on hikey, and as hikey(hi6220) has
> gic-400,
> I didn't notice this problem.
>
>> Indeed, this is completely broken (I just reproduced the issue on a
>> model). I wish this kind of details had been checked earlier, but thanks
>> for pointing it out.
>>
>>> Whats the best way to fix this?
>>> - Call kvm_arch_hardware_enable() before vgic_hyp_init() and disable
> later?
>>> - Fold the VGIC init stuff back into hardware_enable()?
>>
>> None of that works - kvm_arch_hardware_enable() is called once per CPU,
>> while vgic_hyp_init() can only be called once. Also,
>> kvm_arch_hardware_enable() is called from interrupt context, and I
>> wouldn't feel comfortable starting probing DT and allocating stuff from
>> there.
>
> Do you think so?
> How about the fixup! patch attached below?
> The point is that, like Ashwin's first idea, we initialize cpus
> temporarily
> before kvm_vgic_hyp_init() and then soon reset cpus again. Thus,
> kvm cpu hotplug will still continue to work as before.
> Now that cpu_init_hyp_mode() is revived as exactly the same as Marc's
> original code, the change will not be a big jump.
I have tested this patch and verified the fix on our hardware with GICv3 
without any issue.
>
> If kvm_hyp_call() in vgic_v3_probe()/kvm_vgic_hyp_init() is a *problem*,
> I hope this should work. Actually I confirmed that, with this fixup!
> patch,
> we could run a kvm guest and also successfully executed kexec on model
> w/gic-v3.
>
> My only concern is the following kernel message I saw when kexec shut 
> down
> the kernel:
> (Please note that I was running one kvm quest (pid=961) here.)
>
> ===
> sh-4.3# ./kexec -d -e
> kexec version: 15.11.16.11.06-g41e52e2
> arch_process_options:112: command_line: (null)
> arch_process_options:114: initrd: (null)
> arch_process_options:115: dtb: (null)
> arch_process_options:117: port: 0x0
> kvm: exiting hardware virtualization
> kvm [961]: Unsupported exception type: 6248304    <== this message
> kexec_core: Starting new kernel
> Disabling non-boot CPUs ...
> CPU1: shutdown
> CPU2: shutdown
> CPU3: shutdown
> CPU4: shutdown
> CPU5: shutdown
> CPU6: shutdown
> CPU7: shutdown
> Bye!
> Booting Linux on physical CPU 0x0
> ...
> ===
>
> I don't know whether we can ignore this kind of message or not.
> Any thoughts?
>
> Thanks,
> -Takahiro AKASHI
>
>
>
>>> - Read the VGIC number of LRs from the hyp stub?
>>
>> That's may UNDEF if called in the wrong context. Also, this defeats the
>> point of stubs, which is just to install the vectors for the hypervisor.
>>
>>> - ..
>>
>> Yeah, quite.
>>
>> Geoff, Takahiro?
>>
>>     M.
>>
> ----8<----
> From 66ca3baedf45c78c81a76ea77ddd6ace49550ab6 Mon Sep 17 00:00:00 2001
> From: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Date: Fri, 11 Dec 2015 13:43:35 +0900
> Subject: [PATCH 7/7] fixup! arm64: kvm: allows kvm cpu hotplug
>
> ---
>  arch/arm/kvm/arm.c |   37 +++++++++++++++++++++++++++----------
>  1 file changed, 27 insertions(+), 10 deletions(-)
>
> diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
> index 518c3c7..8fe59ba 100644
> --- a/arch/arm/kvm/arm.c
> +++ b/arch/arm/kvm/arm.c
> @@ -950,7 +950,7 @@ long kvm_arch_vm_ioctl(struct file *filp,
>      }
>  }
>
> -int kvm_arch_hardware_enable(void)
> +static void cpu_init_hyp_mode(void *dummy)
>  {
>      phys_addr_t boot_pgd_ptr;
>      phys_addr_t pgd_ptr;
> @@ -958,9 +958,6 @@ int kvm_arch_hardware_enable(void)
>      unsigned long stack_page;
>      unsigned long vector_ptr;
>
> -    if (__hyp_get_vectors() != hyp_default_vectors)
> -        return 0;
> -
>      /* Switch from the HYP stub to our own HYP init vector */
>      __hyp_set_vectors(kvm_get_idmap_vector());
>
> @@ -973,24 +970,35 @@ int kvm_arch_hardware_enable(void)
>      __cpu_init_hyp_mode(boot_pgd_ptr, pgd_ptr, hyp_stack_ptr,
> vector_ptr);
>
>      kvm_arm_init_debug();
> -
> -    return 0;
>  }
>
> -void kvm_arch_hardware_disable(void)
> +static void cpu_reset_hyp_mode(void *dummy)
>  {
>      phys_addr_t boot_pgd_ptr;
>      phys_addr_t phys_idmap_start;
>
> -    if (__hyp_get_vectors() == hyp_default_vectors)
> -        return;
> -
>      boot_pgd_ptr = kvm_mmu_get_boot_httbr();
>      phys_idmap_start = kvm_get_idmap_start();
>
>      __cpu_reset_hyp_mode(boot_pgd_ptr, phys_idmap_start);
>  }
>
> +int kvm_arch_hardware_enable(void)
> +{
> +    if (__hyp_get_vectors() == hyp_default_vectors)
> +        cpu_init_hyp_mode(NULL);
> +
> +    return 0;
> +}
> +
> +void kvm_arch_hardware_disable(void)
> +{
> +    if (__hyp_get_vectors() == hyp_default_vectors)
> +        return;
> +
> +    cpu_reset_hyp_mode(NULL);
> +}
> +
>  #ifdef CONFIG_CPU_PM
>  static int hyp_init_cpu_pm_notifier(struct notifier_block *self,
>                      unsigned long cmd,
> @@ -1114,6 +1122,12 @@ static int init_hyp_mode(void)
>      }
>
>      /*
> +     * Execute the init code on each CPU.
> +     * Only needed to execute kvm_hyp_call() during *_hyp_init().
> +     */
> +    on_each_cpu(cpu_init_hyp_mode, NULL, 1);
> +
> +    /*
>       * Init HYP view of VGIC
>       */
>      err = kvm_vgic_hyp_init();
> @@ -1127,6 +1141,8 @@ static int init_hyp_mode(void)
>      if (err)
>          goto out_free_context;
>
> +    on_each_cpu(cpu_reset_hyp_mode, NULL, 1);
> +
>  #ifndef CONFIG_HOTPLUG_CPU
>      free_boot_hyp_pgd();
>  #endif
> @@ -1137,6 +1153,7 @@ static int init_hyp_mode(void)
>
>      return 0;
>  out_free_context:
> +    on_each_cpu(cpu_reset_hyp_mode, NULL, 1);
>      free_percpu(kvm_host_cpu_state);
>  out_free_mappings:
>      free_hyp_pgds();
