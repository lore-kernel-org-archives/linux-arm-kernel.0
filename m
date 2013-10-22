From: kmpark@infradead.org (Kyungmin Park)
Date: Tue, 22 Oct 2013 10:45:56 +0900
Subject: [PATCH] arm: firmware: Check firmware is running or not
Message-ID: <20131022014556.GA1364@july>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kyungmin Park <kyungmin.park@samsung.com>

To support multi-platform, it needs to know it's running under secure OS or not.
sometime it needs to access physical address by smc calls.

e.g., 
	if (firmware_run()) {
		addr = physical address;
	} else {
		addr = virtual address;
	}

	call_firmware_ops(read_address, addr, &value);

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
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
index 1563130..efc4554 100644
--- a/arch/arm/include/asm/firmware.h
+++ b/arch/arm/include/asm/firmware.h
@@ -42,6 +42,9 @@ struct firmware_ops {
 /* Global pointer for current firmware_ops structure, can't be NULL. */
 extern const struct firmware_ops *firmware_ops;
 
+/* Check firmware is running */
+extern int firmware_run(void);
+
 /*
  * call_firmware_op(op, ...)
  *
