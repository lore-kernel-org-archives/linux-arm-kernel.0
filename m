From: yogeshnarayan.gaur@nxp.com (Yogesh Narayan Gaur)
Date: Mon, 22 Oct 2018 11:03:09 +0000
Subject: [PATCH v3 1/2] mtd: spi-nor: add support to non-uniform SFDP SPI
 NOR flash memories
In-Reply-To: <20181022125259.42df83ea@bbrezillon>
References: <20180911154007.17195-1-tudor.ambarus@microchip.com>
 <20180911154007.17195-2-tudor.ambarus@microchip.com>
 <VI1PR04MB103888BC18F3C5AD0C02DEF699FE0@VI1PR04MB1038.eurprd04.prod.outlook.com>
 <31a8f6a9-1459-443a-6ef8-2b2c17769ae4@microchip.com>
 <de0f7245-2557-12be-a306-67b08e55ae7b@wedev4u.fr>
 <VI1PR04MB1038AB25EABDC8507984ADC799FF0@VI1PR04MB1038.eurprd04.prod.outlook.com>
 <20181017090724.12f2cd79@bbrezillon>	<20181017091045.124e0266@bbrezillon>
 <20181017092941.3658bd9a@bbrezillon>
 <VI1PR04MB1038EFA1E83AD78EBE84ECC499FF0@VI1PR04MB1038.eurprd04.prod.outlook.com>
 <20181017115237.07310b74@bbrezillon>
 <VI1PR04MB1038BD6103DD8BD6B6DEC2B899F40@VI1PR04MB1038.eurprd04.prod.outlook.com>
 <20181022111543.2a607efc@bbrezillon>
 <VI1PR04MB1038EF892921194D1BFDE6FC99F40@VI1PR04MB1038.eurprd04.prod.outlook.com>
 <20181022122659.0675942e@bbrezillon>
 <VI1PR04MB1038E92FFAB03E07048FD8B499F40@VI1PR04MB1038.eurprd04.prod.outlook.com>
 <20181022124627.2c6c3b93@bbrezillon> <20181022125259.42df83ea@bbrezillon>
Message-ID: <VI1PR04MB1038C9C889185F2A700220F299F40@VI1PR04MB1038.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> -----Original Message-----
> From: Boris Brezillon [mailto:boris.brezillon at bootlin.com]
> Sent: Monday, October 22, 2018 4:23 PM
> To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>;
> Cristian.Birsan at microchip.com
> Cc: Tudor Ambarus <tudor.ambarus@microchip.com>; richard at nod.at; Mark
> Brown <broonie@kernel.org>; linux-kernel at vger.kernel.org;
> nicolas.ferre at microchip.com; marek.vasut at gmail.com;
> cyrille.pitchen at microchip.com; linux-mtd at lists.infradead.org; Cyrille Pitchen
> <cyrille.pitchen@wedev4u.fr>; computersforpeace at gmail.com;
> dwmw2 at infradead.org; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH v3 1/2] mtd: spi-nor: add support to non-uniform SFDP SPI
> NOR flash memories
> 
> On Mon, 22 Oct 2018 12:46:27 +0200
> Boris Brezillon <boris.brezillon@bootlin.com> wrote:
> 
> > On Mon, 22 Oct 2018 10:39:48 +0000
> > Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:
> >
> > >
> > > [    1.632190] Start [addr_width:00000000, read_dumy:08,
> read_opcode:00000000]
> > > [    1.639148] spi_nor_get_map_in_use:2882 smpt[0]=08ff65fc
> > > [    1.644451] spi_nor_get_map_in_use:2882 smpt[1]=00000004
> > > [    1.649755] spi_nor_get_map_in_use:2882 smpt[2]=04ff65fc
> > > [    1.655057] spi_nor_get_map_in_use:2882 smpt[3]=00000002
> > > [    1.660360] spi_nor_get_map_in_use:2882 smpt[4]=02ff65fd
> > > [    1.665662] spi_nor_get_map_in_use:2882 smpt[5]=00000004
> > > [    1.670965] spi_nor_get_map_in_use:2882 smpt[6]=ff0201fe
> > > [    1.676267] spi_nor_get_map_in_use:2882 smpt[7]=00007ff1
> > > [    1.681571] spi_nor_get_map_in_use:2882 smpt[8]=00037ff4
> > > [    1.686874] spi_nor_get_map_in_use:2882 smpt[9]=03fbfff4
> > > [    1.692176] spi_nor_get_map_in_use:2882 smpt[10]=ff0203fe
> > > [    1.697566] spi_nor_get_map_in_use:2882 smpt[11]=03fbfff4
> > > [    1.702954] spi_nor_get_map_in_use:2882 smpt[12]=00037ff4
> > > [    1.708343] spi_nor_get_map_in_use:2882 smpt[13]=00007ff1
> > > [    1.713732] spi_nor_get_map_in_use:2882 smpt[14]=ff0005ff
> > > [    1.719120] spi_nor_get_map_in_use:2882 smpt[15]=03fffff4
> > > [    1.724509] smpt[0]=[addr_width:00000000, read_dumy:08,
> read_opcode:00000065]
> > > [    1.731650] smpt[1]=[addr_width:00000000, read_dumy:08,
> read_opcode:00000000]
> > > [    1.738791] smpt[2]=[addr_width:00000000, read_dumy:08,
> read_opcode:00000065]
> >
> > You still don't print read_dummy correctly: %0x8 -> %08x.
> >
> > Can you add
> >
> > 	if (!nor->addr_width)
> > 		nor->addr_width = 3;
> >
> > After the
> >
> > 	nor->addr_width = spi_nor_smpt_addr_width(nor, smpt[i]);
> >
> > line.
> 
> And you should also try to force ->read_dummy to 8, because according to the
> spec, the default read_latency is 8 for this chip. With that in place, you should
> get an map_id of 1, 3 or 5.
> 

