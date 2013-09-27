From: vbocek@gmail.com (Vojtech Bocek)
Date: Fri, 27 Sep 2013 23:25:14 +0200
Subject: About atags_proc buffer size
In-Reply-To: <20130927211537.GN12758@n2100.arm.linux.org.uk>
References: <5245E9C9.9030509@gmail.com>
 <20130927204743.GK12758@n2100.arm.linux.org.uk> <5245F3F9.5040004@gmail.com>
 <20130927211537.GN12758@n2100.arm.linux.org.uk>
Message-ID: <5245F7BA.6080101@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Okay then, I suppose there is no nice way around that, or at least none
that I can find. I'll just make that initial buffer 12kb big on my kernel
for that device and be done with it.

Anyway, thanks for the information and help, it is much appreciated.

On 27.9.2013 23:15, Russell King - ARM Linux wrote:

> On Fri, Sep 27, 2013 at 11:09:13PM +0200, Vojtech Bocek wrote:
>> It only needs to survive until init_atags_procfs is called, because it is
>> copied to another buffer for procfs entry. Can I be sure it survives until
>> that? My guess is that it is likely to survive, but not certain.
>>
>> I suppose it is possible to somehow protect that bit of ram until it is
>> read by init_atags_procfs, but I wonder if you even want to do that in
>> mainline - if majority of devices doesn't use such big tag lists, then
>> it is probably that device's vendor problem. I've met this problem on two
>> devices so far though, both of them Android phones, one is the HTC One
>> (that is MSM APQ8064 SoC) and I unfortunately can't remember the first
>> one - I discarded it as usual Android kernel's mess.
> 
> We've been through several early allocators - particularly one which
> allocates from the bottom of memory upwards, which would overwrite the
> ATAGs long before init_atags_procfs gets called.
> 
> If we rely on the behaviour of the current early allocator not to
> touch that, and it changes in the future, that's going to be rather
> too fragile.
