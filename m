From: wangnan0@huawei.com (Wang Nan)
Date: Thu, 12 Feb 2015 20:19:26 +0800
Subject: [RFC PATCH v2 03/26] kprobes: x86: mark 2 bytes NOP as boostable.
In-Reply-To: <1423743476-11927-1-git-send-email-wangnan0@huawei.com>
References: <1423743476-11927-1-git-send-email-wangnan0@huawei.com>
Message-ID: <1423743566-12137-1-git-send-email-wangnan0@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, x86 kprobes is unable to boost 2 bytes nop like:

nopl 0x0(%rax,%rax,1)

which is 0x0f 0x1f 0x44 0x00 0x00.

Such nops have exactly 5 bytes which is able to hold a relative jmp
instruction. Boosting them should be obviously safe.

This patch enable boosting such nops by simply updating
twobyte_is_boostable[] array.

Signed-off-by: Wang Nan <wangnan0@huawei.com>
Acked-by: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
---
 arch/x86/kernel/kprobes/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 98f654d..6a1146e 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -84,7 +84,7 @@ static volatile u32 twobyte_is_boostable[256 / 32] = {
 	/*      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f          */
 	/*      ----------------------------------------------          */
 	W(0x00, 0, 0, 1, 1, 0, 0, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0) | /* 00 */
-	W(0x10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0) , /* 10 */
+	W(0x10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1) , /* 10 */
 	W(0x20, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0) | /* 20 */
 	W(0x30, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0) , /* 30 */
 	W(0x40, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1) | /* 40 */
-- 
1.8.4
