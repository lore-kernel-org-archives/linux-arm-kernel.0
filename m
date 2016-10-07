From: vz@mleia.com (Vladimir Zapolskiy)
Date: Fri, 7 Oct 2016 04:42:23 +0300
Subject: [PATCH 1/3] firmware: add lpc18xx boot rom driver
In-Reply-To: <20160913195117.2887-2-manabian@gmail.com>
References: <20160913195117.2887-1-manabian@gmail.com>
 <20160913195117.2887-2-manabian@gmail.com>
Message-ID: <9fec6e3b-fcd9-2251-c4c9-5b3f4fdc3c70@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joachim,

On 13.09.2016 22:51, Joachim Eastwood wrote:
> Firmware driver for the boot ROM found on all NXP LPC18xx/43xx
> devices. This driver makes it possible to retrieve device specific
> information from either the ROM via API calls or from OTP memory.
> 
> The boot ROM contains several APIs for on-chip devices. Note that not
> all APIs are available on all devices. The API to retrieve device
> information and internal Flash programming (IAP) is only available on
> devices with Flash. Flashless devices retrieve device information from
> OTP memory. The CHIPID register in CREG (syscon) is used to check if
> IAP is available.
> 
> For now this driver is only used to expose device information via a
> 'SoC device'. Linux API for the IAP and OTP will be added later. These
> two APIs will be used by a Flash MTD driver and a OTP NVMEM driver to
> program the memory.
> 
> Signed-off-by: Joachim Eastwood <manabian@gmail.com>

please feel free to add to the series my

  Tested-by: Vladimir Zapolskiy <vz@mleia.com>
  Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>

I tested the change on a board powered by LPC4357.

Nevertheless I have some nitpicks for your consideration.

And the first one is that I'm not totally convinced that drivers/firmware
is the proper place for the driver, I tend to think that it might be
a good time to create drivers/soc/nxp/

> ---
>  drivers/firmware/Kconfig            |  12 ++
>  drivers/firmware/Makefile           |   1 +
>  drivers/firmware/nxp_lpc_boot_rom.c | 411 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 424 insertions(+)
>  create mode 100644 drivers/firmware/nxp_lpc_boot_rom.c
> 

[snip]

> +/* LPC18xx/43xx CREG (syscon) defines */
> +#define LPC18XX_CREG_CHIPID		0x200
> +#define LPC18XX_FLASH_CHIPID0		0x4284e02b
> +#define LPC18XX_FLASH_CHIPID1		0x7284e02b
> +#define LPC18XX_FLASHLESS_CHIPID0	0x5284e02b
> +#define LPC18XX_FLASHLESS_CHIPID1	0x6284e02b
> +#define LPC43XX_FLASH_CHIPID0		0x4906002b
> +#define LPC43XX_FLASH_CHIPID1		0x7906002b
> +#define LPC43XX_FLASHLESS_CHIPID0	0x5906002b
> +#define LPC43XX_FLASHLESS_CHIPID1	0x6906002b
> +
> +#define NXP_PART_LPC(_num, _id0, _id1, _sz0, _sz1)	\
> +	{						\
> +		.name = "LPC"#_num,			\
> +		.id[0] = _id0, .id[1] = _id1,		\
> +		.flash_size[0] = _sz0 * 1024,		\
> +		.flash_size[1] = _sz1 * 1024,		\
> +	}
> +
> +

checkpatch complains:

CHECK: Please don't use multiple blank lines
#145: FILE: drivers/firmware/nxp_lpc_boot_rom.c:75:
+
+

