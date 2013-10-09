From: Dave.Martin@arm.com (Dave Martin)
Date: Wed,  9 Oct 2013 15:29:49 +0100
Subject: [RFC PATCH 0/4] ARM: Unify const-swabbing and conditional asm
Message-ID: <1381328993-12724-1-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are a few things in assembler.h that would be useful with
inline asm, but currently assembler.h refuses to be included into C
files.

This refactoring provides a place to put const swabbing helpers, which
can then be used in inline asm and other places (I recycle and share
the code from <asm/opcodes.h>).

The final patch modifies the CCI driver to use the new
__asm_cpu_to_le32() helper, based closely on Victor Kamensky's recent
fix for BE8.  This allows us to avoid some unneeded ifdeffery.


Comments?


These patches are untested, but I have build-tested the CCI driver in
LE and BE32 configurations, which produces the following change in the
generated code:

 e0400001 	sub	r0, r0, r1
 e5900004 	ldr	r0, [r0, #4]
-e3a03003 	mov	r3, #3
+e3a03403 	mov	r3, #50331648	; 0x3000000
 e5803000 	str	r3, [r0]
 e28f1024 	add	r1, pc, #36	; 0x24
 e5910000 	ldr	r0, [r1]
 e7900001 	ldr	r0, [r0, r1]
 e590100c 	ldr	r1, [r0, #12]
-e3110001 	tst	r1, #1
+e3110401 	tst	r1, #16777216	; 0x1000000
 1afffffc 	bne	288 <cci_port_not_found+0x44>
 e3a00000 	mov	r0, #0
 e12fff1e 	bx	lr


Dave Martin (4):
  ARM: Allow assembler.h to be used with inline asm
  ARM: Add common compile-time swab32 for asm code
  ARM: Add const cpu_to_le32 for asm
  drivers/bus: arm-cci: Fix CCI enable code for BE32

 arch/arm/include/asm/assembler.h |   41 ++++++++++++++++++++++++++++++++++----
 arch/arm/include/asm/opcodes.h   |    9 +++------
 drivers/bus/arm-cci.c            |    6 ++++--
 3 files changed, 44 insertions(+), 12 deletions(-)

-- 
1.7.9.5
