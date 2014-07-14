From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 14 Jul 2014 18:17:49 +0200
Subject: [PATCH 0/2] arm64: use Image header fields in EFI stub
Message-ID: <1405354671-14031-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a followup on the RFC series I sent a week ago that changes the EFI
stub Image loader to stop using linker arithmetic and build time defines and
use data obtained at runtime instead.

This series is now rebased on top of Catalin's arm64 for-next/core branch, which
contains a relevant set of patches by Mark. This means I could drop my former
patch #1 against Documentation/booting.txt.

Patch #1 adds <asm/image_hdr.h>. I incorporated Geoff's feedback to improve the
comments and make the header suitable for sharing with userland.

Patch #2 contains the changes to the actual stub loader itself. This patch
depends on the stub loader bug fix patch I sent out today. It drops all
references to linker symbols and uses text_offset and image_size from the Image
header, and uses the loaded Image size as reported by EFI. This patch also fixes
the corner case where Image happens to be loaded at exactly the right offset,
but the allocation is actually too small to satisfy the requirement imposed by
image_size as set in the header.

Ard Biesheuvel (2):
  arm64: add C struct definition for Image header
  arm64/efi: efistub: get text offset and image size from the Image
    header

 arch/arm64/include/asm/image_hdr.h | 75 ++++++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/Makefile         |  2 -
 arch/arm64/kernel/efi-stub.c       | 29 ++++++++-------
 3 files changed, 91 insertions(+), 15 deletions(-)
 create mode 100644 arch/arm64/include/asm/image_hdr.h

-- 
1.8.3.2
