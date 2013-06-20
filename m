From: agraf@suse.de (Alexander Graf)
Date: Fri, 21 Jun 2013 00:02:02 +0200
Subject: [PATCH v2] ARM/KVM: save and restore generic timer registers
In-Reply-To: <CAFEAcA8D+SXe8PPfd=sqPf8td4kk5TbdQgXgqUVnkXR7ZKXKpw@mail.gmail.com>
References: <1370963819-26165-1-git-send-email-andre.przywara@linaro.org>
 <51C2D528.90805@arm.com> <20130620170923.GA4563@lvm>
 <51C339BD.2080600@arm.com> <20130620183221.GE4563@lvm>
 <CAFEAcA97WiCYnSSs3utfq5+3tgausn+fjEnWeN6zj9sgP9P9qA@mail.gmail.com>
 <20130620203715.GI4563@lvm> <52054112-99C9-44DD-921C-BA06854B29A5@suse.de>
 <CAFEAcA8D+SXe8PPfd=sqPf8td4kk5TbdQgXgqUVnkXR7ZKXKpw@mail.gmail.com>
Message-ID: <7BA55D0B-D754-4FD2-BD4C-6223AA063E27@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 20.06.2013, at 23:59, Peter Maydell wrote:

> On 20 June 2013 22:55, Alexander Graf <agraf@suse.de> wrote:
>> 
>> On 20.06.2013, at 22:37, Christoffer Dall wrote:
>> 
>>> On Thu, Jun 20, 2013 at 08:29:30PM +0100, Peter Maydell wrote:
>>>> On 20 June 2013 19:32, Christoffer Dall <christoffer.dall@linaro.org> wrote:
>>>>> Marc wrote:
>>>>>> So there is just one thing we absolutely need to make sure here: no vcpu
>>>>>> can run before they've all had their timer restored, and hence a stable
>>>>>> cntvoff. Otherwise two vcpus will have a different view of time.
>>>>>> 
>>>>>> Can we guarantee this?
>>>> 
>>>>> Do we need to?  User space is free to modify time and all sort of other
>>>>> registers at any point during VM execution - it will just break the
>>>>> guest that it's running.
>>>> 
>>>> Note that QEMU will stop all CPUs before doing a migration or
>>>> similar operation. However there is a monitor command to query
>>>> the current CPU registers etc which won't try to stop the VM
>>>> first. So we might try to read vcpu registers (though I hope we
>>>> don't allow writing them).
>>>> 
>>> Sounds like we need to add a -EBUSY return on SET_ONE_REG if the VM is
>>> running.
>> 
>> The ONE_REG API should already be protected here, as it does
>> vcpu_load() in kvm_vcpu_ioctl(). So a separate thread can't possibly
>> do ONE_REG accesses while another thread has the same vcpu running.
> 
> Doesn't protect you against confusion due to another thread running
> a different vcpu in the same vm, though.

Ah, different ONE_REG API. Can't you just notify all vcpus to exit and refresh their timers? That's what kvm_make_request() is there for, no?


Alex
