From: wangnan0@huawei.com (Wang Nan)
Date: Wed, 27 Aug 2014 21:02:31 +0800
Subject: [PATCH v5 2/3] kprobes: copy ainsn after alloc aggr kprobe
In-Reply-To: <1409144552-12751-1-git-send-email-wangnan0@huawei.com>
References: <1409144552-12751-1-git-send-email-wangnan0@huawei.com>
Message-ID: <1409144552-12751-3-git-send-email-wangnan0@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Copy old kprobe to newly alloced optimized_kprobe before
arch_prepare_optimized_kprobe(). Original kprove can brings more
information to optimizer.

Signed-off-by: Wang Nan <wangnan0@huawei.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: "David A. Long" <dave.long@linaro.org> 
Cc: Jon Medhurst <tixy@linaro.org>
Cc: Taras Kondratiuk <taras.kondratiuk@linaro.org>
Cc: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 kernel/kprobes.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 3995f54..33cf568 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -730,7 +730,12 @@ static struct kprobe *alloc_aggr_kprobe(struct kprobe *p)
 		return NULL;
 
 	INIT_LIST_HEAD(&op->list);
-	op->kp.addr = p->addr;
+
+	/*
+	 * copy gives arch_prepare_optimized_kprobe
+	 * more information
+	 */
+	copy_kprobe(p, &op->kp);
 	arch_prepare_optimized_kprobe(op);
 
 	return &op->kp;
-- 
1.8.4
