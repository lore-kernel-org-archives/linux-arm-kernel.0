From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 26 Oct 2018 13:16:31 +0200
Subject: [PATCH 2/9] mailbox: Allow multiple controllers per device
In-Reply-To: <20181026111638.10759-1-thierry.reding@gmail.com>
References: <20181026111638.10759-1-thierry.reding@gmail.com>
Message-ID: <20181026111638.10759-3-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mikko Perttunen <mperttunen@nvidia.com>

Look through the whole controller list when mapping device tree
phandles to controllers instead of stopping at the first one.

Each controller is intended to only contain one kind of mailbox,
but some devices (like Tegra HSP) implement multiple kinds and use
the same device tree node for all of them. As such, we need to allow
multiple mbox_controllers per device tree node.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/mailbox/mailbox.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index 0eaf21259874..f34820bcf33c 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -335,7 +335,8 @@ struct mbox_chan *mbox_request_channel(struct mbox_client *cl, int index)
 	list_for_each_entry(mbox, &mbox_cons, node)
 		if (mbox->dev->of_node == spec.np) {
 			chan = mbox->of_xlate(mbox, &spec);
-			break;
+			if (!IS_ERR(chan))
+				break;
 		}
 
 	of_node_put(spec.np);
-- 
2.19.1
