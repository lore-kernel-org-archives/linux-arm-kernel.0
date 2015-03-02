From: wangnan0@huawei.com (Wang Nan)
Date: Mon, 2 Mar 2015 22:24:54 +0800
Subject: [RFC PATCH v4 16/34] early kprobes: perhibit probing at early kprobe
 reserved area.
In-Reply-To: <1425306312-3437-1-git-send-email-wangnan0@huawei.com>
References: <1425306312-3437-1-git-send-email-wangnan0@huawei.com>
Message-ID: <1425306312-3437-17-git-send-email-wangnan0@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Puts early kprobe reserved area into kprobe blacklist.

Signed-off-by: Wang Nan <wangnan0@huawei.com>
---
 kernel/kprobes.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 2d178fc..7dbe8b2 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1405,6 +1405,12 @@ static bool within_kprobe_blacklist(unsigned long addr)
 	if (arch_within_kprobe_blacklist(addr))
 		return true;
 
+#ifdef CONFIG_EARLY_KPROBES
+	if (addr >= (unsigned long)__early_kprobes_start &&
+			addr < (unsigned long)__early_kprobes_end)
+		return true;
+#endif
+
 	if (!kprobes_blacklist_initialized)
 		return within_kprobe_blacklist_early(addr);
 
-- 
1.8.4
