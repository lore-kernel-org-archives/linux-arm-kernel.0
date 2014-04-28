From: stefan@agner.ch (Stefan Agner)
Date: Mon, 28 Apr 2014 16:41:48 +0200
Subject: [RFC 1/5] =?UTF-8?Q?mtd=3Afsl=5Fnfc=3A=20Nand=20flash=20contr?=
 =?UTF-8?Q?oller=20for=20VF=36=31=30=2C=20MPC=35=31=32=35=2C=20etc=2E?=
In-Reply-To: <1389222441-4322-2-git-send-email-bpringlemeir@nbsps.com>
References: <87siupheou.fsf@nbsps.com>
 <1389222441-4322-1-git-send-email-bpringlemeir@nbsps.com>
 <1389222441-4322-2-git-send-email-bpringlemeir@nbsps.com>
Message-ID: <708e6f84e177e1d02310358688b44c53@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bill,

The driver works fine for me using 3.14 on Colibri VF61 (8-Bit bus
width, Samsung NAND, 2k page size). Also tested with the Hardware ECC.
Do you plan to send an update patch of the driver?

FYI, I ported the driver to U-Boot and will send a patch to the U-Boot
mailing list soon.

Some minor comments below:

Am 2014-01-09 00:07, schrieb Bill Pringlemeir:
<snip>
> +static u8 bbt_pattern[] = {'B', 'b', 't', '0' };
> +static u8 mirror_pattern[] = {'1', 't', 'b', 'B' };
> +
> +static struct nand_bbt_descr bbt_main_descr = {
> +	.options = NAND_BBT_LASTBLOCK | NAND_BBT_CREATE | NAND_BBT_WRITE |
> +		   NAND_BBT_2BIT | NAND_BBT_VERSION,
> +	.offs =	11,
> +	.len = 4,
> +	.veroffs = 15,
> +	.maxblocks = 4,
> +	.pattern = bbt_pattern,
> +};
> +
> +static struct nand_bbt_descr bbt_mirror_descr = {
> +	.options = NAND_BBT_LASTBLOCK | NAND_BBT_CREATE | NAND_BBT_WRITE |
> +		   NAND_BBT_2BIT | NAND_BBT_VERSION,
> +	.offs =	11,
> +	.len = 4,
> +	.veroffs = 15,
> +	.maxblocks = 4,
> +	.pattern = mirror_pattern,
> +};

This is the same BBT descriptor as used on Timesys Vybrid BSP. Other
than this "backward compatibility", is there another reason to use non
default BBT descriptor? As far as I can tell, the ECC does not conflict
with the default BBT description.

> +/* Write data to NFC buffers */
> +static void nfc_write_buf(struct mtd_info *mtd, const u_char *buf, int len)
> +{
...
IMHO this type of commands are not really required, the function name is
descriptive enough.

> +/* Vybrid only.  MPC5125 has full RB and four CS. Assume boot loader
> + * has set this register for now.
> + */

Multi-line comment style (there are some malformed multi-line comments
in the ECC patch as well)

--
Stefan
