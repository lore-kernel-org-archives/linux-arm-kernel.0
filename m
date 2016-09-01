From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Thu,  1 Sep 2016 20:42:19 +0200
Subject: [PATCH 1/3] pinctrl: ns2: constify pinctrl_ops and pinmux_ops
 structures
In-Reply-To: <1472755341-9995-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1472755341-9995-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <1472755341-9995-2-git-send-email-Julia.Lawall@lip6.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Check for pinctrl_ops and pinmux_ops structures that are only stored in the
pctlops field and the pmxops field, respectively, of a pinctrl_desc
structure.  These fields are declared const, so pinctrl_ops and pinmux_ops
structures that have this property can be declared as const also.

The semantic patch that makes this change in the pinctrl_ops is as
follows.  The pinmux_ops case is similar.  (http://coccinelle.lip6.fr/)

// <smpl>
@r disable optional_qualifier@
identifier i;
position p;
@@
static struct pinctrl_ops i at p = { ... };

@ok@
identifier r.i;
struct pinctrl_desc e;
position p;
@@
e.pctlops = &i at p;

@bad@
position p != {r.p,ok.p};
identifier r.i;
struct pinctrl_ops e;
@@
e at i@p

@depends on !bad disable optional_qualifier@
identifier r.i;
@@
static
+const
 struct pinctrl_ops i = { ... };
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/pinctrl/bcm/pinctrl-ns2-mux.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/bcm/pinctrl-ns2-mux.c b/drivers/pinctrl/bcm/pinctrl-ns2-mux.c
index ca81789..13a4c27 100644
--- a/drivers/pinctrl/bcm/pinctrl-ns2-mux.c
+++ b/drivers/pinctrl/bcm/pinctrl-ns2-mux.c
@@ -531,7 +531,7 @@ static void ns2_pin_dbg_show(struct pinctrl_dev *pctrl_dev,
 	seq_printf(s, " %s", dev_name(pctrl_dev->dev));
 }
 
-static struct pinctrl_ops ns2_pinctrl_ops = {
+static const struct pinctrl_ops ns2_pinctrl_ops = {
 	.get_groups_count = ns2_get_groups_count,
 	.get_group_name = ns2_get_group_name,
 	.get_group_pins = ns2_get_group_pins,
@@ -959,7 +959,7 @@ static int ns2_pin_config_set(struct pinctrl_dev *pctrldev, unsigned int pin,
 out:
 	return ret;
 }
-static struct pinmux_ops ns2_pinmux_ops = {
+static const struct pinmux_ops ns2_pinmux_ops = {
 	.get_functions_count = ns2_get_functions_count,
 	.get_function_name = ns2_get_function_name,
 	.get_function_groups = ns2_get_function_groups,
