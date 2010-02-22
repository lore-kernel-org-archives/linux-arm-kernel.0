From: niam.niam@gmail.com (Ni@m)
Date: Mon, 22 Feb 2010 18:26:22 +0200
Subject: [PATCH] jffs2: fix memory leak if the sector was successfully erased
Message-ID: <a9e22dff1002220826p63209a33n27e84ea10e191a19@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Memory allocated for erase instruction is not freed if the sector was
successfully erased.

Signed-off-by: Dmytro Milinevskyy <niam.niam@gmail.com>
---
 fs/jffs2/erase.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/fs/jffs2/erase.c b/fs/jffs2/erase.c
index b47679b..c0a5604 100644
--- a/fs/jffs2/erase.c
+++ b/fs/jffs2/erase.c
@@ -74,8 +74,10 @@ static void jffs2_erase_block(struct jffs2_sb_info *c,
        ((struct erase_priv_struct *)instr->priv)->c = c;

        ret = c->mtd->erase(c->mtd, instr);
-       if (!ret)
+       if (!ret) {
+        kfree(instr);
                return;
+    }

        bad_offset = instr->fail_addr;
        kfree(instr);
