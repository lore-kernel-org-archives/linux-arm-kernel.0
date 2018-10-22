From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Mon, 22 Oct 2018 12:26:59 +0200
Subject: [PATCH v3 1/2] mtd: spi-nor: add support to non-uniform SFDP
 SPI NOR flash memories
In-Reply-To: <VI1PR04MB1038EF892921194D1BFDE6FC99F40@VI1PR04MB1038.eurprd04.prod.outlook.com>
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
 <20181022111543.2a607efc@bbrezillon>
 <VI1PR04MB1038EF892921194D1BFDE6FC99F40@VI1PR04MB1038.eurprd04.prod.outlook.com>
Message-ID: <20181022122659.0675942e@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 22 Oct 2018 10:03:55 +0000
Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:

> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -2863,26 +2863,36 @@ static u8 spi_nor_smpt_read_dummy(const struct spi_nor *nor, const u32 settings)
>   * @nor:       pointer to a 'struct spi_nor'
>   * @smpt:      pointer to the sector map parameter table
>   */
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
> +       pr_info("Start [addr_width:%08x, read_dumy:%0x8, read_opcode:%08x]\n", nor->addr_width, nor->read_dummy, nor->read_opcode);
> +
> +       for (i = 0; i<smpt_len; i++)
> +               pr_info("%s:%i smpt[%d]=%08x\n", __func__, __LINE__, i, smpt[i]);
> +
>         map_id = 0;
> -       i = 0;
>         /* Determine if there are any optional Detection Command Descriptors */
> -       while (!(smpt[i] & SMPT_DESC_TYPE_MAP)) {
> +       for (i = 0; i< smpt_len; i++) {

				   ^ i += 2) {

> +               if ((smpt[i] & SMPT_DESC_TYPE_MAP))
> +                       break;
> +
>                 read_data_mask = SMPT_CMD_READ_DATA(smpt[i]);
>                 nor->addr_width = spi_nor_smpt_addr_width(nor, smpt[i]);
>                 nor->read_dummy = spi_nor_smpt_read_dummy(nor, smpt[i]);
>                 nor->read_opcode = SMPT_CMD_OPCODE(smpt[i]);
> +               pr_info("smpt[%d]=[addr_width:%08x, read_dumy:%0x8, read_opcode:%08x]\n", i, nor->addr_width, nor->read_dummy, nor->read_opcode);
> +
>                 addr = smpt[i + 1];
> 
>                 err = spi_nor_read_raw(nor, addr, 1, &data_byte);
> @@ -2894,18 +2904,36 @@ static const u32 *spi_nor_get_map_in_use(struct spi_nor *nor, const u32 *smpt)
>                  * Configuration that is currently in use.
>                  */
>                 map_id = map_id << 1 | !!(data_byte & read_data_mask);
> +               map_id_is_valid = true;
>                 i = i + 2;

Drop the above line (i = i + 2).

>         }
> 
> -       /* Find the matching configuration map */
> -       while (SMPT_MAP_ID(smpt[i]) != map_id) {
> -               if (smpt[i] & SMPT_DESC_END)
> -                       goto out;
> +       if (map_id_is_valid)
> +               pr_info("%s:%i map_id=%d\n", __func__, __LINE__, map_id);
> +       else
> +               pr_info("%s:%i NO map_id\n", __func__, __LINE__);
> +
> +       for (nmaps = 0; i< smpt_len; nmaps++) {
> +               if((smpt[i] & SMPT_DESC_TYPE_MAP))
> +                       continue;
> +
> +               if(!map_id_is_valid) {
> +                       if (nmaps) {
> +                               ret = NULL;
> +                               break;
> +                       }
> +
> +                       ret = smpt+i;
> +               } else if (map_id == SMPT_MAP_ID(smpt[i])) {
> +                       ret = smpt+i;
> +                       break;
> +               }
> +
>                 /* increment the table index to the next map */
>                 i += SMPT_MAP_REGION_COUNT(smpt[i]) + 1;
>         }
> 
> -       ret = smpt + i;
> +       pr_info("End [addr_width:%08x, read_dumy:%0x8, read_opcode:%08x]\n", nor->addr_width, nor->read_dummy, nor->read_opcode);
>         /* fall through */
>  out:
>         nor->addr_width = addr_width;
