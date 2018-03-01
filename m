From: bich.hemon@st.com (Bich HEMON)
Date: Thu, 1 Mar 2018 12:29:50 +0000
Subject: [PATCH] can: m_can: select pinctrl state in each suspend/resume
 function
Message-ID: <1519907380-15135-1-git-send-email-bich.hemon@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make sure to apply the correct pin state in suspend/resume callbacks.
Putting pins in sleep state saves power.

Signed-off-by: Bich Hemon <bich.hemon@st.com>
---
 drivers/net/can/m_can/m_can.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 2594f77..a86ef69 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1700,6 +1700,8 @@ static __maybe_unused int m_can_suspend(struct device *dev)
 		m_can_clk_stop(priv);
 	}
 
+	pinctrl_pm_select_sleep_state(dev);
+
 	priv->can.state = CAN_STATE_SLEEPING;
 
 	return 0;
@@ -1710,6 +1712,8 @@ static __maybe_unused int m_can_resume(struct device *dev)
 	struct net_device *ndev = dev_get_drvdata(dev);
 	struct m_can_priv *priv = netdev_priv(ndev);
 
+	pinctrl_pm_select_default_state(dev);
+
 	m_can_init_ram(priv);
 
 	priv->can.state = CAN_STATE_ERROR_ACTIVE;
-- 
1.9.1
