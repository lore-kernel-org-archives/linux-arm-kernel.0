From: mchehab+samsung@kernel.org (Mauro Carvalho Chehab)
Date: Tue,  6 Nov 2018 06:21:29 -0500
Subject: [PATCH] cedrus: check if kzalloc() fails
Message-ID: <b9bd5d87291191eeeef2b0611a1cc0acde52b2c9.1541503285.git.mchehab+samsung@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As warned by static code analizer checkers:
	drivers/staging/media/sunxi/cedrus/cedrus.c: drivers/staging/media/sunxi/cedrus/cedrus.c:93 cedrus_init_ctrls() error: potential null dereference 'ctx->ctrls'.  (kzalloc returns null)

The problem is that it assumes that kzalloc() will always
succeed.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 drivers/staging/media/sunxi/cedrus/cedrus.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.c b/drivers/staging/media/sunxi/cedrus/cedrus.c
index dd121f66fa2d..6a73a7841303 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus.c
@@ -72,6 +72,8 @@ static int cedrus_init_ctrls(struct cedrus_dev *dev, struct cedrus_ctx *ctx)
 	ctrl_size = sizeof(ctrl) * CEDRUS_CONTROLS_COUNT + 1;
 
 	ctx->ctrls = kzalloc(ctrl_size, GFP_KERNEL);
+	if (!ctx->ctrls)
+		return -ENOMEM;
 	memset(ctx->ctrls, 0, ctrl_size);
 
 	for (i = 0; i < CEDRUS_CONTROLS_COUNT; i++) {
-- 
2.19.1
