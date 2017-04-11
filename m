From: ynorov@caviumnetworks.com (Yury Norov)
Date: Wed, 12 Apr 2017 00:52:34 +0400
Subject: [PATCH v7 resend 00/20] ILP32 for ARM64
In-Reply-To: <18edebeb-201e-a9d6-7e66-6e34f98a40df@redhat.com>
References: <1488395968-14313-1-git-send-email-ynorov@caviumnetworks.com>
 <20170410194740.GA28503@yury-N73SV>
 <20170411113334.GA27857@e104818-lin.cambridge.arm.com>
 <20170411183636.GB5091@yury-N73SV>
 <18edebeb-201e-a9d6-7e66-6e34f98a40df@redhat.com>
Message-ID: <20170411205234.GA26665@yury-N73SV>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 11, 2017 at 08:42:24PM +0200, Florian Weimer wrote:
> On 04/11/2017 08:36 PM, Yury Norov wrote:
> >>Also, the latest benchmarks I've seen were mostly for user space
> >>while I'm more concerned with the user-kernel interface
> >>(https://marc.info/?l=linux-arm-kernel&m=148690490713310&w=2).
> >
> >>On the glibc testing side, have the regressions been identified/fixed?
> >
> >I run LTP for testing the ABI and kernel, and there is no failures in
> >ltplite scenario. With glibc testsuite, there's only 3 failures
> >comparing to lp64. (Steve, fix me if something changed.) This is
> >slides on ilp32 from Linaro Connect, hope you'll find it useful.
> >
> >https://docs.google.com/presentation/d/1TKZqgH0XJUgMMGkw2fJA3Lzr57slht1sGKYJVBJTNM4/edit?usp=sharing
> 
> The listed failures are:
> 
> misc/tst-sync_file_range
> nptl/tst-stack4
> malloc/tst-mallocstate
> 
> If necessary, I will fix malloc/tst-mallocstate once there's support for a
> new architecture in build-many-glibcs.py.  The failure is
> architecture-independent, it's related to the lack of a compat symbol and
> the difficulty of checking for that at the Makefile or test level.
> 
> nptl/tst-stack4 is also a generic failure, I think.

That would be great, thanks.

> misc/tst-sync_file_range is probably a real failure related to argument
> passing.  I think this system call was problematic on other architectures,
> too.

At first glance, it's pretty trivial, both on glibc and kernel side:

GLIBC:
int
sync_file_range (int fd, __off64_t offset, __off64_t len, unsigned int flags)
{
#if defined (__NR_sync_file_range2)
  return SYSCALL_CANCEL (sync_file_range2, fd, flags, SYSCALL_LL64 (offset),
                         SYSCALL_LL64 (len));
#elif defined (__NR_sync_file_range)
  return SYSCALL_CANCEL (sync_file_range, fd,
                         __ALIGNMENT_ARG SYSCALL_LL64 (offset),
                         SYSCALL_LL64 (len), flags);
#endif
}

And kernel:
ENTRY(compat_sys_sync_file_range2_wrapper)
        regs_to_64      x2, x2, x3
        regs_to_64      x3, x4, x5
        b       sys_sync_file_range2
ENDPROC(compat_sys_sync_file_range2_wrapper)

Anyway, I'll check everything and report here.

Yury
