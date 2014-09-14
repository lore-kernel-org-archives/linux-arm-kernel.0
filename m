From: ben@decadent.org.uk (Ben Hutchings)
Date: Sun, 14 Sep 2014 18:11:38 +0100
Subject: [PATCH 4/5] spi-nor: Replace struct spi_device_id with struct
 flash_info
In-Reply-To: <1410714624.3040.38.camel@decadent.org.uk>
References: <1410714624.3040.38.camel@decadent.org.uk>
Message-ID: <1410714698.3040.42.camel@decadent.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

spi-nor does not depend on the SPI layer, so its use of struct
spi_device_id adds an unnecessary indirection.  Add the chip type name
to struct flash_info and remove the wrapping struct spi_device_id.

Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/mtd/devices/m25p80.c  |   2 +-
 drivers/mtd/spi-nor/spi-nor.c | 344 +++++++++++++++++++++---------------------
 2 files changed, 172 insertions(+), 174 deletions(-)

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index b547c39..271d83f 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -246,7 +246,7 @@ static int m25p_remove(struct spi_device *spi)
 

 /*
- * XXX This needs to be kept in sync with spi_nor_ids.  We can't share
+ * XXX This needs to be kept in sync with spi_nor_info.  We can't share
  * it with spi-nor, because if this is built as a module then modpost
  * won't be able to read it and add appropriate aliases.
  */
diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 40d6f70..3b88c6b 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -28,8 +28,6 @@
 
 #define JEDEC_MFR(_jedec_id)	((_jedec_id) >> 16)
 
-static const struct spi_device_id *spi_nor_match_id(const char *name);
-
 /*
  * Read the status register, returning its value in the location
  * Return the status register value.
@@ -425,6 +423,8 @@ err:
 }
 
 struct flash_info {
+	const char	name[SPI_NAME_SIZE];
+
 	/* JEDEC id zero means "no ID" (most older chips); otherwise it has
 	 * a high byte of zero plus three data bytes: the manufacturer id,
 	 * then a two byte device id.
@@ -452,201 +452,215 @@ struct flash_info {
 #define	USE_FSR			0x80	/* use flag status register */
 };
 
-#define INFO(_jedec_id, _ext_id, _sector_size, _n_sectors, _flags)	\
-	((kernel_ulong_t)&(struct flash_info) {				\
+#define INFO(_name, _jedec_id, _ext_id, _sector_size, _n_sectors, _flags) \
+	{								\
+		.name = (_name),					\
 		.jedec_id = (_jedec_id),				\
 		.ext_id = (_ext_id),					\
 		.sector_size = (_sector_size),				\
 		.n_sectors = (_n_sectors),				\
 		.page_size = 256,					\
 		.flags = (_flags),					\
-	})
+	}
 
-#define CAT25_INFO(_sector_size, _n_sectors, _page_size, _addr_width, _flags)	\
-	((kernel_ulong_t)&(struct flash_info) {				\
+#define CAT25_INFO(_name, _sector_size, _n_sectors, _page_size,		\
+		   _addr_width, _flags)					\
+	{								\
+		.name = (_name),					\
 		.sector_size = (_sector_size),				\
 		.n_sectors = (_n_sectors),				\
 		.page_size = (_page_size),				\
 		.addr_width = (_addr_width),				\
 		.flags = (_flags),					\
-	})
+	}
 
 /* NOTE: double check command sets and memory organization when you add
  * more nor chips.  This current list focusses on newer chips, which
  * have been converging on command sets which including JEDEC ID.
  */
