From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sun, 12 Nov 2017 19:34:12 +0100
Subject: [PATCH] nvmem: meson-mx-efuse: fix reading from an offset other than 0
Message-ID: <20171112183412.12806-1-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

meson_mx_efuse_read calculates the address internal to the eFuse based
on the offset and the word size. This works fine with any given offset.
However, the offset is also included when writing to the output buffer.
This means that reading 4 bytes at offset 500 tries to write beyond the
array allocated by the nvmem core as it wants to write the 4 bytes to
"buffer address + offset (500)".
This issue did not show up in the previous tests since no driver uses
any value from the eFuse yet and reading the eFuse via sysfs simply
reads the whole eFuse, starting at offset 0.

Fix this by only including the offset in the internal address
calculation.

Fixes: 8caef1fa9176 ("nvmem: add a driver for the Amlogic Meson6/Meson8/Meson8b SoCs")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/nvmem/meson-mx-efuse.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvmem/meson-mx-efuse.c b/drivers/nvmem/meson-mx-efuse.c
index a346b4923550..41d3a3c1104e 100644
--- a/drivers/nvmem/meson-mx-efuse.c
+++ b/drivers/nvmem/meson-mx-efuse.c
@@ -156,8 +156,8 @@ static int meson_mx_efuse_read(void *context, unsigned int offset,
 				 MESON_MX_EFUSE_CNTL1_AUTO_RD_ENABLE,
 				 MESON_MX_EFUSE_CNTL1_AUTO_RD_ENABLE);
 
-	for (i = offset; i < offset + bytes; i += efuse->config.word_size) {
-		addr = i / efuse->config.word_size;
+	for (i = 0; i < bytes; i += efuse->config.word_size) {
+		addr = (offset + i) / efuse->config.word_size;
 
 		err = meson_mx_efuse_read_addr(efuse, addr, &tmp);
 		if (err)
-- 
2.15.0
