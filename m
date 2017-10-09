From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon,  9 Oct 2017 22:53:38 +0200
Subject: [PATCH v2 2/3] pinctrl: sunxi: Disable strict mode for old pinctrl
 drivers
In-Reply-To: <cover.3e8ef5cb08d0164375d7644df0548e5f39b0fe66.1507582414.git-series.maxime.ripard@free-electrons.com>
References: <cover.3e8ef5cb08d0164375d7644df0548e5f39b0fe66.1507582414.git-series.maxime.ripard@free-electrons.com>
Message-ID: <ff835e2006e92d5fae35b7325d7ae9a5ae041e1d.1507582414.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Old pinctrl drivers will need to disable strict mode for various reasons,
among which:
  - Some DT will still have a pinctrl group for each GPIO used, which will
    be rejected by pin_request. While we could remove those nodes, we still
    have to deal with old DTs.
  - Some GPIOs on these boards need to have their pin configuration changed
    (for bias or current), and there's no clear migration path

Let's disable the strict mode on those SoCs so that there's no breakage.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c   | 1 +
 drivers/pinctrl/sunxi/pinctrl-sun5i.c       | 1 +
 drivers/pinctrl/sunxi/pinctrl-sun6i-a31-r.c | 1 +
 drivers/pinctrl/sunxi/pinctrl-sun6i-a31.c   | 1 +
 drivers/pinctrl/sunxi/pinctrl-sun8i-a23-r.c | 1 +
 drivers/pinctrl/sunxi/pinctrl-sun8i-a23.c   | 1 +
 drivers/pinctrl/sunxi/pinctrl-sun8i-a33.c   | 1 +
 drivers/pinctrl/sunxi/pinctrl-sun8i-h3-r.c  | 3 ++-
 drivers/pinctrl/sunxi/pinctrl-sun8i-h3.c    | 3 ++-
 drivers/pinctrl/sunxi/pinctrl-sun9i-a80-r.c | 1 +
 drivers/pinctrl/sunxi/pinctrl-sun9i-a80.c   | 1 +
 11 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c b/drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c
index f763d8d62d6e..295e48fc94bc 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c
@@ -1289,6 +1289,7 @@ static const struct sunxi_pinctrl_desc sun4i_a10_pinctrl_data = {
 	.npins = ARRAY_SIZE(sun4i_a10_pins),
 	.irq_banks = 1,
 	.irq_read_needs_mux = true,
+	.disable_strict_mode = true,
 };
 
 static int sun4i_a10_pinctrl_probe(struct platform_device *pdev)
diff --git a/drivers/pinctrl/sunxi/pinctrl-sun5i.c b/drivers/pinctrl/sunxi/pinctrl-sun5i.c
index 47afd558b114..27ec99e81c4c 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun5i.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun5i.c
@@ -713,6 +713,7 @@ static const struct sunxi_pinctrl_desc sun5i_pinctrl_data = {
 	.pins = sun5i_pins,
 	.npins = ARRAY_SIZE(sun5i_pins),
 	.irq_banks = 1,
+	.disable_strict_mode = true,
 };
 
 static int sun5i_pinctrl_probe(struct platform_device *pdev)
diff --git a/drivers/pinctrl/sunxi/pinctrl-sun6i-a31-r.c b/drivers/pinctrl/sunxi/pinctrl-sun6i-a31-r.c
index 49a1deb97bb7..a00246d3dd49 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun6i-a31-r.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun6i-a31-r.c
@@ -106,6 +106,7 @@ static const struct sunxi_pinctrl_desc sun6i_a31_r_pinctrl_data = {
 	.npins = ARRAY_SIZE(sun6i_a31_r_pins),
 	.pin_base = PL_BASE,
 	.irq_banks = 2,
+	.disable_strict_mode = true,
 };
 
 static int sun6i_a31_r_pinctrl_probe(struct platform_device *pdev)
diff --git a/drivers/pinctrl/sunxi/pinctrl-sun6i-a31.c b/drivers/pinctrl/sunxi/pinctrl-sun6i-a31.c
index 951a25c18815..82ffaf466892 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun6i-a31.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun6i-a31.c
@@ -965,6 +965,7 @@ static const struct sunxi_pinctrl_desc sun6i_a31_pinctrl_data = {
 	.pins = sun6i_a31_pins,
 	.npins = ARRAY_SIZE(sun6i_a31_pins),
 	.irq_banks = 4,
+	.disable_strict_mode = true,
 };
 
 static int sun6i_a31_pinctrl_probe(struct platform_device *pdev)
