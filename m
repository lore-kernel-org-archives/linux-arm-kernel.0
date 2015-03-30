From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 30 Mar 2015 19:32:45 +0200
Subject: [PATCH] sata_mv: Manage SATA port multiplier while searching for
 active links
Message-ID: <1427736765-846-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nadav Haklai <nadavh@marvell.com>

With this patch, when searching for active link, first search through
the port multiplier links. And then fall to the default ap active_tag
only if no there is no active link in the port multiplier.

[gregory.clement at free-electrons.com: reword commit log and title]

Signed-off-by: Lior Amsalem <alior@marvell.com>
Reviewed-by: Nadav Haklai <nadavh@marvell.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/ata/sata_mv.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index f8c33e3772b8..7fac4d0fee86 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -2423,10 +2423,19 @@ static struct ata_queued_cmd *mv_get_active_qc(struct ata_port *ap)
 {
 	struct mv_port_priv *pp = ap->private_data;
 	struct ata_queued_cmd *qc;
+	struct ata_link *link = NULL;
 
 	if (pp->pp_flags & MV_PP_FLAG_NCQ_EN)
 		return NULL;
-	qc = ata_qc_from_tag(ap, ap->link.active_tag);
+
+	ata_for_each_link(link, ap, EDGE)
+		if (ata_link_active(link))
+			break;
+
+	if (!link)
+		link = &ap->link;
+
+	qc = ata_qc_from_tag(ap, link->active_tag);
 	if (qc && !(qc->tf.flags & ATA_TFLAG_POLLING))
 		return qc;
 	return NULL;
-- 
2.1.0
