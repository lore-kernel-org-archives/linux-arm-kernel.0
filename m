From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 26 Feb 2014 12:11:20 +0100
Subject: [PATCH] scripts/link-vmlinux.sh: correct base address for some ARM
 special cases
Message-ID: <1393413080-26942-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The toolchain problem described in commit f6537f2f0eba
(scripts/kallsyms: filter symbols not in kernel address space) makes it
necessary to filter out some kernel symbols from /proc/kallsyms to make
perf happy.

For that to work correctly the address used to filter should be just
below the kernel text segment. Depending on kernel configuration
CONFIG_PAGE_OFFSET is not the right address to use. See the comments
introduced by this commit for the glory details.

Fixes: b9b32bf70f2f (ARM: use linker magic for vectors and vector stubs)
Cc: stable at vger.kernel.org
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
Hello,

note I'm not entirely sure if the diagnose "toolchain problem" is right.
That's what Arnd suggested in #armlinux. So maybe the commit log wants
some fixing.

This is probably stable material as 7122c3e9154b and f6537f2f0eba were
considered for stable, too. As b9b32bf70f2f has a stable annotation,
too, maybe older stable kernel also need fixing.

Other than that I wonder if "--page-offset" is a misnomer. Better use
"--kernel-start"?  I didn't do this change here because patches for
stable should be minimal. But maybe it's worth a followup patch?

Best regards
Uwe

 scripts/link-vmlinux.sh | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 2dcb37736d84..493b4ccdf5fc 100644
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -82,8 +82,24 @@ kallsyms()
 		kallsymopt="${kallsymopt} --all-symbols"
 	fi
 
-	if [ -n "${CONFIG_ARM}" ] && [ -n "${CONFIG_PAGE_OFFSET}" ]; then
-		kallsymopt="${kallsymopt} --page-offset=$CONFIG_PAGE_OFFSET"
+	if [ -n "${CONFIG_ARM}" ]; then
+		# There are some ARM toolchains that generate some internal
+		# symbols that then appear in /proc/kallsyms and these disturbe
+		# perf. So filter out all symbols below PAGE_OFFSET.
+		# ARM is a bit complicated here. The page-offset isn't
+		# completely determined in Kconfig as of 3.14-rc. Without MMU
+		# it's not CONFIG_PAGE_OFFSET that is used but (indirectly)
+		# CONFIG_DRAM_BASE. But for XIP we want the XIP PHYS_ADDR
+		# though.
+		if [ -n "${CONFIG_XIP_PHYS_ADDR}" ]; then
+			page_offset="${CONFIG_XIP_PHYS_ADDR}"
+		elif [ -z "${CONFIG_MMU}" ]; then
+			page_offset="${CONFIG_DRAM_BASE}"
+		else
+			page_offset="$CONFIG_PAGE_OFFSET"
+		fi
+
+		kallsymopt="${kallsymopt} --page-offset=$page_offset"
 	fi
 
 	local aflags="${KBUILD_AFLAGS} ${KBUILD_AFLAGS_KERNEL}               \
-- 
1.8.5.3
