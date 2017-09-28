From: will.deacon@arm.com (Will Deacon)
Date: Thu, 28 Sep 2017 11:55:47 +0100
Subject: [PATCH] scripts/decodecode: Fix decoding for AArch64 (arm64)
 instructions
Message-ID: <1506596147-23630-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are a couple of problems with the decodecode script and arm64:

1. AArch64 objdump refuses to disassemble .4byte directives as instructions,
   insisting that they are data values and displaying them as:

	a94153f3	.word	0xa94153f3		<-- trapping instruction

   This is resolved by using the .inst directive instead.

2. Disassembly of branch instructions attempts to provide the target as
   an offset from a symbol, e.g.:

   0:	34000082	cbz	w2, 10 <.text+0x10>

  however this falls foul of the grep -v, which matches lines containing
  ".text" and ends up removing all branch instructions from the dump.

This patch resolves both issues by using the .inst directive for 4-byte
quantities on arm64 and stripping the resulting binaries (as is done on
arm already) to remove the mapping symbols.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 scripts/decodecode | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/scripts/decodecode b/scripts/decodecode
index d8824f37acce..67214ec5b2cb 100755
--- a/scripts/decodecode
+++ b/scripts/decodecode
@@ -58,6 +58,14 @@ disas() {
 		${CROSS_COMPILE}strip $1.o
 	fi
 
+	if [ "$ARCH" = "arm64" ]; then
+		if [ $width -eq 4 ]; then
+			type=inst
+		fi
+
+		${CROSS_COMPILE}strip $1.o
+	fi
+
 	${CROSS_COMPILE}objdump $OBJDUMPFLAGS -S $1.o | \
 		grep -v "/tmp\|Disassembly\|\.text\|^$" > $1.dis 2>&1
 }
-- 
2.1.4
