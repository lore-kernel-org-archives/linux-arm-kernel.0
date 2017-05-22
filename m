From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Mon, 22 May 2017 07:46:55 +0200
Subject: [PATCH] i2c: designware: Fix bogus sda_hold_time due to uninitialized
 vars
In-Reply-To: <CAKv+Gu9x_KCdEGBBOw9yaYOcYBcYtxJX-xTX=4kQuWqY=VK0PA@mail.gmail.com>
References: <20170519085640.15111-1-ard.biesheuvel@linaro.org>
 <CAKv+Gu9x_KCdEGBBOw9yaYOcYBcYtxJX-xTX=4kQuWqY=VK0PA@mail.gmail.com>
Message-ID: <743ebd23-17ab-03d2-ebd9-66acc9aee417@siemens.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need to initializes those variables to 0 for platforms that do not
provide ACPI parameters. Otherwise, we set sda_hold_time to random
values, breaking e.g. Galileo and IOT2000 boards.

Fixes: 9d6408433019 ("i2c: designware: don't infer timings described by ACPI from clock rate")
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Affects 4.12-rc2.

 drivers/i2c/busses/i2c-designware-platdrv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 6283b99d2b17..d1263b82d646 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -94,9 +94,9 @@ static void dw_i2c_acpi_params(struct platform_device *pdev, char method[],
 static int dw_i2c_acpi_configure(struct platform_device *pdev)
 {
 	struct dw_i2c_dev *dev = platform_get_drvdata(pdev);
+	u32 ss_ht = 0, fp_ht = 0, hs_ht = 0, fs_ht = 0;
 	acpi_handle handle = ACPI_HANDLE(&pdev->dev);
 	const struct acpi_device_id *id;
-	u32 ss_ht, fp_ht, hs_ht, fs_ht;
 	struct acpi_device *adev;
 	const char *uid;
 
