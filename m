From: peter.maydell@linaro.org (Peter Maydell)
Date: Tue, 4 Dec 2012 12:05:12 +0000
Subject: [RFC PATCH 1/1] KVM: ARM: add vgic state save and restore support
In-Reply-To: <20121204114410.GA7450@b29396-Latitude-E6410>
References: <1354531019-9335-1-git-send-email-b29396@freescale.com>
 <CAFEAcA-wopCCZrX2-eak-YAVpR2ZorGAyBVpcHUxjbxewVCFeg@mail.gmail.com>
 <20121204114410.GA7450@b29396-Latitude-E6410>
Message-ID: <CAFEAcA8Z-Y4Q6+p4rtByBCdwycLJm-86edUeaECoaMXx=1rLxg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 December 2012 11:44, Dong Aisheng <b29396@freescale.com> wrote:
> On Mon, Dec 03, 2012 at 12:02:55PM +0000, Peter Maydell wrote:

> Probably one way we could try to avoid this issue is also saving the
> banked registers value in kernel, then using it as return value of ONE_REG
> access of specified VCPU rather than performing real register access to get
> the correct banked register value.

You absolutely can't do real hardware accesses to perform the state
save/restore -- the VM/vcpu might not be running at this point,
and the hardware could well be set up with some other VM's state.

>> different question, though. ONE_REG is currently aimed as a vcpu
>> ioctl for CPU state save/restore -- how does it need to change
>> to handle device state save/restore where the device is not per-cpu?
>>
> What do you mean not per-cpu device? Or should it be said per-cpu device?
> I'm a bit confused. For per-cpu variable, it means each cpu has
> its own copy of the variable.
> Then my understanding of non per-cpu device is that the device state
> is consistent between all CPUs. It does not care which CPU is accessing
> it. Then what issues do you mean for such devices when using ONE_REG?

The GIC is not a per-cpu device -- there is only one GIC even if
you have a four-cpu (four-core) machine. ONE_REG is a vcpu ioctl,
which means it is currently assumed to work only for reading
registers for a single vcpu. That doesn't make a great deal of
sense for devices like the GIC which aren't per-cpu (even if some
of their registers are banked). If there was a vm-ioctl version of
ONE_REG that would be ok to call from a non-vcpu thread and could
just return us the whole GIC state.

>> Somebody needs to do this conversion, or TCG-to-KVM migrations won't work.
>> I don't have a strong opinion whether it ought to be userspace or kernel;
>> I think the deciding factor is probably going to be which is the easiest
>> for the kernel to support into the future as a stable ABI (even as GIC
>> versions change etc).
>>
>
> I don't know too much about TCG, will spend some time to research.
> It looks to me if we're using ONE_REG, we then have to do it in qemu.

No, whether we use ONE_REG or GET/SET_IRQCHIP does not affect whether
we do this conversion in qemu or in the kernel. The two choices are
completely distinct.

> I could try ONE_REG if the banked registers access issue is not exist.
> I'm not very familiar with x86 virtualization hw support, but i did refer to
> x86 i8259.c code to implement this function for arm. And it looks the
> KVM_SET_IRQCHIP/KVM_GET_IRQCHIP is designed for irqchip state save/retore.
> Maybe the hw is too much different between x86 and arm.

The x86 KVM ABI was generally the first one put in and it varies
between "exactly the right thing for everybody", "generally the right
thing but described in a slightly x86-centric way", "not really
suitable for all architectures" down to "this really is x86 only".
Separately, sometimes it turns out that the approach taken for x86
wasn't the best possible, and newer APIs have been designed since.
ONE_REG is one of those -- the idea is that new KVM ports will use
it, but x86 will have to retain the old-style interface for compatibility
anyway.

So copying x86's approach is not always the best approach (though
it is not always the wrong approach either -- this is a judgement
call).

-- PMM
