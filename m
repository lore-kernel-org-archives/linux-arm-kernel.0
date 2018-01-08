From: yixun.lan@amlogic.com (Yixun Lan)
Date: Mon, 8 Jan 2018 15:33:27 +0800
Subject: [PATCH 1/2] pinctrl: meson: introduce a macro to have name/groups
 seperated
In-Reply-To: <20180108073328.205769-1-yixun.lan@amlogic.com>
References: <20180108073328.205769-1-yixun.lan@amlogic.com>
Message-ID: <20180108073328.205769-2-yixun.lan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We introduce a macro FUNCTION_EX here, the main motivation is
trying to have the possibility to expand the macro with the same of the
'.name' number but different multiple '.groups/.num_groups' numbers.

With this change, the meson pinctrl drivr is capable of have one uniform
'function' name but with different pin 'groups', as we face the sitiuation
that two pin groups may live inside different hardware domain (EE vs AO domain),
which mean we couldn't put them in one single group.

Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
---
 drivers/pinctrl/meson/pinctrl-meson.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/meson/pinctrl-meson.h b/drivers/pinctrl/meson/pinctrl-meson.h
index 12a391109329..d8f705098810 100644
--- a/drivers/pinctrl/meson/pinctrl-meson.h
+++ b/drivers/pinctrl/meson/pinctrl-meson.h
@@ -124,13 +124,15 @@ struct meson_pinctrl {
 	struct device_node *of_node;
 };
 
-#define FUNCTION(fn)							\
+#define FUNCTION_EX(fn, ex)						\
 	{								\
 		.name = #fn,						\
-		.groups = fn ## _groups,				\
-		.num_groups = ARRAY_SIZE(fn ## _groups),		\
+		.groups = fn ## ex ## _groups,				\
+		.num_groups = ARRAY_SIZE(fn ## ex ## _groups),		\
 	}
 
+#define FUNCTION(fn)	FUNCTION_EX(fn, )
+
 #define BANK(n, f, l, fi, li, per, peb, pr, pb, dr, db, or, ob, ir, ib)	\
 	{								\
 		.name		= n,					\
-- 
2.15.1
