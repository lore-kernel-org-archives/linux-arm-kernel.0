From: ynorov@caviumnetworks.com (Yury Norov)
Date: Wed, 7 Dec 2016 16:04:51 +0530
Subject: [Question] New mmap64 syscall?
In-Reply-To: <3014428.VXGdOARdm1@wuerfel>
References: <20161206185440.GA4654@yury-N73SV>
 <3014428.VXGdOARdm1@wuerfel>
Message-ID: <20161207103451.GA869@yury-N73SV>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 06, 2016 at 10:20:20PM +0100, Arnd Bergmann wrote:
> On Wednesday, December 7, 2016 12:24:40 AM CET Yury Norov wrote:
> > 3. Introduce new mmap64() syscall like this:
> > sys_mmap64(void *addr, size_t len, int prot, int flags, int fd, struct off_pair *off);
> > (The pointer here because otherwise we have 7 args, if simply pass off_hi and
> > off_lo in registers.)
> 
> This wouldn't have to be a pair, just a pointer to a 64-bit number.
> 
> > With new 64-bit interface we can deprecate mmap2(), and generalize all
> > implementations in kernel.
> > 
> > I think we can discuss it because 64-bit is the default size for off_t 
> > in all new 32-bit architectures. So generic solution may take place.
> > 
> > The last question here is how important to support offsets bigger than
> > 2^44 on 32-bit machines in practice? It may be a case for ARM64 servers,
> > which are looking like main aarch64/ilp32 users. If no, we can leave
> > things as is, and just do nothing.
> 
> If there is a use case for larger than 16TB offsets, we should add
> the call on all architectures, probably using your approach 3. I don't
> think that we should treat it as anything special for arm64 though.

>From this point of view, 16+TB offset is a matter of 16+TB storage,
and it's more than real. The other consideration to add it is that
we have 64-bit support for offsets in syscalls like sys_llseek().
So mmap64() will simply extend this support.

I can prepare this patch. Some implementation details I'd like to
clarify:
Syscall declaration:
SYSCALL_DEFINE6(mmap64, unsigned long, addr, unsigned long, len,
                unsigned long, prot, unsigned long, flags,
                unsigned long, fd, unsigned long long *, offset);

sys_mmap64() deprecates sys_mmap2(), and __ARCH_WANT_MMAP2 is
introduced to keep it enabled for all existing architectures.
All modern arches (aarch64/ilp32 is the first candidate) will have
mmap64() only. The example is set/getrlimit() or renameat() drop
patches (b0da6d44).
                                
On GLIBC side, __OFF_T_MATCHES_OFF64_t will wire mmap() from
linux/generic/wordsize32/mmap.c to mmap64() from linux/mmap64.c. 

mmap64() will first try __NR_mmap64, and if not defined, or ENOSYS
is returned, __NR_mmap2 will be called. This is to let userspace that
supports both mmap2() and mmap64() have full 64-bit offset support, not
44-bit one.

For __NR_mmap2 case, I'd also add the check against offsets more than
2^44, and set errno to EOVERFLOW in that case.

Any thoughts?

Yury.