Below is the log output.
I have forced the read_dummy as 8 and addr_width is programmed as 3.

[    1.625176] m25p80 spi0.0: found s25fl512s, expected m25p80                                                                   
[    1.630875] Start [addr_width:00000000, read_dumy:00000000, read_opcode:00000000]                                             
[    1.638352] spi_nor_get_map_in_use:2882 smpt[0]=08ff65fc                                                                      
[    1.643658] spi_nor_get_map_in_use:2882 smpt[1]=00000004                                                                      
[    1.648963] spi_nor_get_map_in_use:2882 smpt[2]=04ff65fc                                                                      
[    1.654266] spi_nor_get_map_in_use:2882 smpt[3]=00000002                                                                      
[    1.659569] spi_nor_get_map_in_use:2882 smpt[4]=02ff65fd                                                                      
[    1.664872] spi_nor_get_map_in_use:2882 smpt[5]=00000004                                                                      
[    1.670175] spi_nor_get_map_in_use:2882 smpt[6]=ff0201fe                                                                      
[    1.675477] spi_nor_get_map_in_use:2882 smpt[7]=00007ff1                                                                      
[    1.680782] spi_nor_get_map_in_use:2882 smpt[8]=00037ff4                                                                      
[    1.686084] spi_nor_get_map_in_use:2882 smpt[9]=03fbfff4                                                                      
[    1.691391] spi_nor_get_map_in_use:2882 smpt[10]=ff0203fe                                                                     
[    1.696782] spi_nor_get_map_in_use:2882 smpt[11]=03fbfff4                                                                     
[    1.702171] spi_nor_get_map_in_use:2882 smpt[12]=00037ff4                                                                     
[    1.707561] spi_nor_get_map_in_use:2882 smpt[13]=00007ff1                                                                     
[    1.712951] spi_nor_get_map_in_use:2882 smpt[14]=ff0005ff                                                                     
[    1.718340] spi_nor_get_map_in_use:2882 smpt[15]=03fffff4                                                                     
[    1.723731] smpt[0]=[addr_width:00000003, read_dumy:00000008, read_opcode:00000065]                                           
[    1.731393] smpt[1]=[addr_width:00000003, read_dumy:00000008, read_opcode:00000000]                                           
[    1.739056] smpt[2]=[addr_width:00000003, read_dumy:00000008, read_opcode:00000065]                                           
[    1.746721] spi_nor_get_map_in_use:2914 map_id=0 smpt_len:16 i=:3                                                             
[    1.752807] End [addr_width:00000003, read_dumy:00000008, read_opcode:00000065]                                               
[    1.760125] m25p80 spi0.0: s25fl512s (65536 Kbytes)  

                read_data_mask = SMPT_CMD_READ_DATA(smpt[i]);
                nor->addr_width = spi_nor_smpt_addr_width(nor, smpt[i]);
                if (!nor->addr_width)
                        nor->addr_width = 3;

                nor->read_dummy = 8; 
                nor->read_opcode = SMPT_CMD_OPCODE(smpt[i]);
                pr_info("smpt[%d]=[addr_width:%08x, read_dumy:%08x, read_opcode:%08x]\n", i, nor->addr_width, nor->read_dummy, nor->read_opcode);

                addr = smpt[i + 1];

                err = spi_nor_read_raw(nor, addr, 1, &data_byte);
                if (err)
                        goto out;

--
Regards
Yogesh Gaur.

> >
> > > [    1.745932] spi_nor_get_map_in_use:2911 map_id=0 smpt_len:16 i=:3
> > > [    1.752018] End [addr_width:00000000, read_dumy:08,
> read_opcode:00000065]
> > >
> > > Also, one more thing when we are returning from the function, we are over-
> writing the values of addr_widthm read_dummy and read_opcode.
> > > Is this correct?
> >
> > Yes, that's correct.
> >
> > >
> > > out:
> > >         nor->addr_width = addr_width;
> > >         nor->read_dummy = read_dummy;
> > >         nor->read_opcode = read_opcode;
> > >         return ret;
> > > }
> > >
> >
> >
