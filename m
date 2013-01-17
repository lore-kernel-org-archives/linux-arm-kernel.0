From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Thu, 17 Jan 2013 13:21:04 +0200
Subject: [PATCH v2] mtd: vt8500: Add support for Wondermedia Serial
 Flash Controller
In-Reply-To: <1358272414-6266-1-git-send-email-linux@prisktech.co.nz>
References: <1358272414-6266-1-git-send-email-linux@prisktech.co.nz>
Message-ID: <1358421664.2731.228.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-01-16 at 06:53 +1300, Tony Prisk wrote:
> This patch adds support for the Wondermedia serial flash controller
> found on WM8505, WM8650 and WM8850 SoCs.
> 
> Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
> ---
> v2:
> Change Kconfig depends to ARCH_VT8500 as this driver can't be used on other
> platforms.

Sparse still complains:

@@ @@
+drivers/mtd/devices/wmt_sflash.c:442:24: warning: cast removes address space of expression [sparse]
+drivers/mtd/devices/wmt_sflash.c:458:17: warning: incorrect type in argument 1 (different address spaces) [sparse]
+drivers/mtd/devices/wmt_sflash.c:458:17:    expected void volatile [noderef] <asn:2>*<noident> [sparse]
+drivers/mtd/devices/wmt_sflash.c:458:17:    got unsigned char [usertype] *<noident> [sparse]
+drivers/mtd/devices/wmt_sflash.c:465:25: warning: incorrect type in argument 1 (different address spaces) [sparse]
+drivers/mtd/devices/wmt_sflash.c:465:25:    expected void volatile [noderef] <asn:2>*<noident> [sparse]
+drivers/mtd/devices/wmt_sflash.c:465:25:    got unsigned char [usertype] *<noident> [sparse]

Also, checkpatch.pl has a valid complaint:

WARNING:CONFIG_DESCRIPTION: please write a paragraph that describes the config symbol fully
#26: FILE: drivers/mtd/devices/Kconfig:131:
+config MTD_WMT_SFLASH

total: 0 errors, 1 warnings, 636 lines checked

...

> +/* WinBond */
> +#define WB_W25X40BV		0x3013	/* 512 KB */
> +#define WB_X16A			0x3015	/* 2 MB */
> +#define WB_X32			0x3016	/* 4 MB */
> +#define WB_X64			0x3017	/* 8 MB */
> +
> +
> +#define SF_ID(mfr, mdl)		((mfr << 16) | mdl)

The flash manufacturer IDs are not specific to this driver, and should
be defined in a common header.


> +
> +#define FLASH_UNKNOWN		0x00ffffff
> +
> +struct wmt_flash_id {
> +	u32	id;
> +	u32	size;		/* Size in KB */
> +};
> +
> +static struct wmt_flash_id flash_ids[] = {
> +	{ SF_ID(MFR_SPANSION,	SPAN_FL016A),	2048 },
> +	{ SF_ID(MFR_SPANSION,	SPAN_FL064A),	8192 },
> +	{ SF_ID(MFR_EON,	EON_25P16),	2048 },
> +	{ SF_ID(MFR_EON,	EON_25P64),	8192 },
> +	{ SF_ID(MFR_EON,	EON_25F40),	512 },
> +	{ SF_ID(MFR_EON,	EON_25F16),	2048 },
> +	{ SF_ID(MFR_ATMEL,	AT_25DF041A),	512 },
> +	{ SF_ID(MFR_NUMONYX,	NX_25P16),	2048 },
> +	{ SF_ID(MFR_NUMONYX,	NX_25P64),	8192 },
> +	{ SF_ID(MFR_FUDAN,	FM_25F04),	512 },
> +	{ SF_ID(MFR_SST,	SST_VF016B),	2048 },
> +	{ SF_ID(MFR_MXIC,	MX_L512),	64 },
> +	{ SF_ID(MFR_MXIC,	MX_L4005A),	512 },
> +	{ SF_ID(MFR_MXIC,	MX_L1605D),	2048 },
> +	{ SF_ID(MFR_MXIC,	MX_L3205D),	4192 },
> +	{ SF_ID(MFR_MXIC,	MX_L6405D),	8192 },
> +	{ SF_ID(MFR_MXIC,	MX_L1635D),	2048 },
> +	{ SF_ID(MFR_MXIC,	MX_L3235D),	4192 },
> +	{ SF_ID(MFR_MXIC,	MX_L12805D),	16384 },
> +	{ SF_ID(MFR_WINBOND,	WB_W25X40BV),	512 },
> +	{ SF_ID(MFR_WINBOND,	WB_X16A),	2048 },
> +	{ SF_ID(MFR_WINBOND,	WB_X32),	4096 },
> +	{ SF_ID(MFR_WINBOND,	WB_X64),	8192 },
> +	{ 0, 0 },
> +};

Probably this should also be outside of the driver, since it is not
specific to this driver.

> +static u32 sf_get_chip_size(struct device *dev, u32 id)
> +{
> +	int i;
> +	for (i = 0; flash_ids[i].id != 0; i++)
> +		if (flash_ids[i].id == id)
> +			return flash_ids[i].size * 1024;
> +
> +	dev_err(dev, "Unknown flash id (%08x)\n", id);
> +	return 0;
> +}

And this.

-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130117/2a635469/attachment.sig>
