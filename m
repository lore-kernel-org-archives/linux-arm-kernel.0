From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Mon, 22 Oct 2018 10:01:52 +0200
Subject: [PATCH v3 1/2] mtd: spi-nor: add support to non-uniform SFDP
 SPI NOR flash memories
In-Reply-To: <VI1PR04MB1038BD6103DD8BD6B6DEC2B899F40@VI1PR04MB1038.eurprd04.prod.outlook.com>
References: <20180911154007.17195-1-tudor.ambarus@microchip.com>
 <20180911154007.17195-2-tudor.ambarus@microchip.com>
 <VI1PR04MB103888BC18F3C5AD0C02DEF699FE0@VI1PR04MB1038.eurprd04.prod.outlook.com>
 <31a8f6a9-1459-443a-6ef8-2b2c17769ae4@microchip.com>
 <de0f7245-2557-12be-a306-67b08e55ae7b@wedev4u.fr>
 <VI1PR04MB1038AB25EABDC8507984ADC799FF0@VI1PR04MB1038.eurprd04.prod.outlook.com>
 <20181017090724.12f2cd79@bbrezillon>
 <20181017091045.124e0266@bbrezillon>
 <20181017092941.3658bd9a@bbrezillon>
 <VI1PR04MB1038EFA1E83AD78EBE84ECC499FF0@VI1PR04MB1038.eurprd04.prod.outlook.com>
 <20181017115237.07310b74@bbrezillon>
 <VI1PR04MB1038BD6103DD8BD6B6DEC2B899F40@VI1PR04MB1038.eurprd04.prod.outlook.com>
Message-ID: <20181022100152.05da1b6c@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 22 Oct 2018 06:04:13 +0000
Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:

> -static const u32 *spi_nor_get_map_in_use(struct spi_nor *nor, const u32 *smpt)
> +static const u32 *spi_nor_get_map_in_use(struct spi_nor *nor, const u32 *smpt, u32 smpt_len)
>  {
>         const u32 *ret = NULL;
> -       u32 i, addr;
> +       u32 i, addr, nmaps;
>         int err;
>         u8 addr_width, read_opcode, read_dummy;
>         u8 read_data_mask, data_byte, map_id;
> +       bool map_id_is_valid = false;
> 
>         addr_width = nor->addr_width;
>         read_dummy = nor->read_dummy;
>         read_opcode = nor->read_opcode;
> 
> +       for (i = 0; i<smpt_len; i++)
> +               pr_info("%s:%i smpt[%d]=%08x\n", __func__, __LINE__, i, smpt[i]);
> +
>         map_id = 0;
> -       i = 0;
>         /* Determine if there are any optional Detection Command Descriptors */
> -       while (!(smpt[i] & SMPT_DESC_TYPE_MAP)) {
> +       for (i = 0; i< smpt_len; i++) {
> +               if (!(smpt[i] & SMPT_DESC_TYPE_MAP))
> +                       break;
> +
>                 read_data_mask = SMPT_CMD_READ_DATA(smpt[i]);
>                 nor->addr_width = spi_nor_smpt_addr_width(nor, smpt[i]);
>                 nor->read_dummy = spi_nor_smpt_read_dummy(nor, smpt[i]);

Could you also print the ->addr_width, ->read_dummy and ->read_opcode
here?

> @@ -2894,18 +2900,35 @@ static const u32 *spi_nor_get_map_in_use(struct spi_nor *nor, const u32 *smpt)
>                  * Configuration that is currently in use.
>                  */
>                 map_id = map_id << 1 | !!(data_byte & read_data_mask);
> +               map_id_is_valid = true;
>                 i = i + 2;
>         }
