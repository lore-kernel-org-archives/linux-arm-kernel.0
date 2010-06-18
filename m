From: adrian.wenl@gmail.com (Lei Wen)
Date: Fri, 18 Jun 2010 15:55:21 +0800
Subject: [PATCH 01/25] pxa3xx_nand: condense the flash definition
In-Reply-To: <AANLkTinOsQ8AcH-As91CRqrEQVnXdsm_CmFQgyj7gI1_@mail.gmail.com>
References: <AANLkTil1FnPkGS7l6W0HWeXyOxXzWbZkvFWY4jJF_I_A@mail.gmail.com>
	<AANLkTinOsQ8AcH-As91CRqrEQVnXdsm_CmFQgyj7gI1_@mail.gmail.com>
Message-ID: <AANLkTim9O5kuGzvQoB65fWDr3Bi9siiVBMCPx6heqZjd@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 18, 2010 at 2:23 PM, Eric Miao <eric.y.miao@gmail.com> wrote:
> On Fri, Jun 18, 2010 at 1:32 PM, Haojian Zhuang
> <haojian.zhuang@gmail.com> wrote:
>> From 76684334fbf214ab164ed07791b02535a3f04779 Mon Sep 17 00:00:00 2001
>> From: Lei Wen <leiwen@marvell.com>
>> Date: Sat, 20 Mar 2010 19:01:23 +0800
>> Subject: [PATCH 01/25] pxa3xx_nand: condense the flash definition
>>
>> Adding a new flash definition would need less code.
>> Keep the platform passing flash defition method.
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?^^^^^^^^ definition?
Oops... Typo...
>> If one flash is both defined in platform data and builtin table,
>> driver would select the one from platform data first.
>
> This makes sense. I thin the CONFIG_MTD_NAND_PXA3xx_BUILTIN is introduced
> as an optimization so to reduce the code size if platform flash definition
> is provided, instead of an option to remove built-in definitions.

Em... I agree...
>
>>
>> By this way, platform could select the timing most suit for itself,
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ^^^^ suitable
>> not need to follow the common settings.
>>
>> Signed-off-by: Lei Wen <leiwen@marvell.com>
>> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
>
> // there are some line wrapped though, maybe it's my gmail fault.
>
>> ---
>> ?arch/arm/plat-pxa/include/plat/pxa3xx_nand.h | ? 37 ----
>> ?drivers/mtd/nand/Kconfig ? ? ? ? ? ? ? ? ? ? | ? ?7 -
>> ?drivers/mtd/nand/pxa3xx_nand.c ? ? ? ? ? ? ? | ?241 +++++++-------------------
>> ?3 files changed, 66 insertions(+), 219 deletions(-)
>>
>> diff --git a/arch/arm/plat-pxa/include/plat/pxa3xx_nand.h
>> b/arch/arm/plat-pxa/include/plat/pxa3xx_nand.h
>> index 3478eae..7e5a28f 100644
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
>> - ? ? ? unsigned int ? ?tWHR; /* ND_nWE high to ND_nRE low for status read */
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
>
> So does this prevent board code from defining their own timing and etc?

No, platform could define its own timing. If there is definition for
the same chip,
driver would choose the one from platform definition first.

