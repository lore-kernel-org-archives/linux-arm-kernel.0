From: wangnan0@huawei.com (Wang Nan)
Date: Mon, 2 Mar 2015 22:25:12 +0800
Subject: [RFC PATCH v4 34/34] early kprobes: enable optimization of kprobes on
 ftrace before ftrace is ready.
In-Reply-To: <1425306312-3437-1-git-send-email-wangnan0@huawei.com>
References: <1425306312-3437-1-git-send-email-wangnan0@huawei.com>
Message-ID: <1425306312-3437-35-git-send-email-wangnan0@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Uses ftrace_process_loc_early() introduced by previous patch to
convert ftrace entries to nops before ftrace_init(). For x86, original
kprobe entries are 'call' and are optimizable only after this conversion.

Signed-off-by: Wang Nan <wangnan0@huawei.com>
---
 kernel/kprobes.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 56fb8c8..1ec8e6e 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1602,6 +1602,9 @@ int register_kprobe(struct kprobe *p)
 		goto out;
 	}
 
+	if (p->flags & KPROBE_FLAG_FTRACE_EARLY)
+		ftrace_process_loc_early((unsigned long)p->addr);
+
 	mutex_lock(&text_mutex);	/* Avoiding text modification */
 	ret = prepare_kprobe(p);
 	mutex_unlock(&text_mutex);
-- 
1.8.4
