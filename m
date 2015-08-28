From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 28 Aug 2015 11:31:51 +0100
Subject: [PATCH v2 4/4] remoteproc: debugfs: Add ability to boot remote
 processor using debugfs
In-Reply-To: <1440757911-9120-1-git-send-email-lee.jones@linaro.org>
References: <1440757911-9120-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1440757911-9120-5-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This functionality is especially useful during the testing phase.  When
used in conjunction with Mailbox's Test Framework we can trivially conduct
end-to-end testing i.e. boot co-processor, send and receive messages to
the co-processor, then shut it down again (repeat as required).

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/remoteproc/remoteproc_debugfs.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/remoteproc/remoteproc_debugfs.c b/drivers/remoteproc/remoteproc_debugfs.c
index 9d30809..464470d 100644
--- a/drivers/remoteproc/remoteproc_debugfs.c
+++ b/drivers/remoteproc/remoteproc_debugfs.c
@@ -88,8 +88,37 @@ static ssize_t rproc_state_read(struct file *filp, char __user *userbuf,
 	return simple_read_from_buffer(userbuf, count, ppos, buf, i);
 }
 
+static ssize_t rproc_state_write(struct file *filp, const char __user *userbuf,
+				 size_t count, loff_t *ppos)
+{
+	struct rproc *rproc = filp->private_data;
+	char buf[2];
+	int ret;
+
+	ret = copy_from_user(buf, userbuf, 1);
+	if (ret)
+		return -EFAULT;
+
+	switch (buf[0]) {
+	case '0':
+		rproc_shutdown(rproc);
+		break;
+	case '1':
+		ret = rproc_boot(rproc);
+		if (ret)
+			dev_warn(&rproc->dev, "Boot failed: %d\n", ret);
+		break;
+	default:
+		dev_err(&rproc->dev, "Unrecognised option: %x\n", buf[1]);
+		return -EINVAL;
+	}
+
+	return count;
+}
+
 static const struct file_operations rproc_state_ops = {
 	.read = rproc_state_read,
+	.write = rproc_state_write,
 	.open = simple_open,
 	.llseek	= generic_file_llseek,
 };
-- 
1.9.1
