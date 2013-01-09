From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Wed, 9 Jan 2013 10:17:04 -0500
Subject: [PATCH v5 01/12] KVM: ARM: Introduce KVM_SET_DEVICE_ADDRESS ioctl
In-Reply-To: <CAFEAcA9z+kaSpVU3c8dWDHEnuGEri1JRZeS2+F5d2EefnX0oyQ@mail.gmail.com>
References: <CANM98qL=tisS_6rqPYHvo+xJUfC_WzypHABK2H_Ac+4Sqwb3-A@mail.gmail.com>
 <1357687783.10453.9@snotra>
 <CANM98q+=5gZ+=muw4UHy5hQ8D6zqz--BLa4Z0C39dnUxeCOWfA@mail.gmail.com>
 <9D32C496-91DE-44FC-BB1A-305BCE4A90CD@suse.de>
 <CAFEAcA99j=9dVz1YwZPZJ5tXR7ODQ4rZN_vfN046Bf7Yc1SQKg@mail.gmail.com>
 <86D3D406-05C3-4569-AD03-3223B46D47D9@suse.de>
 <CAFEAcA9z+kaSpVU3c8dWDHEnuGEri1JRZeS2+F5d2EefnX0oyQ@mail.gmail.com>
Message-ID: <CANM98qKXvfCohJrybZw+5V-GvgS+9kw04BhAzFTagzp_NdcUmA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 9, 2013 at 10:11 AM, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 9 January 2013 14:58, Alexander Graf <agraf@suse.de> wrote:
>>
>> On 09.01.2013, at 15:48, Peter Maydell wrote:
>>
>>> On 9 January 2013 10:02, Alexander Graf <agraf@suse.de> wrote:
>>>> I think we should make thus at least potentially generic. In fact, I wouldn't even
>>>> mind calling it DEV_REG with the same semantics as ONE_REG, just that it also
>>>> gets a unique dev id that gets created during in-kernel device creation and that
>>>> it's a vm ioctl.
>>>
>>> Well, we might want a DEV_REG, but you might as well just make ONE_REG
>>> OK as a VM ioctl, since there's no reason not to have not-per-cpu but not
>>> device registers. ONE_REG already supports dividing up the ID space so
>>> you can say which device or whatever is being used, because we had
>>> things like GIC registers in mind when we put that API together.
>>
>> ONE_REG's address space today doesn't include a field for the target device,
>
> There's 16 bits of "register group type".
>
>> because that's already predetermined by the fd you run it on. Hence my
>> suggestion to add it as separate field, because then we keep the id space
>> mask-free.
>
> Er, it already has masks for the different parts of ID space. That's a feature,
> not a bug.
>
>>> However, this shouldn't be DEV_REG, because this isn't actually setting state
>>> in the irqchip device, it's configuring the kernel's part of the system model
>>> [compare wiring up irq routing, which also has a custom ioctl rather than a
>>> generic one]. As such it definitely needs to happen only before the VM is
>>> actually started and not during VM execution, unlike a DEV_REG which would
>>> presumably be generally valid.
>>
>> The same can be true for ONE_REG/SET_SREGS. On PPC we support setting
>> the PVR (CPU type) via SREGS because ONE_REG only came later. Setting
>> the CPU type only makes sense before you first start using a vcpu. After that
>> point it should be forbidden.
>>
>> So in a way, the irqchip memory address location is a device register, as it has
>> all the properties that a register on that device would have. It is
>>
>>   * per device
>>   * one id for one purpose
>>   * may or may not be writable during certain times
>
> There's a distinction between "things you need to do in machine setup"
> and "things you need to propagate for migration". It should be possible
> to do a migration by doing a complete copy of all ONE_REG (and DEV_REG
> if we have it) state from source to destination, so it needs to be always
> possible to write them.
>
>> We would also keep the gates open to get a new register id one day for a second
>> address. Imagine an interrupt controller that splits its address mappings into
>> "PIC base registers" and "MSI target registers", though the MSI registers logically
>> belong to the PIC. Then the ioctl as designed here gets stuck too.
>
> This is exactly what ARM's GIC has already. We have several memory regions
> (one for the distributor, one for the cpu interface), and map them with several
> calls to SET_DEVICE_ADDRESS.
>
>>> (b) we didn't need to tangle up and delay the KVM ARM work with a vague
>>> and unspecified desire for general configurability
>>
>> Yeah, that was the basic idea. Considering that the patch set hasn't been going
>> in for another 2 months after that discussion indicates that this isn't too much of
>> an issue though :).
>
well, now it's actually going in, and it seems like this is the last
issue. Let's hold our breaths here for a second and let me write up a
new device attribute API and send that out, and if you guys can
possibly live with it, then please consider accepting it.

-Christoffer
