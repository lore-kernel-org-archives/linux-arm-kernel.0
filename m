From: wangnan0@huawei.com (Wang Nan)
Date: Tue, 18 Nov 2014 14:32:38 +0800
Subject: [PATCH v8 1/2] kprobes: copy ainsn after alloc aggr kprobe
In-Reply-To: <1416292359-75893-1-git-send-email-wangnan0@huawei.com>
References: <1416292359-75893-1-git-send-email-wangnan0@huawei.com>
Message-ID: <1416292359-75893-2-git-send-email-wangnan0@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Copy old kprobe to newly alloced optimized_kprobe before
arch_prepare_optimized_kprobe(). Original kprove can brings more
information to optimizer.

v1 -> v2:
 -  Bugfix: copy p->addr when alloc_aggr_kprobe.

Signed-off-by: Wang Nan <wangnan0@huawei.com>
---
 kernel/kprobes.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 3995f54..e9868ec 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -730,7 +730,13 @@ static struct kprobe *alloc_aggr_kprobe(struct kprobe *p)
 		return NULL;
 
 	INIT_LIST_HEAD(&op->list);
+
+	/*
+	 * copy gives arch_prepare_optimized_kprobe
+	 * more information
+	 */
 	op->kp.addr = p->addr;
+	copy_kprobe(p, &op->kp);
 	arch_prepare_optimized_kprobe(op);
 
 	return &op->kp;
-- 
1.8.4
