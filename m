From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 28 Jan 2015 22:17:42 +0100
Subject: [PATCH 2/7] [media] radio/aimslab: use mdelay instead of udelay
In-Reply-To: <1422479867-3370921-1-git-send-email-arnd@arndb.de>
References: <1422479867-3370921-1-git-send-email-arnd@arndb.de>
Message-ID: <1422479867-3370921-3-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Large udelay values are not allowed on the ARM architecture
and result in a build error like

ERROR: "__bad_udelay" [drivers/media/radio/radio-aimslab.ko] undefined!

This changes the aimslab radio driver to use an equivalent mdelay
statement.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Hans Verkuil <hverkuil@xs4all.nl>
---
 drivers/media/radio/radio-aimslab.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/radio/radio-aimslab.c b/drivers/media/radio/radio-aimslab.c
index a739ad492e7b..ea9308796741 100644
--- a/drivers/media/radio/radio-aimslab.c
+++ b/drivers/media/radio/radio-aimslab.c
@@ -129,11 +129,11 @@ static int rtrack_s_mute_volume(struct radio_isa_card *isa, bool mute, int vol)
 	} else if (curvol < vol) {
 		outb(0x98, isa->io);	/* volume up + sigstr + on	*/
 		for (; curvol < vol; curvol++)
-			udelay(3000);
+			mdelay(3);
 	} else if (curvol > vol) {
 		outb(0x58, isa->io);	/* volume down + sigstr + on	*/
 		for (; curvol > vol; curvol--)
-			udelay(3000);
+			mdelay(3);
 	}
 	outb(0xd8, isa->io);		/* volume steady + sigstr + on	*/
 	rt->curvol = vol;
-- 
2.1.0.rc2
