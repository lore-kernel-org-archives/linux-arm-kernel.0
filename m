From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Mon, 22 Oct 2018 12:25:16 +0200
Subject: [PATCH v3 1/2] mtd: spi-nor: add support to non-uniform SFDP
 SPI NOR flash memories
In-Reply-To: <VI1PR04MB10383A3C1381532DF0C18F8699F40@VI1PR04MB1038.eurprd04.prod.outlook.com>
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
 <20181022121044.24039f40@bbrezillon>
 <VI1PR04MB10383A3C1381532DF0C18F8699F40@VI1PR04MB1038.eurprd04.prod.outlook.com>
Message-ID: <20181022122516.24ff2dae@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 22 Oct 2018 10:17:58 +0000
Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:

> It works,

Not really.

> [    1.628162] m25p80 spi0.0: found s25fl512s, expected m25p80                                                                   
> [    1.633854] Start [addr_width:00000000, read_dumy:08, read_opcode:00000000]                                                   
> [    1.640811] spi_nor_get_map_in_use:2882 smpt[0]=08ff65fc                                                                      
> [    1.646117] spi_nor_get_map_in_use:2882 smpt[1]=00000004                                                                      
> [    1.651421] spi_nor_get_map_in_use:2882 smpt[2]=04ff65fc                                                                      
> [    1.656724] spi_nor_get_map_in_use:2882 smpt[3]=00000002                                                                      
> [    1.662028] spi_nor_get_map_in_use:2882 smpt[4]=02ff65fd                                                                      
> [    1.667331] spi_nor_get_map_in_use:2882 smpt[5]=00000004                                                                      
> [    1.672635] spi_nor_get_map_in_use:2882 smpt[6]=ff0201fe                                                                      
> [    1.677937] spi_nor_get_map_in_use:2882 smpt[7]=00007ff1                                                                      
> [    1.683240] spi_nor_get_map_in_use:2882 smpt[8]=00037ff4                                                                      
> [    1.688542] spi_nor_get_map_in_use:2882 smpt[9]=03fbfff4                                                                      
> [    1.693845] spi_nor_get_map_in_use:2882 smpt[10]=ff0203fe                                                                     
> [    1.699234] spi_nor_get_map_in_use:2882 smpt[11]=03fbfff4                                                                     
> [    1.704625] spi_nor_get_map_in_use:2882 smpt[12]=00037ff4                                                                     
> [    1.710014] spi_nor_get_map_in_use:2882 smpt[13]=00007ff1                                                                     
> [    1.715403] spi_nor_get_map_in_use:2882 smpt[14]=ff0005ff                                                                     
> [    1.720791] spi_nor_get_map_in_use:2882 smpt[15]=03fffff4                                                                     
> [    1.726180] smpt[0]=[addr_width:00000000, read_dumy:08, read_opcode:00000065]

There's still a problem here: you should see this trace 3 times since
we have 3 command descriptors. And of course, the addr_width and
read_dummy are wrong.

> [    1.733320] spi_nor_get_map_in_use:2912 map_id=0 smpt_len:16 i=:3                                                             
> [    1.739406] End [addr_width:00000000, read_dumy:08, read_opcode:00000065]                                                     
> [    1.746204] m25p80 spi0.0: s25fl512s (65536 Kbytes)                        
