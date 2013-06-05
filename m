From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 05 Jun 2013 16:06:25 +0900
Subject: [PATCH 01/15] ARM: shmobile: Per-board uImage load addresses
In-Reply-To: <20130605070616.13311.69049.sendpatchset@w520>
References: <20130605070616.13311.69049.sendpatchset@w520>
Message-ID: <20130605070625.13311.17016.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Introduce per-board uImage load address calculation.

This will allow us to use the same uImage for multiple
boards if the load address happens to match. For now
keep on using CONFIG_MEMORY_START.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/Makefile.boot |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- 0001/arch/arm/mach-shmobile/Makefile.boot
+++ work/arch/arm/mach-shmobile/Makefile.boot	2013-06-04 12:33:07.000000000 +0900
@@ -1,6 +1,9 @@
-__ZRELADDR	:= $(shell /bin/bash -c 'printf "0x%08x" \
+loadaddr-y	:= $(shell /bin/bash -c 'printf "0x%08x" \
 		     $$[$(CONFIG_MEMORY_START) + 0x8000]')
 
+__ZRELADDR	:= $(shell /bin/bash -c \
+		     'echo $(loadaddr-y) | tr " " "\n" | sort | uniq')
+
    zreladdr-y   += $(__ZRELADDR)
 
 # Unsupported legacy stuff
