From: vbocek@gmail.com (Vojtech Bocek)
Date: Fri, 27 Sep 2013 23:09:13 +0200
Subject: About atags_proc buffer size
In-Reply-To: <20130927204743.GK12758@n2100.arm.linux.org.uk>
References: <5245E9C9.9030509@gmail.com>
 <20130927204743.GK12758@n2100.arm.linux.org.uk>
Message-ID: <5245F3F9.5040004@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It only needs to survive until init_atags_procfs is called, because it is
copied to another buffer for procfs entry. Can I be sure it survives until
that? My guess is that it is likely to survive, but not certain.

I suppose it is possible to somehow protect that bit of ram until it is
read by init_atags_procfs, but I wonder if you even want to do that in
mainline - if majority of devices doesn't use such big tag lists, then
it is probably that device's vendor problem. I've met this problem on two
devices so far though, both of them Android phones, one is the HTC One
(that is MSM APQ8064 SoC) and I unfortunately can't remember the first
one - I discarded it as usual Android kernel's mess.

On 27.9.2013 22:47, Russell King - ARM Linux wrote:

> On Fri, Sep 27, 2013 at 10:25:45PM +0200, Vojtech Bocek wrote:
>> I want to ask something about atags_proc.c implementation. Currently,
>> it uses a buffer to temporarily store atags. The buffer size is set to
>> 1.5kb for some reason, but as far as I know, atag list's size is not
>> limited in any way. I've got a device (HTC One) which uses about 12kb
>> of tags, that means it panics during boot if CONFIG_ATAGS_PROC is
>> enabled, because the buffer contains only part of the tag list without
>> an end tag.
> 
> The tags are supposed to be a short-lived structure which gets used to
> pass barest minimum of details to the kernel, and the data stored in
> them almost certainly gets overwritten before the kernels memory
> allocators are up and running.
> 
> So, we need to statically allocate some space to save these things -
> it can't be done dynamically.
> 
> The problem is this: for the vast majority of platforms, they pass no
> more than 1.5kB (lower case b is *bits* not *bytes*) to the kernel in
> their tagged list.  Having a static allocation of 12k would be wasteful
> for the majority of users.
> 
>> I don't know much about the way ARM boot process works, but I tried to
>> store just the pointer to atag list, and it works fine (quick patch
>> attached). Do atags get erased later in boot process on some platforms,
>> is that the reason why buffer had to be used?
> 
> This may appear to work, but check it after you've been running for
> some time and have exercised the memory systems.  You'll probably find
> that your tags have vanished!
