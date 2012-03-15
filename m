From: dave.martin@linaro.org (Dave Martin)
Date: Thu, 15 Mar 2012 16:32:08 +0000
Subject: [PATCH 0/4] ARM: opcodes: Facilitate custom opcode injection
Message-ID: <1331829132-9762-1-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since my "uniform assembler" series had some problems and did not
meet with widespread agreement, this can't be used as a basis for a
mechanism to safely inject custom instruction opcodes (which was my
immediate reason for writing those patchse).

This series follows a more conventional approach to achieve the
goal for safe opcode injection across all kernel endianness and
instruction set configurations.

I have made best efforts to verify that these patches do the right
thing for big-endian configurations, but review/testing from people
who are actively working with big-endian targets would be
appreciated.  There's no code in the kernel using these macros yet,
but you can experiment with the __HVC() macro added by the final
patch.  If this disassembles correctly in vmlinux (see below), then
the macros should be safe for your configuration.


Note that for BE8 targets, you _will_ get weird-looking instruction
data in your .o files:  because the ".inst" family of assembler
directives is relatively new I use data directives instead.  This
means that the data for those directives has to be pre-swapped by
the opcode injection macros, whereas _instruction_ data should get
byteswapped by the linker in the final link (with ld --be8).  Using
data directives brings some complexity, but it is the only way to
ensure compatibility with older assembler versions.

To check correctness, you should therefore review the final linker
output (vmlinux) if you want to be certain what the final
instruction stream looks like.  You may need to strip data mapping
symbols (strip -N'$d') from vmlinux in order for the injected
instructions to be disassembled properly -- note that this has no
effect on the run-time meaning of the image.

For BE32 the situation is simpler again, because like LE, BE32 uses
the same endianness for data and instructions.

Dave Martin (4):
  ARM: opcodes: Don't define the thumb32 byteswapping macros for BE32
  ARM: opcodes: Make opcode byteswapping macros assembly-compatible
  ARM: opcodes: Add helpers for emitting custom opcodes
  ARM: opcodes: Opcode definitions for the Virtualization Extensions

 arch/arm/include/asm/opcodes-virt.h |   29 ++++++
 arch/arm/include/asm/opcodes.h      |  181 ++++++++++++++++++++++++++++++++---
 2 files changed, 195 insertions(+), 15 deletions(-)
 create mode 100644 arch/arm/include/asm/opcodes-virt.h

-- 
1.7.4.1
