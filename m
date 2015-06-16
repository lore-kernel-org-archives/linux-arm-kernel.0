From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Tue, 16 Jun 2015 23:29:41 +0100
Subject: [PATCH] GPU: ipu: fix lockup caused by pending chained interrupts
In-Reply-To: <E1Z4yzs-0002Rw-4B@rmk-PC.arm.linux.org.uk>
References: <E1Z4yzs-0002Rw-4B@rmk-PC.arm.linux.org.uk>
Message-ID: <E1Z4zMT-0004Y7-KJ@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Even with the oops fixed by a previous patch, the system still fails to
kexec, due to a stuck chained interrupt locking the system.  We must
disable the child interrupts prior to setting up the irq chip to ensure
we don't get stuck here.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
Maybe this is all that's really needed... would also be nice if this
path had an etry in MAINTAINERS...

 drivers/gpu/ipu-v3/ipu-common.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/ipu-v3/ipu-common.c b/drivers/gpu/ipu-v3/ipu-common.c
index 6d2f39d36e44..00f2058944e5 100644
--- a/drivers/gpu/ipu-v3/ipu-common.c
+++ b/drivers/gpu/ipu-v3/ipu-common.c
@@ -1107,6 +1107,9 @@ static int ipu_irq_init(struct ipu_soc *ipu)
 		return ret;
 	}
 
+	for (i = 0; i < IPU_NUM_IRQS; i += 32)
+		ipu_cm_write(ipu, 0, IPU_INT_CTRL(i / 32));
+
 	for (i = 0; i < IPU_NUM_IRQS; i += 32) {
 		gc = irq_get_domain_generic_chip(ipu->domain, i);
 		gc->reg_base = ipu->cm_reg;
-- 
2.1.0
