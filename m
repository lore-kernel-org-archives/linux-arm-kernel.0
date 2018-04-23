From: lionel.debieve@st.com (Lionel Debieve)
Date: Mon, 23 Apr 2018 17:04:26 +0200
Subject: [PATCH 2/2] hwrng: stm32-rng - fix pm_suspend issue
In-Reply-To: <20180423150426.22198-1-lionel.debieve@st.com>
References: <20180423150426.22198-1-lionel.debieve@st.com>
Message-ID: <20180423150426.22198-3-lionel.debieve@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When suspend is called after pm_runtime_suspend,
same callback is used and access to rng register is
freezing system. By calling the pm_runtime_force_suspend,
it first checks that runtime has been already done.

Signed-off-by: Lionel Debieve <lionel.debieve@st.com>
---
 drivers/char/hw_random/stm32-rng.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/char/hw_random/stm32-rng.c b/drivers/char/hw_random/stm32-rng.c
index 0d2328da3b76..042860d97b15 100644
--- a/drivers/char/hw_random/stm32-rng.c
+++ b/drivers/char/hw_random/stm32-rng.c
@@ -187,8 +187,13 @@ static int stm32_rng_runtime_resume(struct device *dev)
 }
 #endif
 
-static UNIVERSAL_DEV_PM_OPS(stm32_rng_pm_ops, stm32_rng_runtime_suspend,
-			    stm32_rng_runtime_resume, NULL);
+static const struct dev_pm_ops stm32_rng_pm_ops = {
+	SET_RUNTIME_PM_OPS(stm32_rng_runtime_suspend,
+			   stm32_rng_runtime_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
+};
+
 
 static const struct of_device_id stm32_rng_match[] = {
 	{
-- 
2.15.1
