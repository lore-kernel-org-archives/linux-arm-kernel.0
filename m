From: ben@decadent.org.uk (Ben Hutchings)
Date: Sun, 14 Sep 2014 18:11:48 +0100
Subject: [PATCH 5/5] m25p80,spi-nor: Share the list of supported chip type
 names again
In-Reply-To: <1410714624.3040.38.camel@decadent.org.uk>
References: <1410714624.3040.38.camel@decadent.org.uk>
Message-ID: <1410714708.3040.43.camel@decadent.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the list of chip type names to spi-nor.h.  To avoid putting all
the chip type information there, we define this list as a macro
SPI_NOR_ENUM_TYPES() that invokes another macro SPI_NOR_ENUM_TYPE()
that must be defined to expand each name to whatever form it's needed.

In spi-nor.c, use it to define enumerators, then use the enumerators
as indices when defining spi_nor_info so that we cannot accidentally
use a name that's not on the list.

This is somewhat complicated by the fact that some names include
hyphens.  SPI_NOR_ENUM_TYPE() therefore takes separate string and C
identifier parameters.

Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/mtd/devices/m25p80.c  |  47 +------
 drivers/mtd/spi-nor/spi-nor.c | 287 ++++++++++++++++++++++--------------------
 include/linux/mtd/spi-nor.h   |  72 +++++++++++
 3 files changed, 227 insertions(+), 179 deletions(-)

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index 271d83f..368eb9a 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -245,51 +245,10 @@ static int m25p_remove(struct spi_device *spi)
 }
 

-/*
- * XXX This needs to be kept in sync with spi_nor_info.  We can't share
- * it with spi-nor, because if this is built as a module then modpost
- * won't be able to read it and add appropriate aliases.
- */
 static const struct spi_device_id m25p_ids[] = {
-	{"at25fs010"},	{"at25fs040"},	{"at25df041a"},	{"at25df321a"},
-	{"at25df641"},	{"at26f004"},	{"at26df081a"},	{"at26df161a"},
-	{"at26df321"},	{"at45db081d"},
-	{"en25f32"},	{"en25p32"},	{"en25q32b"},	{"en25p64"},
-	{"en25q64"},	{"en25qh128"},	{"en25qh256"},
-	{"f25l32pa"},
-	{"mr25h256"},	{"mr25h10"},
-	{"gd25q32"},	{"gd25q64"},
-	{"160s33b"},	{"320s33b"},	{"640s33b"},
-	{"mx25l2005a"},	{"mx25l4005a"},	{"mx25l8005"},	{"mx25l1606e"},
-	{"mx25l3205d"},	{"mx25l3255e"},	{"mx25l6405d"},	{"mx25l12805d"},
-	{"mx25l12855e"},{"mx25l25635e"},{"mx25l25655e"},{"mx66l51235l"},
-	{"mx66l1g55g"},
-	{"n25q064"},	{"n25q128a11"},	{"n25q128a13"},	{"n25q256a"},
-	{"n25q512a"},	{"n25q512ax3"},	{"n25q00"},
-	{"pm25lv512"},	{"pm25lv010"},	{"pm25lq032"},
-	{"s25sl032p"},	{"s25sl064p"},	{"s25fl256s0"},	{"s25fl256s1"},
-	{"s25fl512s"},	{"s70fl01gs"},	{"s25sl12800"},	{"s25sl12801"},
-	{"s25fl129p0"},	{"s25fl129p1"},	{"s25sl004a"},	{"s25sl008a"},
-	{"s25sl016a"},	{"s25sl032a"},	{"s25sl064a"},	{"s25fl008k"},
-	{"s25fl016k"},	{"s25fl064k"},
-	{"sst25vf040b"},{"sst25vf080b"},{"sst25vf016b"},{"sst25vf032b"},
-	{"sst25vf064c"},{"sst25wf512"},	{"sst25wf010"},	{"sst25wf020"},
-	{"sst25wf040"},
-	{"m25p05"},	{"m25p10"},	{"m25p20"},	{"m25p40"},
-	{"m25p80"},	{"m25p16"},	{"m25p32"},	{"m25p64"},
-	{"m25p128"},	{"n25q032"},
-	{"m25p05-nonjedec"},	{"m25p10-nonjedec"},	{"m25p20-nonjedec"},
-	{"m25p40-nonjedec"},	{"m25p80-nonjedec"},	{"m25p16-nonjedec"},
-	{"m25p32-nonjedec"},	{"m25p64-nonjedec"},	{"m25p128-nonjedec"},
-	{"m45pe10"},	{"m45pe80"},	{"m45pe16"},
-	{"m25pe20"},	{"m25pe80"},	{"m25pe16"},
-	{"m25px16"},	{"m25px32"},	{"m25px32-s0"},	{"m25px32-s1"},
-	{"m25px64"},
-	{"w25x10"},	{"w25x20"},	{"w25x40"},	{"w25x80"},
-	{"w25x16"},	{"w25x32"},	{"w25q32"},	{"w25q32dw"},
-	{"w25x64"},	{"w25q64"},	{"w25q128"},	{"w25q80"},
-	{"w25q80bl"},	{"w25q128"},	{"w25q256"},	{"cat25c11"},
-	{"cat25c03"},	{"cat25c09"},	{"cat25c17"},	{"cat25128"},
+#define SPI_NOR_ENUM_TYPE(s, c) { s },
+	SPI_NOR_ENUM_TYPES()
+#undef SPI_NOR_ENUM_TYPE
 	{ },
 };
 MODULE_DEVICE_TABLE(spi, m25p_ids);
diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 3b88c6b..68fedce 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -452,9 +452,16 @@ struct flash_info {
 #define	USE_FSR			0x80	/* use flag status register */
 };
 
+enum {
+#define SPI_NOR_ENUM_TYPE(s, c) CHIP_TYPE_ ## c,
+	SPI_NOR_ENUM_TYPES()
+#undef SPI_NOR_ENUM_TYPE
+	CHIP_TYPE_COUNT
+};
+
 #define INFO(_name, _jedec_id, _ext_id, _sector_size, _n_sectors, _flags) \
+	[CHIP_TYPE_ ## _name] =						\
 	{								\
-		.name = (_name),					\
 		.jedec_id = (_jedec_id),				\
 		.ext_id = (_ext_id),					\
 		.sector_size = (_sector_size),				\
@@ -465,8 +472,8 @@ struct flash_info {
 
 #define CAT25_INFO(_name, _sector_size, _n_sectors, _page_size,		\
 		   _addr_width, _flags)					\
+	[CHIP_TYPE_ ## _name] =						\
 	{								\
-		.name = (_name),					\
 		.sector_size = (_sector_size),				\
 		.n_sectors = (_n_sectors),				\
 		.page_size = (_page_size),				\
@@ -477,169 +484,179 @@ struct flash_info {
 /* NOTE: double check command sets and memory organization when you add
  * more nor chips.  This current list focusses on newer chips, which
  * have been converging on command sets which including JEDEC ID.
+ *
+ * All chip type names must be added to __SPI_NOR_ENUM_TYPES in
+ * spi-nor.h before they can be used here (enforced by using the
+ * names to index this array).
  */
 static const struct flash_info spi_nor_info[] = {
 	/* Atmel -- some are (confusingly) marketed as "DataFlash" */
-	INFO("at25fs010",  0x1f6601, 0, 32 * 1024,   4, SECT_4K),
-	INFO("at25fs040",  0x1f6604, 0, 64 * 1024,   8, SECT_4K),
+	INFO(at25fs010,  0x1f6601, 0, 32 * 1024,   4, SECT_4K),
+	INFO(at25fs040,  0x1f6604, 0, 64 * 1024,   8, SECT_4K),
 
-	INFO("at25df041a", 0x1f4401, 0, 64 * 1024,   8, SECT_4K),
-	INFO("at25df321a", 0x1f4701, 0, 64 * 1024,  64, SECT_4K),
-	INFO("at25df641",  0x1f4800, 0, 64 * 1024, 128, SECT_4K),
+	INFO(at25df041a, 0x1f4401, 0, 64 * 1024,   8, SECT_4K),
+	INFO(at25df321a, 0x1f4701, 0, 64 * 1024,  64, SECT_4K),
+	INFO(at25df641,  0x1f4800, 0, 64 * 1024, 128, SECT_4K),
 
-	INFO("at26f004",   0x1f0400, 0, 64 * 1024,  8, SECT_4K),
-	INFO("at26df081a", 0x1f4501, 0, 64 * 1024, 16, SECT_4K),
-	INFO("at26df161a", 0x1f4601, 0, 64 * 1024, 32, SECT_4K),
-	INFO("at26df321",  0x1f4700, 0, 64 * 1024, 64, SECT_4K),
+	INFO(at26f004,   0x1f0400, 0, 64 * 1024,  8, SECT_4K),
+	INFO(at26df081a, 0x1f4501, 0, 64 * 1024, 16, SECT_4K),
+	INFO(at26df161a, 0x1f4601, 0, 64 * 1024, 32, SECT_4K),
+	INFO(at26df321,  0x1f4700, 0, 64 * 1024, 64, SECT_4K),
 
-	INFO("at45db081d", 0x1f2500, 0, 64 * 1024, 16, SECT_4K),
+	INFO(at45db081d, 0x1f2500, 0, 64 * 1024, 16, SECT_4K),
 
 	/* EON -- en25xxx */
-	INFO("en25f32",    0x1c3116, 0, 64 * 1024,   64, SECT_4K),
-	INFO("en25p32",    0x1c2016, 0, 64 * 1024,   64, 0),
-	INFO("en25q32b",   0x1c3016, 0, 64 * 1024,   64, 0),
-	INFO("en25p64",    0x1c2017, 0, 64 * 1024,  128, 0),
-	INFO("en25q64",    0x1c3017, 0, 64 * 1024,  128, SECT_4K),
-	INFO("en25qh128",  0x1c7018, 0, 64 * 1024,  256, 0),
-	INFO("en25qh256",  0x1c7019, 0, 64 * 1024,  512, 0),
+	INFO(en25f32,    0x1c3116, 0, 64 * 1024,   64, SECT_4K),
+	INFO(en25p32,    0x1c2016, 0, 64 * 1024,   64, 0),
+	INFO(en25q32b,   0x1c3016, 0, 64 * 1024,   64, 0),
+	INFO(en25p64,    0x1c2017, 0, 64 * 1024,  128, 0),
+	INFO(en25q64,    0x1c3017, 0, 64 * 1024,  128, SECT_4K),
+	INFO(en25qh128,  0x1c7018, 0, 64 * 1024,  256, 0),
+	INFO(en25qh256,  0x1c7019, 0, 64 * 1024,  512, 0),
 
 	/* ESMT */
-	INFO("f25l32pa", 0x8c2016, 0, 64 * 1024, 64, SECT_4K),
+	INFO(f25l32pa, 0x8c2016, 0, 64 * 1024, 64, SECT_4K),
 
 	/* Everspin */
-	CAT25_INFO("mr25h256",  32 * 1024, 1, 256, 2, SPI_NOR_NO_ERASE | SPI_NOR_NO_FR),
-	CAT25_INFO("mr25h10",  128 * 1024, 1, 256, 3, SPI_NOR_NO_ERASE | SPI_NOR_NO_FR),
+	CAT25_INFO(mr25h256,  32 * 1024, 1, 256, 2, SPI_NOR_NO_ERASE | SPI_NOR_NO_FR),
+	CAT25_INFO(mr25h10,  128 * 1024, 1, 256, 3, SPI_NOR_NO_ERASE | SPI_NOR_NO_FR),
 
 	/* GigaDevice */
-	INFO("gd25q32", 0xc84016, 0, 64 * 1024,  64, SECT_4K),
-	INFO("gd25q64", 0xc84017, 0, 64 * 1024, 128, SECT_4K),
+	INFO(gd25q32, 0xc84016, 0, 64 * 1024,  64, SECT_4K),
+	INFO(gd25q64, 0xc84017, 0, 64 * 1024, 128, SECT_4K),
 
 	/* Intel/Numonyx -- xxxs33b */
-	INFO("160s33b",  0x898911, 0, 64 * 1024,  32, 0),
-	INFO("320s33b",  0x898912, 0, 64 * 1024,  64, 0),
-	INFO("640s33b",  0x898913, 0, 64 * 1024, 128, 0),
+	INFO(160s33b,  0x898911, 0, 64 * 1024,  32, 0),
+	INFO(320s33b,  0x898912, 0, 64 * 1024,  64, 0),
+	INFO(640s33b,  0x898913, 0, 64 * 1024, 128, 0),
 
 	/* Macronix */
-	INFO("mx25l2005a",  0xc22012, 0, 64 * 1024,   4, SECT_4K),
-	INFO("mx25l4005a",  0xc22013, 0, 64 * 1024,   8, SECT_4K),
-	INFO("mx25l8005",   0xc22014, 0, 64 * 1024,  16, 0),
-	INFO("mx25l1606e",  0xc22015, 0, 64 * 1024,  32, SECT_4K),
-	INFO("mx25l3205d",  0xc22016, 0, 64 * 1024,  64, 0),
-	INFO("mx25l3255e",  0xc29e16, 0, 64 * 1024,  64, SECT_4K),
-	INFO("mx25l6405d",  0xc22017, 0, 64 * 1024, 128, 0),
-	INFO("mx25l12805d", 0xc22018, 0, 64 * 1024, 256, 0),
-	INFO("mx25l12855e", 0xc22618, 0, 64 * 1024, 256, 0),
-	INFO("mx25l25635e", 0xc22019, 0, 64 * 1024, 512, 0),
-	INFO("mx25l25655e", 0xc22619, 0, 64 * 1024, 512, 0),
-	INFO("mx66l51235l", 0xc2201a, 0, 64 * 1024, 1024, SPI_NOR_QUAD_READ),
-	INFO("mx66l1g55g",  0xc2261b, 0, 64 * 1024, 2048, SPI_NOR_QUAD_READ),
+	INFO(mx25l2005a,  0xc22012, 0, 64 * 1024,   4, SECT_4K),
+	INFO(mx25l4005a,  0xc22013, 0, 64 * 1024,   8, SECT_4K),
+	INFO(mx25l8005,   0xc22014, 0, 64 * 1024,  16, 0),
+	INFO(mx25l1606e,  0xc22015, 0, 64 * 1024,  32, SECT_4K),
+	INFO(mx25l3205d,  0xc22016, 0, 64 * 1024,  64, 0),
+	INFO(mx25l3255e,  0xc29e16, 0, 64 * 1024,  64, SECT_4K),
+	INFO(mx25l6405d,  0xc22017, 0, 64 * 1024, 128, 0),
+	INFO(mx25l12805d, 0xc22018, 0, 64 * 1024, 256, 0),
+	INFO(mx25l12855e, 0xc22618, 0, 64 * 1024, 256, 0),
+	INFO(mx25l25635e, 0xc22019, 0, 64 * 1024, 512, 0),
+	INFO(mx25l25655e, 0xc22619, 0, 64 * 1024, 512, 0),
+	INFO(mx66l51235l, 0xc2201a, 0, 64 * 1024, 1024, SPI_NOR_QUAD_READ),
+	INFO(mx66l1g55g,  0xc2261b, 0, 64 * 1024, 2048, SPI_NOR_QUAD_READ),
 
 	/* Micron */
-	INFO("n25q064",     0x20ba17, 0, 64 * 1024,  128, 0),
-	INFO("n25q128a11",  0x20bb18, 0, 64 * 1024,  256, 0),
-	INFO("n25q128a13",  0x20ba18, 0, 64 * 1024,  256, 0),
-	INFO("n25q256a",    0x20ba19, 0, 64 * 1024,  512, SECT_4K),
-	INFO("n25q512a",    0x20bb20, 0, 64 * 1024, 1024, SECT_4K),
-	INFO("n25q512ax3",  0x20ba20, 0, 64 * 1024, 1024, USE_FSR),
-	INFO("n25q00",      0x20ba21, 0, 64 * 1024, 2048, USE_FSR),
+	INFO(n25q064,     0x20ba17, 0, 64 * 1024,  128, 0),
+	INFO(n25q128a11,  0x20bb18, 0, 64 * 1024,  256, 0),
+	INFO(n25q128a13,  0x20ba18, 0, 64 * 1024,  256, 0),
+	INFO(n25q256a,    0x20ba19, 0, 64 * 1024,  512, SECT_4K),
+	INFO(n25q512a,    0x20bb20, 0, 64 * 1024, 1024, SECT_4K),
+	INFO(n25q512ax3,  0x20ba20, 0, 64 * 1024, 1024, USE_FSR),
+	INFO(n25q00,      0x20ba21, 0, 64 * 1024, 2048, USE_FSR),
 
 	/* PMC */
-	INFO("pm25lv512",   0,        0, 32 * 1024,    2, SECT_4K_PMC),
-	INFO("pm25lv010",   0,        0, 32 * 1024,    4, SECT_4K_PMC),
-	INFO("pm25lq032",   0x7f9d46, 0, 64 * 1024,   64, SECT_4K),
+	INFO(pm25lv512,   0,        0, 32 * 1024,    2, SECT_4K_PMC),
+	INFO(pm25lv010,   0,        0, 32 * 1024,    4, SECT_4K_PMC),
+	INFO(pm25lq032,   0x7f9d46, 0, 64 * 1024,   64, SECT_4K),
 
 	/* Spansion -- single (large) sector size only, at least
 	 * for the chips listed here (without boot sectors).
 	 */
-	INFO("s25sl032p",  0x010215, 0x4d00,  64 * 1024,  64, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ),
-	INFO("s25sl064p",  0x010216, 0x4d00,  64 * 1024, 128, 0),
-	INFO("s25fl256s0", 0x010219, 0x4d00, 256 * 1024, 128, 0),
-	INFO("s25fl256s1", 0x010219, 0x4d01,  64 * 1024, 512, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ),
-	INFO("s25fl512s",  0x010220, 0x4d00, 256 * 1024, 256, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ),
-	INFO("s70fl01gs",  0x010221, 0x4d00, 256 * 1024, 256, 0),
-	INFO("s25sl12800", 0x012018, 0x0300, 256 * 1024,  64, 0),
-	INFO("s25sl12801", 0x012018, 0x0301,  64 * 1024, 256, 0),
-	INFO("s25fl129p0", 0x012018, 0x4d00, 256 * 1024,  64, 0),
-	INFO("s25fl129p1", 0x012018, 0x4d01,  64 * 1024, 256, 0),
-	INFO("s25sl004a",  0x010212,      0,  64 * 1024,   8, 0),
-	INFO("s25sl008a",  0x010213,      0,  64 * 1024,  16, 0),
-	INFO("s25sl016a",  0x010214,      0,  64 * 1024,  32, 0),
-	INFO("s25sl032a",  0x010215,      0,  64 * 1024,  64, 0),
-	INFO("s25sl064a",  0x010216,      0,  64 * 1024, 128, 0),
-	INFO("s25fl008k",  0xef4014,      0,  64 * 1024,  16, SECT_4K),
-	INFO("s25fl016k",  0xef4015,      0,  64 * 1024,  32, SECT_4K),
-	INFO("s25fl064k",  0xef4017,      0,  64 * 1024, 128, SECT_4K),
-
-	/* SST -- large erase sizes are "overlays", "sectors" are 4K */
-	INFO("sst25vf040b", 0xbf258d, 0, 64 * 1024,  8, SECT_4K | SST_WRITE),
-	INFO("sst25vf080b", 0xbf258e, 0, 64 * 1024, 16, SECT_4K | SST_WRITE),
-	INFO("sst25vf016b", 0xbf2541, 0, 64 * 1024, 32, SECT_4K | SST_WRITE),
-	INFO("sst25vf032b", 0xbf254a, 0, 64 * 1024, 64, SECT_4K | SST_WRITE),
-	INFO("sst25vf064c", 0xbf254b, 0, 64 * 1024, 128, SECT_4K),
-	INFO("sst25wf512",  0xbf2501, 0, 64 * 1024,  1, SECT_4K | SST_WRITE),
-	INFO("sst25wf010",  0xbf2502, 0, 64 * 1024,  2, SECT_4K | SST_WRITE),
-	INFO("sst25wf020",  0xbf2503, 0, 64 * 1024,  4, SECT_4K | SST_WRITE),
-	INFO("sst25wf040",  0xbf2504, 0, 64 * 1024,  8, SECT_4K | SST_WRITE),
+	INFO(s25sl032p,  0x010215, 0x4d00,  64 * 1024,  64, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ),
+	INFO(s25sl064p,  0x010216, 0x4d00,  64 * 1024, 128, 0),
+	INFO(s25fl256s0, 0x010219, 0x4d00, 256 * 1024, 128, 0),
+	INFO(s25fl256s1, 0x010219, 0x4d01,  64 * 1024, 512, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ),
+	INFO(s25fl512s,  0x010220, 0x4d00, 256 * 1024, 256, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ),
+	INFO(s70fl01gs,  0x010221, 0x4d00, 256 * 1024, 256, 0),
+	INFO(s25sl12800, 0x012018, 0x0300, 256 * 1024,  64, 0),
+	INFO(s25sl12801, 0x012018, 0x0301,  64 * 1024, 256, 0),
+	INFO(s25fl129p0, 0x012018, 0x4d00, 256 * 1024,  64, 0),
+	INFO(s25fl129p1, 0x012018, 0x4d01,  64 * 1024, 256, 0),
+	INFO(s25sl004a,  0x010212,      0,  64 * 1024,   8, 0),
+	INFO(s25sl008a,  0x010213,      0,  64 * 1024,  16, 0),
+	INFO(s25sl016a,  0x010214,      0,  64 * 1024,  32, 0),
+	INFO(s25sl032a,  0x010215,      0,  64 * 1024,  64, 0),
+	INFO(s25sl064a,  0x010216,      0,  64 * 1024, 128, 0),
+	INFO(s25fl008k,  0xef4014,      0,  64 * 1024,  16, SECT_4K),
+	INFO(s25fl016k,  0xef4015,      0,  64 * 1024,  32, SECT_4K),
+	INFO(s25fl064k,  0xef4017,      0,  64 * 1024, 128, SECT_4K),
+
+	/* SST -- large erase sizes are overlays, sectors are 4K */
+	INFO(sst25vf040b, 0xbf258d, 0, 64 * 1024,  8, SECT_4K | SST_WRITE),
+	INFO(sst25vf080b, 0xbf258e, 0, 64 * 1024, 16, SECT_4K | SST_WRITE),
+	INFO(sst25vf016b, 0xbf2541, 0, 64 * 1024, 32, SECT_4K | SST_WRITE),
+	INFO(sst25vf032b, 0xbf254a, 0, 64 * 1024, 64, SECT_4K | SST_WRITE),
+	INFO(sst25vf064c, 0xbf254b, 0, 64 * 1024, 128, SECT_4K),
+	INFO(sst25wf512,  0xbf2501, 0, 64 * 1024,  1, SECT_4K | SST_WRITE),
+	INFO(sst25wf010,  0xbf2502, 0, 64 * 1024,  2, SECT_4K | SST_WRITE),
+	INFO(sst25wf020,  0xbf2503, 0, 64 * 1024,  4, SECT_4K | SST_WRITE),
+	INFO(sst25wf040,  0xbf2504, 0, 64 * 1024,  8, SECT_4K | SST_WRITE),
 
 	/* ST Microelectronics -- newer production may have feature updates */
-	INFO("m25p05",  0x202010,  0,  32 * 1024,   2, 0),
-	INFO("m25p10",  0x202011,  0,  32 * 1024,   4, 0),
-	INFO("m25p20",  0x202012,  0,  64 * 1024,   4, 0),
-	INFO("m25p40",  0x202013,  0,  64 * 1024,   8, 0),
-	INFO("m25p80",  0x202014,  0,  64 * 1024,  16, 0),
-	INFO("m25p16",  0x202015,  0,  64 * 1024,  32, 0),
-	INFO("m25p32",  0x202016,  0,  64 * 1024,  64, 0),
-	INFO("m25p64",  0x202017,  0,  64 * 1024, 128, 0),
-	INFO("m25p128", 0x202018,  0, 256 * 1024,  64, 0),
-	INFO("n25q032", 0x20ba16,  0,  64 * 1024,  64, 0),
-
-	INFO("m25p05-nonjedec",  0, 0,  32 * 1024,   2, 0),
-	INFO("m25p10-nonjedec",  0, 0,  32 * 1024,   4, 0),
-	INFO("m25p20-nonjedec",  0, 0,  64 * 1024,   4, 0),
-	INFO("m25p40-nonjedec",  0, 0,  64 * 1024,   8, 0),
-	INFO("m25p80-nonjedec",  0, 0,  64 * 1024,  16, 0),
-	INFO("m25p16-nonjedec",  0, 0,  64 * 1024,  32, 0),
-	INFO("m25p32-nonjedec",  0, 0,  64 * 1024,  64, 0),
-	INFO("m25p64-nonjedec",  0, 0,  64 * 1024, 128, 0),
-	INFO("m25p128-nonjedec", 0, 0, 256 * 1024,  64, 0),
-
-	INFO("m45pe10", 0x204011,  0, 64 * 1024,    2, 0),
-	INFO("m45pe80", 0x204014,  0, 64 * 1024,   16, 0),
-	INFO("m45pe16", 0x204015,  0, 64 * 1024,   32, 0),
-
-	INFO("m25pe20", 0x208012,  0, 64 * 1024,  4,       0),
-	INFO("m25pe80", 0x208014,  0, 64 * 1024, 16,       0),
-	INFO("m25pe16", 0x208015,  0, 64 * 1024, 32, SECT_4K),
-
-	INFO("m25px16",    0x207115,  0, 64 * 1024, 32, SECT_4K),
-	INFO("m25px32",    0x207116,  0, 64 * 1024, 64, SECT_4K),
-	INFO("m25px32-s0", 0x207316,  0, 64 * 1024, 64, SECT_4K),
-	INFO("m25px32-s1", 0x206316,  0, 64 * 1024, 64, SECT_4K),
-	INFO("m25px64",    0x207117,  0, 64 * 1024, 128, 0),
-
-	/* Winbond -- w25x "blocks" are 64K, "sectors" are 4KiB */
-	INFO("w25x10", 0xef3011, 0, 64 * 1024,  2,  SECT_4K),
-	INFO("w25x20", 0xef3012, 0, 64 * 1024,  4,  SECT_4K),
-	INFO("w25x40", 0xef3013, 0, 64 * 1024,  8,  SECT_4K),
-	INFO("w25x80", 0xef3014, 0, 64 * 1024,  16, SECT_4K),
-	INFO("w25x16", 0xef3015, 0, 64 * 1024,  32, SECT_4K),
-	INFO("w25x32", 0xef3016, 0, 64 * 1024,  64, SECT_4K),
-	INFO("w25q32", 0xef4016, 0, 64 * 1024,  64, SECT_4K),
-	INFO("w25q32dw", 0xef6016, 0, 64 * 1024,  64, SECT_4K),
-	INFO("w25x64", 0xef3017, 0, 64 * 1024, 128, SECT_4K),
-	INFO("w25q64", 0xef4017, 0, 64 * 1024, 128, SECT_4K),
-	INFO("w25q80", 0xef5014, 0, 64 * 1024,  16, SECT_4K),
-	INFO("w25q80bl", 0xef4014, 0, 64 * 1024,  16, SECT_4K),
-	INFO("w25q128", 0xef4018, 0, 64 * 1024, 256, SECT_4K),
-	INFO("w25q256", 0xef4019, 0, 64 * 1024, 512, SECT_4K),
+	INFO(m25p05,  0x202010,  0,  32 * 1024,   2, 0),
+	INFO(m25p10,  0x202011,  0,  32 * 1024,   4, 0),
+	INFO(m25p20,  0x202012,  0,  64 * 1024,   4, 0),
+	INFO(m25p40,  0x202013,  0,  64 * 1024,   8, 0),
+	INFO(m25p80,  0x202014,  0,  64 * 1024,  16, 0),
+	INFO(m25p16,  0x202015,  0,  64 * 1024,  32, 0),
+	INFO(m25p32,  0x202016,  0,  64 * 1024,  64, 0),
+	INFO(m25p64,  0x202017,  0,  64 * 1024, 128, 0),
+	INFO(m25p128, 0x202018,  0, 256 * 1024,  64, 0),
+	INFO(n25q032, 0x20ba16,  0,  64 * 1024,  64, 0),
+
+	INFO(m25p05_nonjedec,  0, 0,  32 * 1024,   2, 0),
+	INFO(m25p10_nonjedec,  0, 0,  32 * 1024,   4, 0),
+	INFO(m25p20_nonjedec,  0, 0,  64 * 1024,   4, 0),
+	INFO(m25p40_nonjedec,  0, 0,  64 * 1024,   8, 0),
+	INFO(m25p80_nonjedec,  0, 0,  64 * 1024,  16, 0),
+	INFO(m25p16_nonjedec,  0, 0,  64 * 1024,  32, 0),
+	INFO(m25p32_nonjedec,  0, 0,  64 * 1024,  64, 0),
+	INFO(m25p64_nonjedec,  0, 0,  64 * 1024, 128, 0),
+	INFO(m25p128_nonjedec, 0, 0, 256 * 1024,  64, 0),
+
+	INFO(m45pe10, 0x204011,  0, 64 * 1024,    2, 0),
+	INFO(m45pe80, 0x204014,  0, 64 * 1024,   16, 0),
+	INFO(m45pe16, 0x204015,  0, 64 * 1024,   32, 0),
+
+	INFO(m25pe20, 0x208012,  0, 64 * 1024,  4,       0),
+	INFO(m25pe80, 0x208014,  0, 64 * 1024, 16,       0),
+	INFO(m25pe16, 0x208015,  0, 64 * 1024, 32, SECT_4K),
+
+	INFO(m25px16,    0x207115,  0, 64 * 1024, 32, SECT_4K),
+	INFO(m25px32,    0x207116,  0, 64 * 1024, 64, SECT_4K),
+	INFO(m25px32_s0, 0x207316,  0, 64 * 1024, 64, SECT_4K),
+	INFO(m25px32_s1, 0x206316,  0, 64 * 1024, 64, SECT_4K),
+	INFO(m25px64,    0x207117,  0, 64 * 1024, 128, 0),
+
+	/* Winbond -- w25x blocks are 64K, sectors are 4KiB */
+	INFO(w25x10, 0xef3011, 0, 64 * 1024,  2,  SECT_4K),
+	INFO(w25x20, 0xef3012, 0, 64 * 1024,  4,  SECT_4K),
+	INFO(w25x40, 0xef3013, 0, 64 * 1024,  8,  SECT_4K),
+	INFO(w25x80, 0xef3014, 0, 64 * 1024,  16, SECT_4K),
+	INFO(w25x16, 0xef3015, 0, 64 * 1024,  32, SECT_4K),
+	INFO(w25x32, 0xef3016, 0, 64 * 1024,  64, SECT_4K),
+	INFO(w25q32, 0xef4016, 0, 64 * 1024,  64, SECT_4K),
+	INFO(w25q32dw, 0xef6016, 0, 64 * 1024,  64, SECT_4K),
+	INFO(w25x64, 0xef3017, 0, 64 * 1024, 128, SECT_4K),
+	INFO(w25q64, 0xef4017, 0, 64 * 1024, 128, SECT_4K),
+	INFO(w25q80, 0xef5014, 0, 64 * 1024,  16, SECT_4K),
+	INFO(w25q80bl, 0xef4014, 0, 64 * 1024,  16, SECT_4K),
+	INFO(w25q128, 0xef4018, 0, 64 * 1024, 256, SECT_4K),
+	INFO(w25q256, 0xef4019, 0, 64 * 1024, 512, SECT_4K),
 
 	/* Catalyst / On Semiconductor -- non-JEDEC */
-	CAT25_INFO("cat25c11",   16, 8, 16, 1, SPI_NOR_NO_ERASE | SPI_NOR_NO_FR),
-	CAT25_INFO("cat25c03",   32, 8, 16, 2, SPI_NOR_NO_ERASE | SPI_NOR_NO_FR),
-	CAT25_INFO("cat25c09",  128, 8, 32, 2, SPI_NOR_NO_ERASE | SPI_NOR_NO_FR),
-	CAT25_INFO("cat25c17",  256, 8, 32, 2, SPI_NOR_NO_ERASE | SPI_NOR_NO_FR),
-	CAT25_INFO("cat25128", 2048, 8, 64, 2, SPI_NOR_NO_ERASE | SPI_NOR_NO_FR),
-	{ },
+	CAT25_INFO(cat25c11,   16, 8, 16, 1, SPI_NOR_NO_ERASE | SPI_NOR_NO_FR),
+	CAT25_INFO(cat25c03,   32, 8, 16, 2, SPI_NOR_NO_ERASE | SPI_NOR_NO_FR),
+	CAT25_INFO(cat25c09,  128, 8, 32, 2, SPI_NOR_NO_ERASE | SPI_NOR_NO_FR),
+	CAT25_INFO(cat25c17,  256, 8, 32, 2, SPI_NOR_NO_ERASE | SPI_NOR_NO_FR),
+	CAT25_INFO(cat25128, 2048, 8, 64, 2, SPI_NOR_NO_ERASE | SPI_NOR_NO_FR),
+
+	/* Fill in name fields */
+#define SPI_NOR_ENUM_TYPE(s, c) [CHIP_TYPE_ ## c].name = s,
+	SPI_NOR_ENUM_TYPES()
+#undef SPI_NOR_ENUM_TYPE
+
+	[CHIP_TYPE_COUNT] = { },
 };
 
 static const struct flash_info *spi_nor_info_by_name(const char *name)
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 6f92b4b..03b7959 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -198,4 +198,76 @@ struct spi_nor {
  */
 int spi_nor_scan(struct spi_nor *nor, const char *name, enum read_mode mode);
 
+#define __SPI_NOR_ENUM_TYPES(c_id, str_and_c_id)			  \
+	c_id(at25fs010)		c_id(at25fs040)		c_id(at25df041a)  \
+	c_id(at25df321a)	c_id(at25df641)		c_id(at26f004)    \
+	c_id(at26df081a)	c_id(at26df161a)	c_id(at26df321)   \
+	c_id(at45db081d)						  \
+	c_id(en25f32)		c_id(en25p32)		c_id(en25q32b)    \
+	c_id(en25p64)		c_id(en25q64)		c_id(en25qh128)   \
+	c_id(en25qh256)							  \
+	c_id(f25l32pa)						          \
+	c_id(mr25h256)		c_id(mr25h10)				  \
+	c_id(gd25q32)		c_id(gd25q64)				  \
+	c_id(160s33b)		c_id(320s33b)		c_id(640s33b)     \
+	c_id(mx25l2005a)	c_id(mx25l4005a)	c_id(mx25l8005)   \
+	c_id(mx25l1606e)	c_id(mx25l3205d)	c_id(mx25l3255e)  \
+	c_id(mx25l6405d)	c_id(mx25l12805d)	c_id(mx25l12855e) \
+	c_id(mx25l25635e)	c_id(mx25l25655e)	c_id(mx66l51235l) \
+	c_id(mx66l1g55g)						  \
+	c_id(n25q064)		c_id(n25q128a11)	c_id(n25q128a13)  \
+	c_id(n25q256a)		c_id(n25q512a)		c_id(n25q512ax3)  \
+	c_id(n25q00)							  \
+	c_id(pm25lv512)		c_id(pm25lv010)		c_id(pm25lq032)   \
+	c_id(s25sl032p)		c_id(s25sl064p)		c_id(s25fl256s0)  \
+	c_id(s25fl256s1)	c_id(s25fl512s)		c_id(s70fl01gs)   \
+	c_id(s25sl12800)	c_id(s25sl12801)	c_id(s25fl129p0)  \
+	c_id(s25fl129p1)	c_id(s25sl004a)		c_id(s25sl008a)   \
+	c_id(s25sl016a)		c_id(s25sl032a)		c_id(s25sl064a)   \
+	c_id(s25fl008k)		c_id(s25fl016k)		c_id(s25fl064k)   \
+	c_id(sst25vf040b)	c_id(sst25vf080b)	c_id(sst25vf016b) \
+	c_id(sst25vf032b)	c_id(sst25vf064c)	c_id(sst25wf512)  \
+	c_id(sst25wf010)	c_id(sst25wf020)	c_id(sst25wf040)  \
+	c_id(m25p05)		c_id(m25p10)		c_id(m25p20)	  \
+	c_id(m25p40)		c_id(m25p80)		c_id(m25p16)	  \
+	c_id(m25p32)		c_id(m25p64)		c_id(m25p128)	  \
+	c_id(n25q032)							  \
+	str_and_c_id("m25p05-nonjedec", m25p05_nonjedec)		  \
+	str_and_c_id("m25p10-nonjedec", m25p10_nonjedec)		  \
+	str_and_c_id("m25p20-nonjedec", m25p20_nonjedec)		  \
+	str_and_c_id("m25p40-nonjedec", m25p40_nonjedec)		  \
+	str_and_c_id("m25p80-nonjedec", m25p80_nonjedec)		  \
+	str_and_c_id("m25p16-nonjedec", m25p16_nonjedec)		  \
+	str_and_c_id("m25p32-nonjedec", m25p32_nonjedec)		  \
+	str_and_c_id("m25p64-nonjedec", m25p64_nonjedec)		  \
+	str_and_c_id("m25p128-nonjedec", m25p128_nonjedec)		  \
+	c_id(m45pe10)		c_id(m45pe80)		c_id(m45pe16)	  \
+	c_id(m25pe20)		c_id(m25pe80)		c_id(m25pe16)	  \
+	c_id(m25px16)		c_id(m25px32)				  \
+	str_and_c_id("m25px32-s0", m25px32_s0)				  \
+	str_and_c_id("m25px32-s1", m25px32_s1)				  \
+	c_id(m25px64)							  \
+	c_id(w25x10)		c_id(w25x20)		c_id(w25x40)	  \
+	c_id(w25x80)		c_id(w25x16)		c_id(w25x32)	  \
+	c_id(w25q32)		c_id(w25q32dw)		c_id(w25x64)	  \
+	c_id(w25q64)		c_id(w25q80)		c_id(w25q80bl)    \
+	c_id(w25q128)		c_id(w25q256)				  \
+	c_id(cat25c11)		c_id(cat25c03)		c_id(cat25c09)	  \
+	c_id(cat25c17)		c_id(cat25128)
+#define __SPI_NOR_ENUM_TYPE_C_ID(id)	SPI_NOR_ENUM_TYPE(#id, id)
+
+/**
+ * SPI_NOR_ENUM_TYPES - invoke SPI_NOR_ENUM_TYPE() for each SPI NOR chip type
+ *
+ * This will expand to SPI_NOR_ENUM_TYPE(string, c_id) for each chip
+ * type recognised by the spi-nor library.  The first argument is the
+ * string literal version of the chip type name.  The second argument
+ * is a version of the name suitable for including in a C identifier,
+ * though it may begin with a digit.
+ *
+ * The caller must define SPI_NOR_ENUM_TYPE before invoking this macro.
+ */
+#define SPI_NOR_ENUM_TYPES()						\
+	__SPI_NOR_ENUM_TYPES(__SPI_NOR_ENUM_TYPE_C_ID, SPI_NOR_ENUM_TYPE)
+
 #endif

-- 
Ben Hutchings
The world is coming to an end.	Please log off.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 811 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140914/b5b0969d/attachment.sig>
