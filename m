From: frank.hofmann@tomtom.com (Frank Hofmann)
Date: Wed, 29 Jun 2011 16:14:23 +0100 (BST)
Subject: [RFC PATCH v5] ARM hibernation / suspend-to-disk (fwd)
In-Reply-To: <4E0B3C48.1060101@parrot.com>
References: <alpine.DEB.2.00.1106131303290.25153@localhost6.localdomain6>
	<20110613122601.GC12325@n2100.arm.linux.org.uk>
	<alpine.DEB.2.00.1106131400090.25153@localhost6.localdomain6>
	<20110613164452.GE13643@n2100.arm.linux.org.uk>
	<alpine.DEB.2.00.1106151349520.11405@localhost6.localdomain6>
	<4E0B3C48.1060101@parrot.com>
Message-ID: <alpine.DEB.2.00.1106291555330.2266@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Wed, 29 Jun 2011, Matthieu CASTET wrote:

> Frank Hofmann a ?crit :
>> On Mon, 13 Jun 2011, Russell King - ARM Linux wrote:
>>
>> Hi Russell,
>>
>>
>> this change is perfect; with this, the hibernation support code turns into
>> the attached.
>>
>> That's both better and simpler to perform a full suspend/resume cycle (via
>> resetting in the cpu_suspend "finisher") after the snapshot image has been
>> created, instead of shoehorning a return into this.
>>
>> FrankH.
>
>
>>
>> +
>> +u8 __swsusp_resume_stk[PAGE_SIZE/2] __nosavedata;
> It look like dangerous : there is no alignment constraint, but the stack should
> be aligned on a 8 Bytes.

Uh - sorry. I used to have both the __nosavedata and 
__attribute__((__aligned__(PAGE_SIZE/2))) attributes there. That must've 
gone lost at one point.


It's an artifact of the build that things turn out ok by default; the 
__nosavedata forces a separate section (page), and arch/arm is linked 
before kernel/power (the other user of __nosavedata), hence this block, 
due to the way the kernel build works, ends up just fine.

But as you say, not by intent / declaration.


Have you seen Will Deacon's suggested kexec changes ? That keeps a "reset 
stack" page around, _elsewhere_, and I've been considering using that. In 
the end, all swsusp_arch_resume() really requires is a stack page that's 
guaranteed to be outside the target kernel data, thereby left alone by the 
restore. __nosavedata is merely one way.

>
>
> Matthieu
>
Thanks,

FrankH.