>
>> ?struct pxa3xx_nand_platform_data {
>>
>> ? ? ? ?/* the data flash bus is shared between the Static Memory
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
>> diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
>> index e02fa4f..013e075 100644
>> --- a/drivers/mtd/nand/pxa3xx_nand.c
>> +++ b/drivers/mtd/nand/pxa3xx_nand.c
>
> ... snipped ...
>
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
>
> So how to handle the difference of command set between smallpage and
> largepage?

The only difference of cmdsetbetween the small page and large page is
at the read command.
While large page is 0x3000, small page is 0x0.
This handle is not address in this patch, but put to latter patch of
0006 in this seris patch set.
For whole patch set chnage is so large, that it is not easy to make it
very clear at each patch...



>
>> ? ? ? ?.read1 ? ? ? ? ?= 0x3000,
>> ? ? ? ?.read2 ? ? ? ? ?= 0x0050,
>> ? ? ? ?.program ? ? ? ?= 0x1080,
>> @@ -203,143 +225,26 @@ static struct pxa3xx_nand_cmdset largepage_cmdset = {
>> ? ? ? ?.lock_status ? ?= 0x007A,
>> ?};
>>
>> -#ifdef CONFIG_MTD_NAND_PXA3xx_BUILTIN
>> -static struct pxa3xx_nand_timing samsung512MbX16_timing = {
>> - ? ? ? .tCH ? ?= 10,
>> - ? ? ? .tCS ? ?= 0,
>> - ? ? ? .tWH ? ?= 20,
>> - ? ? ? .tWP ? ?= 40,
>
> ...
>
>> +static struct pxa3xx_nand_timing __devinitdata timing[] = {
>
> Better with some comment columns like below:
>
> ?/* ? ? ? ?tCH tCS tWH tWP ... */
>> + ? ? ? /* Samsung NAND series */
>> + ? ? ? { 10, ?0, 20, 40, 30, 40, 11123, 110, 10, },
>> + ? ? ? /* Micron NAND series */
>> + ? ? ? { 10, 25, 15, 25, 15, 30, 25000, ?60, 10, },
>> + ? ? ? /* ST NAND series */
>> + ? ? ? { 10, 35, 15, 25, 15, 25, 25000, ?60, 10, },
>
> Now define something like
>
> #define NAND_TIMING_SAMSUNG ? ? (&timing[0])
> #define NAND_TIMING_MICRON ? ? ?(&timing[1])
> #define NAND_TIMING_ST ? ? ? ? ?(&timing[2])
>
>> ?};
>>
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
>
> /* ? ? ? ?Chip ID, page per block, page size, flash width, .... */
Agree.

>
>> + ? ? ? { 0x46ec, ?32, ?512, 16, 16, 4096, &timing[0], },
>> + ? ? ? { 0xdaec, ?64, 2048, ?8, ?8, 2048, &timing[0], },
>> + ? ? ? { 0xd7ec, 128, 4096, ?8, ?8, 8192, &timing[0], },
>> + ? ? ? { 0xa12c, ?64, 2048, ?8, ?8, 1024, &timing[1], },
>> + ? ? ? { 0xb12c, ?64, 2048, 16, 16, 1024, &timing[1], },
>> + ? ? ? { 0xdc2c, ?64, 2048, ?8, ?8, 4096, &timing[1], },
>> + ? ? ? { 0xcc2c, ?64, 2048, 16, 16, 4096, &timing[1], },
>> + ? ? ? { 0xba20, ?64, 2048, 16, 16, 2048, &timing[2], },
>> ?};
>
> BTW, I like the array above very much.
>
>>
>> -static struct pxa3xx_nand_timing micron_timing = {
>> - ? ? ? .tCH ? ?= 10,
>> - ? ? ? .tCS ? ?= 25,
>> - ? ? ? .tWH ? ?= 15,
>> - ? ? ? .tWP ? ?= 25,
>> - ? ? ? .tRH ? ?= 15,
>> - ? ? ? .tRP ? ?= 30,
>> - ? ? ? .tR ? ? = 25000,
>
> ... snipped ...
>
>> -};
>> -#endif /* CONFIG_MTD_NAND_PXA3xx_BUILTIN */
>> -
>> ?#define NDTR0_tCH(c) ? (min((c), 7) << 19)
>> ?#define NDTR0_tCS(c) ? (min((c), 7) << 16)
>> ?#define NDTR0_tWH(c) ? (min((c), 7) << 11)
>> @@ -412,7 +317,6 @@ static int prepare_read_prog_cmd(struct
>> pxa3xx_nand_info *info,
>> ? ? ? ? ? ? ? ? ? ? ? ?uint16_t cmd, int column, int page_addr)
>> ?{
>> ? ? ? ?const struct pxa3xx_nand_flash *f = info->flash_info;
>> - ? ? ? const struct pxa3xx_nand_cmdset *cmdset = f->cmdset;
>
> I think it's better to keep a local pointer. Reference within a function
> to a global structure is always a bad idea, one day you will find you've
> to modify all these references again when you add a new cmdset.
>
> And most of the modifications below can thus be removed and patch simplified.

My original thinking is for the cmdset is almost standardized, so make
such change for global structure.
Well, the suggestion also make sense. I would revert this change.

Best regards,
Lei
