From: eric@anholt.net (Eric Anholt)
Date: Mon, 17 Oct 2016 12:44:02 -0700
Subject: [PATCH 1/5] staging/vchi: Fix build error in debugfs ops on aarch64.
In-Reply-To: <20161017194406.1080-1-eric@anholt.net>
References: <20161017194406.1080-1-eric@anholt.net>
Message-ID: <20161017194406.1080-2-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

file_operations.write returns a ssize_t, which worked out fine on 32
bit but errors out on 64 bit.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c
index 7e032130d967..f07cd4448ddf 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c
@@ -120,7 +120,7 @@ static int debugfs_log_open(struct inode *inode, struct file *file)
 	return single_open(file, debugfs_log_show, inode->i_private);
 }
 
-static int debugfs_log_write(struct file *file,
+static ssize_t debugfs_log_write(struct file *file,
 	const char __user *buffer,
 	size_t count, loff_t *ppos)
 {
@@ -229,7 +229,7 @@ static int debugfs_trace_open(struct inode *inode, struct file *file)
 	return single_open(file, debugfs_trace_show, inode->i_private);
 }
 
-static int debugfs_trace_write(struct file *file,
+static ssize_t debugfs_trace_write(struct file *file,
 	const char __user *buffer,
 	size_t count, loff_t *ppos)
 {
-- 
2.9.3
