From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Fri, 14 Sep 2012 12:13:18 +0100
Subject: [PATCH v4 16/24] xen: clear IRQ_NOAUTOEN and IRQ_NOREQUEST
In-Reply-To: <alpine.DEB.2.02.1209141145150.29232@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1209141145150.29232@kaball.uk.xensource.com>
Message-ID: <1347621207-11294-16-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reset the IRQ_NOAUTOEN and IRQ_NOREQUEST flags that are enabled by
default on ARM. If IRQ_NOAUTOEN is set, __setup_irq doesn't call
irq_startup, that is responsible for calling irq_unmask at startup time.
As a result event channels remain masked.

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Acked-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
---
 drivers/xen/events.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/xen/events.c b/drivers/xen/events.c
index 5ecb596..8ffb7b7 100644
--- a/drivers/xen/events.c
+++ b/drivers/xen/events.c
@@ -836,6 +836,7 @@ int bind_evtchn_to_irq(unsigned int evtchn)
 		struct irq_info *info = info_for_irq(irq);
 		WARN_ON(info == NULL || info->type != IRQT_EVTCHN);
 	}
+	irq_clear_status_flags(irq, IRQ_NOREQUEST|IRQ_NOAUTOEN);
 
 out:
 	mutex_unlock(&irq_mapping_update_lock);
-- 
1.7.2.5
