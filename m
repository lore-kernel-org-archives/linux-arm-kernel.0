From: eric.y.miao@gmail.com (Eric Miao)
Date: Sat, 26 Dec 2009 16:41:41 +0800
Subject: [ARM] pxafb: fix building issue of incorrect reference
Message-ID: <f17812d70912260041m64f55550v6d478556ca11c468@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

    [ARM] pxafb: fix building issue of incorrect reference

    Commit "d2a34c1 drivers/video: Move dereference after NULL test" introduced
    a build error of "fbi->dev->platform_data->smart_update" being unknown type
    to the compiler, fix this by removing the unnecessary test of 'fbi'.

    Cc: Julia Lawall <julia@diku.dk>
    Signed-off-by: Eric Miao <eric.y.miao@gmail.com>

diff --git a/drivers/video/pxafb.c b/drivers/video/pxafb.c
index 415858b..825b665 100644
--- a/drivers/video/pxafb.c
+++ b/drivers/video/pxafb.c
@@ -1221,9 +1221,9 @@ static void setup_smart_timing(struct pxafb_info *fbi,
 static int pxafb_smart_thread(void *arg)
 {
 	struct pxafb_info *fbi = arg;
-	struct pxafb_mach_info *inf;
+	struct pxafb_mach_info *inf = fbi->dev->platform_data;

-	if (!fbi || !fbi->dev->platform_data->smart_update) {
+	if (!inf->smart_update) {
 		pr_err("%s: not properly initialized, thread terminated\n",
 				__func__);
 		return -EINVAL;
