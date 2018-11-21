From: l.luba@partner.samsung.com (Lukasz Luba)
Date: Wed, 21 Nov 2018 19:01:36 +0100
Subject: [PATCH 1/6] devfreq: add basic fileds supporting suspend functionality
In-Reply-To: <1542823301-23563-1-git-send-email-l.luba@partner.samsung.com>
References: <1542823301-23563-1-git-send-email-l.luba@partner.samsung.com>
 <CGME20181121180201eucas1p1f1f96941c3d16a96722e65d5c21bfe80@eucas1p1.samsung.com>
Message-ID: <1542823301-23563-2-git-send-email-l.luba@partner.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch prepares devfreq device for handling suspend/resume functionality.
The new fields will store needed information during this process.
Devfreq framework handles opp-suspend DT entry and there is no need of
modyfications in the drivers code.

The patch draws on Tobias Jakobi's work posted ~2 years ago, who tried to
solve issue with devfreq device's frequency during suspend/resume.
During the discussion on LKML some corner cases and comments appeared
related to the design. This patch address them keeping in mind suggestions
from Chanwoo Choi.

Suggested-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Suggested-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 drivers/devfreq/devfreq.c | 3 +++
 include/linux/devfreq.h   | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 1414130..e20e7e4 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -657,6 +657,9 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	}
 	devfreq->max_freq = devfreq->scaling_max_freq;
 
+	devfreq->suspend_freq = dev_pm_opp_get_suspend_opp_freq(dev);
+	atomic_set(&devfreq->suspend_count, 0);
+
 	dev_set_name(&devfreq->dev, "devfreq%d",
 				atomic_inc_return(&devfreq_no));
 	err = device_register(&devfreq->dev);
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index e4963b0..7fe96f9 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -167,6 +167,10 @@ struct devfreq {
 	unsigned long scaling_max_freq;
 	bool stop_polling;
 
+	unsigned long suspend_freq;
+	unsigned long resume_freq;
+	atomic_t suspend_count;
+
 	/* information for device frequency transition */
 	unsigned int total_trans;
 	unsigned int *trans_table;
-- 
2.7.4
