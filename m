From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 26 Jan 2017 19:24:44 +0000
Subject: [PATCH v3 0/2] efi/arm64: add vmlinux link to PE/COFF debug table
Message-ID: <1485458686-32544-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Much like GNU debug links, PE/COFF binaries can carry the path on the build
host to the binary containing the debugging symbols. Since the kernel binary
is loaded by UEFI at an a priori unknown offset in the 1:1 mapping of physical
memory, having this information is useful for the debugger automation to find
the file and the offset, and load the symbols automatically.

So if we have debugging symbols to begin with (CONFIG_DEBUG_INFO=y), add the
absolute path to vmlinux to the PE/COFF debug table.

v3: move the EFI debug table itself into the EFI header, which removes the
    need for externally visible symbols or changes to the linker script (#2)
    update commit log to explain that the debug support table is defined
    in the UEFI spec, and is thus not EDK2/PI specific

v2: rebase onto v4.10-rc
    use strip rather than objcopy for first pass (#1)
    move debug table inside #ifdef CONFIG_EFI region in head.S (#2)

Note that these patches can be merged independently, although they are
both required to get the functionality.

Ard Biesheuvel (2):
  efi: libstub: Preserve .debug sections after absolute relocation check
  efi: arm64: Add vmlinux debug link to the Image binary

 arch/arm64/kernel/Makefile            |  4 ++
 arch/arm64/kernel/head.S              | 46 +++++++++++++++++++-
 drivers/firmware/efi/libstub/Makefile | 24 ++++++----
 3 files changed, 65 insertions(+), 9 deletions(-)

-- 
2.7.4
