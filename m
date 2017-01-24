From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue, 24 Jan 2017 12:43:40 +0100
Subject: [PATCH] arm64: Use __pa_symbol for empty_zero_page
Message-ID: <1485258220-21916-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If CONFIG_DEBUG_VIRTUAL=y and CONFIG_ARM64_SW_TTBR0_PAN=y:

    virt_to_phys used for non-linear address: ffffff8008cc0000 (empty_zero_page+0x0/0x1000)
    WARNING: CPU: 0 PID: 0 at arch/arm64/mm/physaddr.c:14 __virt_to_phys+0x28/0x60
    ...
    [<ffffff800809abb4>] __virt_to_phys+0x28/0x60
    [<ffffff8008a02600>] setup_arch+0x46c/0x4d4

Fixes: 2077be6783b5936c ("arm64: Use __pa_symbol for kernel symbols")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/kernel/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 669fc9ff728b227f..b5222094ab52db6f 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -298,7 +298,7 @@ void __init setup_arch(char **cmdline_p)
 	 * faults in case uaccess_enable() is inadvertently called by the init
 	 * thread.
 	 */
-	init_task.thread_info.ttbr0 = virt_to_phys(empty_zero_page);
+	init_task.thread_info.ttbr0 = __pa_symbol(empty_zero_page);
 #endif
 
 #ifdef CONFIG_VT
-- 
1.9.1
