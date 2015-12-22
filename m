From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 22 Dec 2015 13:51:23 +0100
Subject: [GIT PULL] UEFI support for 32-bit ARM
In-Reply-To: <20151222123642.GG8644@n2100.arm.linux.org.uk>
References: <CAKv+Gu_QvQnsYk=coEJQrRk94xATT9Fi5=9jCZhLoNUvTU7kJg@mail.gmail.com>
 <20151222123642.GG8644@n2100.arm.linux.org.uk>
Message-ID: <CAKv+Gu8sJdNd4FK2sycCFuQ2c4NC6Gy-a3CJ13NiV69sMqVkzQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 December 2015 at 13:36, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Dec 14, 2015 at 06:10:12PM +0100, Ard Biesheuvel wrote:
[..]
>> The following changes since commit f7d924894265794f447ea799dd853400749b5a22:
>>
>>   arm64/efi: refactor EFI init and runtime code for reuse by 32-bit ARM
>>   (2015-12-09 16:57:23 +0000)
>>
>> are available in the git repository at:
>>
>>   git://git.linaro.org/people/ard.biesheuvel/linux-arm.git \
>>   tags/arm32-efi-for-v4.5
>>
>> for you to fetch changes up to 81a0bc39ea1960bbf8ece6a895d7cfd2d9efa28a:
>>
>>   ARM: add UEFI stub support (2015-12-14 10:38:21 +0100)
>>
[..]
>
> This pull request done in this way makes it _really_ difficult to
> validate that I've pulled what was intended to be pulled.
>
> The point of the diffstat is to be able to compare the resulting
> diffstat from pulling the changes with the one in the message.  In
> this case, because you've omitted some patches at the beginning of
> the series, it doesn't match:
>
>  29 files changed, 986 insertions(+), 368 deletions(-)
>
> So I can't validate it.
>
> Please send a replacement pull request which covers all the patches
> you want me to merge into my tree, thanks.
>

The following changes since commit 31ade3b83e1821da5fbb2f11b5b3d4ab2ec39db8:

  Linux 4.4-rc3 (2015-11-29 18:58:26 -0800)

are available in the git repository at:

  git://git.linaro.org/people/ard.biesheuvel/linux-arm.git
  tags/arm32-efi-for-v4.5

for you to fetch changes up to 81a0bc39ea1960bbf8ece6a895d7cfd2d9efa28a:

  ARM: add UEFI stub support (2015-12-14 10:38:21 +0100)

----------------------------------------------------------------
This implements UEFI kernel support for 32-bit ARM, based on the existing
arm64 support and existing generic early ioremap support. It is based on
commit f7d924894265 ("arm64/efi: refactor EFI init and runtime code for
reuse by 32-bit ARM"), which was pulled from the arm64 repo [1] as branch
'aarch64/efi'

[1] git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git

----------------------------------------------------------------
Ard Biesheuvel (12):
      mm/memblock: add MEMBLOCK_NOMAP attribute to memblock memory table
      arm64: only consider memblocks with NOMAP cleared for linear mapping
      arm64/efi: mark UEFI reserved regions as MEMBLOCK_NOMAP
      arm64/efi: split off EFI init and runtime code for reuse by 32-bit ARM
      arm64/efi: refactor EFI init and runtime code for reuse by 32-bit ARM
      ARM: add support for generic early_ioremap/early_memremap
      ARM: split off core mapping logic from create_mapping
      ARM: factor out allocation routine from __create_mapping()
      ARM: add support for non-global kernel mappings
      ARM: implement create_mapping_late() for EFI use
      ARM: only consider memblocks with NOMAP cleared for linear mapping
      ARM: wire up UEFI init and runtime support

Roy Franz (1):
      ARM: add UEFI stub support

 arch/arm/Kconfig                          |  20 ++
 arch/arm/boot/compressed/Makefile         |   4 +-
 arch/arm/boot/compressed/efi-header.S     | 130 ++++++++++++
 arch/arm/boot/compressed/head.S           |  54 ++++-
 arch/arm/boot/compressed/vmlinux.lds.S    |   7 +
 arch/arm/include/asm/Kbuild               |   1 +
 arch/arm/include/asm/efi.h                |  83 ++++++++
 arch/arm/include/asm/fixmap.h             |  29 ++-
 arch/arm/include/asm/mach/map.h           |   2 +
 arch/arm/include/asm/mmu_context.h        |   2 +-
 arch/arm/kernel/Makefile                  |   1 +
 arch/arm/kernel/efi.c                     |  38 ++++
 arch/arm/kernel/setup.c                   |  10 +-
 arch/arm/mm/init.c                        |   5 +-
 arch/arm/mm/ioremap.c                     |   9 +
 arch/arm/mm/mmu.c                         | 128 ++++++++----
 arch/arm64/include/asm/efi.h              |   9 +
 arch/arm64/kernel/efi.c                   | 334 ++----------------------------
 arch/arm64/mm/init.c                      |   2 +-
 arch/arm64/mm/mmu.c                       |   2 +
 drivers/firmware/efi/Makefile             |   4 +
 drivers/firmware/efi/arm-init.c           | 209 +++++++++++++++++++
 drivers/firmware/efi/arm-runtime.c        | 135 ++++++++++++
 drivers/firmware/efi/efi.c                |   2 +
 drivers/firmware/efi/libstub/Makefile     |   9 +
 drivers/firmware/efi/libstub/arm-stub.c   |   4 +-
 drivers/firmware/efi/libstub/arm32-stub.c |  85 ++++++++
 include/linux/memblock.h                  |   8 +
 mm/memblock.c                             |  28 +++
 29 files changed, 986 insertions(+), 368 deletions(-)
 create mode 100644 arch/arm/boot/compressed/efi-header.S
 create mode 100644 arch/arm/include/asm/efi.h
 create mode 100644 arch/arm/kernel/efi.c
 create mode 100644 drivers/firmware/efi/arm-init.c
 create mode 100644 drivers/firmware/efi/arm-runtime.c
 create mode 100644 drivers/firmware/efi/libstub/arm32-stub.c
