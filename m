From: agraf@suse.de (Alexander Graf)
Date: Fri, 11 Jan 2013 20:17:50 +0100
Subject: [kvmarm] [PATCH v5.1 0/2] KVM: ARM: Rename KVM_SET_DEVICE_ADDRESS
In-Reply-To: <20130110222801.GB17111@amt.cnet>
References: <1357766143.18196.2@snotra>
 <4F8BA51C-1A21-4ED9-80CE-55ECB01C0AAD@suse.de>
 <20130110222801.GB17111@amt.cnet>
Message-ID: <DE6EF8D6-D999-40E9-8F32-7AE1C4A0EEF9@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 10.01.2013, at 23:28, Marcelo Tosatti wrote:

> On Wed, Jan 09, 2013 at 10:37:20PM +0100, Alexander Graf wrote:
>> 
>>> 
>>>>>> We can start to introduce (and fix ARM) with a generic ioctl in the MPIC patches then.
>>>>> 
>>>>> The ioctl is already generic, except for its name.
>>>> It's making a few wrong assumptions:
>>>> * maximum size of value is u64
>>> 
>>> This is tolerable IMHO.
>>> 
>>>> * combining device id (variable) with addr type id (const) into a single field. It could just be split into multiple fields
>>> 
>>> I agree, but that could be lived with as well.
>>> 
>>> I get that there's a tradeoff between getting something in now, versus waiting until the API is more refined.  Tagging it with a particular ISA seems like an odd way of saying "soon to be deprecated", though.  What happens if we're still squabbling over the perfect replacement API when we're trying to push PPC MPIC stuff in?
> 
> As mentioned, i fail to see the benefit in sharing 0.0x% of the code (the
> interface), while the remaining code is not shared.

Important code sharing happens in user space.

> 
>> Then we're the ones who have to come up with a good interface.
> 
> Or just have KVM_SET_PPC_DEVICE_ADDRESS. Is there a downside to that?

Yes. Harder to read code and a lack of commonality. Also it wouldn't cut it for us, as we need to set more than just addresses. But most of all I really hate to take a generic problem and solve it only for myself.

Btw, x86 has the same issue too, it just only somehow got away with not caring too much about it. The LAPIC has a version register that Mac OS X guests read. If the version is too old, it doesn't boot. So some time ago we just changed the version register.

The real, backwards compatible change however would've been to have user space tell us which version to emulate and set it accordingly. The way we did it basically broke backwards compatibility. We only got away with it because the register is rarely read.


Alex
