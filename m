From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Tue, 25 Nov 2014 02:05:34 +0300
Subject: [PATCH V2 4/6] pcmcia: soc-common: enable/disable socket clocks
In-Reply-To: <1416870336-30114-1-git-send-email-dbaryshkov@gmail.com>
References: <1416870336-30114-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <1416870336-30114-5-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Call clk_prepare_enable() during hw_init() and clk_disable_unprepare()
during hw_shutdown() to ensure that the clock rates returned by
clk_get_rate() are correct.

It is safe to call enable/disable functions even on NULL clock, so this
patch will not break cases when the socket clock is not set.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 drivers/pcmcia/soc_common.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pcmcia/soc_common.c b/drivers/pcmcia/soc_common.c
index a2bc6ee..933f465 100644
--- a/drivers/pcmcia/soc_common.c
+++ b/drivers/pcmcia/soc_common.c
@@ -120,6 +120,8 @@ static void __soc_pcmcia_hw_shutdown(struct soc_pcmcia_socket *skt,
 
 	if (skt->ops->hw_shutdown)
 		skt->ops->hw_shutdown(skt);
+
+	clk_disable_unprepare(skt->clk);
 }
 
 static void soc_pcmcia_hw_shutdown(struct soc_pcmcia_socket *skt)
@@ -131,6 +133,8 @@ static int soc_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
 {
 	int ret = 0, i;
 
+	clk_prepare_enable(skt->clk);
+
 	if (skt->ops->hw_init) {
 		ret = skt->ops->hw_init(skt);
 		if (ret)
-- 
2.1.3
