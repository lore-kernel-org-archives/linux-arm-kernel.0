From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 27 May 2014 14:18:26 +0100
Subject: [PATCHv2 0/4] arm64: simplify restrictions on bootloaders
Message-ID: <1401196710-6290-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This is version 2 of the boot simplification series I posted previously [1].
Many thanks to those who reviewed / tested the first posting.

Changes since v1 [1]:
* Rebased to Matt Fleming's arm64-efi branch [2] to resolve conflict with the
  EFI stub series in head.S.
* Fixed random TEXT_OFFSET generation to be mawk compatible.
* Removed option to set TEXT_OFFSET explicitly per Catalin's request.
* Remove (invalid) recommendation of 1MB for dynamically initialised data.

Laura, due to having to alter head.S to fix a conflict with the EFI stub series,
I've dropped your tested-by from patch 3. While I don't expect a functional
regression it seemed significant enough to drop the tag.

For those who have not seen v1, a rationale and description of the series
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

Mark Rutland (4):
  arm64: head.S: remove unnecessary function alignment
  arm64: place initial page tables above the kernel
  arm64: export effective Image size to bootloaders
  arm64: Enable TEXT_OFFSET fuzzing

 Documentation/arm64/booting.txt | 29 ++++++++++++++++++++-----
 arch/arm64/Kconfig.debug        | 16 ++++++++++++++
 arch/arm64/Makefile             |  4 ++++
 arch/arm64/include/asm/page.h   |  9 ++++++++
 arch/arm64/kernel/head.S        | 47 +++++++++++++++++++----------------------
 arch/arm64/kernel/vmlinux.lds.S | 40 +++++++++++++++++++++++++++++++++++
 arch/arm64/mm/init.c            | 12 ++++-------
 7 files changed, 119 insertions(+), 38 deletions(-)

-- 
1.9.1