-static const struct spi_device_id spi_nor_ids[] = {
+static const struct flash_info spi_nor_info[] = {
 	/* Atmel -- some are (confusingly) marketed as "DataFlash" */
-	{ "at25fs010",  INFO(0x1f6601, 0, 32 * 1024,   4, SECT_4K) },
-	{ "at25fs040",  INFO(0x1f6604, 0, 64 * 1024,   8, SECT_4K) },
+	INFO("at25fs010",  0x1f6601, 0, 32 * 1024,   4, SECT_4K),
+	INFO("at25fs040",  0x1f6604, 0, 64 * 1024,   8, SECT_4K),
 
-	{ "at25df041a", INFO(0x1f4401, 0, 64 * 1024,   8, SECT_4K) },
-	{ "at25df321a", INFO(0x1f4701, 0, 64 * 1024,  64, SECT_4K) },
-	{ "at25df641",  INFO(0x1f4800, 0, 64 * 1024, 128, SECT_4K) },
+	INFO("at25df041a", 0x1f4401, 0, 64 * 1024,   8, SECT_4K),
+	INFO("at25df321a", 0x1f4701, 0, 64 * 1024,  64, SECT_4K),
+	INFO("at25df641",  0x1f4800, 0, 64 * 1024, 128, SECT_4K),
 
-	{ "at26f004",   INFO(0x1f0400, 0, 64 * 1024,  8, SECT_4K) },
-	{ "at26df081a", INFO(0x1f4501, 0, 64 * 1024, 16, SECT_4K) },
-	{ "at26df161a", INFO(0x1f4601, 0, 64 * 1024, 32, SECT_4K) },
-	{ "at26df321",  INFO(0x1f4700, 0, 64 * 1024, 64, SECT_4K) },
+	INFO("at26f004",   0x1f0400, 0, 64 * 1024,  8, SECT_4K),
+	INFO("at26df081a", 0x1f4501, 0, 64 * 1024, 16, SECT_4K),
+	INFO("at26df161a", 0x1f4601, 0, 64 * 1024, 32, SECT_4K),
+	INFO("at26df321",  0x1f4700, 0, 64 * 1024, 64, SECT_4K),
 
-	{ "at45db081d", INFO(0x1f2500, 0, 64 * 1024, 16, SECT_4K) },
+	INFO("at45db081d", 0x1f2500, 0, 64 * 1024, 16, SECT_4K),
 
 	/* EON -- en25xxx */
-	{ "en25f32",    INFO(0x1c3116, 0, 64 * 1024,   64, SECT_4K) },
-	{ "en25p32",    INFO(0x1c2016, 0, 64 * 1024,   64, 0) },
-	{ "en25q32b",   INFO(0x1c3016, 0, 64 * 1024,   64, 0) },
-	{ "en25p64",    INFO(0x1c2017, 0, 64 * 1024,  128, 0) },
-	{ "en25q64",    INFO(0x1c3017, 0, 64 * 1024,  128, SECT_4K) },
-	{ "en25qh128",  INFO(0x1c7018, 0, 64 * 1024,  256, 0) },
-	{ "en25qh256",  INFO(0x1c7019, 0, 64 * 1024,  512, 0) },
+	INFO("en25f32",    0x1c3116, 0, 64 * 1024,   64, SECT_4K),
+	INFO("en25p32",    0x1c2016, 0, 64 * 1024,   64, 0),
+	INFO("en25q32b",   0x1c3016, 0, 64 * 1024,   64, 0),
+	INFO("en25p64",    0x1c2017, 0, 64 * 1024,  128, 0),
+	INFO("en25q64",    0x1c3017, 0, 64 * 1024,  128, SECT_4K),
+	INFO("en25qh128",  0x1c7018, 0, 64 * 1024,  256, 0),
+	INFO("en25qh256",  0x1c7019, 0, 64 * 1024,  512, 0),
 
 	/* ESMT */
-	{ "f25l32pa", INFO(0x8c2016, 0, 64 * 1024, 64, SECT_4K) },
+	INFO("f25l32pa", 0x8c2016, 0, 64 * 1024, 64, SECT_4K),
 
 	/* Everspin */
-	{ "mr25h256", CAT25_INFO( 32 * 1024, 1, 256, 2, SPI_NOR_NO_ERASE | SPI_NOR_NO_FR) },
-	{ "mr25h10",  CAT25_INFO(128 * 1024, 1, 256, 3, SPI_NOR_NO_ERASE | SPI_NOR_NO_FR) },
+	CAT25_INFO("mr25h256",  32 * 1024, 1, 256, 2, SPI_NOR_NO_ERASE | SPI_NOR_NO_FR),
+	CAT25_INFO("mr25h10",  128 * 1024, 1, 256, 3, SPI_NOR_NO_ERASE | SPI_NOR_NO_FR),
 
 	/* GigaDevice */
-	{ "gd25q32", INFO(0xc84016, 0, 64 * 1024,  64, SECT_4K) },
-	{ "gd25q64", INFO(0xc84017, 0, 64 * 1024, 128, SECT_4K) },
+	INFO("gd25q32", 0xc84016, 0, 64 * 1024,  64, SECT_4K),
+	INFO("gd25q64", 0xc84017, 0, 64 * 1024, 128, SECT_4K),
 
 	/* Intel/Numonyx -- xxxs33b */
-	{ "160s33b",  INFO(0x898911, 0, 64 * 1024,  32, 0) },
-	{ "320s33b",  INFO(0x898912, 0, 64 * 1024,  64, 0) },
-	{ "640s33b",  INFO(0x898913, 0, 64 * 1024, 128, 0) },
+	INFO("160s33b",  0x898911, 0, 64 * 1024,  32, 0),
+	INFO("320s33b",  0x898912, 0, 64 * 1024,  64, 0),
+	INFO("640s33b",  0x898913, 0, 64 * 1024, 128, 0),
 
 	/* Macronix */
-	{ "mx25l2005a",  INFO(0xc22012, 0, 64 * 1024,   4, SECT_4K) },
-	{ "mx25l4005a",  INFO(0xc22013, 0, 64 * 1024,   8, SECT_4K) },
-	{ "mx25l8005",   INFO(0xc22014, 0, 64 * 1024,  16, 0) },
-	{ "mx25l1606e",  INFO(0xc22015, 0, 64 * 1024,  32, SECT_4K) },
-	{ "mx25l3205d",  INFO(0xc22016, 0, 64 * 1024,  64, 0) },
-	{ "mx25l3255e",  INFO(0xc29e16, 0, 64 * 1024,  64, SECT_4K) },
-	{ "mx25l6405d",  INFO(0xc22017, 0, 64 * 1024, 128, 0) },
-	{ "mx25l12805d", INFO(0xc22018, 0, 64 * 1024, 256, 0) },
-	{ "mx25l12855e", INFO(0xc22618, 0, 64 * 1024, 256, 0) },
-	{ "mx25l25635e", INFO(0xc22019, 0, 64 * 1024, 512, 0) },
-	{ "mx25l25655e", INFO(0xc22619, 0, 64 * 1024, 512, 0) },
-	{ "mx66l51235l", INFO(0xc2201a, 0, 64 * 1024, 1024, SPI_NOR_QUAD_READ) },
-	{ "mx66l1g55g",  INFO(0xc2261b, 0, 64 * 1024, 2048, SPI_NOR_QUAD_READ) },
+	INFO("mx25l2005a",  0xc22012, 0, 64 * 1024,   4, SECT_4K),
+	INFO("mx25l4005a",  0xc22013, 0, 64 * 1024,   8, SECT_4K),
+	INFO("mx25l8005",   0xc22014, 0, 64 * 1024,  16, 0),
+	INFO("mx25l1606e",  0xc22015, 0, 64 * 1024,  32, SECT_4K),
+	INFO("mx25l3205d",  0xc22016, 0, 64 * 1024,  64, 0),
+	INFO("mx25l3255e",  0xc29e16, 0, 64 * 1024,  64, SECT_4K),
+	INFO("mx25l6405d",  0xc22017, 0, 64 * 1024, 128, 0),
+	INFO("mx25l12805d", 0xc22018, 0, 64 * 1024, 256, 0),
+	INFO("mx25l12855e", 0xc22618, 0, 64 * 1024, 256, 0),
+	INFO("mx25l25635e", 0xc22019, 0, 64 * 1024, 512, 0),
+	INFO("mx25l25655e", 0xc22619, 0, 64 * 1024, 512, 0),
+	INFO("mx66l51235l", 0xc2201a, 0, 64 * 1024, 1024, SPI_NOR_QUAD_READ),
+	INFO("mx66l1g55g",  0xc2261b, 0, 64 * 1024, 2048, SPI_NOR_QUAD_READ),
 
 	/* Micron */
-	{ "n25q064",     INFO(0x20ba17, 0, 64 * 1024,  128, 0) },
-	{ "n25q128a11",  INFO(0x20bb18, 0, 64 * 1024,  256, 0) },
-	{ "n25q128a13",  INFO(0x20ba18, 0, 64 * 1024,  256, 0) },
-	{ "n25q256a",    INFO(0x20ba19, 0, 64 * 1024,  512, SECT_4K) },
-	{ "n25q512a",    INFO(0x20bb20, 0, 64 * 1024, 1024, SECT_4K) },
-	{ "n25q512ax3",  INFO(0x20ba20, 0, 64 * 1024, 1024, USE_FSR) },
-	{ "n25q00",      INFO(0x20ba21, 0, 64 * 1024, 2048, USE_FSR) },
+	INFO("n25q064",     0x20ba17, 0, 64 * 1024,  128, 0),
+	INFO("n25q128a11",  0x20bb18, 0, 64 * 1024,  256, 0),
+	INFO("n25q128a13",  0x20ba18, 0, 64 * 1024,  256, 0),
+	INFO("n25q256a",    0x20ba19, 0, 64 * 1024,  512, SECT_4K),
+	INFO("n25q512a",    0x20bb20, 0, 64 * 1024, 1024, SECT_4K),
+	INFO("n25q512ax3",  0x20ba20, 0, 64 * 1024, 1024, USE_FSR),
+	INFO("n25q00",      0x20ba21, 0, 64 * 1024, 2048, USE_FSR),
 
 	/* PMC */
-	{ "pm25lv512",   INFO(0,        0, 32 * 1024,    2, SECT_4K_PMC) },
-	{ "pm25lv010",   INFO(0,        0, 32 * 1024,    4, SECT_4K_PMC) },
-	{ "pm25lq032",   INFO(0x7f9d46, 0, 64 * 1024,   64, SECT_4K) },
+	INFO("pm25lv512",   0,        0, 32 * 1024,    2, SECT_4K_PMC),
+	INFO("pm25lv010",   0,        0, 32 * 1024,    4, SECT_4K_PMC),
+	INFO("pm25lq032",   0x7f9d46, 0, 64 * 1024,   64, SECT_4K),
 
 	/* Spansion -- single (large) sector size only, at least
 	 * for the chips listed here (without boot sectors).
 	 */
-	{ "s25sl032p",  INFO(0x010215, 0x4d00,  64 * 1024,  64, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
-	{ "s25sl064p",  INFO(0x010216, 0x4d00,  64 * 1024, 128, 0) },
-	{ "s25fl256s0", INFO(0x010219, 0x4d00, 256 * 1024, 128, 0) },
-	{ "s25fl256s1", INFO(0x010219, 0x4d01,  64 * 1024, 512, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
-	{ "s25fl512s",  INFO(0x010220, 0x4d00, 256 * 1024, 256, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
-	{ "s70fl01gs",  INFO(0x010221, 0x4d00, 256 * 1024, 256, 0) },
-	{ "s25sl12800", INFO(0x012018, 0x0300, 256 * 1024,  64, 0) },
-	{ "s25sl12801", INFO(0x012018, 0x0301,  64 * 1024, 256, 0) },
-	{ "s25fl129p0", INFO(0x012018, 0x4d00, 256 * 1024,  64, 0) },
-	{ "s25fl129p1", INFO(0x012018, 0x4d01,  64 * 1024, 256, 0) },
-	{ "s25sl004a",  INFO(0x010212,      0,  64 * 1024,   8, 0) },
-	{ "s25sl008a",  INFO(0x010213,      0,  64 * 1024,  16, 0) },
-	{ "s25sl016a",  INFO(0x010214,      0,  64 * 1024,  32, 0) },
-	{ "s25sl032a",  INFO(0x010215,      0,  64 * 1024,  64, 0) },
-	{ "s25sl064a",  INFO(0x010216,      0,  64 * 1024, 128, 0) },
-	{ "s25fl008k",  INFO(0xef4014,      0,  64 * 1024,  16, SECT_4K) },
-	{ "s25fl016k",  INFO(0xef4015,      0,  64 * 1024,  32, SECT_4K) },
-	{ "s25fl064k",  INFO(0xef4017,      0,  64 * 1024, 128, SECT_4K) },
+	INFO("s25sl032p",  0x010215, 0x4d00,  64 * 1024,  64, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ),
+	INFO("s25sl064p",  0x010216, 0x4d00,  64 * 1024, 128, 0),
+	INFO("s25fl256s0", 0x010219, 0x4d00, 256 * 1024, 128, 0),
+	INFO("s25fl256s1", 0x010219, 0x4d01,  64 * 1024, 512, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ),
+	INFO("s25fl512s",  0x010220, 0x4d00, 256 * 1024, 256, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ),
+	INFO("s70fl01gs",  0x010221, 0x4d00, 256 * 1024, 256, 0),
+	INFO("s25sl12800", 0x012018, 0x0300, 256 * 1024,  64, 0),
+	INFO("s25sl12801", 0x012018, 0x0301,  64 * 1024, 256, 0),
+	INFO("s25fl129p0", 0x012018, 0x4d00, 256 * 1024,  64, 0),
+	INFO("s25fl129p1", 0x012018, 0x4d01,  64 * 1024, 256, 0),
+	INFO("s25sl004a",  0x010212,      0,  64 * 1024,   8, 0),
+	INFO("s25sl008a",  0x010213,      0,  64 * 1024,  16, 0),
+	INFO("s25sl016a",  0x010214,      0,  64 * 1024,  32, 0),
+	INFO("s25sl032a",  0x010215,      0,  64 * 1024,  64, 0),
+	INFO("s25sl064a",  0x010216,      0,  64 * 1024, 128, 0),
+	INFO("s25fl008k",  0xef4014,      0,  64 * 1024,  16, SECT_4K),
+	INFO("s25fl016k",  0xef4015,      0,  64 * 1024,  32, SECT_4K),
+	INFO("s25fl064k",  0xef4017,      0,  64 * 1024, 128, SECT_4K),
 
 	/* SST -- large erase sizes are "overlays", "sectors" are 4K */
-	{ "sst25vf040b", INFO(0xbf258d, 0, 64 * 1024,  8, SECT_4K | SST_WRITE) },
-	{ "sst25vf080b", INFO(0xbf258e, 0, 64 * 1024, 16, SECT_4K | SST_WRITE) },
-	{ "sst25vf016b", INFO(0xbf2541, 0, 64 * 1024, 32, SECT_4K | SST_WRITE) },
-	{ "sst25vf032b", INFO(0xbf254a, 0, 64 * 1024, 64, SECT_4K | SST_WRITE) },
-	{ "sst25vf064c", INFO(0xbf254b, 0, 64 * 1024, 128, SECT_4K) },
-	{ "sst25wf512",  INFO(0xbf2501, 0, 64 * 1024,  1, SECT_4K | SST_WRITE) },
-	{ "sst25wf010",  INFO(0xbf2502, 0, 64 * 1024,  2, SECT_4K | SST_WRITE) },
-	{ "sst25wf020",  INFO(0xbf2503, 0, 64 * 1024,  4, SECT_4K | SST_WRITE) },
-	{ "sst25wf040",  INFO(0xbf2504, 0, 64 * 1024,  8, SECT_4K | SST_WRITE) },
+	INFO("sst25vf040b", 0xbf258d, 0, 64 * 1024,  8, SECT_4K | SST_WRITE),
+	INFO("sst25vf080b", 0xbf258e, 0, 64 * 1024, 16, SECT_4K | SST_WRITE),
+	INFO("sst25vf016b", 0xbf2541, 0, 64 * 1024, 32, SECT_4K | SST_WRITE),
+	INFO("sst25vf032b", 0xbf254a, 0, 64 * 1024, 64, SECT_4K | SST_WRITE),
+	INFO("sst25vf064c", 0xbf254b, 0, 64 * 1024, 128, SECT_4K),
+	INFO("sst25wf512",  0xbf2501, 0, 64 * 1024,  1, SECT_4K | SST_WRITE),
+	INFO("sst25wf010",  0xbf2502, 0, 64 * 1024,  2, SECT_4K | SST_WRITE),
+	INFO("sst25wf020",  0xbf2503, 0, 64 * 1024,  4, SECT_4K | SST_WRITE),
+	INFO("sst25wf040",  0xbf2504, 0, 64 * 1024,  8, SECT_4K | SST_WRITE),
 
 	/* ST Microelectronics -- newer production may have feature updates */
-	{ "m25p05",  INFO(0x202010,  0,  32 * 1024,   2, 0) },
-	{ "m25p10",  INFO(0x202011,  0,  32 * 1024,   4, 0) },
-	{ "m25p20",  INFO(0x202012,  0,  64 * 1024,   4, 0) },
-	{ "m25p40",  INFO(0x202013,  0,  64 * 1024,   8, 0) },
-	{ "m25p80",  INFO(0x202014,  0,  64 * 1024,  16, 0) },
-	{ "m25p16",  INFO(0x202015,  0,  64 * 1024,  32, 0) },
-	{ "m25p32",  INFO(0x202016,  0,  64 * 1024,  64, 0) },
-	{ "m25p64",  INFO(0x202017,  0,  64 * 1024, 128, 0) },
-	{ "m25p128", INFO(0x202018,  0, 256 * 1024,  64, 0) },
-	{ "n25q032", INFO(0x20ba16,  0,  64 * 1024,  64, 0) },
-
-	{ "m25p05-nonjedec",  INFO(0, 0,  32 * 1024,   2, 0) },
-	{ "m25p10-nonjedec",  INFO(0, 0,  32 * 1024,   4, 0) },
-	{ "m25p20-nonjedec",  INFO(0, 0,  64 * 1024,   4, 0) },
-	{ "m25p40-nonjedec",  INFO(0, 0,  64 * 1024,   8, 0) },
-	{ "m25p80-nonjedec",  INFO(0, 0,  64 * 1024,  16, 0) },
-	{ "m25p16-nonjedec",  INFO(0, 0,  64 * 1024,  32, 0) },
-	{ "m25p32-nonjedec",  INFO(0, 0,  64 * 1024,  64, 0) },
-	{ "m25p64-nonjedec",  INFO(0, 0,  64 * 1024, 128, 0) },
-	{ "m25p128-nonjedec", INFO(0, 0, 256 * 1024,  64, 0) },
-
-	{ "m45pe10", INFO(0x204011,  0, 64 * 1024,    2, 0) },
-	{ "m45pe80", INFO(0x204014,  0, 64 * 1024,   16, 0) },
-	{ "m45pe16", INFO(0x204015,  0, 64 * 1024,   32, 0) },
-
-	{ "m25pe20", INFO(0x208012,  0, 64 * 1024,  4,       0) },
-	{ "m25pe80", INFO(0x208014,  0, 64 * 1024, 16,       0) },
-	{ "m25pe16", INFO(0x208015,  0, 64 * 1024, 32, SECT_4K) },
-
-	{ "m25px16",    INFO(0x207115,  0, 64 * 1024, 32, SECT_4K) },
-	{ "m25px32",    INFO(0x207116,  0, 64 * 1024, 64, SECT_4K) },
-	{ "m25px32-s0", INFO(0x207316,  0, 64 * 1024, 64, SECT_4K) },
-	{ "m25px32-s1", INFO(0x206316,  0, 64 * 1024, 64, SECT_4K) },
-	{ "m25px64",    INFO(0x207117,  0, 64 * 1024, 128, 0) },
-	{ "m25px80",    INFO(0x207114,  0, 64 * 1024, 16, 0) },
+	INFO("m25p05",  0x202010,  0,  32 * 1024,   2, 0),
+	INFO("m25p10",  0x202011,  0,  32 * 1024,   4, 0),
+	INFO("m25p20",  0x202012,  0,  64 * 1024,   4, 0),
+	INFO("m25p40",  0x202013,  0,  64 * 1024,   8, 0),
+	INFO("m25p80",  0x202014,  0,  64 * 1024,  16, 0),
+	INFO("m25p16",  0x202015,  0,  64 * 1024,  32, 0),
+	INFO("m25p32",  0x202016,  0,  64 * 1024,  64, 0),
+	INFO("m25p64",  0x202017,  0,  64 * 1024, 128, 0),
+	INFO("m25p128", 0x202018,  0, 256 * 1024,  64, 0),
+	INFO("n25q032", 0x20ba16,  0,  64 * 1024,  64, 0),
+
+	INFO("m25p05-nonjedec",  0, 0,  32 * 1024,   2, 0),
+	INFO("m25p10-nonjedec",  0, 0,  32 * 1024,   4, 0),
+	INFO("m25p20-nonjedec",  0, 0,  64 * 1024,   4, 0),
+	INFO("m25p40-nonjedec",  0, 0,  64 * 1024,   8, 0),
+	INFO("m25p80-nonjedec",  0, 0,  64 * 1024,  16, 0),
+	INFO("m25p16-nonjedec",  0, 0,  64 * 1024,  32, 0),
+	INFO("m25p32-nonjedec",  0, 0,  64 * 1024,  64, 0),
+	INFO("m25p64-nonjedec",  0, 0,  64 * 1024, 128, 0),
+	INFO("m25p128-nonjedec", 0, 0, 256 * 1024,  64, 0),
+
+	INFO("m45pe10", 0x204011,  0, 64 * 1024,    2, 0),
+	INFO("m45pe80", 0x204014,  0, 64 * 1024,   16, 0),
+	INFO("m45pe16", 0x204015,  0, 64 * 1024,   32, 0),
+
+	INFO("m25pe20", 0x208012,  0, 64 * 1024,  4,       0),
+	INFO("m25pe80", 0x208014,  0, 64 * 1024, 16,       0),
+	INFO("m25pe16", 0x208015,  0, 64 * 1024, 32, SECT_4K),
+
+	INFO("m25px16",    0x207115,  0, 64 * 1024, 32, SECT_4K),
+	INFO("m25px32",    0x207116,  0, 64 * 1024, 64, SECT_4K),
+	INFO("m25px32-s0", 0x207316,  0, 64 * 1024, 64, SECT_4K),
+	INFO("m25px32-s1", 0x206316,  0, 64 * 1024, 64, SECT_4K),
+	INFO("m25px64",    0x207117,  0, 64 * 1024, 128, 0),
 
 	/* Winbond -- w25x "blocks" are 64K, "sectors" are 4KiB */
-	{ "w25x10", INFO(0xef3011, 0, 64 * 1024,  2,  SECT_4K) },
-	{ "w25x20", INFO(0xef3012, 0, 64 * 1024,  4,  SECT_4K) },
-	{ "w25x40", INFO(0xef3013, 0, 64 * 1024,  8,  SECT_4K) },
-	{ "w25x80", INFO(0xef3014, 0, 64 * 1024,  16, SECT_4K) },
-	{ "w25x16", INFO(0xef3015, 0, 64 * 1024,  32, SECT_4K) },
-	{ "w25x32", INFO(0xef3016, 0, 64 * 1024,  64, SECT_4K) },
-	{ "w25q32", INFO(0xef4016, 0, 64 * 1024,  64, SECT_4K) },
-	{ "w25q32dw", INFO(0xef6016, 0, 64 * 1024,  64, SECT_4K) },
-	{ "w25x64", INFO(0xef3017, 0, 64 * 1024, 128, SECT_4K) },
-	{ "w25q64", INFO(0xef4017, 0, 64 * 1024, 128, SECT_4K) },
-	{ "w25q80", INFO(0xef5014, 0, 64 * 1024,  16, SECT_4K) },
-	{ "w25q80bl", INFO(0xef4014, 0, 64 * 1024,  16, SECT_4K) },
-	{ "w25q128", INFO(0xef4018, 0, 64 * 1024, 256, SECT_4K) },
-	{ "w25q256", INFO(0xef4019, 0, 64 * 1024, 512, SECT_4K) },
+	INFO("w25x10", 0xef3011, 0, 64 * 1024,  2,  SECT_4K),
+	INFO("w25x20", 0xef3012, 0, 64 * 1024,  4,  SECT_4K),
+	INFO("w25x40", 0xef3013, 0, 64 * 1024,  8,  SECT_4K),
+	INFO("w25x80", 0xef3014, 0, 64 * 1024,  16, SECT_4K),
+	INFO("w25x16", 0xef3015, 0, 64 * 1024,  32, SECT_4K),
+	INFO("w25x32", 0xef3016, 0, 64 * 1024,  64, SECT_4K),
+	INFO("w25q32", 0xef4016, 0, 64 * 1024,  64, SECT_4K),
+	INFO("w25q32dw", 0xef6016, 0, 64 * 1024,  64, SECT_4K),
+	INFO("w25x64", 0xef3017, 0, 64 * 1024, 128, SECT_4K),
+	INFO("w25q64", 0xef4017, 0, 64 * 1024, 128, SECT_4K),
+	INFO("w25q80", 0xef5014, 0, 64 * 1024,  16, SECT_4K),
+	INFO("w25q80bl", 0xef4014, 0, 64 * 1024,  16, SECT_4K),
+	INFO("w25q128", 0xef4018, 0, 64 * 1024, 256, SECT_4K),
+	INFO("w25q256", 0xef4019, 0, 64 * 1024, 512, SECT_4K),
 
 	/* Catalyst / On Semiconductor -- non-JEDEC */
-	{ "cat25c11", CAT25_INFO(  16, 8, 16, 1, SPI_NOR_NO_ERASE | SPI_NOR_NO_FR) },
-	{ "cat25c03", CAT25_INFO(  32, 8, 16, 2, SPI_NOR_NO_ERASE | SPI_NOR_NO_FR) },
-	{ "cat25c09", CAT25_INFO( 128, 8, 32, 2, SPI_NOR_NO_ERASE | SPI_NOR_NO_FR) },
-	{ "cat25c17", CAT25_INFO( 256, 8, 32, 2, SPI_NOR_NO_ERASE | SPI_NOR_NO_FR) },
-	{ "cat25128", CAT25_INFO(2048, 8, 64, 2, SPI_NOR_NO_ERASE | SPI_NOR_NO_FR) },
+	CAT25_INFO("cat25c11",   16, 8, 16, 1, SPI_NOR_NO_ERASE | SPI_NOR_NO_FR),
+	CAT25_INFO("cat25c03",   32, 8, 16, 2, SPI_NOR_NO_ERASE | SPI_NOR_NO_FR),
+	CAT25_INFO("cat25c09",  128, 8, 32, 2, SPI_NOR_NO_ERASE | SPI_NOR_NO_FR),
+	CAT25_INFO("cat25c17",  256, 8, 32, 2, SPI_NOR_NO_ERASE | SPI_NOR_NO_FR),
+	CAT25_INFO("cat25128", 2048, 8, 64, 2, SPI_NOR_NO_ERASE | SPI_NOR_NO_FR),
 	{ },
 };
 
-static const struct spi_device_id *spi_nor_read_id(struct spi_nor *nor)
+static const struct flash_info *spi_nor_info_by_name(const char *name)
+{
+	const struct flash_info *info = spi_nor_info;
+
+	while (info->name[0]) {
+		if (!strcmp(name, info->name))
+			return info;
+		info++;
+	}
+	return NULL;
+}
+
+static const struct flash_info *spi_nor_info_probe(struct spi_nor *nor)
 {
 	int			tmp;
 	u8			id[5];
 	u32			jedec;
 	u16                     ext_jedec;
-	struct flash_info	*info;
+	const struct flash_info	*info;
 
 	tmp = nor->read_reg(nor, SPINOR_OP_RDID, id, 5);
 	if (tmp < 0) {
@@ -661,11 +675,11 @@ static const struct spi_device_id *spi_nor_read_id(struct spi_nor *nor)
 
 	ext_jedec = id[3] << 8 | id[4];
 
-	for (tmp = 0; tmp < ARRAY_SIZE(spi_nor_ids) - 1; tmp++) {
-		info = (void *)spi_nor_ids[tmp].driver_data;
+	for (tmp = 0; tmp < ARRAY_SIZE(spi_nor_info) - 1; tmp++) {
+		info = &spi_nor_info[tmp];
 		if (info->jedec_id == jedec) {
 			if (info->ext_id == 0 || info->ext_id == ext_jedec)
-				return &spi_nor_ids[tmp];
+				return info;
 		}
 	}
 	dev_err(nor->dev, "unrecognized JEDEC id %06x\n", jedec);
@@ -912,8 +926,7 @@ static int spi_nor_check(struct spi_nor *nor)
 
 int spi_nor_scan(struct spi_nor *nor, const char *name, enum read_mode mode)
 {
-	const struct spi_device_id	*id = NULL;
-	struct flash_info		*info;
+	const struct flash_info		*info = NULL;
 	struct flash_platform_data	*data;
 	struct device *dev = nor->dev;
 	struct mtd_info *mtd = nor->mtd;
@@ -932,26 +945,24 @@ int spi_nor_scan(struct spi_nor *nor, const char *name, enum read_mode mode)
 	 */
 	data = dev_get_platdata(dev);
 	if (data && data->type) {
-		id = spi_nor_match_id(data->type);
-		if (!id)
+		info = spi_nor_info_by_name(data->type);
+		if (!info)
 			dev_warn(dev, "unrecognized id %s\n", data->type);
 	}
 
-	if (!id && name)
-		id = spi_nor_match_id(name);
+	if (!info && name)
+		info = spi_nor_info_by_name(name);
 
-	if (!id)
+	if (!info)
 		return -ENODEV;
 
-	info = (void *)id->driver_data;
-
 	if (info->jedec_id) {
-		const struct spi_device_id *jid;
+		const struct flash_info *jinfo;
 
-		jid = spi_nor_read_id(nor);
-		if (IS_ERR(jid)) {
-			return PTR_ERR(jid);
-		} else if (jid != id) {
+		jinfo = spi_nor_info_probe(nor);
+		if (IS_ERR(jinfo)) {
+			return PTR_ERR(jinfo);
+		} else if (jinfo != info) {
 			/*
 			 * JEDEC knows better, so overwrite platform ID. We
 			 * can't trust partitions any longer, but we'll let
@@ -960,9 +971,8 @@ int spi_nor_scan(struct spi_nor *nor, const char *name, enum read_mode mode)
 			 * information, even if it's not 100% accurate.
 			 */
 			dev_warn(dev, "found %s, expected %s\n",
-				 jid->name, id->name);
-			id = jid;
-			info = (void *)jid->driver_data;
+				 jinfo->name, info->name);
+			info = jinfo;
 		}
 	}
 
@@ -1108,7 +1118,7 @@ int spi_nor_scan(struct spi_nor *nor, const char *name, enum read_mode mode)
 
 	nor->read_dummy = spi_nor_read_dummy_cycles(nor);
 
-	dev_info(dev, "%s (%lld Kbytes)\n", id->name,
+	dev_info(dev, "%s (%lld Kbytes)\n", info->name,
 			(long long)mtd->size >> 10);
 
 	dev_dbg(dev,
@@ -1131,18 +1141,6 @@ int spi_nor_scan(struct spi_nor *nor, const char *name, enum read_mode mode)
 }
 EXPORT_SYMBOL_GPL(spi_nor_scan);
 
-static const struct spi_device_id *spi_nor_match_id(const char *name)
-{
-	const struct spi_device_id *id = spi_nor_ids;
-
-	while (id->name[0]) {
-		if (!strcmp(name, id->name))
-			return id;
-		id++;
-	}
-	return NULL;
-}
-
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Huang Shijie <shijie8@gmail.com>");
 MODULE_AUTHOR("Mike Lavender");


-- 
Ben Hutchings
The world is coming to an end.	Please log off.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 811 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140914/2c9f4918/attachment-0001.sig>
