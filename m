From: fabrice.gasnier@st.com (Fabrice Gasnier)
Date: Mon, 18 Sep 2017 12:05:30 +0200
Subject: [PATCH 1/3] iio: trigger: stm32-timer: preset shouldn't be buffered
In-Reply-To: <1505729132-1369-1-git-send-email-fabrice.gasnier@st.com>
References: <1505729132-1369-1-git-send-email-fabrice.gasnier@st.com>
Message-ID: <1505729132-1369-2-git-send-email-fabrice.gasnier@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, setting preset value (ARR) will update directly 'Auto reload
value' only on 1st write access. But then, ARPE is set. This makes
ARR a shadow register. Preset value should be updated upon each
write request: ensure ARPE is 0. This fixes successive writes to
preset attribute.

Fixes: 4adec7da0536 ("iio: stm32 trigger: Add quadrature encoder device")

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/iio/trigger/stm32-timer-trigger.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/trigger/stm32-timer-trigger.c b/drivers/iio/trigger/stm32-timer-trigger.c
index 9b90534..34cc25b 100644
--- a/drivers/iio/trigger/stm32-timer-trigger.c
+++ b/drivers/iio/trigger/stm32-timer-trigger.c
@@ -715,8 +715,9 @@ static ssize_t stm32_count_set_preset(struct iio_dev *indio_dev,
 	if (ret)
 		return ret;
 
+	/* TIMx_ARR register shouldn't be buffered (ARPE=0) */
+	regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_ARPE, 0);
 	regmap_write(priv->regmap, TIM_ARR, preset);
-	regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_ARPE, TIM_CR1_ARPE);
 
 	return len;
 }
-- 
1.9.1
