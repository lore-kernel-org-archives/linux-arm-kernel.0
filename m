From: peter.maydell@linaro.org (Peter Maydell)
Date: Wed, 9 Jan 2013 14:48:00 +0000
Subject: [PATCH v5 01/12] KVM: ARM: Introduce KVM_SET_DEVICE_ADDRESS ioctl
In-Reply-To: <9D32C496-91DE-44FC-BB1A-305BCE4A90CD@suse.de>
References: <CANM98qL=tisS_6rqPYHvo+xJUfC_WzypHABK2H_Ac+4Sqwb3-A@mail.gmail.com>
 <1357687783.10453.9@snotra>
 <CANM98q+=5gZ+=muw4UHy5hQ8D6zqz--BLa4Z0C39dnUxeCOWfA@mail.gmail.com>
 <9D32C496-91DE-44FC-BB1A-305BCE4A90CD@suse.de>
Message-ID: <CAFEAcA99j=9dVz1YwZPZJ5tXR7ODQ4rZN_vfN046Bf7Yc1SQKg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9 January 2013 10:02, Alexander Graf <agraf@suse.de> wrote:
> I think we should make thus at least potentially generic. In fact, I wouldn't even
> mind calling it DEV_REG with the same semantics as ONE_REG, just that it also
> gets a unique dev id that gets created during in-kernel device creation and that
> it's a vm ioctl.

Well, we might want a DEV_REG, but you might as well just make ONE_REG
OK as a VM ioctl, since there's no reason not to have not-per-cpu but not
device registers. ONE_REG already supports dividing up the ID space so
you can say which device or whatever is being used, because we had
things like GIC registers in mind when we put that API together.

However, this shouldn't be DEV_REG, because this isn't actually setting state
in the irqchip device, it's configuring the kernel's part of the system model
[compare wiring up irq routing, which also has a custom ioctl rather than a
generic one]. As such it definitely needs to happen only before the VM is
actually started and not during VM execution, unlike a DEV_REG which would
presumably be generally valid.

> That way we wouldn't block our path to create two in-kernel irqchips one day.

Er, SET_DEVICE_ADDRESS doesn't block us doing that; that's why it has
an ID parameter.

The discussion at the KVM forum, as I recall it was basically:
 (a) some other ppc irqchips also want to set the base address for where
their memory mapped registers live, so this isn't a totally ARM specific
weirdness
 (b) we didn't need to tangle up and delay the KVM ARM work with a vague
and unspecified desire for general configurability

-- PMM
