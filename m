From: broonie@kernel.org (Mark Brown)
Date: Mon, 18 Apr 2016 14:10:35 +0100
Subject: Applied "regulator: qcom_spmi: Always return a selector when asked"
 to the regulator tree
In-Reply-To: <1460742277-2838-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <E1as8wl-00020a-EQ@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   regulator: qcom_spmi: Always return a selector when asked

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

>From b1d21a24df458c897911af51cb637460c1ac5d95 Mon Sep 17 00:00:00 2001
From: Stephen Boyd <sboyd@codeaurora.org>
Date: Fri, 15 Apr 2016 10:44:37 -0700
Subject: [PATCH] regulator: qcom_spmi: Always return a selector when asked

I had a thinko in spmi_regulator_select_voltage_same_range() when
converting it to return selectors via the function's return value
instead of by modifying a pointer argument. I only tested
multi-range regulators so this passed through testing. Fix it by
returning the selector here.

Fixes: 1b5b19689278 ("regulator: qcom_spmi: Only use selector based regulator ops")
Reported-by: Rajendra Nayak <rnayak@codeaurora.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/qcom_spmi-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/qcom_spmi-regulator.c b/drivers/regulator/qcom_spmi-regulator.c
index f502f2cc65d8..84cce21e98cd 100644
--- a/drivers/regulator/qcom_spmi-regulator.c
+++ b/drivers/regulator/qcom_spmi-regulator.c
@@ -692,7 +692,7 @@ static int spmi_regulator_select_voltage_same_range(struct spmi_regulator *vreg,
 	if (selector >= vreg->set_points->n_voltages)
 		goto different_range;
 
-	return 0;
+	return selector;
 
 different_range:
 	return spmi_regulator_select_voltage(vreg, min_uV, max_uV);
-- 
2.8.0.rc3
