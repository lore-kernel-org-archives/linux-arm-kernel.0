From: marc@plastictigers.com (Marc Butler)
Date: Tue, 5 Jun 2012 16:57:21 -0400
Subject: [PATCH] slimbus: Linux driver framework for SLIMbus.
In-Reply-To: <1338340310-4473-1-git-send-email-sdharia@codeaurora.org>
References: <1338340310-4473-1-git-send-email-sdharia@codeaurora.org>
Message-ID: <20120605205721.GA20560@plastictigers.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch below fixes an bug where devices that have not be matched
to a driver will result in a segv when the bus is shutdown.

I am not sure what the policy on patches-on-patches is, it just
doesn't seem workable. So I this will be the first and last. Instead I
am maintaing a git repository that tracks Linus's tree:

git://git.plastictigers.com/slimbus.git

or it can be browsed via the web:

http://git.plastictigers.com/

Currently there are 3 branches:

slimbus-rfc-patch   : the original rfc patch (for reference)
slimbus-patch       : the current patch (as posted by Sagar)
slimbus-patch-fixes : slimbus-patch + fixes (like the one below)

There will likely be a couple of new branches in the future.

If anyone has a suggestion on a better way of doing this I am all
ears.

---
 drivers/slimbus/slimbus.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/slimbus/slimbus.c b/drivers/slimbus/slimbus.c
index 6d20241..673222c 100644
--- a/drivers/slimbus/slimbus.c
+++ b/drivers/slimbus/slimbus.c
@@ -125,6 +125,9 @@ static void slim_device_shutdown(struct device *dev)
 	struct slim_device *slim_dev;
 	struct slim_driver *driver;
 
+	if (!dev->driver)
+		return;
+
 	if (dev->type == &slim_dev_type)
 		slim_dev = to_slim_device(dev);
 	else
-- 
1.7.7
