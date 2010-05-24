From: adrian.wenl@gmail.com (Lei Wen)
Date: Mon, 24 May 2010 16:27:21 +0800
Subject: [PATCH 01/20] mtd: pxa3xx_nand: refuse the flash definition get
	from platform
In-Reply-To: <4BFA2B5B.4080105@compulab.co.il>
References: <AANLkTinVBXhT77Zd-LNpufgJAl7WZdic0oxDFwvNkvJg@mail.gmail.com>
	<4BFA2B5B.4080105@compulab.co.il>
Message-ID: <AANLkTilLYFVPcel-rE8RbuTWEir4RJOBqmyxirb6Vozn@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

This patch set is applied to mtd-2.6 git. We submit the patch with a
package in attachment already.
http://permalink.gmane.org/gmane.linux.ports.arm.kernel/79818

Best regards,
Lei

On Mon, May 24, 2010 at 3:31 PM, Mike Rapoport <mike@compulab.co.il> wrote:
> Hi Haojian,
> This is a comment to the entire series, and should have been Re: [PATCH
> 0/20], but there's no cover letter for these patches.
>
> The patches are all line-wrapped and do not apply. It's really hard to read
> them because of hunks added inside the existing functions. Please try to
> organize your changes in a more straight ?forward way.
>
> Haojian Zhuang wrote:
>>
>> From 16057e690aa4a2fd8a9c07c70ab48ffc2f76204f Mon Sep 17 00:00:00 2001
>> From: Lei Wen <leiwen@marvell.com>
>> Date: Sat, 20 Mar 2010 19:01:23 +0800
>> Subject: [PATCH] mtd: pxa3xx_nand: refuse the flash definition get from
>> platform
>>
>> For current usage, it is little reason to use a platform defined flash
>> info
>> for the flash detection. Flash timing through platform should be the same.
>> And allow multiple platform to define the same flash chip would be a
>> waste.
>>
>> Also condense the flash definition way in the c file to simplify adding a
>> new chip.
>>
>> Signed-off-by: Lei Wen <leiwen@marvell.com>
>> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
>> ---
>> ?arch/arm/plat-pxa/include/plat/pxa3xx_nand.h | ? 40 ----
>> ?drivers/mtd/nand/Kconfig ? ? ? ? ? ? ? ? ? ? | ? ?7 -
>> ?drivers/mtd/nand/pxa3xx_nand.c ? ? ? ? ? ? ? | ?262
>> ++++++--------------------
>> ?3 files changed, 60 insertions(+), 249 deletions(-)
>>
>> diff --git a/arch/arm/plat-pxa/include/plat/pxa3xx_nand.h
>> b/arch/arm/plat-pxa/include/plat/pxa3xx_nand.h
>> index 3478eae..c494f68 100644
>> --- a/arch/arm/plat-pxa/include/plat/pxa3xx_nand.h
>> +++ b/arch/arm/plat-pxa/include/plat/pxa3xx_nand.h
>> @@ -4,43 +4,6 @@
>> ?#include <linux/mtd/mtd.h>
>> ?#include <linux/mtd/partitions.h>
>>
>> -struct pxa3xx_nand_timing {
>> - ? ? ? unsigned int ? ?tCH; ?/* Enable signal hold time */
>> - ? ? ? unsigned int ? ?tCS; ?/* Enable signal setup time */
>> - ? ? ? unsigned int ? ?tWH; ?/* ND_nWE high duration */
>> - ? ? ? unsigned int ? ?tWP; ?/* ND_nWE pulse time */
>> - ? ? ? unsigned int ? ?tRH; ?/* ND_nRE high duration */
>> - ? ? ? unsigned int ? ?tRP; ?/* ND_nRE pulse width */
>> - ? ? ? unsigned int ? ?tR; ? /* ND_nWE high to ND_nRE low for read */
>> - ? ? ? unsigned int ? ?tWHR; /* ND_nWE high to ND_nRE low for status read
>> */
>> - ? ? ? unsigned int ? ?tAR; ?/* ND_ALE low to ND_nRE low delay */
>> -};
>> -
>> -struct pxa3xx_nand_cmdset {
>> - ? ? ? uint16_t ? ? ? ?read1;
>> - ? ? ? uint16_t ? ? ? ?read2;
>> - ? ? ? uint16_t ? ? ? ?program;
>> - ? ? ? uint16_t ? ? ? ?read_status;
>> - ? ? ? uint16_t ? ? ? ?read_id;
>> - ? ? ? uint16_t ? ? ? ?erase;
>> - ? ? ? uint16_t ? ? ? ?reset;
>> - ? ? ? uint16_t ? ? ? ?lock;
>> - ? ? ? uint16_t ? ? ? ?unlock;
>> - ? ? ? uint16_t ? ? ? ?lock_status;
>> -};
>> -
>> -struct pxa3xx_nand_flash {
>> - ? ? ? const struct pxa3xx_nand_timing *timing; /* NAND Flash timing */
>> - ? ? ? const struct pxa3xx_nand_cmdset *cmdset;
>> -
>> - ? ? ? uint32_t page_per_block;/* Pages per block (PG_PER_BLK) */
>> - ? ? ? uint32_t page_size; ? ? /* Page size in bytes (PAGE_SZ) */
>> - ? ? ? uint32_t flash_width; ? /* Width of Flash memory (DWIDTH_M) */
>> - ? ? ? uint32_t dfc_width; ? ? /* Width of flash controller(DWIDTH_C) */
>> - ? ? ? uint32_t num_blocks; ? ?/* Number of physical blocks in Flash */
>> - ? ? ? uint32_t chip_id;
>> -};
>> -
>> ?struct pxa3xx_nand_platform_data {
>>
>> ? ? ? ?/* the data flash bus is shared between the Static Memory
>> @@ -54,9 +17,6 @@ struct pxa3xx_nand_platform_data {
>>
>> ? ? ? ?const struct mtd_partition ? ? ? ? ? ? ?*parts;
>> ? ? ? ?unsigned int ? ? ? ? ? ? ? ? ? ? ? ? ? ?nr_parts;
>> -
>> - ? ? ? const struct pxa3xx_nand_flash * ? ? ? ?flash;
>> - ? ? ? size_t ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?num_flash;
>> ?};
>>
>> ?extern void pxa3xx_set_nand_info(struct pxa3xx_nand_platform_data *info);
>> diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
>> index 98a04b3..9a35d92 100644
>> --- a/drivers/mtd/nand/Kconfig
>> +++ b/drivers/mtd/nand/Kconfig
>> @@ -399,13 +399,6 @@ config MTD_NAND_PXA3xx
>> ? ? ? ? ?This enables the driver for the NAND flash device found on
>> ? ? ? ? ?PXA3xx processors
>>
>> -config MTD_NAND_PXA3xx_BUILTIN
>> - ? ? ? bool "Use builtin definitions for some NAND chips (deprecated)"
>> - ? ? ? depends on MTD_NAND_PXA3xx
>> - ? ? ? help
>> - ? ? ? ? This enables builtin definitions for some NAND chips. This
>> - ? ? ? ? is deprecated in favor of platform specific data.
>> -
>> ?config MTD_NAND_CM_X270
>> ? ? ? ?tristate "Support for NAND Flash on CM-X270 modules"
>> ? ? ? ?depends on MTD_NAND && MACH_ARMCORE
>> diff --git a/drivers/mtd/nand/pxa3xx_nand.c
>> b/drivers/mtd/nand/pxa3xx_nand.c
>> index e02fa4f..da40b9a 100644
>> --- a/drivers/mtd/nand/pxa3xx_nand.c
>> +++ b/drivers/mtd/nand/pxa3xx_nand.c
>> @@ -113,6 +113,41 @@ enum {
>> ? ? ? ?STATE_PIO_WRITING,
>> ?};
>>
>> +struct pxa3xx_nand_timing {
>> + ? ? ? uint32_t ? ? ? ?tCH; ?/* Enable signal hold time */
>> + ? ? ? uint32_t ? ? ? ?tCS; ?/* Enable signal setup time */
>> + ? ? ? uint32_t ? ? ? ?tWH; ?/* ND_nWE high duration */
>> + ? ? ? uint32_t ? ? ? ?tWP; ?/* ND_nWE pulse time */
>> + ? ? ? uint32_t ? ? ? ?tRH; ?/* ND_nRE high duration */
>> + ? ? ? uint32_t ? ? ? ?tRP; ?/* ND_nRE pulse width */
>> + ? ? ? uint32_t ? ? ? ?tAR; ?/* ND_ALE low to ND_nRE low delay */
>> + ? ? ? uint32_t ? ? ? ?tWHR; /* ND_nWE high to ND_nRE low for status read
>> */
>> + ? ? ? uint32_t ? ? ? ?tR; ? /* ND_nWE high to ND_nRE low for read */
>> +};
>> +
>> +struct pxa3xx_nand_cmdset {
>> + ? ? ? uint16_t ? ? ? ?read1;
>> + ? ? ? uint16_t ? ? ? ?read2;
>> + ? ? ? uint16_t ? ? ? ?program;
>> + ? ? ? uint16_t ? ? ? ?read_status;
>> + ? ? ? uint16_t ? ? ? ?read_id;
>> + ? ? ? uint16_t ? ? ? ?erase;
>> + ? ? ? uint16_t ? ? ? ?reset;
>> + ? ? ? uint16_t ? ? ? ?lock;
>> + ? ? ? uint16_t ? ? ? ?unlock;
>> + ? ? ? uint16_t ? ? ? ?lock_status;
>> +};
>> +
>> +struct pxa3xx_nand_flash {
>> + ? ? ? uint32_t ? ? ? ?chip_id;
>> + ? ? ? uint16_t ? ? ? ?page_per_block; /* Pages per block (PG_PER_BLK) */
>> + ? ? ? uint16_t ? ? ? ?page_size; ? ? ?/* Page size in bytes (PAGE_SZ) */
>> + ? ? ? uint8_t ? ? ? ? flash_width; ? ?/* Width of Flash memory
>> (DWIDTH_M) */
>> + ? ? ? uint8_t ? ? ? ? dfc_width; ? ? ?/* Width of flash
>> controller(DWIDTH_C) */
>> + ? ? ? uint32_t ? ? ? ?num_blocks; ? ? /* Number of physical blocks in
>> Flash */
>> + ? ? ? struct pxa3xx_nand_timing timing; ? ? ? /* NAND Flash timing */
>> +};
>> +
>> ?struct pxa3xx_nand_info {
>> ? ? ? ?struct nand_chip ? ? ? ?nand_chip;
>>
>> @@ -177,20 +212,7 @@ MODULE_PARM_DESC(use_dma, "enable DMA for data
>> transfering to/from NAND HW");
>> ?static struct pxa3xx_nand_timing default_timing;
>> ?static struct pxa3xx_nand_flash default_flash;
>>
>> -static struct pxa3xx_nand_cmdset smallpage_cmdset = {
>> - ? ? ? .read1 ? ? ? ? ?= 0x0000,
>> - ? ? ? .read2 ? ? ? ? ?= 0x0050,
>> - ? ? ? .program ? ? ? ?= 0x1080,
>> - ? ? ? .read_status ? ?= 0x0070,
>> - ? ? ? .read_id ? ? ? ?= 0x0090,
>> - ? ? ? .erase ? ? ? ? ?= 0xD060,
>> - ? ? ? .reset ? ? ? ? ?= 0x00FF,
>> - ? ? ? .lock ? ? ? ? ? = 0x002A,
>> - ? ? ? .unlock ? ? ? ? = 0x2423,
>> - ? ? ? .lock_status ? ?= 0x007A,
>> -};
>> -
>> -static struct pxa3xx_nand_cmdset largepage_cmdset = {
>> +const static struct pxa3xx_nand_cmdset cmdset = {
>> ? ? ? ?.read1 ? ? ? ? ?= 0x3000,
>> ? ? ? ?.read2 ? ? ? ? ?= 0x0050,
>> ? ? ? ?.program ? ? ? ?= 0x1080,
>> @@ -203,143 +225,17 @@ static struct pxa3xx_nand_cmdset largepage_cmdset =
>> {
>> ? ? ? ?.lock_status ? ?= 0x007A,
>> ?};
>>
>> -#ifdef CONFIG_MTD_NAND_PXA3xx_BUILTIN
>> -static struct pxa3xx_nand_timing samsung512MbX16_timing = {
>> - ? ? ? .tCH ? ?= 10,
>> - ? ? ? .tCS ? ?= 0,
>> - ? ? ? .tWH ? ?= 20,
>> - ? ? ? .tWP ? ?= 40,
>> - ? ? ? .tRH ? ?= 30,
>> - ? ? ? .tRP ? ?= 40,
>> - ? ? ? .tR ? ? = 11123,
>> - ? ? ? .tWHR ? = 110,
>> - ? ? ? .tAR ? ?= 10,
>> -};
>> -
>> -static struct pxa3xx_nand_flash samsung512MbX16 = {
>> - ? ? ? .timing ? ? ? ? = &samsung512MbX16_timing,
>> - ? ? ? .cmdset ? ? ? ? = &smallpage_cmdset,
>> - ? ? ? .page_per_block = 32,
>> - ? ? ? .page_size ? ? ?= 512,
>> - ? ? ? .flash_width ? ?= 16,
>> - ? ? ? .dfc_width ? ? ?= 16,
>> - ? ? ? .num_blocks ? ? = 4096,
>> - ? ? ? .chip_id ? ? ? ?= 0x46ec,
>> -};
>> -
>> -static struct pxa3xx_nand_flash samsung2GbX8 = {
>> - ? ? ? .timing ? ? ? ? = &samsung512MbX16_timing,
>> - ? ? ? .cmdset ? ? ? ? = &smallpage_cmdset,
>> - ? ? ? .page_per_block = 64,
>> - ? ? ? .page_size ? ? ?= 2048,
>> - ? ? ? .flash_width ? ?= 8,
>> - ? ? ? .dfc_width ? ? ?= 8,
>> - ? ? ? .num_blocks ? ? = 2048,
>> - ? ? ? .chip_id ? ? ? ?= 0xdaec,
>> -};
>> -
>> -static struct pxa3xx_nand_flash samsung32GbX8 = {
>> - ? ? ? .timing ? ? ? ? = &samsung512MbX16_timing,
>> - ? ? ? .cmdset ? ? ? ? = &smallpage_cmdset,
>> - ? ? ? .page_per_block = 128,
>> - ? ? ? .page_size ? ? ?= 4096,
>> - ? ? ? .flash_width ? ?= 8,
>> - ? ? ? .dfc_width ? ? ?= 8,
>> - ? ? ? .num_blocks ? ? = 8192,
>> - ? ? ? .chip_id ? ? ? ?= 0xd7ec,
>> +static struct pxa3xx_nand_flash __devinitdata builtin_flash_types[] = {
>> +{ 0x46ec, 32, 512, 16, 16, 4096, { 10, 0, 20, 40, 30, 40, 11123, 110, 10,
>> }, },
>> +{ 0xdaec, 64, 2048, 8, 8, 2048, { 10, 0, 20, 40, 30, 40, 11123, 110, 10,
>> }, },
>> +{ 0xd7ec, 128, 4096, 8, 8, 8192, { 10, 0, 20, 40, 30, 40, 11123, 110, 10,
>> }, },
>> +{ 0xa12c, 64, 2048, 8, 8, 1024, { 10, 25, 15, 25, 15, 30, 25000, 60, 10,
>> }, },
>> +{ 0xb12c, 64, 2048, 16, 16, 1024, { 10, 25, 15, 25, 15, 30, 25000,
>> 60, 10, }, },
>> +{ 0xdc2c, 64, 2048, 8, 8, 4096, { 10, 25, 15, 25, 15, 30, 25000, 60, 10,
>> }, },
>> +{ 0xcc2c, 64, 2048, 16, 16, 4096, { 10, 25, 15, 25, 15, 30, 25000,
>> 60, 10, }, },
>> +{ 0xba20, 64, 2048, 16, 16, 2048, { 10, 35, 15, 25, 15, 25, 25000,
>> 60, 10, }, },
>> ?};
>>
>> -static struct pxa3xx_nand_timing micron_timing = {
>> - ? ? ? .tCH ? ?= 10,
>> - ? ? ? .tCS ? ?= 25,
>> - ? ? ? .tWH ? ?= 15,
>> - ? ? ? .tWP ? ?= 25,
>> - ? ? ? .tRH ? ?= 15,
>> - ? ? ? .tRP ? ?= 30,
>> - ? ? ? .tR ? ? = 25000,
>> - ? ? ? .tWHR ? = 60,
>> - ? ? ? .tAR ? ?= 10,
>> -};
>> -
>> -static struct pxa3xx_nand_flash micron1GbX8 = {
>> - ? ? ? .timing ? ? ? ? = &micron_timing,
>> - ? ? ? .cmdset ? ? ? ? = &largepage_cmdset,
>> - ? ? ? .page_per_block = 64,
>> - ? ? ? .page_size ? ? ?= 2048,
>> - ? ? ? .flash_width ? ?= 8,
>> - ? ? ? .dfc_width ? ? ?= 8,
>> - ? ? ? .num_blocks ? ? = 1024,
>> - ? ? ? .chip_id ? ? ? ?= 0xa12c,
>> -};
>> -
>> -static struct pxa3xx_nand_flash micron1GbX16 = {
>> - ? ? ? .timing ? ? ? ? = &micron_timing,
>> - ? ? ? .cmdset ? ? ? ? = &largepage_cmdset,
>> - ? ? ? .page_per_block = 64,
>> - ? ? ? .page_size ? ? ?= 2048,
>> - ? ? ? .flash_width ? ?= 16,
>> - ? ? ? .dfc_width ? ? ?= 16,
>> - ? ? ? .num_blocks ? ? = 1024,
>> - ? ? ? .chip_id ? ? ? ?= 0xb12c,
>> -};
>> -
>> -static struct pxa3xx_nand_flash micron4GbX8 = {
>> - ? ? ? .timing ? ? ? ? = &micron_timing,
>> - ? ? ? .cmdset ? ? ? ? = &largepage_cmdset,
>> - ? ? ? .page_per_block = 64,
>> - ? ? ? .page_size ? ? ?= 2048,
>> - ? ? ? .flash_width ? ?= 8,
>> - ? ? ? .dfc_width ? ? ?= 8,
>> - ? ? ? .num_blocks ? ? = 4096,
>> - ? ? ? .chip_id ? ? ? ?= 0xdc2c,
>> -};
>> -
>> -static struct pxa3xx_nand_flash micron4GbX16 = {
>> - ? ? ? .timing ? ? ? ? = &micron_timing,
>> - ? ? ? .cmdset ? ? ? ? = &largepage_cmdset,
>> - ? ? ? .page_per_block = 64,
>> - ? ? ? .page_size ? ? ?= 2048,
>> - ? ? ? .flash_width ? ?= 16,
>> - ? ? ? .dfc_width ? ? ?= 16,
>> - ? ? ? .num_blocks ? ? = 4096,
>> - ? ? ? .chip_id ? ? ? ?= 0xcc2c,
>> -};
>> -
>> -static struct pxa3xx_nand_timing stm2GbX16_timing = {
>> - ? ? ? .tCH = 10,
>> - ? ? ? .tCS = 35,
>> - ? ? ? .tWH = 15,
>> - ? ? ? .tWP = 25,
>> - ? ? ? .tRH = 15,
>> - ? ? ? .tRP = 25,
>> - ? ? ? .tR = 25000,
>> - ? ? ? .tWHR = 60,
>> - ? ? ? .tAR = 10,
>> -};
>> -
>> -static struct pxa3xx_nand_flash stm2GbX16 = {
>> - ? ? ? .timing = &stm2GbX16_timing,
>> - ? ? ? .cmdset = &largepage_cmdset,
>> - ? ? ? .page_per_block = 64,
>> - ? ? ? .page_size = 2048,
>> - ? ? ? .flash_width = 16,
>> - ? ? ? .dfc_width = 16,
>> - ? ? ? .num_blocks = 2048,
>> - ? ? ? .chip_id = 0xba20,
>> -};
>> -
>> -static struct pxa3xx_nand_flash *builtin_flash_types[] = {
>> - ? ? ? &samsung512MbX16,
>> - ? ? ? &samsung2GbX8,
>> - ? ? ? &samsung32GbX8,
>> - ? ? ? &micron1GbX8,
>> - ? ? ? &micron1GbX16,
>> - ? ? ? &micron4GbX8,
>> - ? ? ? &micron4GbX16,
>> - ? ? ? &stm2GbX16,
>> -};
>> -#endif /* CONFIG_MTD_NAND_PXA3xx_BUILTIN */
>> -
>> ?#define NDTR0_tCH(c) ? (min((c), 7) << 19)
>> ?#define NDTR0_tCS(c) ? (min((c), 7) << 16)
>> ?#define NDTR0_tWH(c) ? (min((c), 7) << 11)
>> @@ -412,7 +308,6 @@ static int prepare_read_prog_cmd(struct
>> pxa3xx_nand_info *info,
>> ? ? ? ? ? ? ? ? ? ? ? ?uint16_t cmd, int column, int page_addr)
>> ?{
>> ? ? ? ?const struct pxa3xx_nand_flash *f = info->flash_info;
>> - ? ? ? const struct pxa3xx_nand_cmdset *cmdset = f->cmdset;
>>
>> ? ? ? ?/* calculate data size */
>> ? ? ? ?switch (f->page_size) {
>> @@ -445,7 +340,7 @@ static int prepare_read_prog_cmd(struct
>> pxa3xx_nand_info *info,
>> ? ? ? ? ? ? ? ? */
>> ? ? ? ? ? ? ? ?info->ndcb1 = page_addr << 8;
>>
>> - ? ? ? if (cmd == cmdset->program)
>> + ? ? ? if (cmd == cmdset.program)
>> ? ? ? ? ? ? ? ?info->ndcb0 |= NDCB0_CMD_TYPE(1) | NDCB0_AUTO_RS;
>>
>> ? ? ? ?return 0;
>> @@ -463,20 +358,18 @@ static int prepare_erase_cmd(struct
>> pxa3xx_nand_info *info,
>>
>> ?static int prepare_other_cmd(struct pxa3xx_nand_info *info, uint16_t cmd)
>> ?{
>> - ? ? ? const struct pxa3xx_nand_cmdset *cmdset =
>> info->flash_info->cmdset;
>> -
>> ? ? ? ?info->ndcb0 = cmd | ((cmd & 0xff00) ? NDCB0_DBC : 0);
>> ? ? ? ?info->ndcb1 = 0;
>> ? ? ? ?info->ndcb2 = 0;
>>
>> - ? ? ? if (cmd == cmdset->read_id) {
>> + ? ? ? if (cmd == cmdset.read_id) {
>> ? ? ? ? ? ? ? ?info->ndcb0 |= NDCB0_CMD_TYPE(3);
>> ? ? ? ? ? ? ? ?info->data_size = 8;
>> - ? ? ? } else if (cmd == cmdset->read_status) {
>> + ? ? ? } else if (cmd == cmdset.read_status) {
>> ? ? ? ? ? ? ? ?info->ndcb0 |= NDCB0_CMD_TYPE(4);
>> ? ? ? ? ? ? ? ?info->data_size = 8;
>> - ? ? ? } else if (cmd == cmdset->reset || cmd == cmdset->lock ||
>> - ? ? ? ? ? ? ? ? ?cmd == cmdset->unlock) {
>> + ? ? ? } else if (cmd == cmdset.reset || cmd == cmdset.lock ||
>> + ? ? ? ? ? ? ? ? ?cmd == cmdset.unlock) {
>> ? ? ? ? ? ? ? ?info->ndcb0 |= NDCB0_CMD_TYPE(5);
>> ? ? ? ?} else
>> ? ? ? ? ? ? ? ?return -EINVAL;
>> @@ -700,8 +593,6 @@ static void pxa3xx_nand_cmdfunc(struct mtd_info
>> *mtd, unsigned command,
>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?int column, int page_addr)
>> ?{
>> ? ? ? ?struct pxa3xx_nand_info *info = mtd->priv;
>> - ? ? ? const struct pxa3xx_nand_flash *flash_info = info->flash_info;
>> - ? ? ? const struct pxa3xx_nand_cmdset *cmdset = flash_info->cmdset;
>> ? ? ? ?int ret;
>>
>> ? ? ? ?info->use_dma = (use_dma) ? 1 : 0;
>> @@ -718,7 +609,7 @@ static void pxa3xx_nand_cmdfunc(struct mtd_info
>> *mtd, unsigned command,
>> ? ? ? ? ? ? ? ?info->buf_start = mtd->writesize + column;
>> ? ? ? ? ? ? ? ?memset(info->data_buff, 0xFF, info->buf_count);
>>
>> - ? ? ? ? ? ? ? if (prepare_read_prog_cmd(info, cmdset->read1, column,
>> page_addr))
>> + ? ? ? ? ? ? ? if (prepare_read_prog_cmd(info, cmdset.read1, column,
>> page_addr))
>> ? ? ? ? ? ? ? ? ? ? ? ?break;
>>
>> ? ? ? ? ? ? ? ?pxa3xx_nand_do_cmd(info, NDSR_RDDREQ | NDSR_DBERR |
>> NDSR_SBERR);
>> @@ -735,7 +626,7 @@ static void pxa3xx_nand_cmdfunc(struct mtd_info
>> *mtd, unsigned command,
>> ? ? ? ? ? ? ? ?info->buf_count = mtd->writesize + mtd->oobsize;
>> ? ? ? ? ? ? ? ?memset(info->data_buff, 0xFF, info->buf_count);
>>
>> - ? ? ? ? ? ? ? if (prepare_read_prog_cmd(info, cmdset->read1, column,
>> page_addr))
>> + ? ? ? ? ? ? ? if (prepare_read_prog_cmd(info, cmdset.read1, column,
>> page_addr))
>> ? ? ? ? ? ? ? ? ? ? ? ?break;
>>
>> ? ? ? ? ? ? ? ?pxa3xx_nand_do_cmd(info, NDSR_RDDREQ | NDSR_DBERR |
>> NDSR_SBERR);
>> @@ -761,14 +652,14 @@ static void pxa3xx_nand_cmdfunc(struct mtd_info
>> *mtd, unsigned command,
>> ? ? ? ?case NAND_CMD_PAGEPROG:
>> ? ? ? ? ? ? ? ?info->use_ecc = (info->seqin_column >= mtd->writesize) ? 0
>> : 1;
>>
>> - ? ? ? ? ? ? ? if (prepare_read_prog_cmd(info, cmdset->program,
>> + ? ? ? ? ? ? ? if (prepare_read_prog_cmd(info, cmdset.program,
>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?info->seqin_column, info->seqin_page_addr))
>> ? ? ? ? ? ? ? ? ? ? ? ?break;
>>
>> ? ? ? ? ? ? ? ?pxa3xx_nand_do_cmd(info, NDSR_WRDREQ);
>> ? ? ? ? ? ? ? ?break;
>> ? ? ? ?case NAND_CMD_ERASE1:
>> - ? ? ? ? ? ? ? if (prepare_erase_cmd(info, cmdset->erase, page_addr))
>> + ? ? ? ? ? ? ? if (prepare_erase_cmd(info, cmdset.erase, page_addr))
>> ? ? ? ? ? ? ? ? ? ? ? ?break;
>>
>> ? ? ? ? ? ? ? ?pxa3xx_nand_do_cmd(info, NDSR_CS0_BBD | NDSR_CS0_CMDD);
>> @@ -783,13 +674,13 @@ static void pxa3xx_nand_cmdfunc(struct mtd_info
>> *mtd, unsigned command,
>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?info->read_id_bytes : 1;
>>
>> ? ? ? ? ? ? ? ?if (prepare_other_cmd(info, (command == NAND_CMD_READID) ?
>> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? cmdset->read_id : cmdset->read_status))
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? cmdset.read_id : cmdset.read_status))
>> ? ? ? ? ? ? ? ? ? ? ? ?break;
>>
>> ? ? ? ? ? ? ? ?pxa3xx_nand_do_cmd(info, NDSR_RDDREQ);
>> ? ? ? ? ? ? ? ?break;
>> ? ? ? ?case NAND_CMD_RESET:
>> - ? ? ? ? ? ? ? if (prepare_other_cmd(info, cmdset->reset))
>> + ? ? ? ? ? ? ? if (prepare_other_cmd(info, cmdset.reset))
>> ? ? ? ? ? ? ? ? ? ? ? ?break;
>>
>> ? ? ? ? ? ? ? ?ret = pxa3xx_nand_do_cmd(info, NDSR_CS0_CMDD);
>> @@ -925,12 +816,10 @@ static int pxa3xx_nand_ecc_correct(struct mtd_info
>> *mtd,
>>
>> ?static int __readid(struct pxa3xx_nand_info *info, uint32_t *id)
>> ?{
>> - ? ? ? const struct pxa3xx_nand_flash *f = info->flash_info;
>> - ? ? ? const struct pxa3xx_nand_cmdset *cmdset = f->cmdset;
>> ? ? ? ?uint32_t ndcr;
>> ? ? ? ?uint8_t ?id_buff[8];
>>
>> - ? ? ? if (prepare_other_cmd(info, cmdset->read_id)) {
>> + ? ? ? if (prepare_other_cmd(info, cmdset.read_id)) {
>> ? ? ? ? ? ? ? ?printk(KERN_ERR "failed to prepare command\n");
>> ? ? ? ? ? ? ? ?return -EINVAL;
>> ? ? ? ?}
>> @@ -991,7 +880,7 @@ static int pxa3xx_nand_config_flash(struct
>> pxa3xx_nand_info *info,
>>
>> ? ? ? ?info->reg_ndcr = ndcr;
>>
>> - ? ? ? pxa3xx_nand_set_timing(info, f->timing);
>> + ? ? ? pxa3xx_nand_set_timing(info, &f->timing);
>> ? ? ? ?info->flash_info = f;
>> ? ? ? ?return 0;
>> ?}
>> @@ -1027,11 +916,6 @@ static int pxa3xx_nand_detect_config(struct
>> pxa3xx_nand_info *info)
>> ? ? ? ?default_flash.flash_width = ndcr & NDCR_DWIDTH_M ? 16 : 8;
>> ? ? ? ?default_flash.dfc_width = ndcr & NDCR_DWIDTH_C ? 16 : 8;
>>
>> - ? ? ? if (default_flash.page_size == 2048)
>> - ? ? ? ? ? ? ? default_flash.cmdset = &largepage_cmdset;
>> - ? ? ? else
>> - ? ? ? ? ? ? ? default_flash.cmdset = &smallpage_cmdset;
>> -
>> ? ? ? ?/* set info fields needed to __readid */
>> ? ? ? ?info->flash_info = &default_flash;
>> ? ? ? ?info->read_id_bytes = (default_flash.page_size == 2048) ? 4 : 2;
>> @@ -1067,7 +951,7 @@ static int pxa3xx_nand_detect_config(struct
>> pxa3xx_nand_info *info)
>> ? ? ? ? ? ? ? ?info->row_addr_cycles = 2;
>>
>> ? ? ? ?pxa3xx_nand_detect_timing(info, &default_timing);
>> - ? ? ? default_flash.timing = &default_timing;
>> + ? ? ? memcpy(&default_flash.timing, &default_timing,
>> sizeof(default_timing));
>>
>> ? ? ? ?return 0;
>> ?}
>> @@ -1083,23 +967,9 @@ static int pxa3xx_nand_detect_flash(struct
>> pxa3xx_nand_info *info,
>> ? ? ? ? ? ? ? ?if (pxa3xx_nand_detect_config(info) == 0)
>> ? ? ? ? ? ? ? ? ? ? ? ?return 0;
>>
>> - ? ? ? for (i = 0; i<pdata->num_flash; ++i) {
>> - ? ? ? ? ? ? ? f = pdata->flash + i;
>> -
>> - ? ? ? ? ? ? ? if (pxa3xx_nand_config_flash(info, f))
>> - ? ? ? ? ? ? ? ? ? ? ? continue;
>> -
>> - ? ? ? ? ? ? ? if (__readid(info, &id))
>> - ? ? ? ? ? ? ? ? ? ? ? continue;
>> -
>> - ? ? ? ? ? ? ? if (id == f->chip_id)
>> - ? ? ? ? ? ? ? ? ? ? ? return 0;
>> - ? ? ? }
>> -
>> -#ifdef CONFIG_MTD_NAND_PXA3xx_BUILTIN
>> ? ? ? ?for (i = 0; i < ARRAY_SIZE(builtin_flash_types); i++) {
>>
>> - ? ? ? ? ? ? ? f = builtin_flash_types[i];
>> + ? ? ? ? ? ? ? f = &builtin_flash_types[i];
>>
>> ? ? ? ? ? ? ? ?if (pxa3xx_nand_config_flash(info, f))
>> ? ? ? ? ? ? ? ? ? ? ? ?continue;
>> @@ -1110,7 +980,6 @@ static int pxa3xx_nand_detect_flash(struct
>> pxa3xx_nand_info *info,
>> ? ? ? ? ? ? ? ?if (id == f->chip_id)
>> ? ? ? ? ? ? ? ? ? ? ? ?return 0;
>> ? ? ? ?}
>> -#endif
>>
>> ? ? ? ?dev_warn(&info->pdev->dev,
>> ? ? ? ? ? ? ? ? "failed to detect configured nand flash; found %04x
>> instead of\n",
>> @@ -1320,17 +1189,6 @@ static int pxa3xx_nand_probe(struct
>> platform_device *pdev)
>> ? ? ? ? ? ? ? ?goto fail_free_irq;
>> ? ? ? ?}
>>
>> - ? ? ? if (mtd_has_cmdlinepart()) {
>> - ? ? ? ? ? ? ? static const char *probes[] = { "cmdlinepart", NULL };
>> - ? ? ? ? ? ? ? struct mtd_partition *parts;
>> - ? ? ? ? ? ? ? int nr_parts;
>> -
>> - ? ? ? ? ? ? ? nr_parts = parse_mtd_partitions(mtd, probes, &parts, 0);
>> -
>> - ? ? ? ? ? ? ? if (nr_parts)
>> - ? ? ? ? ? ? ? ? ? ? ? return add_mtd_partitions(mtd, parts, nr_parts);
>> - ? ? ? }
>> -
>> ? ? ? ?return add_mtd_partitions(mtd, pdata->parts, pdata->nr_parts);
>>
>> ?fail_free_irq:
>
>
> --
> Sincerely yours,
> Mike.
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
