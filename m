From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 22 Dec 2015 12:36:42 +0000
Subject: [GIT PULL] UEFI support for 32-bit ARM
In-Reply-To: <CAKv+Gu_QvQnsYk=coEJQrRk94xATT9Fi5=9jCZhLoNUvTU7kJg@mail.gmail.com>
References: <CAKv+Gu_QvQnsYk=coEJQrRk94xATT9Fi5=9jCZhLoNUvTU7kJg@mail.gmail.com>
Message-ID: <20151222123642.GG8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 14, 2015 at 06:10:12PM +0100, Ard Biesheuvel wrote:
> NOTE: this pull request is based on a stable, shared branch published
> by the arm64 maintainers. This means that pulling the
> arm32-efi-for-v4.5 tag will pull the following patches along with the
> patches listed below:
> 
> f7d924894265 arm64/efi: refactor EFI init and runtime code for reuse
> by 32-bit ARM
> e5bc22a42e4d arm64/efi: split off EFI init and runtime code for reuse
> by 32-bit ARM
> 4dffbfc48d65 arm64/efi: mark UEFI reserved regions as MEMBLOCK_NOMAP
> 68709f45385a arm64: only consider memblocks with NOMAP cleared for
> linear mapping
> bf3d3cc580f9 mm/memblock: add MEMBLOCK_NOMAP attribute to memblock memory table
> 
> @Will: please advise when you intend to send these to -next. Thanks.
> 
> The following changes since commit f7d924894265794f447ea799dd853400749b5a22:
> 
>   arm64/efi: refactor EFI init and runtime code for reuse by 32-bit ARM
>   (2015-12-09 16:57:23 +0000)
> 
> are available in the git repository at:
> 
>   git://git.linaro.org/people/ard.biesheuvel/linux-arm.git \
>   tags/arm32-efi-for-v4.5
> 
> for you to fetch changes up to 81a0bc39ea1960bbf8ece6a895d7cfd2d9efa28a:
> 
>   ARM: add UEFI stub support (2015-12-14 10:38:21 +0100)
> 
> ----------------------------------------------------------------
> This implements UEFI kernel support for 32-bit ARM, based on the existing
> arm64 support and existing generic early ioremap support. It is based on
> commit f7d924894265 ("arm64/efi: refactor EFI init and runtime code for
> reuse by 32-bit ARM"), which was pulled from the arm64 repo [1] as branch
> 'aarch64/efi'
> 
> [1] git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
> 
> ----------------------------------------------------------------
> 
> Weblink:
> http://thread.gmane.org/gmane.linux.kernel.mm/142134
> 
> Repo browse link:
> http://git.linaro.org/people/ard.biesheuvel/linux-arm.git/shortlog/refs/tags/arm32-efi-for-v4.5
> 
> Regression test results:
> http://kernelci.org/build/ardb/kernel/v4.4-rc3-13-g81a0bc39ea19/
> 
> Ard Biesheuvel (7):
>       ARM: add support for generic early_ioremap/early_memremap
>       ARM: split off core mapping logic from create_mapping
>       ARM: factor out allocation routine from __create_mapping()
>       ARM: add support for non-global kernel mappings
>       ARM: implement create_mapping_late() for EFI use
>       ARM: only consider memblocks with NOMAP cleared for linear mapping
>       ARM: wire up UEFI init and runtime support
> 
> Roy Franz (1):
>       ARM: add UEFI stub support
> 
>  arch/arm/Kconfig                          |  20 +++++
>  arch/arm/boot/compressed/Makefile         |   4 +-
>  arch/arm/boot/compressed/efi-header.S     | 130 ++++++++++++++++++++++++++++++
>  arch/arm/boot/compressed/head.S           |  54 ++++++++++++-
>  arch/arm/boot/compressed/vmlinux.lds.S    |   7 ++
>  arch/arm/include/asm/Kbuild               |   1 +
>  arch/arm/include/asm/efi.h                |  83 +++++++++++++++++++
>  arch/arm/include/asm/fixmap.h             |  29 ++++++-
>  arch/arm/include/asm/mach/map.h           |   2 +
>  arch/arm/include/asm/mmu_context.h        |   2 +-
>  arch/arm/kernel/Makefile                  |   1 +
>  arch/arm/kernel/efi.c                     |  38 +++++++++
>  arch/arm/kernel/setup.c                   |  10 ++-
>  arch/arm/mm/init.c                        |   5 +-
>  arch/arm/mm/ioremap.c                     |   9 +++
>  arch/arm/mm/mmu.c                         | 128 +++++++++++++++++++----------
>  drivers/firmware/efi/Makefile             |   1 +
>  drivers/firmware/efi/libstub/Makefile     |   9 +++
>  drivers/firmware/efi/libstub/arm-stub.c   |   4 +-
>  drivers/firmware/efi/libstub/arm32-stub.c |  85 +++++++++++++++++++
>  20 files changed, 572 insertions(+), 50 deletions(-)
>  create mode 100644 arch/arm/boot/compressed/efi-header.S
>  create mode 100644 arch/arm/include/asm/efi.h
>  create mode 100644 arch/arm/kernel/efi.c
>  create mode 100644 drivers/firmware/efi/libstub/arm32-stub.c

This pull request done in this way makes it _really_ difficult to
validate that I've pulled what was intended to be pulled.

The point of the diffstat is to be able to compare the resulting
diffstat from pulling the changes with the one in the message.  In
this case, because you've omitted some patches at the beginning of
the series, it doesn't match:

 29 files changed, 986 insertions(+), 368 deletions(-)

So I can't validate it.

Please send a replacement pull request which covers all the patches
you want me to merge into my tree, thanks.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
