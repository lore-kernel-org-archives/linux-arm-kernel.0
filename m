From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Mon,  4 Dec 2017 11:57:50 +0900
Subject: [PATCH v7 00/11] arm64: kexec: add kexec_file_load() support
Message-ID: <20171204025801.12161-1-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the seventh round of implementing kexec_file_load() support
on arm64.[1]
Most of the code is based on kexec-tools (along with some kernel code
from x86, which also came from kexec-tools).


This patch series enables us to
  * load the kernel, Image, via kexec_file_load() system call, and
  * optionally verify its signature at load time for trusted boot.

To load the kernel via kexec_file_load() system call, a small change
is also required on kexec-tools. See [2]. This enables '-s' option.
(Please use v7.2.1+ crash utility for v4.14+ kernel)

As we discussed a long time ago, users may not be allowed to specify
device-tree file of the 2nd kernel explicitly with kexec-tools, hence
re-using the blob of the first kernel.

Regarding a kernel image verification, a signature must be presented
along with the binary itself. A signature is basically a hash value
calculated against the whole binary data and encrypted by a key which
will be authenticated by the system's trusted certificate.
Any attempt to read and load a to-be-kexec-ed kernel image through
a system call will be checked and blocked if the binary's hash value
doesn't match its associated signature.

There are two methods available now:
1. implementing arch-specific verification hook of kexec_file_load()
2. utilizing IMA(Integrity Measurement Architecture)[3] appraisal framework

Before my v7, I believed that my patch only supports (1) but am now
confident that (2) comes free if IMA is enabled and properly configured.


(1) Arch-specific verification hook
If CONFIG_KEXEC_VERIFY_SIG is enabled, kexec_file_load() invokes an arch-
defined (and hence file-format-specific) hook function to check for the
validity of kernel binary.

On x86, a signature is embedded into a PE file (Microsoft's format) header
of binary. Since arm64's "Image" can also be seen as a PE file as far as
CONFIG_EFI is enabled, we adopt this format for kernel signing.  

As in the case of UEFI applications, we can create a signed kernel image:
    $ sbsign --key ${KEY} --cert ${CERT} Image

You may want to use certs/signing_key.pem, which is intended to be used
for module sigining (CONFIG_MODULE_SIG), as ${KEY} and ${CERT} for test
purpose.


(2) IMA appraisal-based
IMA was first introduced in linux in order to meet TCG (Trusted Computing
Group) requirement that all the sensitive files be *measured* before
reading/executing them to detect any untrusted changes/modification.
Then appraisal feature, which allows us to ensure the integrity of
files and even prevent them from reading/executing, was added later.

Meanwhile, kexec_file_load() has been merged since v3.17 and evolved to
enable IMA-appraisal type verification by the commit b804defe4297 ("kexec:
replace call to copy_file_from_fd() with kernel version").

In this scheme, a signature will be stored in a extended file attribute,
"security.ima" while a decryption key is hold in a dedicated keyring,
".ima" or "_ima".  All the necessary process of verification is confined
in a secure API, kernel_read_file_from_fd(), called by kexec_file_load().

    Please note that powerpc is one of the two architectures now
    supporting KEXEC_FILE, and that it wishes to exntend IMA,
    where a signature may be appended to "vmlinux" file[4], like module
    signing, instead of using an extended file attribute.

While IMA meant to be used with TPM (Trusted Platform Module) on secure
platform, IMA is still usable without TPM. Here is an example procedure
about how we can give it a try to run the feature using a self-signed
root ca for demo/test purposes:

 1) Generate needed keys and certificates, following "Generate trusted
    keys" section in README of ima-evm-utils[5].

 2) Build the kernel with the following kernel configurations, specifying
    "ima-local-ca.pem" for CONFIG_SYSTEM_TRUSTED_KEYS:
	CONFIG_EXT4_FS_SECURITY
	CONFIG_INTEGRITY_SIGNATURE
	CONFIG_INTEGRITY_ASYMMETRIC_KEYS
	CONFIG_INTEGRITY_TRUSTED_KEYRING
	CONFIG_IMA
	CONFIG_IMA_WRITE_POLICY
	CONFIG_IMA_READ_POLICY
	CONFIG_IMA_APPRAISE
	CONFIG_IMA_APPRAISE_BOOTPARAM
	CONFIG_SYSTEM_TRUSTED_KEYS
    Please note that CONFIG_KEXEC_VERIFY_SIG is not, actually should
    not be, enabled.

 3) Sign(label) a kernel image binary to be kexec-ed on target filesystem:
    $ evmctl ima_sign --key /path/to/private_key.pem /your/Image

 4) Add a command line parameter and boot the kernel:
    ima_appraise=enforce

 On live system,
 5) Set a security policy:
    $ mount -t securityfs none /sys/kernel/security
    $ echo "appraise func=KEXEC_KERNEL_CHECK appraise_type=imasig" \
      > /sys/kernel/security/ima/policy

 6) Add a key for ima:
    $ keyctl padd asymmetric my_ima_key %:.ima < /path/to/x509_ima.der
    (or evmctl import /path/to/x509_ima.der <ima_keyring_id>)

 7) Then try kexec as normal.