> +struct nxp_lpc_part {
> +	const char *name;
> +	u16 flash_size[2];

flash_size[2] is set by NXP_PART_LPC() macro but unused, however
in my build environment (W=1 and sparse checks) I get tons of
legitimate compile time warnings:

drivers/firmware/nxp_lpc_boot_rom.c:93:9: warning: cast truncates bits from constant value (80000 becomes 0)
drivers/firmware/nxp_lpc_boot_rom.c:93:9: warning: cast truncates bits from constant value (80000 becomes 0)
drivers/firmware/nxp_lpc_boot_rom.c:94:9: warning: cast truncates bits from constant value (80000 becomes 0)
drivers/firmware/nxp_lpc_boot_rom.c:94:9: warning: cast truncates bits from constant value (80000 becomes 0)
....

drivers/firmware/nxp_lpc_boot_rom.c:93:2: warning: large integer implicitly truncated to unsigned type [-Woverflow]
   NXP_PART_LPC(1857,  0xf001d830, 0x00, 512, 512),
   ^
drivers/firmware/nxp_lpc_boot_rom.c:93:2: warning: large integer implicitly truncated to unsigned type [-Woverflow]
drivers/firmware/nxp_lpc_boot_rom.c:94:2: warning: large integer implicitly truncated to unsigned type [-Woverflow]
   NXP_PART_LPC(18S57, 0xf001d860, 0x00, 512, 512),
   ^
....

and so on.

Please consider either to store flash size in kB or change storage type to u32.

> +	u32 id[2];
> +};
> +
> +static const struct nxp_lpc_part nxp_lpc_parts[] = {
> +	/* LPC18xx Flashless parts */
> +	NXP_PART_LPC(1850,  0xf000d830, 0x00,   0,   0),
> +	NXP_PART_LPC(18S50, 0xf000d860, 0x00,   0,   0),
> +	NXP_PART_LPC(1830,  0xf000da30, 0x00,   0,   0),
> +	NXP_PART_LPC(18S30, 0xf000da60, 0x00,   0,   0),
> +	NXP_PART_LPC(1820,  0xf00adb3c, 0x00,   0,   0),
> +	NXP_PART_LPC(18S20, 0xf00adb6c, 0x00,   0,   0),
> +	NXP_PART_LPC(1810,  0xf00b5b3f, 0x00,   0,   0),
> +	NXP_PART_LPC(18S10, 0xf00b5b6f, 0x00,   0,   0),
> +	/* LPC18xx Flash parts */
> +	NXP_PART_LPC(1857,  0xf001d830, 0x00, 512, 512),
> +	NXP_PART_LPC(18S57, 0xf001d860, 0x00, 512, 512),
> +	NXP_PART_LPC(1853,  0xf001d830, 0x44, 256, 256),
> +	NXP_PART_LPC(1837,  0xf001da30, 0x00, 512, 512),
> +	NXP_PART_LPC(18S37, 0xf001d860, 0x00, 512, 512),
> +	NXP_PART_LPC(1833,  0xf001da30, 0x44, 256, 256),
> +	NXP_PART_LPC(1827,  0xf001db3c, 0x00, 512, 512),
> +	NXP_PART_LPC(1825,  0xf001db3c, 0x22, 384, 384),
> +	NXP_PART_LPC(1823,  0xf00bdb3c, 0x44, 256, 256),
> +	NXP_PART_LPC(1822,  0xf00bdb3c, 0x80, 512,   0),
> +	NXP_PART_LPC(1817,  0xf001db3f, 0x00, 512, 512),
> +	NXP_PART_LPC(1815,  0xf001db3f, 0x22, 384, 384),
> +	NXP_PART_LPC(1813,  0xf00bdb3f, 0x44, 256, 256),
> +	NXP_PART_LPC(1812,  0xf00bdb3f, 0x80, 512,   0),
> +	/* LPC43xx Flashless parts */
> +	NXP_PART_LPC(4370,  0x00000030, 0x00,   0,   0), /* LBGA256 */
> +	NXP_PART_LPC(4370,  0x00000230, 0x00,   0,   0), /* TFBGA100 */
> +	NXP_PART_LPC(43S70, 0x00000060, 0x00,   0,   0),
> +	NXP_PART_LPC(4350,  0xa0000830, 0x00,   0,   0),
> +	NXP_PART_LPC(43S50, 0xa0000860, 0x00,   0,   0),
> +	NXP_PART_LPC(4330,  0xa0000a30, 0x00,   0,   0),
> +	NXP_PART_LPC(43S30, 0xa0000a60, 0x00,   0,   0),
> +	NXP_PART_LPC(4320,  0xa000cb3c, 0x00,   0,   0),
> +	NXP_PART_LPC(43S20, 0xa000cb6c, 0x00,   0,   0),
> +	NXP_PART_LPC(4310,  0xa00acb3f, 0x00,   0,   0),
> +	/* LPC43xx parts with Flash */
> +	NXP_PART_LPC(4367,  0x8001c030, 0x00, 512, 512),
> +	NXP_PART_LPC(43S67, 0x8001c060, 0x00, 512, 512),
> +	NXP_PART_LPC(4357,  0xa001c830, 0x00, 512, 512),
> +	NXP_PART_LPC(43S57, 0xa001c860, 0x00, 512, 512), /* LBGA256 */
> +	NXP_PART_LPC(43S57, 0xa001ca60, 0x00, 512, 512), /* LQFP208 */
> +	NXP_PART_LPC(4353,  0xa001c830, 0x44, 256, 256),
> +	NXP_PART_LPC(4337,  0xa001ca30, 0x00, 512, 512),
> +	NXP_PART_LPC(43S37, 0xa001ca60, 0x00, 512, 512),
> +	NXP_PART_LPC(4333,  0xa001ca30, 0x44, 256, 256),
> +	NXP_PART_LPC(4327,  0xa001cb3c, 0x00, 512, 512),
> +	NXP_PART_LPC(4325,  0xa001cb3c, 0x22, 384, 384),
> +	NXP_PART_LPC(4323,  0xa00bcb3c, 0x44, 256, 256),
> +	NXP_PART_LPC(4322,  0xa00bcb3c, 0x80, 512,   0),
> +	NXP_PART_LPC(4317,  0xa001cb3f, 0x00, 512, 512),
> +	NXP_PART_LPC(4315,  0xa001cb3f, 0x22, 384, 384),
> +	NXP_PART_LPC(4313,  0xa00bcb3f, 0x44, 256, 256),
> +	NXP_PART_LPC(4312,  0xa00bcb3f, 0x80, 512,   0),
> +};
> +
> +struct iap_rom {
> +	void (*entry)(u32 *, u32 *);
> +};

Here it might be simpler to declare a typedef instead of a struct.

> +struct nxp_rom_api {
> +	struct device *dev;
> +	void __iomem *rom;
> +
> +	bool has_iap;
> +	struct iap_rom iap;
> +	spinlock_t lock;
> +
> +	const struct nxp_lpc_part *part;
> +	const char *partname;
> +	u32 boot_version;
> +
> +	struct soc_device *soc_dev;
> +	struct soc_device_attribute soc_dev_attr;
> +};
> +

--
With best wishes,
Vladimir
