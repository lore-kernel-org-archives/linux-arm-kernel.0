From: broonie@kernel.org (Mark Brown)
Date: Sun, 26 Jun 2016 13:03:08 +0100
Subject: Applied "regulator: qcom_spmi: Update mvs1/mvs2 switches on pm8941"
 to the regulator tree
In-Reply-To: <20160626055213.18071-3-stephen.boyd@linaro.org>
Message-ID: <E1bH8mK-0002bI-8q@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   regulator: qcom_spmi: Update mvs1/mvs2 switches on pm8941

has been applied to the regulator tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 93bfe79b03365f410aa91caf04263173c008ecdf Mon Sep 17 00:00:00 2001
From: Stephen Boyd <stephen.boyd@linaro.org>
Date: Sat, 25 Jun 2016 22:52:12 -0700
Subject: [PATCH] regulator: qcom_spmi: Update mvs1/mvs2 switches on pm8941

The mvs1 and mvs2 switches are actually called 5vs1 and 5vs2 on
some datasheets. Let's rename them to match the datasheets and
also match the RPM based regulator driver which calls these by
their 5vs names (see qcom_smd-regulator.c). There aren't any
users of these regulators so far, so there aren't any concerns of
DT ABI breakage here. While we're here making updates to the
switches, also mandate usage of the OCP irq for these switches
too.

Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Fixes: e92a4047419c ("regulator: Add QCOM SPMI regulator driver")
Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.txt | 2 +-
 drivers/regulator/qcom_spmi-regulator.c                             | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.txt b/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.txt
index 3e827bb9a56d..0fa3b0fac129 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.txt
@@ -115,7 +115,7 @@ pm8916:
 pm8941:
 	s1, s2, s3, s4, l1, l2, l3, l4, l5, l6, l7, l8, l9, l10, l11, l12, l13,
 	l14, l15, l16, l17, l18, l19, l20, l21, l22, l23, l24, lvs1, lvs2, lvs3,
-	mvs1, mvs2
+	5vs1, 5vs2
 
 pm8994:
 	s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, l1, l2, l3, l4, l5,
diff --git a/drivers/regulator/qcom_spmi-regulator.c b/drivers/regulator/qcom_spmi-regulator.c
index fe09407b150b..43f8f20b82e9 100644
--- a/drivers/regulator/qcom_spmi-regulator.c
+++ b/drivers/regulator/qcom_spmi-regulator.c
@@ -1524,8 +1524,8 @@ static const struct spmi_regulator_data pm8941_regulators[] = {
 	{ "lvs1", 0x8000, "vdd_l2_lvs_1_2_3", },
 	{ "lvs2", 0x8100, "vdd_l2_lvs_1_2_3", },
 	{ "lvs3", 0x8200, "vdd_l2_lvs_1_2_3", },
-	{ "mvs1", 0x8300, "vin_5vs", },
-	{ "mvs2", 0x8400, "vin_5vs", },
+	{ "5vs1", 0x8300, "vin_5vs", "ocp-5vs1", },
+	{ "5vs2", 0x8400, "vin_5vs", "ocp-5vs2", },
 	{ }
 };
 
-- 
2.8.1
