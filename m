From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 20 Sep 2015 08:34:54 -0400
Subject: [PATCH resend] extcon: Fix attached value returned by
 is_extcon_changed
In-Reply-To: <1442752494-22244-1-git-send-email-hdegoede@redhat.com>
References: <1442752494-22244-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1442752494-22244-2-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

is_extcon_changed should only check the idx-th bit of new, not
the entirety of new when setting attached.

This fixes extcon sending notifications that a cable was inserted when
it gets removed while another cable is still connected.

Cc: stable at vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/extcon/extcon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
index a07addd..8dd0af1 100644
--- a/drivers/extcon/extcon.c
+++ b/drivers/extcon/extcon.c
@@ -159,7 +159,7 @@ static int find_cable_index_by_name(struct extcon_dev *edev, const char *name)
 static bool is_extcon_changed(u32 prev, u32 new, int idx, bool *attached)
 {
 	if (((prev >> idx) & 0x1) != ((new >> idx) & 0x1)) {
-		*attached = new ? true : false;
+		*attached = ((new >> idx) & 0x1) ? true : false;
 		return true;
 	}
 
-- 
2.4.3
