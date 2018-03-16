From: okaya@codeaurora.org (Sinan Kaya)
Date: Fri, 16 Mar 2018 12:16:25 -0400
Subject: [PATCH v3 12/18] bnx2x: Eliminate duplicate barriers on
 weakly-ordered archs
In-Reply-To: <1521216991-28706-1-git-send-email-okaya@codeaurora.org>
References: <1521216991-28706-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1521216991-28706-13-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Code includes wmb() followed by writel(). writel() already has a
barrier on some architectures like arm64.

This ends up CPU observing two barriers back to back before executing
the register write.

Since code already has an explicit barrier call, changing writel() to
writel_relaxed().

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_vfpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_vfpf.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_vfpf.c
index 76a4668..3b2f1bd 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_vfpf.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_vfpf.c
@@ -170,7 +170,7 @@ static int bnx2x_send_msg2pf(struct bnx2x *bp, u8 *done, dma_addr_t msg_mapping)
 	wmb();
 
 	/* Trigger the PF FW */
-	writeb(1, &zone_data->trigger.vf_pf_channel.addr_valid);
+	writeb_relaxed(1, &zone_data->trigger.vf_pf_channel.addr_valid);
 
 	/* Wait for PF to complete */
 	while ((tout >= 0) && (!*done)) {
-- 
2.7.4
