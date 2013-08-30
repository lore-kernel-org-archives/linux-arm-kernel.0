From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Fri, 30 Aug 2013 20:10:50 +0100
Subject: [PATCH 14/20] ARM: set --be8 when linking modules
In-Reply-To: <1377889856-9447-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1377889856-9447-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1377889856-9447-15-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To avoid having to make every text section swap the instruction order
of all instructions, make sure modules are built also built with --be8
(as is the current kernel final link).

If we do not do this, we would end up having to swap all instructions
when loading a module, instead of just the instructions that we are
applying ELF relocations to.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
Reviewed-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm/Makefile |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 6fd2cea..2c659f9 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -16,6 +16,7 @@ LDFLAGS		:=
 LDFLAGS_vmlinux	:=-p --no-undefined -X
 ifeq ($(CONFIG_CPU_ENDIAN_BE8),y)
 LDFLAGS_vmlinux	+= --be8
+LDFLAGS_MODULE	+= --be8
 endif
 
 OBJCOPYFLAGS	:=-O binary -R .comment -S
-- 
1.7.10.4
