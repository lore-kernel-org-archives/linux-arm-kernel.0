From: agraf@suse.de (Alexander Graf)
Date: Wed, 9 Jan 2013 11:02:31 +0100
Subject: [PATCH v5 01/12] KVM: ARM: Introduce KVM_SET_DEVICE_ADDRESS ioctl
In-Reply-To: <CANM98q+=5gZ+=muw4UHy5hQ8D6zqz--BLa4Z0C39dnUxeCOWfA@mail.gmail.com>
References: <CANM98qL=tisS_6rqPYHvo+xJUfC_WzypHABK2H_Ac+4Sqwb3-A@mail.gmail.com>
 <1357687783.10453.9@snotra>
 <CANM98q+=5gZ+=muw4UHy5hQ8D6zqz--BLa4Z0C39dnUxeCOWfA@mail.gmail.com>
Message-ID: <9D32C496-91DE-44FC-BB1A-305BCE4A90CD@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Am 09.01.2013 um 00:49 schrieb Christoffer Dall <c.dall@virtualopensystems.com>:

> On Tue, Jan 8, 2013 at 6:29 PM, Scott Wood <scottwood@freescale.com> wrote:
>> On 01/08/2013 05:17:05 PM, Christoffer Dall wrote:
>>> 
>>> On Tue, Jan 8, 2013 at 5:36 PM, Scott Wood <scottwood@freescale.com>
>>> wrote:
>>>> On 01/08/2013 12:41:30 PM, Christoffer Dall wrote:
>>>>> +struct kvm_device_address {
>>>>> +       __u64 id;
>>>>> +       __u64 addr;
>>>>> +};
>>>> 
>>>> 
>>>> What about this is really specific to addresses?  Can't we set other
>>>> device
>>>> parameters this way?
>>>> 
>>>> Sort of like a device equivalent of PPC's one-reg interface.
>>>> 
>>> This has been discussed a number of times,
>> 
>> 
>> Sorry, this patch was just pointed out to me today.  I googled the patch
>> title but couldn't find this discussion.
>> 
>> 
> 
> I believe it was mainly discussed at the KVM Forum in person.
> 
>>> and one or the other there
>>> is a need for userspace to tell KVM to present memory-mapped devices
>>> at a given address. It was also considered to make this specific to
>>> irqchip initialization, but irqchips are different and a lot of that
>>> code is x86-specific, so that approach was discarded.
>>> 
>>> This *could* look something like this:
>>> 
>>> struct kvm_device_param {
>>>    u64 dev_id;
>>>    u64 param_id;
>>>    u64 value;
>>> };
>>> 
>>> but that has less clear, or at least less specific, semantics.
>> 
>> 
>> Why is it less clear?  You need to have device-specific documentation for
>> what "id" means, so why not also an enumeration of "param"s?  Or just keep
>> it as is, and rename "address" to "value".  Whether "dev" and "param" are
>> combined is orthogonal from whether it's used for non-address things.
> 
> less clear in the sense that you have to look at more code to see what
> it does. I'm not saying that it's too unclear, at all, I'm actually
> fine with it, but to make my point, we can make an ioctl that's called
> do_something() that takes a struct with val0, val1, val2, val3, ...
> 
>> 
>> If you leave it as "address", either we'll have it being used for
>> non-address things regardless of the name ("Not a typewriter!"), or there'll
>> end up being yet more unnecessary ioctls, or device-specific things will end
>> up getting shoved into CPU interfaces such as one-reg.  For example, on MPIC
>> we need to be able to specify the version of the chip to emulate in addition
>> to the address at which it lives.
>> 
>> Also, why is it documented as an "arm" interface?  Shouldn't it be a generic
>> interface, with other architectures currently not implementing any IDs?
>> What in the kvm_arch_vm_ioctl() wrapper is arm-specific?
>> 
> As I remember the argument for keeping this the point was that there
> were other preferred methods for other archs to do this, and that ARM
> was the only platform that had this explicit need, but maybe I'm
> making this up.
> 
> I'll let Peter and Alex respond this as well, and if they're fine with
> changing it to what I proposed above, then let's do that, and we can
> make it a non arm-specific interface.

I think we should make thus at least potentially generic. In fact, I wouldn't even mind calling it DEV_REG with the same semantics as ONE_REG, just that it also gets a unique dev id that gets created during in-kernel device creation and that it's a vm ioctl.

That way we wouldn't block our path to create two in-kernel irqchips one day.


Alex
