From: josh.beavers@gmail.com (Josh Beavers)
Date: Fri, 10 Mar 2017 14:20:45 -0500
Subject: Managing shared buffers on VIVT cache systems
In-Reply-To: <20170310105922.GS21222@n2100.armlinux.org.uk>
References: <CAE=AiOO4J1qGjZb5dqhniQ04aV+WBh4HU+TLsDbXgkrATB8iiw@mail.gmail.com>
 <20170310105922.GS21222@n2100.armlinux.org.uk>
Message-ID: <CAE=AiOOwycY2XcFESotYaFuZ4gazU9HvQoQBGebZJZ73dASDCw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russel,

Thank you for the fast and outstanding explanation!  I did not expect
such a thorough response.


On Fri, Mar 10, 2017 at 5:59 AM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> There are essentially two options:
> (a) flush the cache for _each_ virtual alias whenever you modify the
>     data via one of those aliases.
> (b) map the memory uncacheable, so that aliases do not happen in the
>     first place.
>
> Under Linux on ARM with VIVT caches, we do a mixture of both with the
> page cache and multiple userspace mmap()s.  The page cache tends to
> always have a kernel mapping which aliases with any userspace mapping.
> Whenever the kernel writes to its mapping, it calls flush_dcache_page(),
> which flushes the kernel mapping, and then calls into
> __flush_dcache_aliases() to flush all the currently visible userspace
> aliases.
>
> When userspace sets up multiple mmap()s for the same _shared mapping_
> memory in the same process address space, then the code in
> make_coherent() triggers to make the mappings uncacheable, since
> userspace is allowed to write to any alias and read the updated data
> from any alias without issuing cache flushes.

I can manually call flush_dcache_page() (which calls
__flush_dcache_aliases()) after the kernel writes to a shared buffer
and before the kernel reads from a shared buffer.  Am I understanding
correctly that this is a proper solution even on a VIVT system, as
long as vmalloc() / vmalloc_user() are not used?

I did not realize it was possible to make mappings uncatchable with
make_coherent().  Is this something that will happen automatically
when a properly mapped buffer is used, or something that requires
careful userspace sequencing (mapping / unmapping on the fly, etc.)?
I do not fully grasp the make_coherent() path, though I am about to
instrument up a calltrace.


> Now for the bit you're not going to like: There is no support in Linux
> for coherency between vmalloc() mappings and userspace mappings on VIVT
> systems.

Are there any particular allocation paradigms that would be best for
refactoring vmalloc_user() out of a driver?


Thanks again,
-J
