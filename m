From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 23 Mar 2016 14:43:43 +0000
Subject: [PATCH v2 5/5] mailbox: Stop using ENOSYS for anything other than
 unimplemented syscalls
In-Reply-To: <1458744223-12164-1-git-send-email-lee.jones@linaro.org>
References: <1458744223-12164-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1458744223-12164-6-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In accordance with e15f431fe2d5 ("errno.h: Improve ENOSYS's comment") and
91c9afaf97ee ("checkpatch.pl: new instances of ENOSYS are errors") we're
converting from the old meaning of: ENOSYS "Function not implemented" to
a more standard EINVAL.

Reported-by: Seraphin Bonnaffe <seraphin.bonnaffe@st.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mailbox/mailbox.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index 6a4811f..4a36632 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -375,13 +375,13 @@ struct mbox_chan *mbox_request_channel_byname(struct mbox_client *cl,
 
 	if (!np) {
 		dev_err(cl->dev, "%s() currently only supports DT\n", __func__);
-		return ERR_PTR(-ENOSYS);
+		return ERR_PTR(-EINVAL);
 	}
 
 	if (!of_get_property(np, "mbox-names", NULL)) {
 		dev_err(cl->dev,
 			"%s() requires an \"mbox-names\" property\n", __func__);
-		return ERR_PTR(-ENOSYS);
+		return ERR_PTR(-EINVAL);
 	}
 
 	of_property_for_each_string(np, "mbox-names", prop, mbox_name) {
-- 
1.9.1
