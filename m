From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 19 Jun 2014 11:49:19 +0100
Subject: [PATCHv3 0/4] arm64: simplify restrictions on bootloaders
Message-ID: <1403174963-10730-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This is version 3 of the boot simplification series I posted previously [1,4].
Many thanks to those who reviewed / tested the prior postings.

Changes since v2 [4]
* Rebased to v3.16-rc1 now that the EFI changes have been merged. Fixed
  conflicts in arch/arm64/mm/init.c.
* Added flags field to export kernel endianness.
* Moved the linker script macros to image.h, to hide the magic behind a new
  HEAD_SYMBOLS macro.
* Fixed up the documentation, including some cleanups for the EFI changes. It
  now refers to v3.17, but I can update if this is delayed further.
* Renamed patch 3 as it has absorbed several Image header changes.
Changes since v1 [1]:
* Rebased to Matt Fleming's arm64-efi branch [2] to resolve conflict with the
  EFI stub series in head.S.
* Fixed random TEXT_OFFSET generation to be mawk compatible.
* Removed option to set TEXT_OFFSET explicitly per Catalin's request.
* Remove (invalid) recommendation of 1MB for dynamically initialised data.

For those who have not seen v1 or v2, a rationale and description of the series
follows:

Currently bootloaders have an extremely difficult time protecting memory from
the kernel, as the kernel may clobber memory below TEXT_OFFSET with pagetables,
and above the end of the kernel binary with the BSS.

This series attempts to ameliorate matters by adding a mechanism for bootloaders
to discover the minimum runtime footprint of the kernel image, including the BSS
and any other dynamically initialised data, and moving the initial page tables
into this region.

The currently ill-described image load offset variable is coerced to always be
little-endian. This means that bootloader can actually make use of the field for
any kernel (wither LE or BE), and as the field does not yet seem to be used
anywhere taking endianness into account I hope this is not problematic.
Documentation is updated with recommendations on handling the field. To aid in
encouraging bootloader authors to respect the field, an option is added to
randomize the text_offset field at link time, which may be used in test and/or
distribution kernels. So as to not break existing (but arguably broken) loaders
immediately, this option is hidden under kernel hacking and disabled by default.

The documentation is updated to cover how to use the new image_size field and
what to do if it is zero, and how to use the image_size field to determine
whether the text_offset field is guaranteed to be little-endian. In the absence
of an image_size field, it's not possible to provide a reasonable sensible
value due to configuration-dependent variation -- a recent defconfg kernel had
a ~190KB BSS, while an allyesconfig build (with some features disabled due to
build breakages) had a ~13MB BSS.

A BE conditional 64-bit endianness swapping routine (DATA_LE64) is added to
vmlinux.lds.S, as the linker is the only place we can endianness swap a value
calculated from two symbols known only at link time. There are several existing
headers that do almost the same thing but due to use of C prototypes and/or
casts are not suitable for use in a linker script. A separate series may be able
to unify that.

I've given some light testing to text_offset fuzzing with an updated bootwrapper
[3] which reads the text_offset field at build time to ensure the kernel gets
loaded at the right address. Nothing else is yet moved however, so this may
explode if this location happens to overlap the bootwrapper code, DTB, or
spin-table mbox. I'll try to teach the bootwrapper how to deal with that
shortly.

Cheers,
Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-May/257141.html
[2] git://git.kernel.org/pub/scm/linux/kernel/git/mfleming/efi.git arm64-efi
[3] http://linux-arm.org/git?p=boot-wrapper-aarch64.git;a=shortlog;h=refs/heads/unstable/text-offset
[4] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-May/260076.html

Mark Rutland (4):
  arm64: head.S: remove unnecessary function alignment
  arm64: place initial page tables above the kernel
  arm64: Update the Image header
  arm64: Enable TEXT_OFFSET fuzzing

 Documentation/arm64/booting.txt | 43 ++++++++++++++++++++++------
 arch/arm64/Kconfig.debug        | 16 +++++++++++
 arch/arm64/Makefile             |  4 +++
 arch/arm64/include/asm/image.h  | 62 +++++++++++++++++++++++++++++++++++++++++
 arch/arm64/include/asm/page.h   |  9 ++++++
 arch/arm64/kernel/head.S        | 49 +++++++++++++++-----------------
 arch/arm64/kernel/vmlinux.lds.S | 15 ++++++++++
 arch/arm64/mm/init.c            | 12 +++-----
 8 files changed, 168 insertions(+), 42 deletions(-)
 create mode 100644 arch/arm64/include/asm/image.h

-- 
1.9.1
