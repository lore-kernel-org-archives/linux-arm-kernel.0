From: wangnan0@huawei.com (Wang Nan)
Date: Fri, 13 Feb 2015 13:41:03 +0800
Subject: [RFC PATCH v3 19/26] early kprobes: perhibit probing at early kprobe
 reserved area.
In-Reply-To: <1423805941-61407-1-git-send-email-wangnan0@huawei.com>
References: <1423805941-61407-1-git-send-email-wangnan0@huawei.com>
Message-ID: <1423806063-62276-1-git-send-email-wangnan0@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Puts early kprobe reserved area into kprobe blacklist.

Signed-off-by: Wang Nan <wangnan0@huawei.com>
---
 kernel/kprobes.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index fa1e422..b83c406 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1358,6 +1358,13 @@ static bool within_kprobe_blacklist(unsigned long addr)
 
 	if (arch_within_kprobe_blacklist(addr))
 		return true;
+
+#ifdef CONFIG_EARLY_KPROBES
+	if (addr >= (unsigned long)__early_kprobes_start &&
+			addr < (unsigned long)__early_kprobes_end)
+		return true;
+#endif
+
 	/*
 	 * If there exists a kprobe_blacklist, verify and
 	 * fail any probe registration in the prohibited area
-- 
1.8.4
