From: yogeshnarayan.gaur@nxp.com (Yogesh Narayan Gaur)
Date: Tue, 23 Oct 2018 08:18:35 +0000
Subject: [PATCH v3 1/2] mtd: spi-nor: add support to non-uniform SFDP SPI
 NOR flash memories
In-Reply-To: <20181023073946.138b287e@bbrezillon>
References: <20180911154007.17195-1-tudor.ambarus@microchip.com>
 <20181017091045.124e0266@bbrezillon>	<20181017092941.3658bd9a@bbrezillon>
 <VI1PR04MB1038EFA1E83AD78EBE84ECC499FF0@VI1PR04MB1038.eurprd04.prod.outlook.com>
 <20181017115237.07310b74@bbrezillon>
 <VI1PR04MB1038BD6103DD8BD6B6DEC2B899F40@VI1PR04MB1038.eurprd04.prod.outlook.com>
 <20181022111543.2a607efc@bbrezillon>
 <VI1PR04MB1038EF892921194D1BFDE6FC99F40@VI1PR04MB1038.eurprd04.prod.outlook.com>
 <20181022122659.0675942e@bbrezillon>
 <VI1PR04MB1038E92FFAB03E07048FD8B499F40@VI1PR04MB1038.eurprd04.prod.outlook.com>
 <20181022124627.2c6c3b93@bbrezillon>	<20181022125259.42df83ea@bbrezillon>
 <VI1PR04MB1038C9C889185F2A700220F299F40@VI1PR04MB1038.eurprd04.prod.outlook.com>
 <20181022134324.2c1bd248@bbrezillon>
 <VI1PR04MB1038E072BFFD09C7C19AD2F899F40@VI1PR04MB1038.eurprd04.prod.outlook.com>
 <20181022135211.1978c25d@bbrezillon>
 <VI1PR04MB1038B9A5A8C59E6CB0863FF599F50@VI1PR04MB1038.eurprd04.prod.outlook.com>
 <20181023073946.138b287e@bbrezillon>
Message-ID: <VI1PR04MB10381C2DC4052E636BA26ADA99F50@VI1PR04MB1038.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI,

> -----Original Message-----
> From: Boris Brezillon [mailto:boris.brezillon at bootlin.com]
> Sent: Tuesday, October 23, 2018 11:10 AM
> To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> Cc: Cristian.Birsan at microchip.com; Tudor Ambarus
> <tudor.ambarus@microchip.com>; richard at nod.at; Mark Brown
> <broonie@kernel.org>; linux-kernel at vger.kernel.org;
> nicolas.ferre at microchip.com; marek.vasut at gmail.com;
> cyrille.pitchen at microchip.com; linux-mtd at lists.infradead.org; Cyrille Pitchen
> <cyrille.pitchen@wedev4u.fr>; computersforpeace at gmail.com;
> dwmw2 at infradead.org; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH v3 1/2] mtd: spi-nor: add support to non-uniform SFDP SPI
> NOR flash memories
> 
> On Tue, 23 Oct 2018 04:47:33 +0000
> Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:
> 
> > Hi,
> >
> > > -----Original Message-----
[....]
> 
> Ok, so now the opcode and address are matching the values in the spec.
> Can you check what's sent to the SPI controller side (in your
> ->exec_op() implementation), just to make sure the m25p80 propagates
> the information correctly? When you do that, make sure you also print the
> buswidth of each element (op->cmd.buswidth, op->addr.buswidth,
> op->dummy.buswidth and op->data.buswidth).
> 
> Can you also print the read_data_mask value here.

I have added the prints in m25p80_read() and in flexspi controller prepare_lut and read_rxfifo() func.
In these have added prints for data variable of struct op and data which being read by the controller from the flash.

