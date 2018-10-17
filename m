From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Wed, 17 Oct 2018 09:07:24 +0200
Subject: [PATCH v3 1/2] mtd: spi-nor: add support to non-uniform SFDP
 SPI NOR flash memories
In-Reply-To: <VI1PR04MB1038AB25EABDC8507984ADC799FF0@VI1PR04MB1038.eurprd04.prod.outlook.com>
References: <20180911154007.17195-1-tudor.ambarus@microchip.com>
 <20180911154007.17195-2-tudor.ambarus@microchip.com>
 <VI1PR04MB103888BC18F3C5AD0C02DEF699FE0@VI1PR04MB1038.eurprd04.prod.outlook.com>
 <31a8f6a9-1459-443a-6ef8-2b2c17769ae4@microchip.com>
 <de0f7245-2557-12be-a306-67b08e55ae7b@wedev4u.fr>
 <VI1PR04MB1038AB25EABDC8507984ADC799FF0@VI1PR04MB1038.eurprd04.prod.outlook.com>
Message-ID: <20181017090724.12f2cd79@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 17 Oct 2018 02:07:43 +0000
Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:

> >   
> Actually there is no entry of s25fs512s in current spi-nor.c file.
> For my connected flash part, jedec ID read points to s25fl512s. I
> have asked my board team to confirm the name of exact connected flash
> part. When I check the data sheet of s25fs512s, it also points to the
> same Jedec ID information. { "s25fl512s",  INFO(0x010220, 0x4d00, 256
> * 1024, 256, ....}
> 
> But as stated earlier, if I skip reading SFDP or read using 1-1-1
> protocol then read are always correct. For 1-4-4 protocol read are
> wrong and on further debugging found that Read code of 0x6C is being
> send as opcode instead of 0xEC.
> 
> If I revert this patch, reads are working fine.

Can you try with the following patch?

Also, can you add a trace to check whether you're reaching this point
[1] or not.

[1]https://elixir.bootlin.com/linux/v4.19-rc8/source/drivers/mtd/spi-nor/spi-nor.c#L2227

--->8---
diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 9407ca5f9443..49278c1491a6 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -2643,6 +2643,8 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
                break;
 
        case BFPT_DWORD1_ADDRESS_BYTES_4_ONLY:
+       case BFPT_DWORD1_ADDRESS_BYTES_3_OR_4:
+               nor->flags |= SNOR_F_4B_OPCODES;
                nor->addr_width = 4;
                break;
 
@@ -3552,7 +3554,7 @@ static int spi_nor_init(struct spi_nor *nor)
 
        if ((nor->addr_width == 4) &&
            (JEDEC_MFR(nor->info) != SNOR_MFR_SPANSION) &&
-           !(nor->info->flags & SPI_NOR_4B_OPCODES)) {
+           !(nor->flags & SNOR_F_4B_OPCODES)) {
                /*
                 * If the RESET# pin isn't hooked up properly, or the system
                 * otherwise doesn't perform a reset command in the boot
@@ -3586,7 +3588,7 @@ void spi_nor_restore(struct spi_nor *nor)
        /* restore the addressing mode */
        if ((nor->addr_width == 4) &&
            (JEDEC_MFR(nor->info) != SNOR_MFR_SPANSION) &&
-           !(nor->info->flags & SPI_NOR_4B_OPCODES) &&
+           !(nor->flags & SNOR_F_4B_OPCODES) &&
            (nor->flags & SNOR_F_BROKEN_RESET))
                set_4byte(nor, nor->info, 0);
 }
@@ -3724,6 +3726,9 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
        if (info->flags & SPI_NOR_NO_FR)
                params.hwcaps.mask &= ~SNOR_HWCAPS_READ_FAST;
 
+       if (info->flags & SPI_NOR_4B_OPCODES)
+               nor->flags |= SNOR_F_4B_OPCODES;
+
        /*
         * Configure the SPI memory:
         * - select op codes for (Fast) Read, Page Program and Sector Erase.
@@ -3742,13 +3747,16 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
        } else if (mtd->size > 0x1000000) {
                /* enable 4-byte addressing if the device exceeds 16MiB */
                nor->addr_width = 4;
-               if (JEDEC_MFR(info) == SNOR_MFR_SPANSION ||
-                   info->flags & SPI_NOR_4B_OPCODES)
-                       spi_nor_set_4byte_opcodes(nor, info);
+               if (JEDEC_MFR(info) == SNOR_MFR_SPANSION)
+                       nor->flags |= SNOR_F_4B_OPCODES;
        } else {
                nor->addr_width = 3;
        }
 
+       if (info->addr_width == 4 &&
+           nor->flags & SNOR_F_4B_OPCODES)
+               spi_nor_set_4byte_opcodes(nor, info);
+
        if (nor->addr_width > SPI_NOR_MAX_ADDR_WIDTH) {
                dev_err(dev, "address width is too large: %u\n",
                        nor->addr_width);
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 7f0c7303575e..4ffb165f4f85 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -236,6 +236,7 @@ enum spi_nor_option_flags {
        SNOR_F_READY_XSR_RDY    = BIT(4),
        SNOR_F_USE_CLSR         = BIT(5),
        SNOR_F_BROKEN_RESET     = BIT(6),
+       SNOR_F_4B_OPCODES       = BIT(7)
 };
 
 /**
