From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed,  5 Sep 2018 17:38:11 +0100
Subject: [PATCH] firmware: arm_scmi: fix divide by zero when
 sustained_perf_level is zero
Message-ID: <1536165491-27813-1-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Firmware can provide zero as values for sustained performance level and
corresponding sustained frequency in kHz in order to hide the actual
frequencies and provide only abstract values. It may endup with divide
by zero scenario resulting in kernel panic.

Let's set the multiplication factor to one if either one or both of them
(sustained_perf_level and sustained_freq) are set to zero.

Fixes: a9e3fbfaa0ff ("firmware: arm_scmi: add initial support for performance protocol")
Reported-by: Ionela Voinescu <ionela.voinescu@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scmi/perf.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

Hi ARM SoC team,

Can you pick this patch directly ?

Regards,
Sudeep

diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index 721e6c57beae..51c08394026b 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -166,7 +166,12 @@ scmi_perf_domain_attributes_get(const struct scmi_handle *handle, u32 domain,
 					le32_to_cpu(attr->sustained_freq_khz);
 		dom_info->sustained_perf_level =
 					le32_to_cpu(attr->sustained_perf_level);
-		dom_info->mult_factor =	(dom_info->sustained_freq_khz * 1000) /
+		if (!dom_info->sustained_freq_khz ||
+		    !dom_info->sustained_perf_level)
+			dom_info->mult_factor =	1;
+		else
+			dom_info->mult_factor =
+					(dom_info->sustained_freq_khz * 1000) /
 					dom_info->sustained_perf_level;
 		memcpy(dom_info->name, attr->name, SCMI_MAX_STR_SIZE);
 	}
--
2.7.4
