From: jintack@cs.columbia.edu (Jintack Lim)
Date: Tue, 17 Jan 2017 12:15:24 -0500
Subject: [RFC 0/8] Provide the EL1 physical timer to the VM
In-Reply-To: <b15297e4-1b30-27f8-dd43-fb1a85bd2cd5@arm.com>
References: <1482772326-29110-1-git-send-email-jintack@cs.columbia.edu>
 <b15297e4-1b30-27f8-dd43-fb1a85bd2cd5@arm.com>
Message-ID: <CAHyh4xiWxE_EE=ysdOAf_--p_ZZVLDSy+QcD8qY_G7xr3n0HVw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 17, 2017 at 12:09 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 26/12/16 17:11, Jintack Lim wrote:
>> The ARM architecture defines the EL1 physical timer and the virtual
>> timer, and it is reasonable for an OS to expect to be able to access
>> both.  However, the current KVM implementation does not provide the EL1
>> physical timer to VMs but terminates VMs on access to the timer.
>>
>> On VHE systems, this would be as simple as allowing full access to the
>> EL1 physical timer to VMs because the KVM host does not use the EL1
>> physical timer.  However, on non-VHE systems, the KVM host already uses
>> the EL1 physical timer which prevents us from granting full access of
>> the EL1 physical timer to VMs.
>>
>> This patchset enables VMs to use the EL1 physical timer through
>> trap-and-emulate.  The KVM host emulates each EL1 physical timer
>> register access and sets up the background timer accordingly.  When the
>> background timer expires, the KVM host injects EL1 physical timer
>> interrupts to the VM.  Alternatively, it's also possible to allow VMs to
>> access the EL1 physical timer without trapping.  However, this requires
>> somehow using the EL2 physical timer for the Linux host while running
>> the VM instead of the EL1 physical timer.  Right now I just implemented
>> trap-and-emulate because this was straightforward to do, and I leave it
>> to future work to determine if transferring the EL1 physical timer state
>> to the EL2 timer provides any performance benefit.
>>
>> This feature will be useful for any OS that wishes to access the EL1
>> physical timer. Nested virtualization is one of those use cases. A
>> nested hypervisor running inside a VM would think it has full access to
>> the hardware and naturally tries to use the EL1 physical timer as Linux
>> would do. Other nested hypervisors may try to use the EL2 physical timer
>> as Xen would do, but supporting the EL2 physical timer to the VM is out
>> of scope of this patchset. This patchset will make it easy to add the
>> EL2 timer support in the future, though.
>>
>> Note, Linux VMs booting in EL1 will be unaffected by this patch set and
>> will continue to use only the virtual timer and this patch set will
>> therefore not introduce any performance degredation as a result of
>> trap-and-emulate.
>
> Hi Jintack,
>
> Any chance you could address Christoffer's comments and respin this
> series? This looks like a good enhancement to our emulation, and
> definitely a requirement for the nested work, so I'm obviously keen on it.

Hi Marc,

Yes, I plan to respin this patch series this week.

Thanks,
Jintack

>
> Thanks,
>
>         M.
> --
> Jazz is not dead. It just smells funny...
>
