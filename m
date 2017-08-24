From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Thu, 24 Aug 2017 17:17:57 +0900
Subject: [PATCH 00/14] arm64: kexec: add kexec_file_load support
Message-ID: <20170824081811.19299-1-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the initial attempt of implementing kexec_file_load() support
on arm64.[1]
Most of the code is based on kexec-tools (along with some kernel code
from x86 and from powerpc, which also came from kexec-tools).


This patch series enables us to
  * load the kernel, either Image or vmlinux, with kexec_file_load
    system call, and
  * optionally verify its signature at load time for trusted boot.

To load the kernel via kexec_file_load system call, a small change
needs to be applied on kexec-tools. See [2]. This enables '-s' option.

As we discussed a long time ago, users may not be allowed to specify
device-tree file of the 2nd kernel explicitly with kexec-tools, therefore
re-using the blob of the first kernel.

Regarding a method of placing the signature into the kernel binary,
  * for 'Image', we conform with x86 (or rather Microsoft?) style of
    signing since the binary can also be seen as in PE format
    (assuming that CONFIG_EFI is enabled),
  * for 'vmlinux', we follow powerpc approach[3]: The signature will
    be appended just after the binary itself as module signing does.
    This implies that we need to enable CONFIG_MODULE_SIG, too.

    Powerpc is also going to support extended-file-attribute-based
    verification[3], but arm64 doesn't for now partly because we don't
    have TPM-based IMA at this moment.

Accordingly, we can use the existing commands, sbsign and sig-file
respectively, to sign the kernel. Please note that it is totally up to
the system what key/certificate is used for signing.

Some concerns(or future works):
* Even if the kernel is configured with CONFIG_RANDOMIZE_BASE, the 2nd
  kernel won't be placed at a randomized address. We will have to
  add some boot code similar to efi-stub to implement the feature.
* While big-endian kernel can support kernel signing, I'm not sure that
  Image can be recognized as in PE format because x86 standard only
  defines little-endian-based format.
  So I tested big-endian kernel signing only with vmlinux.
* IMA(and file extended attribute)-based kexec


Patch #1 to #7 are all preparatory patches on generic side.
(Patch #1 is not part of mine, but a prerequisite from [4].)
Patch #8 and #9 are purgatory code.
Patch #10 to #12 are common for enabling kexec_file_load.
Patch #13 is for 'Image' support.
Patch #14 is for 'vmlinux' support.


  [1] http://git.linaro.org/people/takahiro.akashi/linux-aarch64.git
	branch:arm64/kexec_file
  [2] http://git.linaro.org/people/takahiro.akashi/kexec-tools.git
	branch:arm64/kexec_file
  [3] http://lkml.iu.edu//hypermail/linux/kernel/1707.0/03669.html
  [4] http://lkml.iu.edu//hypermail/linux/kernel/1707.0/03670.html


AKASHI Takahiro (13):
  include: pe.h: remove message[] from mz header definition
  resource: add walk_system_ram_res_rev()
  kexec_file: factor out vmlinux (elf) parser from powerpc
  kexec_file: factor out crashdump elf header function from x86
  kexec_file: add kexec_add_segment()
  asm-generic: add kexec_file_load system call to unistd.h
  arm64: kexec_file: create purgatory
  arm64: kexec_file: add sha256 digest check in purgatory
  arm64: kexec_file: load initrd, device-tree and purgatory segments
  arm64: kexec_file: set up for crash dump adding elf core header
  arm64: enable KEXEC_FILE config
  arm64: kexec_file: add Image format support
  arm64: kexec_file: add vmlinux format support

Thiago Jung Bauermann (1):
  MODSIGN: Export module signature definitions

 arch/Kconfig                            |   3 +
 arch/arm64/Kconfig                      |  33 ++
 arch/arm64/Makefile                     |   1 +
 arch/arm64/crypto/sha256-core.S_shipped |   2 +
 arch/arm64/include/asm/kexec.h          |  23 ++
 arch/arm64/include/asm/kexec_file.h     |  84 +++++
 arch/arm64/kernel/Makefile              |   5 +-
 arch/arm64/kernel/kexec_elf.c           | 216 ++++++++++++
 arch/arm64/kernel/kexec_image.c         | 112 ++++++
 arch/arm64/kernel/machine_kexec_file.c  | 606 ++++++++++++++++++++++++++++++++
 arch/arm64/purgatory/Makefile           |  43 +++
 arch/arm64/purgatory/entry.S            |  41 +++
 arch/arm64/purgatory/purgatory.c        |  20 ++
 arch/arm64/purgatory/sha256-core.S      |   1 +
 arch/arm64/purgatory/sha256.c           |  79 +++++
 arch/arm64/purgatory/sha256.h           |   1 +
 arch/arm64/purgatory/string.c           |  32 ++
 arch/arm64/purgatory/string.h           |   5 +
 arch/powerpc/Kconfig                    |   1 +
 arch/powerpc/kernel/kexec_elf_64.c      | 464 ------------------------
 arch/x86/kernel/crash.c                 | 324 -----------------
 include/linux/elf.h                     |  62 ++++
 include/linux/ioport.h                  |   3 +
 include/linux/kexec.h                   |  39 ++
 include/linux/module.h                  |   3 -
 include/linux/module_signature.h        |  47 +++
 include/linux/pe.h                      |   2 +-
 include/uapi/asm-generic/unistd.h       |   4 +-
 init/Kconfig                            |   6 +-
 kernel/Makefile                         |   3 +-
 kernel/crash_core.c                     | 333 ++++++++++++++++++
 kernel/kexec_file.c                     |  47 +++
 kernel/kexec_file_elf.c                 | 454 ++++++++++++++++++++++++
 kernel/module.c                         |   1 +
 kernel/module_signing.c                 |  74 ++--
 kernel/resource.c                       |  48 +++
 36 files changed, 2383 insertions(+), 839 deletions(-)
 create mode 100644 arch/arm64/include/asm/kexec_file.h
 create mode 100644 arch/arm64/kernel/kexec_elf.c
 create mode 100644 arch/arm64/kernel/kexec_image.c
 create mode 100644 arch/arm64/kernel/machine_kexec_file.c
 create mode 100644 arch/arm64/purgatory/Makefile
 create mode 100644 arch/arm64/purgatory/entry.S
 create mode 100644 arch/arm64/purgatory/purgatory.c
 create mode 100644 arch/arm64/purgatory/sha256-core.S
 create mode 100644 arch/arm64/purgatory/sha256.c
 create mode 100644 arch/arm64/purgatory/sha256.h
 create mode 100644 arch/arm64/purgatory/string.c
 create mode 100644 arch/arm64/purgatory/string.h
 create mode 100644 include/linux/module_signature.h
 create mode 100644 kernel/kexec_file_elf.c

-- 
2.14.1