[    2.091467] smpt[0]=[addr_width:00000003, read_dumy:00000008, read_opcode:00000065, data_mask:00000008]          
[    2.099113] m25p80_read, nor[op:00000065 addr_width:00000003, dummy:00000008, len:00000001                       
[    2.107367] m25p80_read, cmd[opcode:65 bwidth:1] aadr[val:4, nbytes:3, bwidth:1]                                 
[    2.114753] m25p80_read, dummy[nbytes:1 bwidth:1] data[bwidth:1, nbytes:1]                                       
[    2.121706] nxp_fspi_prepare_lut cmd[opcode:65 bwidth:1] aadr[val:4, nbytes:3, bwidth:1]                         
[    2.129786] dummy[nbytes:1 bwidth:1] data[dir:0 bwidth:1, nbytes:1]                                              
[    2.136132] nxp-fspi 20c0000.flexspi: CMD[65] lutval[0:8180465        1:24003008      2:0     3:0]               
[    2.144223] nxp_fspi_read_rxfifo, ReadData op.buf[0x00]                                         
[    2.151004] smpt_read[1] addr[00000004], data_byte[00000000] err:00000000   

                                                  
[    2.157782] smpt[2]=[addr_width:00000003, read_dumy:00000008, read_opcode:00000065, data_mask:00000004]  
[    2.165429] m25p80_read, nor[op:00000065 addr_width:00000003, dummy:00000008, len:00000001                 
[    2.173683] m25p80_read, cmd[opcode:65 bwidth:1] aadr[val:2, nbytes:3, bwidth:1]                       
[    2.181068] m25p80_read, dummy[nbytes:1 bwidth:1] data[bwidth:1, nbytes:1]                                     
[    2.188021] nxp_fspi_prepare_lut cmd[opcode:65 bwidth:1] aadr[val:2, nbytes:3, bwidth:1]                   
[    2.196101] dummy[nbytes:1 bwidth:1] data[dir:0 bwidth:1, nbytes:1]                   
[    2.202447] nxp-fspi 20c0000.flexspi: CMD[65] lutval[0:8180465        1:24003008      2:0     3:0]       
[    2.210539] nxp_fspi_read_rxfifo, ReadData op.buf[0x02]                            
[    2.217319] smpt_read[3] addr[00000002], data_byte[00000002] err:00000000                                                     


[    2.224098] smpt[4]=[addr_width:00000003, read_dumy:00000008, read_opcode:00000065, data_mask:00000002]                 
[    2.231744] m25p80_read, nor[op:00000065 addr_width:00000003, dummy:00000008, len:00000001              
[    2.239998] m25p80_read, cmd[opcode:65 bwidth:1] aadr[val:4, nbytes:3, bwidth:1]                     
[    2.247383] m25p80_read, dummy[nbytes:1 bwidth:1] data[bwidth:1, nbytes:1]                     
[    2.254336] nxp_fspi_prepare_lut cmd[opcode:65 bwidth:1] aadr[val:4, nbytes:3, bwidth:1]            
[    2.262416] dummy[nbytes:1 bwidth:1] data[dir:0 bwidth:1, nbytes:1]                                    
[    2.268762] nxp-fspi 20c0000.flexspi: CMD[65] lutval[0:8180465        1:24003008      2:0     3:0]         
[    2.276854] nxp_fspi_read_rxfifo, ReadData op.buf[0x00]                                     
[    2.283634] smpt_read[5] addr[00000004], data_byte[00000000] err:00000000                 


[    2.290412] spi_nor_get_map_in_use:2915 map_id=0 smpt_len:16 i=:6                                                             
[    2.296496] End [addr_width:00000003, read_dumy:00000008, read_opcode:00000065] ReturnVal:00000000                            
[    2.305444] spi_nor_parse_smpt:3065                                                                                           
[    2.308924] m25p80 spi0.0: failed to parse SMPT (err = -22)                                      


> 
> Next thing you can do is read the CR2NV reg (using the RDAR command) and
> check the RL (Read Latency) and AL (Address Length) values.

Please let me know how to read CR2NV register.

--
Regards,
Yogesh Gaur

> 
> > [    1.767710] spi_nor_get_map_in_use:2915 map_id=0 smpt_len:16 i=:6
> > [    1.773794] End [addr_width:00000003, read_dumy:00000008,
> read_opcode:00000065] ReturnVal:00000000
> > [    1.781092] spi_nor_parse_smpt:3065
> > [    1.784573] m25p80 spi0.0: failed to parse SMPT (err = -22)
> > [    1.790153] m25p80 spi0.0: s25fl512s (65536 Kbytes)
> >
> >
> > Code:
> >         for (i = 0; i< smpt_len; i+=2) {
> >                 if ((smpt[i] & SMPT_DESC_TYPE_MAP))
> >                         break;
> >
> >                 read_data_mask = SMPT_CMD_READ_DATA(smpt[i]);
> >                 nor->addr_width = spi_nor_smpt_addr_width(nor, smpt[i]);
> >                 if (!nor->addr_width)
> >                         nor->addr_width = 3;
> >
> >                 nor->read_dummy = 8;
> >                 nor->read_opcode = SMPT_CMD_OPCODE(smpt[i]);
> >                 pr_info("smpt[%d]=[addr_width:%08x, read_dumy:%08x,
> > read_opcode:%08x]\n", i, nor->addr_width, nor->read_dummy,
> > nor->read_opcode);
> >
> >                 addr = smpt[i + 1];
> >
> >                 err = spi_nor_read_raw(nor, addr, 1, &data_byte);
> >                 pr_info("smpt_read[%d] addr[%08x], data_byte[%08x] err:%08x\n",
> (i+1), addr, data_byte, err);
> >                 if (err)
> >                         goto out;
> >
> >                 /*
> >                  * Build an index value that is used to select the Sector Map
> >                  * Configuration that is currently in use.
> >                  */
> >                 map_id = map_id << 1 | !!(data_byte & read_data_mask);
> >                 map_id_is_valid = true;
> >         }
> >
> >         if (map_id_is_valid)
> >                 pr_info("%s:%i map_id=%d smpt_len:%d i=:%d\n", __func__,
> __LINE__, map_id, smpt_len, i);
> >         else
> >                 pr_info("%s:%i NO map_id\n", __func__, __LINE__);
> >
> >         for (nmaps = 0; i< smpt_len; nmaps++) {
> >                 if(!(smpt[i] & SMPT_DESC_TYPE_MAP)) {
> >                         i += 2;
> >                         continue;
> >                 }
> >
> >                 if(!map_id_is_valid) {
> >                         if (nmaps) {
> >                                 ret = NULL;
> >                                 break;
> >                         }
> >
> >                         ret = smpt+i;
> >                 } else if (map_id == SMPT_MAP_ID(smpt[i])) {
> >                         ret = smpt+i;
> >                         break;
> >                 }
> >
> >                 /* increment the table index to the next map */
> >                 i += SMPT_MAP_REGION_COUNT(smpt[i]) + 1;
> >         }
> >
> >         pr_info("End [addr_width:%08x, read_dumy:%08x,
> > read_opcode:%08x] ReturnVal:%08x\n", nor->addr_width, nor->read_dummy,
> > nor->read_opcode, ret);
> >
> > --
> > Thanks
> > Yogesh Gaur.
> >
> > > Thanks,
> > >
> > > Boris
