From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Mon,  2 Oct 2017 15:14:21 +0900
Subject: [PATCH v4 00/10] arm64: kexec: add kexec_file_load() support
Message-ID: <20171002061431.11117-1-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the fourth round of implementing kexec_file_load() support
on arm64.[1]
Most of the code is based on kexec-tools (along with some kernel code
from x86, which also came from kexec-tools).


This patch series enables us to
  * load the kernel, Image, with kexec_file_load system call, and
  * optionally verify its signature at load time for trusted boot.

To load the kernel via kexec_file_load system call, a small change
is also needed to kexec-tools. See [2]. This enables '-s' option.

As we discussed a long time ago, users may not be allowed to specify
device-tree file of the 2nd kernel explicitly with kexec-tools, hence
re-using the blob of the first kernel.

Regarding a signing method, we conform with x86 (or rather Microsoft?)
style of signing since the binary can also be seen as in PE format
(assuming that CONFIG_EFI is enabled).

    Powerpc is also going to support extended-file-attribute-based
    verification[3] with vmlinux, but arm64 doesn't for now partly
    because we don't have TPM-based IMA at this moment.

Accordingly, we can use the existing command, sbsign, to sign the kernel.

    $ sbsign --key ${KEY} --cert ${CERT} Image

Please note that it is totally up to the system what key/certificate is
used for signing, but one of easy ways to *try* this feature is to turn on
CONFIG_MODULE_SIG so that we can reuse certs/signing_key.pem as a signing
key, KEY and CERT above, for kernel.
(This also enables CONFIG_CRYPTO_SHA1 by default.)


Some concerns(or future works):
* Even if the kernel is configured with CONFIG_RANDOMIZE_BASE, the 2nd
  kernel won't be placed at a randomized address. We will have to
  add some boot code similar to efi-stub to implement the feature.
* While big-endian kernel can support kernel signing, I'm not sure that
  Image can be recognized as in PE format because x86 standard only
  defines little-endian-based format.
* IMA(and extended file attribute)-based kexec
* vmlinux support

  [1] http://git.linaro.org/people/takahiro.akashi/linux-aarch64.git
	branch:arm64/kexec_file
  [2] http://git.linaro.org/people/takahiro.akashi/kexec-tools.git
	branch:arm64/kexec_file
  [3] http://lkml.iu.edu//hypermail/linux/kernel/1707.0/03669.html


Changes in v4 (Oct 2, 2017)
* reinstate x86's arch_kexec_kernel_image_load()
* rename weak arch_kexec_kernel_xxx() to _kexec_kernel_xxx() for
  better re-use
* constify kexec_file_loaders[]

Changes in v3 (Sep 15, 2017)
* fix kbuild test error
* factor out arch_kexec_kernel_*() & arch_kimage_file_post_load_cleanup()
* remove CONFIG_CRASH_CORE guard from kexec_file.c
* add vmapped kernel region to vmcore for gdb backtracing
  (see prepare_elf64_headers())
* merge asm/kexec_file.h into asm/kexec.h
* and some cleanups

Changes in v2 (Sep 8, 2017)
* move core-header-related functions from crash_core.c to kexec_file.c
* drop hash-check code from purgatory
* modify purgatory asm to remove arch_kexec_apply_relocations_add()
* drop older kernel support
* drop vmlinux support (at least, for this series)

Patch #1 to #5 are all preparatory patches on generic side.
Patch #6 is purgatory code.
Patch #7 to #9 are common for enabling kexec_file_load.
Patch #10 is for 'Image' support.

AKASHI Takahiro (10):
  include: pe.h: remove message[] from mz header definition
  resource: add walk_system_ram_res_rev()
  kexec_file: factor out arch_kexec_kernel_*() from x86, powerpc
  kexec_file: factor out crashdump elf header function from x86
  asm-generic: add kexec_file_load system call to unistd.h
  arm64: kexec_file: create purgatory
  arm64: kexec_file: load initrd, device-tree and purgatory segments
  arm64: kexec_file: set up for crash dump adding elf core header
  arm64: enable KEXEC_FILE config
  arm64: kexec_file: add Image format support

 arch/arm64/Kconfig                          |  29 +++
 arch/arm64/Makefile                         |   1 +
 arch/arm64/include/asm/kexec.h              |  93 +++++++
 arch/arm64/kernel/Makefile                  |   4 +-
 arch/arm64/kernel/kexec_image.c             | 105 ++++++++
 arch/arm64/kernel/machine_kexec_file.c      | 365 +++++++++++++++++++++++++++
 arch/arm64/purgatory/Makefile               |  24 ++
 arch/arm64/purgatory/entry.S                |  55 +++++
 arch/powerpc/kernel/kexec_elf_64.c          |   2 +-
 arch/powerpc/kernel/machine_kexec_file_64.c |  36 +--
 arch/x86/kernel/crash.c                     | 324 ------------------------
 arch/x86/kernel/kexec-bzimage64.c           |   2 +-
 arch/x86/kernel/machine_kexec_64.c          |  45 +---
 include/linux/ioport.h                      |   3 +
 include/linux/kexec.h                       |  32 ++-
 include/linux/pe.h                          |   2 +-
 include/uapi/asm-generic/unistd.h           |   4 +-
 kernel/kexec_file.c                         | 371 +++++++++++++++++++++++++++-
 kernel/kexec_internal.h                     |  20 ++
 kernel/resource.c                           |  59 +++++
 20 files changed, 1159 insertions(+), 417 deletions(-)
 create mode 100644 arch/arm64/kernel/kexec_image.c
 create mode 100644 arch/arm64/kernel/machine_kexec_file.c
 create mode 100644 arch/arm64/purgatory/Makefile
 create mode 100644 arch/arm64/purgatory/entry.S

-- 
2.14.1
