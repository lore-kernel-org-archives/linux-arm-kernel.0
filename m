From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Tue, 23 Oct 2018 10:48:27 +0200
Subject: [PATCH v3 1/2] mtd: spi-nor: add support to non-uniform SFDP
 SPI NOR flash memories
In-Reply-To: <VI1PR04MB10381C2DC4052E636BA26ADA99F50@VI1PR04MB1038.eurprd04.prod.outlook.com>
References: <20180911154007.17195-1-tudor.ambarus@microchip.com>
 <20181017115237.07310b74@bbrezillon>
 <VI1PR04MB1038BD6103DD8BD6B6DEC2B899F40@VI1PR04MB1038.eurprd04.prod.outlook.com>
 <20181022111543.2a607efc@bbrezillon>
 <VI1PR04MB1038EF892921194D1BFDE6FC99F40@VI1PR04MB1038.eurprd04.prod.outlook.com>
 <20181022122659.0675942e@bbrezillon>
 <VI1PR04MB1038E92FFAB03E07048FD8B499F40@VI1PR04MB1038.eurprd04.prod.outlook.com>
 <20181022124627.2c6c3b93@bbrezillon>
 <20181022125259.42df83ea@bbrezillon>
 <VI1PR04MB1038C9C889185F2A700220F299F40@VI1PR04MB1038.eurprd04.prod.outlook.com>
 <20181022134324.2c1bd248@bbrezillon>
 <VI1PR04MB1038E072BFFD09C7C19AD2F899F40@VI1PR04MB1038.eurprd04.prod.outlook.com>
 <20181022135211.1978c25d@bbrezillon>
 <VI1PR04MB1038B9A5A8C59E6CB0863FF599F50@VI1PR04MB1038.eurprd04.prod.outlook.com>
 <20181023073946.138b287e@bbrezillon>
 <VI1PR04MB10381C2DC4052E636BA26ADA99F50@VI1PR04MB1038.eurprd04.prod.outlook.com>
Message-ID: <20181023104827.77e7775b@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 23 Oct 2018 08:18:35 +0000
Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:

> 
> I have added the prints in m25p80_read() and in flexspi controller prepare_lut and read_rxfifo() func.
> In these have added prints for data variable of struct op and data which being read by the controller from the flash.
> 
> [    2.091467] smpt[0]=[addr_width:00000003, read_dumy:00000008, read_opcode:00000065, data_mask:00000008]          
> [    2.099113] m25p80_read, nor[op:00000065 addr_width:00000003, dummy:00000008, len:00000001                       
> [    2.107367] m25p80_read, cmd[opcode:65 bwidth:1] aadr[val:4, nbytes:3, bwidth:1]                                 
> [    2.114753] m25p80_read, dummy[nbytes:1 bwidth:1] data[bwidth:1, nbytes:1]                                       
> [    2.121706] nxp_fspi_prepare_lut cmd[opcode:65 bwidth:1] aadr[val:4, nbytes:3, bwidth:1]                         
> [    2.129786] dummy[nbytes:1 bwidth:1] data[dir:0 bwidth:1, nbytes:1]                                              
> [    2.136132] nxp-fspi 20c0000.flexspi: CMD[65] lutval[0:8180465        1:24003008      2:0     3:0]               
> [    2.144223] nxp_fspi_read_rxfifo, ReadData op.buf[0x00]                                         
> [    2.151004] smpt_read[1] addr[00000004], data_byte[00000000] err:00000000   
> 
>                                                   
> [    2.157782] smpt[2]=[addr_width:00000003, read_dumy:00000008, read_opcode:00000065, data_mask:00000004]  
> [    2.165429] m25p80_read, nor[op:00000065 addr_width:00000003, dummy:00000008, len:00000001                 
> [    2.173683] m25p80_read, cmd[opcode:65 bwidth:1] aadr[val:2, nbytes:3, bwidth:1]                       
> [    2.181068] m25p80_read, dummy[nbytes:1 bwidth:1] data[bwidth:1, nbytes:1]                                     
> [    2.188021] nxp_fspi_prepare_lut cmd[opcode:65 bwidth:1] aadr[val:2, nbytes:3, bwidth:1]                   
> [    2.196101] dummy[nbytes:1 bwidth:1] data[dir:0 bwidth:1, nbytes:1]                   
> [    2.202447] nxp-fspi 20c0000.flexspi: CMD[65] lutval[0:8180465        1:24003008      2:0     3:0]       
> [    2.210539] nxp_fspi_read_rxfifo, ReadData op.buf[0x02]                            
> [    2.217319] smpt_read[3] addr[00000002], data_byte[00000002] err:00000000                                                     
> 
> 
> [    2.224098] smpt[4]=[addr_width:00000003, read_dumy:00000008, read_opcode:00000065, data_mask:00000002]                 
> [    2.231744] m25p80_read, nor[op:00000065 addr_width:00000003, dummy:00000008, len:00000001              
> [    2.239998] m25p80_read, cmd[opcode:65 bwidth:1] aadr[val:4, nbytes:3, bwidth:1]                     
> [    2.247383] m25p80_read, dummy[nbytes:1 bwidth:1] data[bwidth:1, nbytes:1]                     
> [    2.254336] nxp_fspi_prepare_lut cmd[opcode:65 bwidth:1] aadr[val:4, nbytes:3, bwidth:1]            
> [    2.262416] dummy[nbytes:1 bwidth:1] data[dir:0 bwidth:1, nbytes:1]                                    
> [    2.268762] nxp-fspi 20c0000.flexspi: CMD[65] lutval[0:8180465        1:24003008      2:0     3:0]         
> [    2.276854] nxp_fspi_read_rxfifo, ReadData op.buf[0x00]                                     
> [    2.283634] smpt_read[5] addr[00000004], data_byte[00000000] err:00000000                 
> 
> 
> [    2.290412] spi_nor_get_map_in_use:2915 map_id=0 smpt_len:16 i=:6                                                             
> [    2.296496] End [addr_width:00000003, read_dumy:00000008, read_opcode:00000065] ReturnVal:00000000                            
> [    2.305444] spi_nor_parse_smpt:3065                                                                                           
> [    2.308924] m25p80 spi0.0: failed to parse SMPT (err = -22)                                      
> 
> 
> > 
> > Next thing you can do is read the CR2NV reg (using the RDAR command) and
> > check the RL (Read Latency) and AL (Address Length) values.  
> 
> Please let me know how to read CR2NV register.

Actually, RDAR is already what you use to read the map_id, and we need
to use it to read the register that contains the number of dummy cycles
and the number of address bytes to use for RDAR operations. Looks like
we have a chicken and egg situation here :-).

Let's try something else:

1/ create an u8 array of 16 entries named data_bytes

for each loop iteration (the first for loop):
2/ set ->addr_width to 3 and ->read_dummy to 0
3/ call spi_nor_read_raw(nor, addr, ARRAY_SIZE(data_bytes), data_bytes)
4/ dump the data_bytes buf
5/ set ->addr_width to 4
6/ call spi_nor_read_raw(nor, addr, ARRAY_SIZE(data_bytes), data_bytes)
7/ dump the data_bytes buf
   
If the SPI driver is working correctly, we should be able to figure out
the right value for ->addr_width and ->read_dummy.

Thanks,

Boris
