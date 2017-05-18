From: dsafonov@virtuozzo.com (Dmitry Safonov)
Date: Thu, 18 May 2017 14:22:57 +0300
Subject: [PATCH] ARM/shmem: Drop page coloring align for non-VIPT CPUs
In-Reply-To: <20170425173546.GS17774@n2100.armlinux.org.uk>
References: <20170414100953.4703-1-dsafonov@virtuozzo.com>
 <571024bf-892d-4d08-dd9e-654b1e28c23e@virtuozzo.com>
 <20170425173546.GS17774@n2100.armlinux.org.uk>
Message-ID: <4ba91200-3bc7-e6b0-69c1-40430b1b7e05@virtuozzo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/25/2017 08:35 PM, Russell King - ARM Linux wrote:
> On Tue, Apr 25, 2017 at 08:19:21PM +0300, Dmitry Safonov wrote:
>> On 04/14/2017 01:09 PM, Dmitry Safonov wrote:
>>> On ARMv6 CPUs with VIPT caches there are aliasing issues: if two
>>> different cache line indexes correspond to the same physical
>>> address, then changes made to one of the alias might be lost
>>> or they can overwrite each other. To overcome aliasing issues,
>>> the align for shared mappings was introduced with:
>>>
>>> commit 4197692eef113eeb8e3e413cc70993a5e667e5b8
>>> Author: Russell King <rmk@flint.arm.linux.org.uk>
>>> Date:   Wed Apr 28 22:22:33 2004 +0100
>>>
>>>      [ARM] Fix shared mmap()ings for ARM VIPT caches.
>>>
>>>      This allows us to appropriately align shared mappings on VIPT caches
>>>      with aliasing issues.
>>>
>>> Which introduced 4 pages align with SHMLBA, which resulted in
>>> unique physical address after any tag in cache (because two upper bits
>>> corresponding to page address get unused in tags).
>>>
>>> As this workaround is not needed by non-VIPT caches (like most armv7
>>> CPUs which have PIPT caches), ARM mmap() code checks if cache is VIPT
>>> aliasing for MAP_SHARED.
>>>
>>> The problem here is in shmat() syscall:
>>> 1. if shmaddr is NULL then do_shmat() uses arch_get_unmapped_area()
>>>     to allocate shared mapping.
>>> 2. if shmaddr is specified then do_shmat() checks that address has
>>>     SHMLBA alignment regardless to CPU cache aliasing.
>>>
>>> Which results on ARMv7 CPUs that shmat() with NULL shmaddr may return
>>> non-SHMLBA aligned address (page-aligned), but shmat() with the same
>>> address will fail.
>>>
>>> That is not critical issue for CRIU as after shmat() with NULL address,
> 
> CRIU?  Please try to keep use of acronyms to a minimum.
> 
>>> we can mremap() resulted shmem to restore shared memory mappings on the
>>> same address where they were on checkpointing.
>>> But it's still worth fixing because we can't reliably tell from
>>> userspace if the platform has VIPT cache, and so this mremap()
>>> workaround is done with HUGE warning that restoring application, that
>>> uses SHMBLA-unaligned shmem on ARMv6 CPU with VIPT cache may result
>>> in data corruptions.
>>>
>>> I also changed SHMLBA build-time check to init-time WARN_ON(), as
>>> it's not constant afterward.
> 
> I'm not happy with this.  SHMLBA is defined by POSIX to be a constant,
> which means that if we want to have any kind of binary compatibility
> between different architecture versions, SHMLBA must be constant across
> all variants of the architecture.
> 
> Making it dependent on the cache architecture means that userspace's
> assumptions can be broken.  Increasing it is not an issue (since SHMLBA
> is defined to be the address multiple - an address that is aligned to
> 4-page is also by definition aligned to 1-page.)  So what I did back in
> 2004 wasn't a problem.
> 
> However, reducing it (as you're now suggesting) is - newly built programs
> are built today with:
> 
> #define SHMLBA              (__getpagesize () << 2)
> 
> so we must not allow the kernel to return addresses that violate that.
> As I say, we can't reduce SHMLBA now.

So, we violate this on return address with shmat(smid, NULL, shmflg)
when shmaddr == 0.
But we don't do this on shmat(smid, shmaddr, shmflg)
where shmaddr should be SHMLBA-aligned.

That API looks unexpected and creates difficulties, which I've
workarounded in CRIU, but still might worth fixing.

-- 
              Dmitry
