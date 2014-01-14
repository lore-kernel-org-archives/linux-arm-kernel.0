From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Mon, 13 Jan 2014 19:19:41 -0500
Subject: [PATCH 1/3] arm: use subsys_initcall in non-modular pl320 IPC code
In-Reply-To: <1389658783-9876-1-git-send-email-paul.gortmaker@windriver.com>
References: <1389658783-9876-1-git-send-email-paul.gortmaker@windriver.com>
Message-ID: <1389658783-9876-2-git-send-email-paul.gortmaker@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The drivers/mailbox/pl320-ipc.o is dependent on config PL320_MBOX
which is declared as a bool.  Hence the code is never going to be
modular.  So using module_init as an alias for __initcall can be
somewhat misleading.

Fix this up now, so that we can relocate module_init from
init.h into module.h in the future.  If we don't do this, we'd
have to add module.h to obviously non-modular code, and that
would be a worse thing.  Also add an inclusion of init.h, as
that was previously implicit.

Note that direct use of __initcall is discouraged, vs. one of the
priority categorized subgroups.  As __initcall gets mapped onto
device_initcall, our use of subsys_initcall (which seems to make
sense for IPC code) will thus change this registration from a
level 6-device to a level 4-subsys (i.e. slightly earlier).
However no impact of that small difference is expected.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/mailbox/pl320-ipc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/pl320-ipc.c b/drivers/mailbox/pl320-ipc.c
index d873cbae2fbb..b2737a2df1d3 100644
--- a/drivers/mailbox/pl320-ipc.c
+++ b/drivers/mailbox/pl320-ipc.c
@@ -195,4 +195,4 @@ static int __init ipc_init(void)
 {
 	return amba_driver_register(&pl320_driver);
 }
-module_init(ipc_init);
+subsys_initcall(ipc_init);
-- 
1.8.5.2
