From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Sun, 24 Jul 2016 11:30:23 -0400
Subject: [PATCH v5 09/15] binfmt_flat: use clear_user() rather than memset()
 to clear .bss
In-Reply-To: <1469374229-21585-1-git-send-email-nicolas.pitre@linaro.org>
References: <1469374229-21585-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1469374229-21585-10-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is needed on systems with a MMU.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
Reviewed-by: Greg Ungerer <gerg@linux-m68k.org>
---
 fs/binfmt_flat.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/binfmt_flat.c b/fs/binfmt_flat.c
index 63756ca6a7..92c1530a2c 100644
--- a/fs/binfmt_flat.c
+++ b/fs/binfmt_flat.c
@@ -795,10 +795,11 @@ static int load_flat_file(struct linux_binprm *bprm,
 	flush_icache_range(start_code, end_code);
 
 	/* zero the BSS,  BRK and stack areas */
-	memset((void *)(datapos + data_len), 0, bss_len +
-			(memp + memp_size - stack_len -		/* end brk */
-			libinfo->lib_list[id].start_brk) +	/* start brk */
-			stack_len);
+	if (clear_user((void __user *)(datapos + data_len), bss_len +
+		       (memp + memp_size - stack_len -		/* end brk */
+		       libinfo->lib_list[id].start_brk) +	/* start brk */
+		       stack_len))
+		return -EFAULT;
 
 	return 0;
 err:
-- 
2.7.4