Concerns(or future works):
* Even if the kernel is configured with CONFIG_RANDOMIZE_BASE, the 2nd
  kernel won't be placed at a randomized address. We will have to
  add some boot code similar to efi-stub to implement the randomization.
for approach (1),
* While big-endian kernel can support kernel signing, I'm not sure that
  Image can be recognized as in PE format because x86 standard only
  defines little-endian-based format.
* vmlinux support

  [1] http://git.linaro.org/people/takahiro.akashi/linux-aarch64.git
	branch:arm64/kexec_file
  [2] http://git.linaro.org/people/takahiro.akashi/kexec-tools.git
	branch:arm64/kexec_file
  [3] https://sourceforge.net/p/linux-ima/wiki/Home/
  [4] http://lkml.iu.edu//hypermail/linux/kernel/1707.0/03669.html
  [5] https://sourceforge.net/p/linux-ima/ima-evm-utils/ci/master/tree/


Changes in v7 (Dec 4, 2017)
* rebased to v4.15-rc2
* re-organize the patch set to separate KEXEC_FILE_VERIFY_SIG-related
  code from the others
* revamp factored-out code in kernel/kexec_file.c due to the changes
  in original x86 code
* redefine walk_sys_ram_res_rev() prototype due to change of callback
  type in the counterpart, walk_sys_ram_res()
* make KEXEC_FILE_IMAGE_FMT defaut on if KEXEC_FILE selected

Changes in v6 (Oct 24, 2017)
* fix a for-loop bug in _kexec_kernel_image_probe() per Julien

Changes in v5 (Oct 10, 2017)
* fix kbuild errors around patch #3
per Julien's comments,
* fix a bug in walk_system_ram_res_rev() with some cleanup
* modify fdt_setprop_range() to use vmalloc()
* modify fill_property() to use memset()

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


Patch #1 to #9 are essential for KEXEC_FILE support (plus IMA-based
verification):
  Patch #1 to #4 are all preparatory patches on generic side.
  Patch #5 to #8 are common for enabling kexec_file_load.
  Patch #9 is for 'Image'-specific loading.

Patch #10 to #11 are for KEXEC_VERIFY_SIG (arch-specific verification)
support

AKASHI Takahiro (11):
  resource: add walk_system_ram_res_rev()
  kexec_file: factor out arch_kexec_kernel_*() from x86, powerpc
  kexec_file: factor out crashdump elf header function from x86
  asm-generic: add kexec_file_load system call to unistd.h
  arm64: kexec_file: create purgatory
  arm64: kexec_file: load initrd, device-tree and purgatory segments
  arm64: kexec_file: set up for crash dump adding elf core header
  arm64: kexec_file: enable KEXEC_FILE config
  arm64: kexec_file: add Image format support
  include: pe.h: remove message[] from mz header definition
  arm64: kexec_file: enable KEXEC_VERIFY_SIG for Image

 arch/arm64/Kconfig                          |  30 +++
 arch/arm64/Makefile                         |   1 +
 arch/arm64/include/asm/kexec.h              |  93 +++++++
 arch/arm64/kernel/Makefile                  |   4 +-
 arch/arm64/kernel/kexec_image.c             | 105 ++++++++
 arch/arm64/kernel/machine_kexec_file.c      | 368 ++++++++++++++++++++++++++++
 arch/arm64/purgatory/Makefile               |  24 ++
 arch/arm64/purgatory/entry.S                |  55 +++++
 arch/powerpc/include/asm/kexec.h            |   2 +-
 arch/powerpc/kernel/kexec_elf_64.c          |   2 +-
 arch/powerpc/kernel/machine_kexec_file_64.c |  39 +--
 arch/x86/include/asm/kexec-bzimage64.h      |   2 +-
 arch/x86/kernel/crash.c                     | 324 ------------------------
 arch/x86/kernel/kexec-bzimage64.c           |   2 +-
 arch/x86/kernel/machine_kexec_64.c          |  45 +---
 include/linux/ioport.h                      |   3 +
 include/linux/kexec.h                       |  32 ++-
 include/linux/pe.h                          |   2 +-
 include/uapi/asm-generic/unistd.h           |   4 +-
 kernel/kexec_file.c                         | 365 ++++++++++++++++++++++++++-
 kernel/kexec_internal.h                     |  20 ++
 kernel/resource.c                           |  57 +++++
 22 files changed, 1158 insertions(+), 421 deletions(-)
 create mode 100644 arch/arm64/kernel/kexec_image.c
 create mode 100644 arch/arm64/kernel/machine_kexec_file.c
 create mode 100644 arch/arm64/purgatory/Makefile
 create mode 100644 arch/arm64/purgatory/entry.S

-- 
2.14.1
