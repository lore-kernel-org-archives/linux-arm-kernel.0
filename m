From: glin@suse.com (Gary Lin)
Date: Tue,  5 Dec 2017 18:01:46 +0800
Subject: [RFC v3 PATCH 0/2] Introduce Security Version to EFI Stub
Message-ID: <20171205100148.5757-1-glin@suse.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The series of patches introduce Security Version to EFI stub.

Security Version is a monotonically increasing number and designed to
prevent the user from loading an insecure kernel accidentally. The
bootloader maintains a list of security versions corresponding to
different distributions. After fixing a critical vulnerability, the
distribution kernel maintainer bumps the "version", and the bootloader
updates the list automatically. When the user tries to load a kernel
with a lower security version, the bootloader shows a warning prompt
to notify the user the potential risk.

For more details: https://github.com/lcp/shim/wiki/Security-Version

The original idea is to add a new PE/COFF section to store the data.
However, there are some restrictions.

1. For x86, the size limit of the EFI header is 0x200, and a section entry
   in the section table takes 40 bytes. Currently, the EFI header already
   occupies the first 0x1da bytes, so there is no room for a new section
   entry.

2. The MemoryAttributes table sets the attributes of memory pages according
   to the section flags. For ARM64, the minimal granularity is 4KB, but
   Security Version only needs a few bytes, and it's pointless to allocate
   4KB for it.

Fortunately, there is a special section defined in PE/COFF: resource
section. The only known user of the resource section in UEFI is the HII
protocol which fetches data from "HII" directory. For Security Version, a
new directory called "LinuxSV" is created and it contains the file offset
to the struct of Security Version. The bootloader just follows the
resource table to fetch the "version" from the image file.

v3:
    - Move everything to the resource section to be compatible with both
      x86 and ARM64
v2:
    - Decrease the size of secdata_offset to 2 bytes since the setup header
      is limited to around 32KB.
    - Restructure the secdata section. The signer is now a null-terminated
      string. The type of distro_version changes to u32 in case the distro
      uses a long version.
    - Modify the Kconfig names and add help.
    - Remove the signer name hack in build.c.

Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Joey Lee <jlee@suse.com>
Signed-off-by: Gary Lin <glin@suse.com>

Gary Lin (2):
  x86/efi: Introduce Security Version to x86
  arm64/efi: Introduce Security Version to ARM64

 arch/arm64/kernel/efi-header.S | 57 ++++++++++++++++++++++++++++++++++++++++++
 arch/x86/boot/header.S         | 55 ++++++++++++++++++++++++++++++++++++++++
 drivers/firmware/efi/Kconfig   | 40 +++++++++++++++++++++++++++++
 3 files changed, 152 insertions(+)

-- 
2.15.0
