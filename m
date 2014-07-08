From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue,  8 Jul 2014 14:50:01 +0200
Subject: [RFC PATCH 1/3] arm64: clarify Image header requirement for EFI
 booting
Message-ID: <1404823803-7317-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 'res5' field in the Image header is defined as 'reserved, should be 0',
while it serves a specific purpose when booting via the EFI stub, in which
case it should contain the offset of the PE header. So update the doc to
reflect this.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 Documentation/arm64/booting.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/arm64/booting.txt b/Documentation/arm64/booting.txt
index 37fc4f632176..52a07a8d2cfa 100644
--- a/Documentation/arm64/booting.txt
+++ b/Documentation/arm64/booting.txt
@@ -79,15 +79,15 @@ The decompressed kernel image contains a 64-byte header as follows:
   u64 res3	= 0;		/* reserved */
   u64 res4	= 0;		/* reserved */
   u32 magic	= 0x644d5241;	/* Magic number, little endian, "ARM\x64" */
-  u32 res5 = 0;      		/* reserved */
+  u32 pehdr_offset;		/* PE header offset, only used by EFI */
 
 
 Header notes:
 
 - code0/code1 are responsible for branching to stext.
 - when booting through EFI, code0/code1 are initially skipped.
-  res5 is an offset to the PE header and the PE header has the EFI
-  entry point (efi_stub_entry). When the stub has done its work, it
+  pehdr_offset is an offset to the PE header and the PE header has the
+  EFI entry point (efi_stub_entry). When the stub has done its work, it
   jumps to code0 to resume the normal boot process.
 
 The image must be placed at the specified offset (currently 0x80000)
-- 
1.8.3.2
