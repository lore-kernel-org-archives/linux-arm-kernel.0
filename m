From: james.morse@arm.com (James Morse)
Date: Mon, 16 Nov 2015 12:29:52 +0000
Subject: [PATCH v2 11/11] arm64: kernel: Add support for
 hibernate/suspend-to-disk.
In-Reply-To: <20151114213415.GG20429@amd>
References: <1445966960-31724-1-git-send-email-james.morse@arm.com>
 <1445966960-31724-12-git-send-email-james.morse@arm.com>
 <20151114213415.GG20429@amd>
Message-ID: <5649CC40.9010805@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

On 14/11/15 21:34, Pavel Machek wrote:
>> The implementation assumes that exactly the same kernel is booted on the
>> same hardware, and that the kernel is loaded at the same physical address.
> 
> BTW... on newer implementations (and I have patch for x86, too), we
> try to make it so that resume kernel does not have to be same as
> suspend one. It would be nice to move there with arm64, too. 

Yes, that is a neat trick, can I leave it as future work?


>> Signed-off-by: James Morse <james.morse@arm.com>
> 
> Acked-by: Pavel Machek <pavel@ucw.cz>

Thanks!

(I have a fixup for this patch to add a missing __pgprot() in the page
 table copy code.)


>> +/*
>> + * Corrupt memory.
>> + *
> 
> Umm. Really?

Effectively. Until it finishes copying, you have to assume all memory is
corrupt, code, page-tables etc. It was more a tounge-in-cheek reminder to
myself to be careful.


>> + * Because this code has to be copied to a safe_page, it can't call out to
>> + * other functions by pc-relative address. Also remember that it
> 
> PC-relative?

The linker may (often!) use program-counter relative addresses for loads
and stores. This code gets copied, so the linker doesn't know where the
code will be executed from, so any instructions using pc-relative addresses
will get the wrong result, (if they reference something outside the function).


>> + * mid-way through over-writing other functions. For this reason it contains
>> + * a copy of copy_page() and code from flush_icache_range().
>> + *
>> + * All of memory gets written to, including code. We need to clean the kernel
>> + * text to the PoC before secondary cores can be booted. Because kernel modules,
> 
> "the kernel modules" and no ","?

Sure.


>> + * and executable pages mapped to user space are also written as data, we
>> + * clean all pages we touch to the PoU.
> 
> What is PoC and PoU?

They are points in the CPU's cache hierarchy:

ARM processors are of a 'modified Harvard' architecture, their paths to
read instructions and data are different. The 'Point of Unification' is the
first point in the cache hierarchy that is the same for both. On ARM,
flush_icache_range() makes sure code written as data is pushed through any
data caches to this point, and then evicts any stale copies in the
instruction caches.

PoC is the 'Point of Coherency', it is the first point that is the same for
all devices, (e.g. a cpu with caches turned on, and one with them off), it
is normally main memory. The kernel text has to be pushed to this point, so
that secondary cores, while running early-boot code with their MMU and
caches turned off, don't get incorrect code/data from before resume.

I have resisted the urge to draw some ascii-art!



Thanks for your comments,

James
