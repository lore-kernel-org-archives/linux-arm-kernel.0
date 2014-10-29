From: b29396@freescale.com (Dong Aisheng)
Date: Wed, 29 Oct 2014 18:45:24 +0800
Subject: [PATCH 4/7] can: m_can: add a bit delay after setting CCCR_INIT bit
In-Reply-To: <1414579527-31100-1-git-send-email-b29396@freescale.com>
References: <1414579527-31100-1-git-send-email-b29396@freescale.com>
Message-ID: <1414579527-31100-4-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The spec mentions there may be a delay until the value written to
INIT can be read back due to the synchronization mechanism between the
two clock domains. But it does not indicate the exact clock cycles needed.
The 5us delay is a test value and seems ok.

Without the delay, CCCR.CCE bit may fail to be set and then the
initialization fail sometimes when do repeatly up and down.

Signed-off-by: Dong Aisheng <b29396@freescale.com>
---
 drivers/net/can/m_can/m_can.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index e4ef146..6160b9c 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -296,6 +296,7 @@ static inline void m_can_config_endisable(const struct m_can_priv *priv,
 	if (enable) {
 		/* enable m_can configuration */
 		m_can_write(priv, M_CAN_CCCR, cccr | CCCR_INIT);
+		udelay(5);
 		/* CCCR.CCE can only be set/reset while CCCR.INIT = '1' */
 		m_can_write(priv, M_CAN_CCCR, cccr | CCCR_INIT | CCCR_CCE);
 	} else {
-- 
1.9.1
