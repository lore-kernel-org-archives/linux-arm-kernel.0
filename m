From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Wed, 3 Jun 2015 16:52:57 -0400
Subject: [PATCH staging] drivers/hwtracing: fix coresight-replicator-qcom
 implicit <module.h> usage
Message-ID: <1433364777-29651-1-git-send-email-paul.gortmaker@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In commit 620cf787c121f39b5223e43bad3d1b7c66ecead5 ("coresight: replicator:
Add Qualcomm CoreSight Replicator driver") this driver was added.

It uses module_amba_driver(replicator_driver) to register itself with
the system -- which is just an alias for module_driver.  This currently
works by relying on getting that via init.h but we are planning to move
that code[1] to module.h -- at which time this will fail to compile since
it does not include module.h currently, resulting in:

drivers/hwtracing/coresight/coresight-replicator-qcom.c:214:1: error: type defaults to 'int' in declaration of 'module_init' [-Werror=implicit-int]
drivers/hwtracing/coresight/coresight-replicator-qcom.c:214:1: error: type defaults to 'int' in declaration of 'module_exit' [-Werror=implicit-int]

In the future, the amba support may want to create another alias that
uses builtin_driver[2] for cases like this which are using bool Kconfig
triggers, but for now we just fix the implicit include.

[1] https://lkml.kernel.org/r/1433276168-21550-1-git-send-email-paul.gortmaker at windriver.com
[2] https://lkml.kernel.org/r/1431287385-1526-1-git-send-email-paul.gortmaker at windriver.com

Cc: Pratik Patel <pratikp@codeaurora.org>
Cc: Ivan T. Ivanov <ivan.ivanov@linaro.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---

[Note: Commit 620cf787c121 is only in linux-next trees via staging-next;
 this fixes a next build fail when staging-next is merged with [1] above.]

 drivers/hwtracing/coresight/coresight-replicator-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwtracing/coresight/coresight-replicator-qcom.c b/drivers/hwtracing/coresight/coresight-replicator-qcom.c
index deacea49af36..584059e9e866 100644
--- a/drivers/hwtracing/coresight/coresight-replicator-qcom.c
+++ b/drivers/hwtracing/coresight/coresight-replicator-qcom.c
@@ -15,6 +15,7 @@
 #include <linux/clk.h>
 #include <linux/coresight.h>
 #include <linux/device.h>
+#include <linux/module.h>
 #include <linux/err.h>
 #include <linux/init.h>
 #include <linux/io.h>
-- 
2.2.1
