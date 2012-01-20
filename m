From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 20 Jan 2012 10:22:35 +0000
Subject: [PATCH 16/19] PCMCIA: sa1111: jornada720: no need to disable IRQs
 around sa1111_set_io
In-Reply-To: <20120120101709.GE1068@n2100.arm.linux.org.uk>
References: <20120120101709.GE1068@n2100.arm.linux.org.uk>
Message-ID: <E1RoBcB-0005iU-8i@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sa1111_set_io() already contains the necessary locking within itself
to safely change the state of a set of GPIOs.  There's no need for
callers to protect this by disabling IRQs themselves.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/pcmcia/sa1100_jornada720.c |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/drivers/pcmcia/sa1100_jornada720.c b/drivers/pcmcia/sa1100_jornada720.c
index 61b443e..69428d1 100644
--- a/drivers/pcmcia/sa1100_jornada720.c
+++ b/drivers/pcmcia/sa1100_jornada720.c
@@ -78,13 +78,8 @@ jornada720_pcmcia_configure_socket(struct soc_pcmcia_socket *skt, const socket_s
 	}
 
 	ret = sa1111_pcmcia_configure_socket(skt, state);
-	if (ret == 0) {
-		unsigned long flags;
-
-		local_irq_save(flags);
+	if (ret == 0)
 		sa1111_set_io(s->dev, pa_dwr_mask, pa_dwr_set);
-		local_irq_restore(flags);
-	}
 
 	return ret;
 }
-- 
1.7.4.4
