From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Mon, 05 May 2014 12:57:13 +0200
Subject: [PATCH 1/7] arm: firmware: Check firmware is running or not
In-Reply-To: <1399287439-31376-1-git-send-email-b.zolnierkie@samsung.com>
References: <1399287439-31376-1-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <1399287439-31376-2-git-send-email-b.zolnierkie@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kyungmin Park <kyungmin.park@samsung.com>

To support multi-platform, it needs to know it's running under secure
OS or not.  Sometimes it needs to access physical address by SMC calls.

e.g.,
        if (firmware_run()) {
                addr = physical address;
        } else {
                addr = virtual address;
        }

        call_firmware_ops(read_address, addr, &value);

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/common/firmware.c      | 5 +++++
 arch/arm/include/asm/firmware.h | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/arch/arm/common/firmware.c b/arch/arm/common/firmware.c
index 27ddccb..e9d9ee5 100644
--- a/arch/arm/common/firmware.c
+++ b/arch/arm/common/firmware.c
@@ -16,3 +16,8 @@
 static const struct firmware_ops default_firmware_ops;
 
 const struct firmware_ops *firmware_ops = &default_firmware_ops;
+
+int firmware_run(void)
+{
+	return firmware_ops != &default_firmware_ops;
+}
diff --git a/arch/arm/include/asm/firmware.h b/arch/arm/include/asm/firmware.h
index 2c9f10d..c72ec47 100644
--- a/arch/arm/include/asm/firmware.h
+++ b/arch/arm/include/asm/firmware.h
@@ -46,6 +46,9 @@ struct firmware_ops {
 /* Global pointer for current firmware_ops structure, can't be NULL. */
 extern const struct firmware_ops *firmware_ops;
 
+/* Check firmware is running */
+extern int firmware_run(void);
+
 /*
  * call_firmware_op(op, ...)
  *
-- 
1.8.2.3
