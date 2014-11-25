From: pramod.gurav@smartplayin.com (Pramod Gurav)
Date: Tue, 25 Nov 2014 16:23:23 +0530
Subject: [RFC PATCH] regulator: core: do not disable regulator if boot_on is
 set
Message-ID: <1416912803-10772-1-git-send-email-pramod.gurav@smartplayin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the regulator core disables the regulators which are unused
or whose reference count is zero or if they are configured always_on.
This change adds a check in this logic to see if a regulator is
configured as boot_on and does not disable it if found true.

Signed-off-by: Pramod Gurav <pramod.gurav@smartplayin.com>

---

The issue was found on apq8064 based IFC6410 on which a fixed regulator
configured as regulator-boot-on in DT and was being disabled when not in
use. Tested this change on this board and found working.

 drivers/regulator/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index cd87c0c..9f7a13f 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -4019,7 +4019,7 @@ static int __init regulator_init_complete(void)
 		ops = rdev->desc->ops;
 		c = rdev->constraints;
 
-		if (c && c->always_on)
+		if (c && (c->always_on || c->boot_on))
 			continue;
 
 		if (c && !(c->valid_ops_mask & REGULATOR_CHANGE_STATUS))
-- 
1.7.9.5
