From: lee.jones@linaro.org (Lee Jones)
Date: Wed,  2 Jul 2014 16:28:42 +0100
Subject: [PATCH 10/12] mfd: aat2870-core: Stop using obsolte simple_strtoul()
In-Reply-To: <1404314924-23564-1-git-send-email-lee.jones@linaro.org>
References: <1404314924-23564-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1404314924-23564-11-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Soothes checkpatch warning:

    WARNING: simple_strtoul is obsolete, use kstrtoul instead
    #306: FILE: drivers/mfd/aat2870-core.c:306:
    +	addr = simple_strtoul(start, &start, 16);

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/aat2870-core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/aat2870-core.c b/drivers/mfd/aat2870-core.c
index 14d9542..4e6e03d 100644
--- a/drivers/mfd/aat2870-core.c
+++ b/drivers/mfd/aat2870-core.c
@@ -303,7 +303,10 @@ static ssize_t aat2870_reg_write_file(struct file *file,
 	while (*start == ' ')
 		start++;
 
-	addr = simple_strtoul(start, &start, 16);
+	ret = kstrtoul(start, 16, &addr);
+	if (ret)
+		return ret;
+
 	if (addr >= AAT2870_REG_NUM) {
 		dev_err(aat2870->dev, "Invalid address, 0x%lx\n", addr);
 		return -EINVAL;
-- 
1.8.3.2
