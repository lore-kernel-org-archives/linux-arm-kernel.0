From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 06 Dec 2016 22:20:20 +0100
Subject: [Question] New mmap64 syscall?
In-Reply-To: <20161206185440.GA4654@yury-N73SV>
References: <20161206185440.GA4654@yury-N73SV>
Message-ID: <3014428.VXGdOARdm1@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, December 7, 2016 12:24:40 AM CET Yury Norov wrote:

> I see 3 solutions for my problem:
> 1. Reuse aarch64/lp64 mmap code for ilp32 in glibc, but wrap offset with
> SYSCALL_LL64() macro - which converts offset to the pair for 32-bit
> ports. This is simple but local solution. And most probably it's enough.

I wouldn't want arm64 to be different from all other architectures
here for the 32-bit API. The mmap() API used to be done entirely
in architecture specific code, while nowadays at least new architectures
use something resembling sys_mmap_pgoff(). I think that was originally
introduced to be the default API for 32-bit architectures, but it
failed to address architectures with variable page sizes.

> 2. Add new flag to mmap, like MAP_OFFSET_IN_PAIR. This will also work.
> The problem here is that there are too much arches that implement
> their custom sys_mmap2(). And, of course, this type of flags is
> looking ugly.

Right, better not touch make complicate it further. The other problem
is that mmap2() already has six argument and on most architectures
that is the limit for the number of syscall arguments, so you
cannot add another argument for the upper half.

> 3. Introduce new mmap64() syscall like this:
> sys_mmap64(void *addr, size_t len, int prot, int flags, int fd, struct off_pair *off);
> (The pointer here because otherwise we have 7 args, if simply pass off_hi and
> off_lo in registers.)

This wouldn't have to be a pair, just a pointer to a 64-bit number.

> With new 64-bit interface we can deprecate mmap2(), and generalize all
> implementations in kernel.
> 
> I think we can discuss it because 64-bit is the default size for off_t 
> in all new 32-bit architectures. So generic solution may take place.
> 
> The last question here is how important to support offsets bigger than
> 2^44 on 32-bit machines in practice? It may be a case for ARM64 servers,
> which are looking like main aarch64/ilp32 users. If no, we can leave
> things as is, and just do nothing.

If there is a use case for larger than 16TB offsets, we should add
the call on all architectures, probably using your approach 3. I don't
think that we should treat it as anything special for arm64 though.

	Arnd
