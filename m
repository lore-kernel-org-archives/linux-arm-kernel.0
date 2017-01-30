From: jintack@cs.columbia.edu (Jintack Lim)
Date: Mon, 30 Jan 2017 14:02:28 -0500
Subject: [RFC v2 00/10] Provide the EL1 physical timer to the VM
In-Reply-To: <86h94h97yn.fsf@arm.com>
References: <1485479100-4966-1-git-send-email-jintack@cs.columbia.edu>
 <86h94h97yn.fsf@arm.com>
Message-ID: <CAHyh4xiErc288_bj=YmtADcZj5rUG8ryMrW+dP428gxDuOJCUQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On Sun, Jan 29, 2017 at 10:55 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> Hi Jintack,
>
> On Fri, Jan 27 2017 at 01:04:50 AM, Jintack Lim <jintack@cs.columbia.edu> wrote:
>> The ARM architecture defines the EL1 physical timer and the virtual timer,
>> and it is reasonable for an OS to expect to be able to access both.
>> However, the current KVM implementation does not provide the EL1 physical
>> timer to VMs but terminates VMs on access to the timer.
>>
>> This patch series enables VMs to use the EL1 physical timer through
>> trap-and-emulate.  The KVM host emulates each EL1 physical timer register
>> access and sets up the background timer accordingly.  When the background
>> timer expires, the KVM host injects EL1 physical timer interrupts to the
>> VM.  Alternatively, it's also possible to allow VMs to access the EL1
>> physical timer without trapping.  However, this requires somehow using the
>> EL2 physical timer for the Linux host while running the VM instead of the
>> EL1 physical timer.  Right now I just implemented trap-and-emulate because
>> this was straightforward to do, and I leave it to future work to determine
>> if transferring the EL1 physical timer state to the EL2 timer provides any
>> performance benefit.
>>
>> This feature will be useful for any OS that wishes to access the EL1
>> physical timer. Nested virtualization is one of those use cases. A nested
>> hypervisor running inside a VM would think it has full access to the
>> hardware and naturally tries to use the EL1 physical timer as Linux would
>> do. Other nested hypervisors may try to use the EL2 physical timer as Xen
>> would do, but supporting the EL2 physical timer to the VM is out of scope
>> of this patch series. This patch series will make it easy to add the EL2
>> timer support in the future, though.
>>
>> Note that Linux VMs booting in EL1 will be unaffected by this patch series
>> and will continue to use only the virtual timer and this patch series will
>> therefore not introduce any performance degredation as a result of
>> trap-and-emulate.
>
> Thanks for respining this series. Overall, this looks quite good, and
> the couple of comments I have should be easy to address.

Thanks for the review!

>
> My main concern is that we do expose a timer that doesn't hide
> CNTVOFF. I appreciate that that was already the case, since CNTPCT was
> always available (and this avoided trapping the counter), but maybe we
> should have a way for userspace to ask for a mode where CNTPCT=CNTVCT,
> byt trapping the physical counter and taking CNTVOFF in all physical
> timer calculations.

As discussed in the other thread, I think we can expose CNTVOFF to the
guest OS. I have a patch that lets the guest hypervisor observe CNTVCT
= CNTPCT - offset (virtual CNTVOFF_EL2) and I will include it in the
next nesting patch series.

Thanks,
Jintack

>
> I'm pretty sure you've addressed this one way or another in your nested
> virt series, so maybe extracting the relevant patches and adding them on
> top of this series could be an option?
>
> Thanks,
>
>         M.
> --
> Jazz is not dead. It just smells funny.
>