diff --git a/drivers/pinctrl/sunxi/pinctrl-sun8i-a23-r.c b/drivers/pinctrl/sunxi/pinctrl-sun8i-a23-r.c
index 67ee6f9b3b68..8a08c4afc6a8 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun8i-a23-r.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun8i-a23-r.c
@@ -93,6 +93,7 @@ static const struct sunxi_pinctrl_desc sun8i_a23_r_pinctrl_data = {
 	.npins = ARRAY_SIZE(sun8i_a23_r_pins),
 	.pin_base = PL_BASE,
 	.irq_banks = 1,
+	.disable_strict_mode = true,
 };
 
 static int sun8i_a23_r_pinctrl_probe(struct platform_device *pdev)
diff --git a/drivers/pinctrl/sunxi/pinctrl-sun8i-a23.c b/drivers/pinctrl/sunxi/pinctrl-sun8i-a23.c
index 721b6935baf3..402fd7d21e7b 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun8i-a23.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun8i-a23.c
@@ -563,6 +563,7 @@ static const struct sunxi_pinctrl_desc sun8i_a23_pinctrl_data = {
 	.pins = sun8i_a23_pins,
 	.npins = ARRAY_SIZE(sun8i_a23_pins),
 	.irq_banks = 3,
+	.disable_strict_mode = true,
 };
 
 static int sun8i_a23_pinctrl_probe(struct platform_device *pdev)
diff --git a/drivers/pinctrl/sunxi/pinctrl-sun8i-a33.c b/drivers/pinctrl/sunxi/pinctrl-sun8i-a33.c
index ef1e0bef4099..da387211a75e 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun8i-a33.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun8i-a33.c
@@ -486,6 +486,7 @@ static const struct sunxi_pinctrl_desc sun8i_a33_pinctrl_data = {
 	.npins = ARRAY_SIZE(sun8i_a33_pins),
 	.irq_banks = 2,
 	.irq_bank_base = 1,
+	.disable_strict_mode = true,
 };
 
 static int sun8i_a33_pinctrl_probe(struct platform_device *pdev)
diff --git a/drivers/pinctrl/sunxi/pinctrl-sun8i-h3-r.c b/drivers/pinctrl/sunxi/pinctrl-sun8i-h3-r.c
index ebfd9a26628c..b795a199e240 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun8i-h3-r.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun8i-h3-r.c
@@ -82,7 +82,8 @@ static const struct sunxi_pinctrl_desc sun8i_h3_r_pinctrl_data = {
 	.npins = ARRAY_SIZE(sun8i_h3_r_pins),
 	.irq_banks = 1,
 	.pin_base = PL_BASE,
-	.irq_read_needs_mux = true
+	.irq_read_needs_mux = true,
+	.disable_strict_mode = true,
 };
 
 static int sun8i_h3_r_pinctrl_probe(struct platform_device *pdev)
diff --git a/drivers/pinctrl/sunxi/pinctrl-sun8i-h3.c b/drivers/pinctrl/sunxi/pinctrl-sun8i-h3.c
index 518a92df4418..d1719a738c20 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun8i-h3.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun8i-h3.c
@@ -491,7 +491,8 @@ static const struct sunxi_pinctrl_desc sun8i_h3_pinctrl_data = {
 	.pins = sun8i_h3_pins,
 	.npins = ARRAY_SIZE(sun8i_h3_pins),
 	.irq_banks = 2,
-	.irq_read_needs_mux = true
+	.irq_read_needs_mux = true,
+	.disable_strict_mode = true,
 };
 
 static int sun8i_h3_pinctrl_probe(struct platform_device *pdev)
diff --git a/drivers/pinctrl/sunxi/pinctrl-sun9i-a80-r.c b/drivers/pinctrl/sunxi/pinctrl-sun9i-a80-r.c
index 92a873f73697..c63086c98335 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun9i-a80-r.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun9i-a80-r.c
@@ -152,6 +152,7 @@ static const struct sunxi_pinctrl_desc sun9i_a80_r_pinctrl_data = {
 	.npins = ARRAY_SIZE(sun9i_a80_r_pins),
 	.pin_base = PL_BASE,
 	.irq_banks = 2,
+	.disable_strict_mode = true,
 };
 
 static int sun9i_a80_r_pinctrl_probe(struct platform_device *pdev)
diff --git a/drivers/pinctrl/sunxi/pinctrl-sun9i-a80.c b/drivers/pinctrl/sunxi/pinctrl-sun9i-a80.c
index bc14e954d7a2..472ef0d91b99 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun9i-a80.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun9i-a80.c
@@ -721,6 +721,7 @@ static const struct sunxi_pinctrl_desc sun9i_a80_pinctrl_data = {
 	.pins = sun9i_a80_pins,
 	.npins = ARRAY_SIZE(sun9i_a80_pins),
 	.irq_banks = 5,
+	.disable_strict_mode = true,
 };
 
 static int sun9i_a80_pinctrl_probe(struct platform_device *pdev)
-- 
git-series 0.9.1
