From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 9 Dec 2013 16:50:42 -0500
Subject: [PATCH v3 09/23] mm/init: Use memblock apis for early memory
 allocations
In-Reply-To: <1386625856-12942-1-git-send-email-santosh.shilimkar@ti.com>
References: <1386625856-12942-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1386625856-12942-10-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Switch to memblock interfaces for early memory allocator instead of
bootmem allocator. No functional change in beahvior than what it is
in current code from bootmem users points of view.

Archs already converted to NO_BOOTMEM now directly use memblock
interfaces instead of bootmem wrappers build on top of memblock.
And the archs which still uses bootmem, these new apis just fall
back to exiting bootmem APIs.

Cc: Yinghai Lu <yinghai@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 init/main.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/init/main.c b/init/main.c
index febc511..d3e3cff 100644
--- a/init/main.c
+++ b/init/main.c
@@ -355,9 +355,11 @@ static inline void smp_prepare_cpus(unsigned int maxcpus) { }
  */
 static void __init setup_command_line(char *command_line)
 {
-	saved_command_line = alloc_bootmem(strlen (boot_command_line)+1);
-	initcall_command_line = alloc_bootmem(strlen (boot_command_line)+1);
-	static_command_line = alloc_bootmem(strlen (command_line)+1);
+	saved_command_line =
+		memblock_virt_alloc(strlen(boot_command_line) + 1, 0);
+	initcall_command_line =
+		memblock_virt_alloc(strlen(boot_command_line) + 1, 0);
+	static_command_line = memblock_virt_alloc(strlen(command_line) + 1, 0);
 	strcpy (saved_command_line, boot_command_line);
 	strcpy (static_command_line, command_line);
 }
-- 
1.7.9.5
