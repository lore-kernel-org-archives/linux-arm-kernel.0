From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 26 Sep 2011 10:46:13 -0700
Subject: [PATCH] ARM: platform fixups: remove mdesc argument to fixup
	function
In-Reply-To: <E1R6kA4-0002vc-HZ@rmk-PC.arm.linux.org.uk>
References: <E1R6kA4-0002vc-HZ@rmk-PC.arm.linux.org.uk>
Message-ID: <4E80BA65.30209@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/22/11 07:22, Russell King - ARM Linux wrote:
> Get rid of the mdesc pointer in the fixup function call.  No one uses
> the mdesc pointer, it shouldn't be modified anyway, and we can't wrap
> it, so let's remove it.  Updated for 3.1-rc6.
>
> Platform files found by:
>
>   $ regexp=$(git grep -h '\.fixup.*=' arch/arm |
> 		sed 's!.*= *\([^,]*\),* *!\1!' | sort -u |
> 		tr '\n' '|' | sed 's,|$,,;s,|,\\|,g')
>   $ git grep $regexp arch/arm
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>

When this merges into your for-next branch it breaks 9e775ad (ARM:
7012/1: Set proper TEXT_OFFSET for newer MSMs, 2011-08-12). Here is a
fixup patch on top of your for-next branch. How should we deal with this?

-----8<---[ cut here ]--->8-----
From: Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH] msm: boards: Fix fallout from removal of machine_desc in
 fixup

After 77821af (ARM: platform fixups: remove mdesc argument to
fixup function, 2010-12-20) the fixup functions introduced in
9e775ad (ARM: 7012/1: Set proper TEXT_OFFSET for newer MSMs,
2011-08-12) cause warnings like:

arch/arm/mach-msm/board-msm8x60.c:85: warning: initialization
from incompatible pointer type

Fix them by removing the machine_desc argument from the fixup
functions.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/mach-msm/board-msm7x30.c |    4 ++--
 arch/arm/mach-msm/board-msm8960.c |    4 ++--
 arch/arm/mach-msm/board-msm8x60.c |    4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-msm/board-msm7x30.c b/arch/arm/mach-msm/board-msm7x30.c
index 71de506..db81ed5 100644
--- a/arch/arm/mach-msm/board-msm7x30.c
+++ b/arch/arm/mach-msm/board-msm7x30.c
@@ -42,8 +42,8 @@
 
 extern struct sys_timer msm_timer;
 
-static void __init msm7x30_fixup(struct machine_desc *desc, struct tag *tag,
-			 char **cmdline, struct meminfo *mi)
+static void __init msm7x30_fixup(struct tag *tag, char **cmdline,
+		struct meminfo *mi)
 {
 	for (; tag->hdr.size; tag = tag_next(tag))
 		if (tag->hdr.tag == ATAG_MEM && tag->u.mem.start == 0x200000) {
diff --git a/arch/arm/mach-msm/board-msm8960.c b/arch/arm/mach-msm/board-msm8960.c
index b04468e..6dc1cbd 100644
--- a/arch/arm/mach-msm/board-msm8960.c
+++ b/arch/arm/mach-msm/board-msm8960.c
@@ -32,8 +32,8 @@
 
 #include "devices.h"
 
-static void __init msm8960_fixup(struct machine_desc *desc, struct tag *tag,
-			 char **cmdline, struct meminfo *mi)
+static void __init msm8960_fixup(struct tag *tag, char **cmdline,
+		struct meminfo *mi)
 {
 	for (; tag->hdr.size; tag = tag_next(tag))
 		if (tag->hdr.tag == ATAG_MEM &&
diff --git a/arch/arm/mach-msm/board-msm8x60.c b/arch/arm/mach-msm/board-msm8x60.c
index 9221f54..056d9d7 100644
--- a/arch/arm/mach-msm/board-msm8x60.c
+++ b/arch/arm/mach-msm/board-msm8x60.c
@@ -30,8 +30,8 @@
 #include <mach/board.h>
 #include <mach/msm_iomap.h>
 
-static void __init msm8x60_fixup(struct machine_desc *desc, struct tag *tag,
-			 char **cmdline, struct meminfo *mi)
+static void __init msm8x60_fixup(struct tag *tag, char **cmdline,
+		struct meminfo *mi)
 {
 	for (; tag->hdr.size; tag = tag_next(tag))
 		if (tag->hdr.tag == ATAG_MEM &&

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
