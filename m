From: mchehab@osg.samsung.com (Mauro Carvalho Chehab)
Date: Tue, 11 Aug 2015 16:15:38 -0300
Subject: [PATCH] c8sectpfe: don't go past channel_data array
Message-ID: <298d59cd52c4ecce188439fcd19946ffafe682fc.1439320535.git.mchehab@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As reported by smatch:
	drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c:365 find_channel() error: buffer overflow 'fei->channel_data' 8 <= 63

It seems that a cut-and-paste type of error occurred here:
the channel_data array size is C8SECTPFE_MAX_TSIN_CHAN, and not
C8SECTPFE_MAXCHANNEL.

Signed-off-by: Mauro Carvalho Chehab <mchehab@osg.samsung.com>

diff --git a/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c b/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c
index 3a9109356e67..955d8daf055f 100644
--- a/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c
+++ b/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c
@@ -361,7 +361,7 @@ static struct channel_info *find_channel(struct c8sectpfei *fei, int tsin_num)
 {
 	int i;
 
-	for (i = 0; i < C8SECTPFE_MAXCHANNEL; i++) {
+	for (i = 0; i < C8SECTPFE_MAX_TSIN_CHAN; i++) {
 		if (!fei->channel_data[i])
 			continue;
 
-- 
2.4.3
