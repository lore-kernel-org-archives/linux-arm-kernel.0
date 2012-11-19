From: cyril@ti.com (Cyril Chemparathy)
Date: Mon, 19 Nov 2012 10:27:05 -0500
Subject: [PATCH v4 05/14] KVM: ARM: Hypervisor inititalization
In-Reply-To: <20121119145100.GX3205@mudshark.cambridge.arm.com>
References: <20121110154203.2836.46686.stgit@chazy-air>
 <20121110154245.2836.17259.stgit@chazy-air>
 <20121119145100.GX3205@mudshark.cambridge.arm.com>
Message-ID: <50AA4FC9.8080208@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/19/2012 09:51 AM, Will Deacon wrote:
>
> Typo in subject, use one of initiali[sz]ation instead.
>
> On Sat, Nov 10, 2012 at 03:42:45PM +0000, Christoffer Dall wrote:
>> Sets up KVM code to handle all exceptions taken to Hyp mode.
>>
>> When the kernel is booted in Hyp mode, calling "hvc #0xff" with r0 pointing to
>> the new vectors, the HVBAR is changed to the the vector pointers.  This allows
>> subsystems (like KVM here) to execute code in Hyp-mode with the MMU disabled.
>>
>> We initialize other Hyp-mode registers and enables the MMU for Hyp-mode from
>> the id-mapped hyp initialization code. Afterwards, the HVBAR is changed to
>> point to KVM Hyp vectors used to catch guest faults and to switch to Hyp mode
>> to perform a world-switch into a KVM guest.
>>
>> If the KVM module is unloaded we call "hvc #0xff" once more to disable the MMU
>> in Hyp mode again and install a vector handler to change the HVBAR for a
>> subsequent reload of KVM or another hypervisor.
>
> 0xff might be a bit too simple. I notice Xen use 0xEA1, which is
> probably less likely to conflict with anything else. We should probably
> also put these numbers in the same header file so that any conflicts
> become immediately apparent.
>
>>
>> Also provides memory mapping code to map required code pages, data structures,
>> and I/O regions  accessed in Hyp mode at the same virtual address as the host
>> kernel virtual addresses, but which conforms to the architectural requirements
>> for translations in Hyp mode. This interface is added in arch/arm/kvm/arm_mmu.c
>> and comprises:
>>   - create_hyp_mappings(from, to);
>>   - create_hyp_io_mappings(from, to, phys_addr);
>>   - free_hyp_pmds();
>>
>> Reviewed-by: Marcelo Tosatti <mtosatti@redhat.com>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
>
[...]
>> +static int init_hyp_mode(void)
>> +{
>> +       phys_addr_t init_phys_addr;
>> +       int cpu;
>> +       int err = 0;
>> +
>> +       /*
>> +        * Allocate Hyp PGD and setup Hyp identity mapping
>> +        */
>> +       err = kvm_mmu_init();
>> +       if (err)
>> +               return err;
>> +
>> +       /*
>> +        * It is probably enough to obtain the default on one
>> +        * CPU. It's unlikely to be different on the others.
>> +        */
>> +       hyp_default_vectors = __hyp_get_vectors();
>> +
>> +       /*
>> +        * Allocate stack pages for Hypervisor-mode
>> +        */
>> +       for_each_possible_cpu(cpu) {
>> +               unsigned long stack_page;
>> +
>> +               stack_page = __get_free_page(GFP_KERNEL);
>> +               if (!stack_page) {
>> +                       err = -ENOMEM;
>> +                       goto out_free_stack_pages;
>> +               }
>> +
>> +               per_cpu(kvm_arm_hyp_stack_page, cpu) = stack_page;
>> +       }
>> +
>> +       /*
>> +        * Execute the init code on each CPU.
>> +        *
>> +        * Note: The stack is not mapped yet, so don't do anything else than
>> +        * initializing the hypervisor mode on each CPU using a local stack
>> +        * space for temporary storage.
>> +        */
>> +       init_phys_addr = virt_to_phys(__kvm_hyp_init);
>> +       for_each_online_cpu(cpu) {
>> +               smp_call_function_single(cpu, cpu_init_hyp_mode,
>> +                                        (void *)(long)init_phys_addr, 1);
>> +       }
>
> Hmm, this will probably go wrong for platforms like keystone, where
> everything is above 4GB in physical memory. Actually, I'm not sure on
> the status of the patches so you could check with Cyril [CC'd].
>

Thanks for the heads up.

Looks like __kvm_hyp_init is idmap'ed.  This should be ok on keystone, 
but we'll need to replace the virt_to_phys() with a virt_to_idmap() when 
we get to this.

Thanks
-- Cyril.
