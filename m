From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 19 Nov 2015 11:36:20 -0800
Subject: Executable mapping of on-chip registers through /dev/mem?
In-Reply-To: <20151119151728.GZ8644@n2100.arm.linux.org.uk>
References: <564CC192.1000907@gmail.com>
 <20151119151728.GZ8644@n2100.arm.linux.org.uk>
Message-ID: <564E24B4.1080302@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/11/15 07:17, Russell King - ARM Linux wrote:
> On Wed, Nov 18, 2015 at 10:21:06AM -0800, Florian Fainelli wrote:
>> It turns out, that we can re-create that condition just that by opening
>> /dev/mem and calling mmap() with PROT_EXEC, giving the physical base
>> address of the register range (0xF000_0000 typically on these
>> platforms), and a mapping size which spans the entire register range
>> (32MB), although smaller mapping size also exhibit the problem, just a
>> little slower.
> 
> There's two ways of looking at this:
> 1. the kernel should protect against it and prevent you creating an
>    executable /dev/mem mapping
> 2. only root can create these mappings (provided the permissions are
>    set sanely on /dev/mem) and this is just another way for root to
>    hang themselves.
> 
> Someone may have valid reasons to be able to open /dev/mem, map it
> executable, and execute code there - for example, an expansion ROM,
> some platform specific code, etc.  So I'd be very nervous about
> changing the behaviour and causing userspace regressions.
> 
> In my mind, it's a case of "if it hurts when I do X then don't do X".
> 
>> Tracing through the calls from drivers/char/mem.c, we have this:
>>
>> drivers/char/mem.c:
>> mmap_mem()
>> 	ARM does define __HAVE_PHYS_MEM_ACCESS_PROT and we have
>> CONFIG_MEM_DMA_BUFFERABLE=y for our V7 builds here
>>
>> arch/arm/mm/mmu.c:
>> 	-> phys_mem_access_prot()
>> 		-> !pfn_valid(pfn) is true
>> 			-> pgprot_uncached()
>>
>> If I do change the pgprot value to also include the XN bit, this problem
>> never occurs, because we satisfy the piece of hardware checking for the
>> executable bit (or lack, thereof) in the mapping.
> 
> Yes, but you're changing the permissions that _any_ pgprot_uncached()
> mapping gets to be different from what the user requested.  At best,
> if we're saying we want to deny executable mappings of /dev/mem, we
> should return an error if userspace tries to request such a mapping.

Well, what I ended-up doing was directly using __pgprot_modify() locally
in phys_mem_access_prot() when !pfn_valid() is true, but that is still
too broad, not changing the definition of pgprot_uncached(), precisely
as this would break other areas.

We do not want to deny executable mappings through /dev/mem for the
entire range the mapping is established, just if it falls within a
platform-specific problematic region. The more I think about it, and the
more I think we might be able to solve this by simply documenting this
as a caveat/feature of the platform rather than looking for something
overly complicated involving adding machine-specific register space
knowledge and acting upon this.

> 
> However, there's an issue here which is not obvious: when you don't
> have an XN bit, then the kernel has assumptions that when you request
> read but without execute permission, you'll end up with read _and_
> execute permission.  In other words, on older CPUs, even if you
> request in userspace a PROT_READ mapping, the kernel will silently
> translate that to PROT_READ | PROT_EXEC internally.  So denying a
> PROT_EXEC mapping will result in /dev/mem being useless on older CPUs
> as you'd never be able to create any mapping of it.

I see, we clearly do not want that, I agree.

> 
>> What is is not really clear to me, is whether we are creating a new
>> mapping of this 32MB register range on this SoC, with an uncached
>> mapping + executable bit set, or we are modifying the existing mapping
>> in that case?
> 
> You're creating a new mapping in the userspace address range, it's not
> a new mapping in kernel space.
> 
>> - having a better way to determine if the pfn falls within existing
>> register mappings? But without a map_io() or putting that information in
>> Device Tree, how am I sure this is an exhaustive range?
> 
> Is there really some problem with having userspace avoid using
> PROT_EXEC when mapping /dev/mem, which all round seems to be the
> correct solution here ?

Well, no and yes. No because, this clearly is a simple fix, that can be
documented as such. Yes in the sense that this particular platform is
sensitive to such a thing, and can lead to particularly difficult
debugging exercises with the platform users. As I just learned, some
other people decided that open-coding a /dev/mem like was a brilliant
idea, which sort of motivated me for looking into a kernel-level
solution to stop that from happening.

Appreciate your answer, thanks!
-- 
Florian
