From: gmbnomis@gmail.com (Simon Baatz)
Date: Sun,  7 Oct 2012 13:29:10 +0200
Subject: [PATCH V2 0/2] fix and improvement of flush(_kernel)_dcache_page()
Message-ID: <1349609352-6408-1-git-send-email-gmbnomis@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The first patch optimizes flush_dcache_page() for non-aliasing VIPT
caches.  On these the flush of the kernel mapping for the anon case is
actually not needed.  It may be needed to ensure I/D coherency, but
this can be handled by __sync_icache_dcache() later and more
effectively (similar to arm64, see [3]).  Thus, we should be lazy as
well here and just clear the PG_dcache_clean bit.

The second patch is another attempt to fix the regression caused by
patch f8b63c1 "ARM: 6382/1" in 2.6.37 (see [2]).  The problem occurs
on VIVT (and probably VIPT aliasing) cache architectures for drivers
that use flush_kernel_dcache_page().  For example, 3.6 (as any
kernel beginning with 2.6.37) on kirkwood using mv_cesa produces data
corruption when using direct I/O:

~# cryptsetup luksOpen /dev/sda2 c_sda2
Enter passphrase for /dev/sda2: 
~# dd if=/dev/mapper/c_sda2 iflag=direct bs=4k count=16 2>/dev/null | sha1sum 
9ae4997ec85ad9b7ab4b10341e42ace80f0ea5d6  -
~# dd if=/dev/mapper/c_sda2 bs=4k count=16 2>/dev/null | sha1sum
ca39c5d4950b3704eff952c48e383bf1db20532e  -

(The mv_cesa driver uses the scatterlist memory iterator, which uses
flush_kernel_dcache_page() before kunmap()).

As described in [1], both flush_dcache_page() and
flush_kernel_dcache_page() need to handle the following cases:
- page cache pages with no user space mapping
- page cache pages with user space mapping(s)
- flush the kernel mapping of anonymous pages

The last one is contradictory to documentation for flush_dcache_page(),
but many uses in the kernel require it (drivers use it to flush
modifications via the kernel mapping).

In the proposed patch the implementation of flush_kernel_dcache_page()
follows the one of flush_dcache_page(), but only flushes the kernel
mapping, not the alias user mapping(s).

I could only test this on kirkwood (ARMv5, VIVT) and raspberry pi
BCM2835 (ARMv6, PIPT / VIPT nonaliasing data cache).  More testing
would probably be a good thing...  Especially, I could not test the
non-aliasing cache case with a real driver using
flush_kernel_dcache_page() (mv_cesa on dove could be a test case for
this).


Changes:

in V2:
- Followed Catalin's suggestion to reverse the order of the patches
- Clarified comment for flush_dcache_page()


- Simon

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2012-August/113908.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2012-May/101795.html
[3] https://lkml.org/lkml/2012/9/12/121



Simon Baatz (2):
  ARM: remove unnecessary flush of anon pages in flush_dcache_page()
  ARM: Handle user space mapped pages in flush_kernel_dcache_page

 arch/arm/include/asm/cacheflush.h |    4 ++
 arch/arm/mm/flush.c               |   87 +++++++++++++++++++++++++++++--------
 2 files changed, 72 insertions(+), 19 deletions(-)

-- 
1.7.9.5
