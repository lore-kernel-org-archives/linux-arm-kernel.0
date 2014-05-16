From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 16 May 2014 10:50:35 +0100
Subject: [PATCH 0/4] arm64: simplify restrictions on bootloaders
Message-ID: <1400233839-15140-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently bootloaders have an extremely difficult time protecting memory from
the kernel, as the kernel may clobber memory below TEXT_OFFSET with pagetables,
and above the end of the kernel binary with the BSS.

This series attempts to ameliorate matters by adding a mechanism for
bootloaders to discover the minimum runtime footprint of the kernel image,
including the BSS and any other dynamically initialised data, and moving the
initial page tables into this region.

The currently ill-described image load offset variable is coerced to always be
little-endian. This means that bootloader can actually make use of the field
for any kernel (wither LE or BE), and as the field does not yet seem to be used
anywhere taking endianness into account I hope this is not problematic.
Documentation is updated with recommendations on handling the field. To aid in
encouraging bootloader authors to respect the field, an option is added to
randomize the text_offset field at link time, which may be used in test and/or
distribution kernels. So as to not break existing (but arguably broken) loaders
immediately, this option is hidden under kernel hacking and disabled by
default.

The documentation is updated to cover how to use the new image_size field and
what to do if it is zero, and how to use the image_size field to determine
whether the text_offset field is guaranteed to be little-endian. The
recommended fallback reservation of 1MB is an arbitrary large value; for me
_end - _edata was ~190k for a defconfig build on v3.14 with patch 1 applied.
I'm happy to increase this to a larger arbitrary value if this seems too small.

A BE conditional 64-bit endianness swapping routine (DATA_LE64) is added to
vmlinux.lds.S, as the linker is the only place we can endianness swap a value
calulated from two symbols known only at link time. There are several existing
headers that do almost the same thing but due to use of C prototypes and/or
casts are not suitable for use in a linker script. A separate series may be
able to unify that.

This series applies to v3.15-rc5, and is not based on the EFI stub patches.
However I believe the field I've chosen to use is available even with the EFI
stub patches and shouldn't need to be moved around. I'm happy to rebase as
necessary.

I've given some light testing to text_offset fuzzing with an updated
bootwrapper [1] which reads the text_offset field at build time to ensure the
kernel gets loaded at the right address. Nothing else is yet moved however, so
this may explode if this location happens to overlap the bootwrapper code, DTB,
or spin-table mbox. I'll try to teach the bootwrapper how to deal with that
shortly.

Cheers,
Mark.

[1] http://linux-arm.org/git?p=boot-wrapper-aarch64.git;a=shortlog;h=refs/heads/unstable/text-offset

Mark Rutland (4):
  arm64: head.S: remove unnecessary function alignment
  arm64: place initial page tables above the kernel
  arm64: export effective Image size to bootloaders
  arm64: Enable TEXT_OFFSET fuzzing

 Documentation/arm64/booting.txt | 28 +++++++++++++++++++-----
 arch/arm64/Kconfig.debug        | 31 +++++++++++++++++++++++++++
 arch/arm64/Makefile             |  6 +++++-
 arch/arm64/include/asm/page.h   |  9 ++++++++
 arch/arm64/kernel/head.S        | 47 +++++++++++++++++++----------------------
 arch/arm64/kernel/vmlinux.lds.S | 40 +++++++++++++++++++++++++++++++++++
 arch/arm64/mm/init.c            | 12 ++++-------
 7 files changed, 134 insertions(+), 39 deletions(-)

-- 
1.9.1
