From: jintack@cs.columbia.edu (Jintack Lim)
Date: Fri, 24 Feb 2017 05:28:34 -0500
Subject: [RFC 00/55] Nested Virtualization on KVM/ARM
In-Reply-To: <20170222182331.GA27653@cbox>
References: <1483943091-1364-1-git-send-email-jintack@cs.columbia.edu>
 <20170222182331.GA27653@cbox>
Message-ID: <CAHyh4xgRxTVhtez7ubye=99e1N27jcFpAC06k6_9Smzta8Zcpg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[My previous reply had HTML subpart, which made the e-mail look
terrible and being rejected from mailing lists. So, I'm sending it
again. Sorry for the inconvenience]

Hi Christoffer,

On Wed, Feb 22, 2017 at 1:23 PM, Christoffer Dall <cdall@linaro.org> wrote:
> Hi Jintack,
>
>
> On Mon, Jan 09, 2017 at 01:23:56AM -0500, Jintack Lim wrote:
>> Nested virtualization is the ability to run a virtual machine inside another
>> virtual machine. In other words, it?s about running a hypervisor (the guest
>> hypervisor) on top of another hypervisor (the host hypervisor).
>>
>> This series supports nested virtualization on arm64. ARM recently announced an
>> extension (ARMv8.3) which has support for nested virtualization[1]. This series
>> is based on the ARMv8.3 specification.
>>
>> Supporting nested virtualization means that the hypervisor provides not only
>> EL0/EL1 execution environment with VMs as it usually does, but also the
>> virtualization extensions including EL2 execution environment with the VMs.
>> Once the host hypervisor provides those execution environment with the VMs,
>> then the guest hypervisor can run its own VMs (nested VMs) naturally.
>>
>> To support nested virtualization on ARM the hypervisor must emulate a virtual
>> execution environment consisting of EL2, EL1, and EL0, as the guest hypervisor
>> will run in a virtual EL2 mode.  Normally KVM/ARM only emulated a VM supporting
>> EL1/0 running in their respective native CPU modes, but with nested
>> virtualization we deprivilege the guest hypervisor and emulate a virtual EL2
>> execution mode in EL1 using the hardware features provided by ARMv8.3 to trap
>> EL2 operations to EL1. To do that the host hypervisor needs to manage EL2
>> register state for the guest hypervisor, and shadow EL1 register state that
>> reflects the EL2 register state to run the guest hypervisor in EL1. See patch 6
>> through 10 for this.
>>
>> For memory virtualization, the biggest issue is that we now have more than two
>> stages of translation when running nested VMs. We choose to merge two stage-2
>> page tables (one from the guest hypervisor and the other from the host
>> hypervisor) and create shadow stage-2 page tables, which have mappings from the
>> nested VM?s physical addresses to the machine physical addresses. Stage-1
>> translation is done by the hardware as is done for the normal VMs.
>>
>> To provide VGIC support to the guest hypervisor, we emulate the GIC
>> virtualization extensions using trap-and-emulate to a virtual GIC Hypervisor
>> Control Interface.  Furthermore, we can still use the GIC VE hardware features
>> to deliver virtual interrupts to the nested VM, by directly mapping the GIC
>> VCPU interface to the nested VM and switching the content of the GIC Hypervisor
>> Control interface when alternating between a nested VM and a normal VM.  See
>> patches 25 through 32, and 50 through 52 for more information.
>>
>> For timer virtualization, the guest hypervisor expects to have access to the
>> EL2 physical timer, the EL1 physical timer and the virtual timer. So, the host
>> hypervisor needs to provide all of them. The virtual timer is always available
>> to VMs. The physical timer is available to VMs via my previous patch series[3].
>> The EL2 physical timer is not supported yet in this RFC. We plan to support
>> this as it is required to run other guest hypervisors such as Xen.
>>
>> Even though this work is not complete (see limitations below), I'd appreciate
>> early feedback on this RFC. Specifically, I'm interested in:
>> - Is it better to have a kernel config or to make it configurable at runtime?
>> - I wonder if the data structure for memory management makes sense.
>> - What architecture version do we support for the guest hypervisor, and how?
>>   For example, do we always support all architecture versions or the same
>>   architecture as the underlying hardware platform? Or is it better
>>   to make it configurable from the userspace?
>> - Initial comments on the overall design?
>>
>> This patch series is based on kvm-arm-for-4.9-rc7 with the patch series to provide
>> VMs with the EL1 physical timer[2].
>>
>> Git: https://github.com/columbia/nesting-pub/tree/rfc-v1
>>
>> Testing:
>> We have tested this on ARMv8.0 (Applied Micro X-Gene)[3] since ARMv8.3 hardware
>> is not available yet. We have paravirtualized the guest hypervisor to trap to
>> EL2 as specified in ARMv8.3 specification using hvc instruction. We plan to
>> test this on ARMv8.3 model, and will post the result and v2 if necessary.
>>
>> Limitations:
>> - This patch series only supports arm64, not arm. All the patches compile on
>>   arm, but I haven't try to boot normal VMs on it.
>> - The guest hypervisor with VHE (ARMv8.1) is not supported in this RFC. I have
>>   patches for that, but they need to be cleaned up.
>> - Recursive nesting (i.e. emulating ARMv8.3 in the VM) is not tested yet.
>> - Other hypervisors (such as Xen) on KVM are not tested.
>>
>> TODO:
>> - Test to boot normal VMs on arm architecture
>> - Test this on ARMv8.3 model
>> - Support the guest hypervisor with VHE
>> - Provide the guest hypervisor with the EL2 physical timer
>> - Run other hypervisors such as Xen on KVM
>>
>
> I have a couple of overall questions and comments on this series:
>
> First, I think we should make sure that the series actually works with
> v8.3 on the model using both VHE and non-VHE for the host hypervisor.

I agree. Will send out v2 once I make this work with v8.3 model.

>
> Second, this patch set is pretty large overall and it would be great if
> we could split it up into some slightly more manageable bits.  I'm not
> exactly how to do that, but perhaps we can rework it so that we add bits
> of framework (CPU, memory, interrupt, timers) as individual series, and
> finally we plug all the logic together with the current flow.  What do
> you think?

I think it sounds great. I can start with CPU patch series first.

>
> Third, we should follow the feedback from David about not using a kernel
> config option.  I'm afraid that some code will bitrot too fast if guided
> by a kernel config option, so a runtime parameter and using static keys
> where relevant seems like a better approach to me.  But since KVM/ARM is
> not loaded as a module, this would have to be a kernel cmdline
> parameter.  What do people think?
>
> Fourth, there are some places where we have hard-coded information (like
> the location of the GICH/GICV interfaces) which have to be fixed by
> adding the required userspace interfaces.

Right. I'll fix them and I'll provide a link which has userspace
changes for this nesting work in the cover letter.

>
> Fifth, the ordering of the patches needs a bit of love. I think it's
> important that we build the whole infrastructure first, but leave it
> completely disabled until the end, and then we plug in all the
> capabilities of userspace to create a nested VM in the end.  So for
> example, I would expect that patch 03 would be the last patch in the
> series.

Ah, I got it. I'll reorder patches accordingly.

>
> Overall though, this is a massive amount of work, and it's awesome that
> you were able to pull it together to a pretty nice initial RFC!

Thanks a lot for your help and reviews. I'll address individual reviews soon :)

Thanks,
Jintack

>
> Thanks!
> -Christoffer
>
