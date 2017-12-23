From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 23 Dec 2017 18:14:18 +0100
Subject: [PATCH 00/12] Marvell NAND controller rework with ->exec_op()
In-Reply-To: <20171223155709.2ba16e95@xps13> (Miquel RAYNAL's message of "Sat,
 23 Dec 2017 15:57:09 +0100")
References: <20171207201814.30411-1-miquel.raynal@free-electrons.com>
 <20171214070930.0b885f6d@bbrezillon> <877etkecig.fsf@belgarion.home>
 <20171218092535.2ca1fe13@xps13> <87y3lxccr7.fsf@belgarion.home>
 <20171220224121.2cb6f690@bbrezillon> <87lghucykr.fsf@belgarion.home>
 <20171222222441.0fd77df9@bbrezillon> <20171222233730.68d9cb9d@xps13>
 <87k1xdblxf.fsf@belgarion.home> <20171223155709.2ba16e95@xps13>
Message-ID: <87fu81bc45.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Miquel RAYNAL <miquel.raynal@free-electrons.com> writes:

>> Here it comes in [3]. I suspect the BBT parser here, here is the
>> extract that _might_ be relevant:
>> [    3.372907] nand: ->exec_op() parser: pattern not found!
>
> Indeed this might be the problem, it means there is one scenario that
> should be handled by the parser that is missing. I am really
> interrogative about which one it is and to discover it, can you rebuild
> with
>
>         #define DEBUG
>
> in drivers/mtd/nand/nand_base.c too.
It was already there, check the patch I attached to my previous mail.

> This way the core will display the patterns it try to find a match for.
The core displays already debug message, as these are displayed :
[    3.228598] nand: executing subop:
[    3.232187] nand:     ->CMD      [0x90]
[    3.236077] nand:     ->ADDR     [1 cyc: 40]
[    3.240517] nand:     ->DATA_IN  [5 B, force 8-bit]

As to your statement "the core will display the patterns it try to find a match
for", how confident are you with it ? Because my reading of the following code
is quite different :
			if (!nand_op_parser_match_pat(pattern, &ctx))
				continue;

			nand_op_parser_trace(&ctx);

> Also to ease the understanding, you might add a dump_stack() right
> next to this error message.
Attached in [1].

>> information, ie. platform_data, ECC and BBT settings (ie. the
>> "MBBbt0" pattern).
>
> This is probably a typo, because we expect the pattern to be "MVBbt0"?
Right, it's a typo.

Cheers.

-- 
Robert

[1] DMesg extract
[    3.053528] console [ttyS0] enabled
[    3.059893] pxa2xx-uart.1: ttyS1 at MMIO 0x40200000 (irq = 37, base_baud = 928571) is a UART2
[    3.072771] pxa2xx-uart.2: ttyS2 at MMIO 0x40700000 (irq = 36, base_baud = 928571) is a UART3
[    3.088327] nand: executing subop:
[    3.094488] nand:     ->CMD      [0xff]
[    3.098387] nand:     ->WAITRDY  [max 250 ms]
[    3.103543] marvell-nfc pxa3xx-nand: 
[    3.103543] NDCR:  0x90079fff
[    3.103543] NDCB0: 0x00a000ff
[    3.103543] NDCB1: 0x00000000
[    3.103543] NDCB2: 0x00000000
[    3.103543] NDCB3: 0x00000000
[    3.122800] nand: executing subop:
[    3.126272] nand:     ->CMD      [0x90]
[    3.130146] nand:     ->ADDR     [1 cyc: 00]
[    3.134811] nand:     ->DATA_IN  [2 B, force 8-bit]
[    3.139818] marvell-nfc pxa3xx-nand: 
[    3.139818] NDCR:  0x90079fff
[    3.139818] NDCB0: 0x00610090
[    3.139818] NDCB1: 0x00000000
[    3.139818] NDCB2: 0x00000000
[    3.139818] NDCB3: 0x00000000
[    3.158657] nand: executing subop:
[    3.162302] nand:     ->CMD      [0x90]
[    3.166192] nand:     ->ADDR     [1 cyc: 00]
[    3.170494] nand:     ->DATA_IN  [8 B, force 8-bit]
[    3.175607] marvell-nfc pxa3xx-nand: 
[    3.175607] NDCR:  0x90079fff
[    3.175607] NDCB0: 0x00610090
[    3.175607] NDCB1: 0x00000000
[    3.175607] NDCB2: 0x00000000
[    3.175607] NDCB3: 0x00000000
[    3.194281] nand: executing subop:
[    3.197734] nand:     ->CMD      [0x90]
[    3.201757] nand:     ->ADDR     [1 cyc: 20]
[    3.206078] nand:     ->DATA_IN  [4 B, force 8-bit]
[    3.211186] marvell-nfc pxa3xx-nand: 
[    3.211186] NDCR:  0x90079fff
[    3.211186] NDCB0: 0x00610090
[    3.211186] NDCB1: 0x00000020
[    3.211186] NDCB2: 0x00000000
[    3.211186] NDCB3: 0x00000000
[    3.229806] nand: executing subop:
[    3.233396] nand:     ->CMD      [0x90]
[    3.237286] nand:     ->ADDR     [1 cyc: 40]
[    3.241728] nand:     ->DATA_IN  [5 B, force 8-bit]
[    3.246709] marvell-nfc pxa3xx-nand: 
[    3.246709] NDCR:  0x90079fff
[    3.246709] NDCB0: 0x00610090
[    3.246709] NDCB1: 0x00000040
[    3.246709] NDCB2: 0x00000000
[    3.246709] NDCB3: 0x00000000
[    3.265346] nand: device found, Manufacturer ID: 0x20, Chip ID: 0xba
[    3.271858] nand: ST Micro NAND 256MiB 1,8V 16-bit
[    3.276700] nand: 256 MiB, SLC, erase size: 128 KiB, page size: 2048, OOB size: 64
[    3.284428] marvell-nfc pxa3xx-nand: No minimum ECC strength, using 1b/512B
[    3.292092] marvell-nfc pxa3xx-nand: 
[    3.292092] NDCR:  0xdd079fff
[    3.292092] NDCB0: 0x000d3000
[    3.292092] NDCB1: 0xffc00000
[    3.292092] NDCB2: 0x00000001
[    3.292092] NDCB3: 0x00000000
[    3.311481] marvell-nfc pxa3xx-nand: 
[    3.311481] NDCR:  0xdd079fff
[    3.311481] NDCB0: 0x000d3000
[    3.311481] NDCB1: 0xff800000
[    3.311481] NDCB2: 0x00000001
[    3.311481] NDCB3: 0x00000000
[    3.330508] marvell-nfc pxa3xx-nand: 
[    3.330508] NDCR:  0xdd079fff
[    3.330508] NDCB0: 0x000d3000
[    3.330508] NDCB1: 0xff400000
[    3.330508] NDCB2: 0x00000001
[    3.330508] NDCB3: 0x00000000
[    3.349472] CPU: 0 PID: 1 Comm: swapper Not tainted 4.15.0-rc1-00041-g0f3e977 #749
[    3.357225] Hardware name: PXA3xx Platform Development Kit (aka Zylonite)
[    3.364323] [<c0010440>] (unwind_backtrace) from [<c000df94>] (show_stack+0x10/0x14)
[    3.372307] [<c000df94>] (show_stack) from [<c02adb58>] (nand_op_parser_exec_op+0x39c/0x474)
[    3.380966] [<c02adb58>] (nand_op_parser_exec_op) from [<c02ac6b0>] (nand_change_read_column_op+0x134/0x194)
[    3.391038] [<c02ac6b0>] (nand_change_read_column_op) from [<c02b9ac8>] (marvell_nfc_hw_ecc_hmg_read_page+0xd0/0x16c)
[    3.401864] [<c02b9ac8>] (marvell_nfc_hw_ecc_hmg_read_page) from [<c02b25e4>] (nand_do_read_ops+0x200/0x55c)
[    3.411902] [<c02b25e4>] (nand_do_read_ops) from [<c02b29f4>] (nand_read_oob+0xb4/0x3f8)
[    3.420098] [<c02b29f4>] (nand_read_oob) from [<c02a4c54>] (mtd_read_oob+0x60/0x9c)
[    3.427964] [<c02a4c54>] (mtd_read_oob) from [<c02b39a8>] (scan_read+0xa0/0x104)
[    3.435583] [<c02b39a8>] (scan_read) from [<c02b3ba0>] (search_bbt+0x194/0x2b4)
[    3.443116] [<c02b3ba0>] (search_bbt) from [<c02b4cd8>] (nand_default_bbt+0x100/0x640)
[    3.451259] [<c02b4cd8>] (nand_default_bbt) from [<c02af1b0>] (nand_scan_tail+0x990/0xabc)
[    3.459605] [<c02af1b0>] (nand_scan_tail) from [<c02b7e7c>] (marvell_nfc_probe+0x3ac/0x9b8)
[    3.468213] [<c02b7e7c>] (marvell_nfc_probe) from [<c028bb54>] (platform_drv_probe+0x38/0x94)
[    3.476979] [<c028bb54>] (platform_drv_probe) from [<c0289de0>] (driver_probe_device+0x2e8/0x4b4)
[    3.486070] [<c0289de0>] (driver_probe_device) from [<c028a090>] (__driver_attach+0xe4/0x124)
[    3.494809] [<c028a090>] (__driver_attach) from [<c0287e44>] (bus_for_each_dev+0x64/0x94)
[    3.503210] [<c0287e44>] (bus_for_each_dev) from [<c02890b8>] (bus_add_driver+0x198/0x264)
[    3.511702] [<c02890b8>] (bus_add_driver) from [<c028aa50>] (driver_register+0x78/0xf8)
[    3.519790] [<c028aa50>] (driver_register) from [<c00099f8>] (do_one_initcall+0x3c/0x17c)
[    3.528216] [<c00099f8>] (do_one_initcall) from [<c053fd80>] (kernel_init_freeable+0x104/0x1c0)
[    3.537136] [<c053fd80>] (kernel_init_freeable) from [<c0423a38>] (kernel_init+0x8/0xf8)
[    3.545443] [<c0423a38>] (kernel_init) from [<c000a780>] (ret_from_fork+0x14/0x34)
[    3.553175] nand: ->exec_op() parser: pattern not found!
[    3.558743] marvell-nfc pxa3xx-nand: 
[    3.558743] NDCR:  0xdd079fff
[    3.558743] NDCB0: 0x000d3000
[    3.558743] NDCB1: 0xff000000
[    3.558743] NDCB2: 0x00000001
[    3.558743] NDCB3: 0x00000000
[    3.577698] CPU: 0 PID: 1 Comm: swapper Not tainted 4.15.0-rc1-00041-g0f3e977 #749
[    3.585451] Hardware name: PXA3xx Platform Development Kit (aka Zylonite)
[    3.592496] [<c0010440>] (unwind_backtrace) from [<c000df94>] (show_stack+0x10/0x14)
[    3.600325] [<c000df94>] (show_stack) from [<c02adb58>] (nand_op_parser_exec_op+0x39c/0x474)
[    3.608973] [<c02adb58>] (nand_op_parser_exec_op) from [<c02ac6b0>] (nand_change_read_column_op+0x134/0x194)
[    3.619037] [<c02ac6b0>] (nand_change_read_column_op) from [<c02b9ac8>] (marvell_nfc_hw_ecc_hmg_read_page+0xd0/0x16c)
[    3.629869] [<c02b9ac8>] (marvell_nfc_hw_ecc_hmg_read_page) from [<c02b25e4>] (nand_do_read_ops+0x200/0x55c)
[    3.639908] [<c02b25e4>] (nand_do_read_ops) from [<c02b29f4>] (nand_read_oob+0xb4/0x3f8)
[    3.648244] [<c02b29f4>] (nand_read_oob) from [<c02a4c54>] (mtd_read_oob+0x60/0x9c)
[    3.656121] [<c02a4c54>] (mtd_read_oob) from [<c02b39a8>] (scan_read+0xa0/0x104)
[    3.663736] [<c02b39a8>] (scan_read) from [<c02b3ba0>] (search_bbt+0x194/0x2b4)
[    3.671269] [<c02b3ba0>] (search_bbt) from [<c02b4cd8>] (nand_default_bbt+0x100/0x640)
[    3.679266] [<c02b4cd8>] (nand_default_bbt) from [<c02af1b0>] (nand_scan_tail+0x990/0xabc)
[    3.687745] [<c02af1b0>] (nand_scan_tail) from [<c02b7e7c>] (marvell_nfc_probe+0x3ac/0x9b8)
[    3.696354] [<c02b7e7c>] (marvell_nfc_probe) from [<c028bb54>] (platform_drv_probe+0x38/0x94)
[    3.705120] [<c028bb54>] (platform_drv_probe) from [<c0289de0>] (driver_probe_device+0x2e8/0x4b4)
[    3.714214] [<c0289de0>] (driver_probe_device) from [<c028a090>] (__driver_attach+0xe4/0x124)
[    3.722952] [<c028a090>] (__driver_attach) from [<c0287e44>] (bus_for_each_dev+0x64/0x94)
[    3.731353] [<c0287e44>] (bus_for_each_dev) from [<c02890b8>] (bus_add_driver+0x198/0x264)
[    3.739701] [<c02890b8>] (bus_add_driver) from [<c028aa50>] (driver_register+0x78/0xf8)
[    3.747915] [<c028aa50>] (driver_register) from [<c00099f8>] (do_one_initcall+0x3c/0x17c)
[    3.756339] [<c00099f8>] (do_one_initcall) from [<c053fd80>] (kernel_init_freeable+0x104/0x1c0)
[    3.765261] [<c053fd80>] (kernel_init_freeable) from [<c0423a38>] (kernel_init+0x8/0xf8)
[    3.773559] [<c0423a38>] (kernel_init) from [<c000a780>] (ret_from_fork+0x14/0x34)
[    3.781295] nand: ->exec_op() parser: pattern not found!
[    3.786853] marvell-nfc pxa3xx-nand: 
[    3.786853] NDCR:  0xdd079fff
[    3.786853] NDCB0: 0x000d3000
[    3.786853] NDCB1: 0xfec00000
[    3.786853] NDCB2: 0x00000001
[    3.786853] NDCB3: 0x00000000
[    3.805809] CPU: 0 PID: 1 Comm: swapper Not tainted 4.15.0-rc1-00041-g0f3e977 #749
[    3.813560] Hardware name: PXA3xx Platform Development Kit (aka Zylonite)
[    3.820488] [<c0010440>] (unwind_backtrace) from [<c000df94>] (show_stack+0x10/0x14)
[    3.828451] [<c000df94>] (show_stack) from [<c02adb58>] (nand_op_parser_exec_op+0x39c/0x474)
[    3.837106] [<c02adb58>] (nand_op_parser_exec_op) from [<c02ac6b0>] (nand_change_read_column_op+0x134/0x194)
[    3.847177] [<c02ac6b0>] (nand_change_read_column_op) from [<c02b9ac8>] (marvell_nfc_hw_ecc_hmg_read_page+0xd0/0x16c)
[    3.858006] [<c02b9ac8>] (marvell_nfc_hw_ecc_hmg_read_page) from [<c02b25e4>] (nand_do_read_ops+0x200/0x55c)
[    3.868044] [<c02b25e4>] (nand_do_read_ops) from [<c02b29f4>] (nand_read_oob+0xb4/0x3f8)
[    3.876378] [<c02b29f4>] (nand_read_oob) from [<c02a4c54>] (mtd_read_oob+0x60/0x9c)
[    3.884257] [<c02a4c54>] (mtd_read_oob) from [<c02b39a8>] (scan_read+0xa0/0x104)
[    3.891872] [<c02b39a8>] (scan_read) from [<c02b3ba0>] (search_bbt+0x194/0x2b4)
[    3.899261] [<c02b3ba0>] (search_bbt) from [<c02b4cd8>] (nand_default_bbt+0x100/0x640)
[    3.907391] [<c02b4cd8>] (nand_default_bbt) from [<c02af1b0>] (nand_scan_tail+0x990/0xabc)
[    3.915881] [<c02af1b0>] (nand_scan_tail) from [<c02b7e7c>] (marvell_nfc_probe+0x3ac/0x9b8)
[    3.924490] [<c02b7e7c>] (marvell_nfc_probe) from [<c028bb54>] (platform_drv_probe+0x38/0x94)
[    3.933248] [<c028bb54>] (platform_drv_probe) from [<c0289de0>] (driver_probe_device+0x2e8/0x4b4)
[    3.942366] [<c0289de0>] (driver_probe_device) from [<c028a090>] (__driver_attach+0xe4/0x124)
[    3.951113] [<c028a090>] (__driver_attach) from [<c0287e44>] (bus_for_each_dev+0x64/0x94)
[    3.959372] [<c0287e44>] (bus_for_each_dev) from [<c02890b8>] (bus_add_driver+0x198/0x264)
[    3.967847] [<c02890b8>] (bus_add_driver) from [<c028aa50>] (driver_register+0x78/0xf8)
[    3.976073] [<c028aa50>] (driver_register) from [<c00099f8>] (do_one_initcall+0x3c/0x17c)
[    3.984501] [<c00099f8>] (do_one_initcall) from [<c053fd80>] (kernel_init_freeable+0x104/0x1c0)
[    3.993421] [<c053fd80>] (kernel_init_freeable) from [<c0423a38>] (kernel_init+0x8/0xf8)
[    4.001722] [<c0423a38>] (kernel_init) from [<c000a780>] (ret_from_fork+0x14/0x34)
[    4.009319] nand: ->exec_op() parser: pattern not found!
[    4.015007] marvell-nfc pxa3xx-nand: 
[    4.015007] NDCR:  0xdd079fff
[    4.015007] NDCB0: 0x000d3000
[    4.015007] NDCB1: 0xfe800000
[    4.015007] NDCB2: 0x00000001
[    4.015007] NDCB3: 0x00000000
[    4.033976] CPU: 0 PID: 1 Comm: swapper Not tainted 4.15.0-rc1-00041-g0f3e977 #749
[    4.041735] Hardware name: PXA3xx Platform Development Kit (aka Zylonite)
[    4.048659] [<c0010440>] (unwind_backtrace) from [<c000df94>] (show_stack+0x10/0x14)
[    4.056618] [<c000df94>] (show_stack) from [<c02adb58>] (nand_op_parser_exec_op+0x39c/0x474)
[    4.065274] [<c02adb58>] (nand_op_parser_exec_op) from [<c02ac6b0>] (nand_change_read_column_op+0x134/0x194)
[    4.075341] [<c02ac6b0>] (nand_change_read_column_op) from [<c02b9ac8>] (marvell_nfc_hw_ecc_hmg_read_page+0xd0/0x16c)
[    4.086166] [<c02b9ac8>] (marvell_nfc_hw_ecc_hmg_read_page) from [<c02b25e4>] (nand_do_read_ops+0x200/0x55c)
[    4.096559] [<c02b25e4>] (nand_do_read_ops) from [<c02b29f4>] (nand_read_oob+0xb4/0x3f8)
[    4.104948] [<c02b29f4>] (nand_read_oob) from [<c02a4c54>] (mtd_read_oob+0x60/0x9c)
[    4.112833] [<c02a4c54>] (mtd_read_oob) from [<c02b39a8>] (scan_read+0xa0/0x104)
[    4.120314] [<c02b39a8>] (scan_read) from [<c02b3ba0>] (search_bbt+0x194/0x2b4)
[    4.127832] [<c02b3ba0>] (search_bbt) from [<c02b4cd8>] (nand_default_bbt+0x100/0x640)
[    4.135976] [<c02b4cd8>] (nand_default_bbt) from [<c02af1b0>] (nand_scan_tail+0x990/0xabc)
[    4.144468] [<c02af1b0>] (nand_scan_tail) from [<c02b7e7c>] (marvell_nfc_probe+0x3ac/0x9b8)
[    4.153092] [<c02b7e7c>] (marvell_nfc_probe) from [<c028bb54>] (platform_drv_probe+0x38/0x94)
[    4.161857] [<c028bb54>] (platform_drv_probe) from [<c0289de0>] (driver_probe_device+0x2e8/0x4b4)
[    4.170942] [<c0289de0>] (driver_probe_device) from [<c028a090>] (__driver_attach+0xe4/0x124)
[    4.179555] [<c028a090>] (__driver_attach) from [<c0287e44>] (bus_for_each_dev+0x64/0x94)
[    4.187941] [<c0287e44>] (bus_for_each_dev) from [<c02890b8>] (bus_add_driver+0x198/0x264)
[    4.196432] [<c02890b8>] (bus_add_driver) from [<c028aa50>] (driver_register+0x78/0xf8)
[    4.204658] [<c028aa50>] (driver_register) from [<c00099f8>] (do_one_initcall+0x3c/0x17c)
[    4.213094] [<c00099f8>] (do_one_initcall) from [<c053fd80>] (kernel_init_freeable+0x104/0x1c0)
[    4.222012] [<c053fd80>] (kernel_init_freeable) from [<c0423a38>] (kernel_init+0x8/0xf8)
[    4.230171] [<c0423a38>] (kernel_init) from [<c000a780>] (ret_from_fork+0x14/0x34)
[    4.237894] nand: ->exec_op() parser: pattern not found!
[    4.243602] marvell-nfc pxa3xx-nand: 
[    4.243602] NDCR:  0xdd079fff
[    4.243602] NDCB0: 0x000d3000
[    4.243602] NDCB1: 0xfe400000
[    4.243602] NDCB2: 0x00000001
[    4.243602] NDCB3: 0x00000000
[    4.262584] CPU: 0 PID: 1 Comm: swapper Not tainted 4.15.0-rc1-00041-g0f3e977 #749
[    4.270175] Hardware name: PXA3xx Platform Development Kit (aka Zylonite)
[    4.277257] [<c0010440>] (unwind_backtrace) from [<c000df94>] (show_stack+0x10/0x14)
[    4.285235] [<c000df94>] (show_stack) from [<c02adb58>] (nand_op_parser_exec_op+0x39c/0x474)
[    4.293894] [<c02adb58>] (nand_op_parser_exec_op) from [<c02ac6b0>] (nand_change_read_column_op+0x134/0x194)
[    4.303961] [<c02ac6b0>] (nand_change_read_column_op) from [<c02b9ac8>] (marvell_nfc_hw_ecc_hmg_read_page+0xd0/0x16c)
[    4.314793] [<c02b9ac8>] (marvell_nfc_hw_ecc_hmg_read_page) from [<c02b25e4>] (nand_do_read_ops+0x200/0x55c)
[    4.324831] [<c02b25e4>] (nand_do_read_ops) from [<c02b29f4>] (nand_read_oob+0xb4/0x3f8)
[    4.333159] [<c02b29f4>] (nand_read_oob) from [<c02a4c54>] (mtd_read_oob+0x60/0x9c)
[    4.341037] [<c02a4c54>] (mtd_read_oob) from [<c02b39a8>] (scan_read+0xa0/0x104)
[    4.348518] [<c02b39a8>] (scan_read) from [<c02b3ba0>] (search_bbt+0x194/0x2b4)
[    4.356037] [<c02b3ba0>] (search_bbt) from [<c02b4cd8>] (nand_default_bbt+0x100/0x640)
[    4.364179] [<c02b4cd8>] (nand_default_bbt) from [<c02af1b0>] (nand_scan_tail+0x990/0xabc)
[    4.372667] [<c02af1b0>] (nand_scan_tail) from [<c02b7e7c>] (marvell_nfc_probe+0x3ac/0x9b8)
[    4.381276] [<c02b7e7c>] (marvell_nfc_probe) from [<c028bb54>] (platform_drv_probe+0x38/0x94)
[    4.389889] [<c028bb54>] (platform_drv_probe) from [<c0289de0>] (driver_probe_device+0x2e8/0x4b4)
[    4.398979] [<c0289de0>] (driver_probe_device) from [<c028a090>] (__driver_attach+0xe4/0x124)
[    4.407718] [<c028a090>] (__driver_attach) from [<c0287e44>] (bus_for_each_dev+0x64/0x94)
[    4.416111] [<c0287e44>] (bus_for_each_dev) from [<c02890b8>] (bus_add_driver+0x198/0x264)
[    4.424603] [<c02890b8>] (bus_add_driver) from [<c028aa50>] (driver_register+0x78/0xf8)
[    4.432827] [<c028aa50>] (driver_register) from [<c00099f8>] (do_one_initcall+0x3c/0x17c)
[    4.441256] [<c00099f8>] (do_one_initcall) from [<c053fd80>] (kernel_init_freeable+0x104/0x1c0)
[    4.450035] [<c053fd80>] (kernel_init_freeable) from [<c0423a38>] (kernel_init+0x8/0xf8)
[    4.458326] [<c0423a38>] (kernel_init) from [<c000a780>] (ret_from_fork+0x14/0x34)
[    4.466055] nand: ->exec_op() parser: pattern not found!
[    4.471753] marvell-nfc pxa3xx-nand: 
[    4.471753] NDCR:  0xdd079fff
[    4.471753] NDCB0: 0x000d3000
[    4.471753] NDCB1: 0xfe000000
[    4.471753] NDCB2: 0x00000001
[    4.471753] NDCB3: 0x00000000
[    4.490714] CPU: 0 PID: 1 Comm: swapper Not tainted 4.15.0-rc1-00041-g0f3e977 #749
[    4.498469] Hardware name: PXA3xx Platform Development Kit (aka Zylonite)
[    4.505524] [<c0010440>] (unwind_backtrace) from [<c000df94>] (show_stack+0x10/0x14)
[    4.513498] [<c000df94>] (show_stack) from [<c02adb58>] (nand_op_parser_exec_op+0x39c/0x474)
[    4.522149] [<c02adb58>] (nand_op_parser_exec_op) from [<c02ac6b0>] (nand_change_read_column_op+0x134/0x194)
[    4.532219] [<c02ac6b0>] (nand_change_read_column_op) from [<c02b9ac8>] (marvell_nfc_hw_ecc_hmg_read_page+0xd0/0x16c)
[    4.543050] [<c02b9ac8>] (marvell_nfc_hw_ecc_hmg_read_page) from [<c02b25e4>] (nand_do_read_ops+0x200/0x55c)
[    4.553089] [<c02b25e4>] (nand_do_read_ops) from [<c02b29f4>] (nand_read_oob+0xb4/0x3f8)
[    4.561419] [<c02b29f4>] (nand_read_oob) from [<c02a4c54>] (mtd_read_oob+0x60/0x9c)
[    4.569161] [<c02a4c54>] (mtd_read_oob) from [<c02b39a8>] (scan_read+0xa0/0x104)
[    4.576796] [<c02b39a8>] (scan_read) from [<c02b3ba0>] (search_bbt+0x194/0x2b4)
[    4.584338] [<c02b3ba0>] (search_bbt) from [<c02b4cd8>] (nand_default_bbt+0x100/0x640)
[    4.592478] [<c02b4cd8>] (nand_default_bbt) from [<c02af1b0>] (nand_scan_tail+0x990/0xabc)
[    4.600967] [<c02af1b0>] (nand_scan_tail) from [<c02b7e7c>] (marvell_nfc_probe+0x3ac/0x9b8)
[    4.609432] [<c02b7e7c>] (marvell_nfc_probe) from [<c028bb54>] (platform_drv_probe+0x38/0x94)
[    4.618179] [<c028bb54>] (platform_drv_probe) from [<c0289de0>] (driver_probe_device+0x2e8/0x4b4)
[    4.627271] [<c0289de0>] (driver_probe_device) from [<c028a090>] (__driver_attach+0xe4/0x124)
[    4.636011] [<c028a090>] (__driver_attach) from [<c0287e44>] (bus_for_each_dev+0x64/0x94)
[    4.644412] [<c0287e44>] (bus_for_each_dev) from [<c02890b8>] (bus_add_driver+0x198/0x264)
[    4.652903] [<c02890b8>] (bus_add_driver) from [<c028aa50>] (driver_register+0x78/0xf8)
[    4.661123] [<c028aa50>] (driver_register) from [<c00099f8>] (do_one_initcall+0x3c/0x17c)
[    4.669407] [<c00099f8>] (do_one_initcall) from [<c053fd80>] (kernel_init_freeable+0x104/0x1c0)
[    4.678322] [<c053fd80>] (kernel_init_freeable) from [<c0423a38>] (kernel_init+0x8/0xf8)
[    4.686627] [<c0423a38>] (kernel_init) from [<c000a780>] (ret_from_fork+0x14/0x34)
[    4.694360] nand: ->exec_op() parser: pattern not found!
[    4.699810] Bad block table not found for chip 0
[    4.704717] marvell-nfc pxa3xx-nand: 
[    4.704717] NDCR:  0xdd079fff
[    4.704717] NDCB0: 0x000d3000
[    4.704717] NDCB1: 0xffc00000
[    4.704717] NDCB2: 0x00000001
[    4.704717] NDCB3: 0x00000000
[    4.723741] marvell-nfc pxa3xx-nand: 
[    4.723741] NDCR:  0xdd079fff
[    4.723741] NDCB0: 0x000d3000
[    4.723741] NDCB1: 0xff800000
[    4.723741] NDCB2: 0x00000001
[    4.723741] NDCB3: 0x00000000
[    4.742760] marvell-nfc pxa3xx-nand: 
[    4.742760] NDCR:  0xdd079fff
[    4.742760] NDCB0: 0x000d3000
[    4.742760] NDCB1: 0xff400000
[    4.742760] NDCB2: 0x00000001
[    4.742760] NDCB3: 0x00000000
[    4.761711] CPU: 0 PID: 1 Comm: swapper Not tainted 4.15.0-rc1-00041-g0f3e977 #749
[    4.769307] Hardware name: PXA3xx Platform Development Kit (aka Zylonite)
[    4.776386] [<c0010440>] (unwind_backtrace) from [<c000df94>] (show_stack+0x10/0x14)
[    4.784360] [<c000df94>] (show_stack) from [<c02adb58>] (nand_op_parser_exec_op+0x39c/0x474)
[    4.793018] [<c02adb58>] (nand_op_parser_exec_op) from [<c02ac6b0>] (nand_change_read_column_op+0x134/0x194)
[    4.803088] [<c02ac6b0>] (nand_change_read_column_op) from [<c02b9ac8>] (marvell_nfc_hw_ecc_hmg_read_page+0xd0/0x16c)
[    4.813917] [<c02b9ac8>] (marvell_nfc_hw_ecc_hmg_read_page) from [<c02b25e4>] (nand_do_read_ops+0x200/0x55c)
[    4.823956] [<c02b25e4>] (nand_do_read_ops) from [<c02b29f4>] (nand_read_oob+0xb4/0x3f8)
[    4.832290] [<c02b29f4>] (nand_read_oob) from [<c02a4c54>] (mtd_read_oob+0x60/0x9c)
[    4.840028] [<c02a4c54>] (mtd_read_oob) from [<c02b39a8>] (scan_read+0xa0/0x104)
[    4.847636] [<c02b39a8>] (scan_read) from [<c02b3ba0>] (search_bbt+0x194/0x2b4)
[    4.855170] [<c02b3ba0>] (search_bbt) from [<c02b4cf4>] (nand_default_bbt+0x11c/0x640)
[    4.863312] [<c02b4cf4>] (nand_default_bbt) from [<c02af1b0>] (nand_scan_tail+0x990/0xabc)
[    4.871801] [<c02af1b0>] (nand_scan_tail) from [<c02b7e7c>] (marvell_nfc_probe+0x3ac/0x9b8)
[    4.880267] [<c02b7e7c>] (marvell_nfc_probe) from [<c028bb54>] (platform_drv_probe+0x38/0x94)
[    4.889013] [<c028bb54>] (platform_drv_probe) from [<c0289de0>] (driver_probe_device+0x2e8/0x4b4)
[    4.898106] [<c0289de0>] (driver_probe_device) from [<c028a090>] (__driver_attach+0xe4/0x124)
[    4.906842] [<c028a090>] (__driver_attach) from [<c0287e44>] (bus_for_each_dev+0x64/0x94)
[    4.915234] [<c0287e44>] (bus_for_each_dev) from [<c02890b8>] (bus_add_driver+0x198/0x264)
[    4.923718] [<c02890b8>] (bus_add_driver) from [<c028aa50>] (driver_register+0x78/0xf8)
[    4.931940] [<c028aa50>] (driver_register) from [<c00099f8>] (do_one_initcall+0x3c/0x17c)
[    4.940235] [<c00099f8>] (do_one_initcall) from [<c053fd80>] (kernel_init_freeable+0x104/0x1c0)
[    4.949146] [<c053fd80>] (kernel_init_freeable) from [<c0423a38>] (kernel_init+0x8/0xf8)
[    4.957451] [<c0423a38>] (kernel_init) from [<c000a780>] (ret_from_fork+0x14/0x34)
[    4.965177] nand: ->exec_op() parser: pattern not found!
[    4.970731] marvell-nfc pxa3xx-nand: 
[    4.970731] NDCR:  0xdd079fff
[    4.970731] NDCB0: 0x000d3000
[    4.970731] NDCB1: 0xff000000
[    4.970731] NDCB2: 0x00000001
[    4.970731] NDCB3: 0x00000000
[    4.989786] CPU: 0 PID: 1 Comm: swapper Not tainted 4.15.0-rc1-00041-g0f3e977 #749
[    4.997531] Hardware name: PXA3xx Platform Development Kit (aka Zylonite)
[    5.004586] [<c0010440>] (unwind_backtrace) from [<c000df94>] (show_stack+0x10/0x14)
[    5.012562] [<c000df94>] (show_stack) from [<c02adb58>] (nand_op_parser_exec_op+0x39c/0x474)
[    5.021224] [<c02adb58>] (nand_op_parser_exec_op) from [<c02ac6b0>] (nand_change_read_column_op+0x134/0x194)
[    5.031287] [<c02ac6b0>] (nand_change_read_column_op) from [<c02b9ac8>] (marvell_nfc_hw_ecc_hmg_read_page+0xd0/0x16c)
[    5.042111] [<c02b9ac8>] (marvell_nfc_hw_ecc_hmg_read_page) from [<c02b25e4>] (nand_do_read_ops+0x200/0x55c)
[    5.052150] [<c02b25e4>] (nand_do_read_ops) from [<c02b29f4>] (nand_read_oob+0xb4/0x3f8)
[    5.060335] [<c02b29f4>] (nand_read_oob) from [<c02a4c54>] (mtd_read_oob+0x60/0x9c)
[    5.068201] [<c02a4c54>] (mtd_read_oob) from [<c02b39a8>] (scan_read+0xa0/0x104)
[    5.075821] [<c02b39a8>] (scan_read) from [<c02b3ba0>] (search_bbt+0x194/0x2b4)
[    5.083356] [<c02b3ba0>] (search_bbt) from [<c02b4cf4>] (nand_default_bbt+0x11c/0x640)
[    5.091498] [<c02b4cf4>] (nand_default_bbt) from [<c02af1b0>] (nand_scan_tail+0x990/0xabc)
[    5.099844] [<c02af1b0>] (nand_scan_tail) from [<c02b7e7c>] (marvell_nfc_probe+0x3ac/0x9b8)
[    5.108442] [<c02b7e7c>] (marvell_nfc_probe) from [<c028bb54>] (platform_drv_probe+0x38/0x94)
[    5.117207] [<c028bb54>] (platform_drv_probe) from [<c0289de0>] (driver_probe_device+0x2e8/0x4b4)
[    5.126303] [<c0289de0>] (driver_probe_device) from [<c028a090>] (__driver_attach+0xe4/0x124)
[    5.135046] [<c028a090>] (__driver_attach) from [<c0287e44>] (bus_for_each_dev+0x64/0x94)
[    5.143440] [<c0287e44>] (bus_for_each_dev) from [<c02890b8>] (bus_add_driver+0x198/0x264)
[    5.151931] [<c02890b8>] (bus_add_driver) from [<c028aa50>] (driver_register+0x78/0xf8)
[    5.160012] [<c028aa50>] (driver_register) from [<c00099f8>] (do_one_initcall+0x3c/0x17c)
[    5.168428] [<c00099f8>] (do_one_initcall) from [<c053fd80>] (kernel_init_freeable+0x104/0x1c0)
[    5.177346] [<c053fd80>] (kernel_init_freeable) from [<c0423a38>] (kernel_init+0x8/0xf8)
[    5.185647] [<c0423a38>] (kernel_init) from [<c000a780>] (ret_from_fork+0x14/0x34)
[    5.193379] nand: ->exec_op() parser: pattern not found!
[    5.198932] marvell-nfc pxa3xx-nand: 
[    5.198932] NDCR:  0xdd079fff
[    5.198932] NDCB0: 0x000d3000
[    5.198932] NDCB1: 0xfec00000
[    5.198932] NDCB2: 0x00000001
[    5.198932] NDCB3: 0x00000000
[    5.217913] CPU: 0 PID: 1 Comm: swapper Not tainted 4.15.0-rc1-00041-g0f3e977 #749
[    5.225670] Hardware name: PXA3xx Platform Development Kit (aka Zylonite)
[    5.232729] [<c0010440>] (unwind_backtrace) from [<c000df94>] (show_stack+0x10/0x14)
[    5.240559] [<c000df94>] (show_stack) from [<c02adb58>] (nand_op_parser_exec_op+0x39c/0x474)
[    5.249206] [<c02adb58>] (nand_op_parser_exec_op) from [<c02ac6b0>] (nand_change_read_column_op+0x134/0x194)
[    5.259272] [<c02ac6b0>] (nand_change_read_column_op) from [<c02b9ac8>] (marvell_nfc_hw_ecc_hmg_read_page+0xd0/0x16c)
[    5.270104] [<c02b9ac8>] (marvell_nfc_hw_ecc_hmg_read_page) from [<c02b25e4>] (nand_do_read_ops+0x200/0x55c)
[    5.280141] [<c02b25e4>] (nand_do_read_ops) from [<c02b29f4>] (nand_read_oob+0xb4/0x3f8)
[    5.288475] [<c02b29f4>] (nand_read_oob) from [<c02a4c54>] (mtd_read_oob+0x60/0x9c)
[    5.296355] [<c02a4c54>] (mtd_read_oob) from [<c02b39a8>] (scan_read+0xa0/0x104)
[    5.303975] [<c02b39a8>] (scan_read) from [<c02b3ba0>] (search_bbt+0x194/0x2b4)
[    5.311510] [<c02b3ba0>] (search_bbt) from [<c02b4cf4>] (nand_default_bbt+0x11c/0x640)
[    5.319509] [<c02b4cf4>] (nand_default_bbt) from [<c02af1b0>] (nand_scan_tail+0x990/0xabc)
[    5.327986] [<c02af1b0>] (nand_scan_tail) from [<c02b7e7c>] (marvell_nfc_probe+0x3ac/0x9b8)
[    5.336594] [<c02b7e7c>] (marvell_nfc_probe) from [<c028bb54>] (platform_drv_probe+0x38/0x94)
[    5.345352] [<c028bb54>] (platform_drv_probe) from [<c0289de0>] (driver_probe_device+0x2e8/0x4b4)
[    5.354446] [<c0289de0>] (driver_probe_device) from [<c028a090>] (__driver_attach+0xe4/0x124)
[    5.363183] [<c028a090>] (__driver_attach) from [<c0287e44>] (bus_for_each_dev+0x64/0x94)
[    5.371584] [<c0287e44>] (bus_for_each_dev) from [<c02890b8>] (bus_add_driver+0x198/0x264)
[    5.379934] [<c02890b8>] (bus_add_driver) from [<c028aa50>] (driver_register+0x78/0xf8)
[    5.388151] [<c028aa50>] (driver_register) from [<c00099f8>] (do_one_initcall+0x3c/0x17c)
[    5.396576] [<c00099f8>] (do_one_initcall) from [<c053fd80>] (kernel_init_freeable+0x104/0x1c0)
[    5.405499] [<c053fd80>] (kernel_init_freeable) from [<c0423a38>] (kernel_init+0x8/0xf8)
[    5.413800] [<c0423a38>] (kernel_init) from [<c000a780>] (ret_from_fork+0x14/0x34)
[    5.421534] nand: ->exec_op() parser: pattern not found!
[    5.427088] marvell-nfc pxa3xx-nand: 
[    5.427088] NDCR:  0xdd079fff
[    5.427088] NDCB0: 0x000d3000
[    5.427088] NDCB1: 0xfe800000
[    5.427088] NDCB2: 0x00000001
[    5.427088] NDCB3: 0x00000000
[    5.446044] CPU: 0 PID: 1 Comm: swapper Not tainted 4.15.0-rc1-00041-g0f3e977 #749
[    5.453794] Hardware name: PXA3xx Platform Development Kit (aka Zylonite)
[    5.460725] [<c0010440>] (unwind_backtrace) from [<c000df94>] (show_stack+0x10/0x14)
[    5.468703] [<c000df94>] (show_stack) from [<c02adb58>] (nand_op_parser_exec_op+0x39c/0x474)
[    5.477344] [<c02adb58>] (nand_op_parser_exec_op) from [<c02ac6b0>] (nand_change_read_column_op+0x134/0x194)
[    5.487418] [<c02ac6b0>] (nand_change_read_column_op) from [<c02b9ac8>] (marvell_nfc_hw_ecc_hmg_read_page+0xd0/0x16c)
[    5.498247] [<c02b9ac8>] (marvell_nfc_hw_ecc_hmg_read_page) from [<c02b25e4>] (nand_do_read_ops+0x200/0x55c)
[    5.508283] [<c02b25e4>] (nand_do_read_ops) from [<c02b29f4>] (nand_read_oob+0xb4/0x3f8)
[    5.516607] [<c02b29f4>] (nand_read_oob) from [<c02a4c54>] (mtd_read_oob+0x60/0x9c)
[    5.524488] [<c02a4c54>] (mtd_read_oob) from [<c02b39a8>] (scan_read+0xa0/0x104)
[    5.532101] [<c02b39a8>] (scan_read) from [<c02b3ba0>] (search_bbt+0x194/0x2b4)
[    5.539493] [<c02b3ba0>] (search_bbt) from [<c02b4cf4>] (nand_default_bbt+0x11c/0x640)
[    5.547623] [<c02b4cf4>] (nand_default_bbt) from [<c02af1b0>] (nand_scan_tail+0x990/0xabc)
[    5.556111] [<c02af1b0>] (nand_scan_tail) from [<c02b7e7c>] (marvell_nfc_probe+0x3ac/0x9b8)
[    5.564723] [<c02b7e7c>] (marvell_nfc_probe) from [<c028bb54>] (platform_drv_probe+0x38/0x94)
[    5.573487] [<c028bb54>] (platform_drv_probe) from [<c0289de0>] (driver_probe_device+0x2e8/0x4b4)
[    5.582580] [<c0289de0>] (driver_probe_device) from [<c028a090>] (__driver_attach+0xe4/0x124)
[    5.591320] [<c028a090>] (__driver_attach) from [<c0287e44>] (bus_for_each_dev+0x64/0x94)
[    5.599579] [<c0287e44>] (bus_for_each_dev) from [<c02890b8>] (bus_add_driver+0x198/0x264)
[    5.608054] [<c02890b8>] (bus_add_driver) from [<c028aa50>] (driver_register+0x78/0xf8)
[    5.616279] [<c028aa50>] (driver_register) from [<c00099f8>] (do_one_initcall+0x3c/0x17c)
[    5.624709] [<c00099f8>] (do_one_initcall) from [<c053fd80>] (kernel_init_freeable+0x104/0x1c0)
[    5.633625] [<c053fd80>] (kernel_init_freeable) from [<c0423a38>] (kernel_init+0x8/0xf8)
[    5.641925] [<c0423a38>] (kernel_init) from [<c000a780>] (ret_from_fork+0x14/0x34)
[    5.649518] nand: ->exec_op() parser: pattern not found!
[    5.655192] marvell-nfc pxa3xx-nand: 
[    5.655192] NDCR:  0xdd079fff
[    5.655192] NDCB0: 0x000d3000
[    5.655192] NDCB1: 0xfe400000
[    5.655192] NDCB2: 0x00000001
[    5.655192] NDCB3: 0x00000000
[    5.674154] CPU: 0 PID: 1 Comm: swapper Not tainted 4.15.0-rc1-00041-g0f3e977 #749
[    5.681904] Hardware name: PXA3xx Platform Development Kit (aka Zylonite)
[    5.688832] [<c0010440>] (unwind_backtrace) from [<c000df94>] (show_stack+0x10/0x14)
[    5.696798] [<c000df94>] (show_stack) from [<c02adb58>] (nand_op_parser_exec_op+0x39c/0x474)
[    5.705456] [<c02adb58>] (nand_op_parser_exec_op) from [<c02ac6b0>] (nand_change_read_column_op+0x134/0x194)
[    5.715521] [<c02ac6b0>] (nand_change_read_column_op) from [<c02b9ac8>] (marvell_nfc_hw_ecc_hmg_read_page+0xd0/0x16c)
[    5.726344] [<c02b9ac8>] (marvell_nfc_hw_ecc_hmg_read_page) from [<c02b25e4>] (nand_do_read_ops+0x200/0x55c)
[    5.736376] [<c02b25e4>] (nand_do_read_ops) from [<c02b29f4>] (nand_read_oob+0xb4/0x3f8)
[    5.744710] [<c02b29f4>] (nand_read_oob) from [<c02a4c54>] (mtd_read_oob+0x60/0x9c)
[    5.752589] [<c02a4c54>] (mtd_read_oob) from [<c02b39a8>] (scan_read+0xa0/0x104)
[    5.760061] [<c02b39a8>] (scan_read) from [<c02b3ba0>] (search_bbt+0x194/0x2b4)
[    5.767580] [<c02b3ba0>] (search_bbt) from [<c02b4cf4>] (nand_default_bbt+0x11c/0x640)
[    5.775714] [<c02b4cf4>] (nand_default_bbt) from [<c02af1b0>] (nand_scan_tail+0x990/0xabc)
[    5.784204] [<c02af1b0>] (nand_scan_tail) from [<c02b7e7c>] (marvell_nfc_probe+0x3ac/0x9b8)
[    5.792814] [<c02b7e7c>] (marvell_nfc_probe) from [<c028bb54>] (platform_drv_probe+0x38/0x94)
[    5.801579] [<c028bb54>] (platform_drv_probe) from [<c0289de0>] (driver_probe_device+0x2e8/0x4b4)
[    5.810534] [<c0289de0>] (driver_probe_device) from [<c028a090>] (__driver_attach+0xe4/0x124)
[    5.819264] [<c028a090>] (__driver_attach) from [<c0287e44>] (bus_for_each_dev+0x64/0x94)
[    5.827665] [<c0287e44>] (bus_for_each_dev) from [<c02890b8>] (bus_add_driver+0x198/0x264)
[    5.836154] [<c02890b8>] (bus_add_driver) from [<c028aa50>] (driver_register+0x78/0xf8)
[    5.844403] [<c028aa50>] (driver_register) from [<c00099f8>] (do_one_initcall+0x3c/0x17c)
[    5.852834] [<c00099f8>] (do_one_initcall) from [<c053fd80>] (kernel_init_freeable+0x104/0x1c0)
[    5.861753] [<c053fd80>] (kernel_init_freeable) from [<c0423a38>] (kernel_init+0x8/0xf8)
[    5.869912] [<c0423a38>] (kernel_init) from [<c000a780>] (ret_from_fork+0x14/0x34)
[    5.877632] nand: ->exec_op() parser: pattern not found!
[    5.883334] marvell-nfc pxa3xx-nand: 
[    5.883334] NDCR:  0xdd079fff
[    5.883334] NDCB0: 0x000d3000
[    5.883334] NDCB1: 0xfe000000
[    5.883334] NDCB2: 0x00000001
[    5.883334] NDCB3: 0x00000000
[    5.902303] CPU: 0 PID: 1 Comm: swapper Not tainted 4.15.0-rc1-00041-g0f3e977 #749
[    5.909898] Hardware name: PXA3xx Platform Development Kit (aka Zylonite)
[    5.916979] [<c0010440>] (unwind_backtrace) from [<c000df94>] (show_stack+0x10/0x14)
[    5.924950] [<c000df94>] (show_stack) from [<c02adb58>] (nand_op_parser_exec_op+0x39c/0x474)
[    5.933606] [<c02adb58>] (nand_op_parser_exec_op) from [<c02ac6b0>] (nand_change_read_column_op+0x134/0x194)
[    5.943672] [<c02ac6b0>] (nand_change_read_column_op) from [<c02b9ac8>] (marvell_nfc_hw_ecc_hmg_read_page+0xd0/0x16c)
[    5.954498] [<c02b9ac8>] (marvell_nfc_hw_ecc_hmg_read_page) from [<c02b25e4>] (nand_do_read_ops+0x200/0x55c)
[    5.964526] [<c02b25e4>] (nand_do_read_ops) from [<c02b29f4>] (nand_read_oob+0xb4/0x3f8)
[    5.972855] [<c02b29f4>] (nand_read_oob) from [<c02a4c54>] (mtd_read_oob+0x60/0x9c)
[    5.980592] [<c02a4c54>] (mtd_read_oob) from [<c02b39a8>] (scan_read+0xa0/0x104)
[    5.988202] [<c02b39a8>] (scan_read) from [<c02b3ba0>] (search_bbt+0x194/0x2b4)
[    5.995734] [<c02b3ba0>] (search_bbt) from [<c02b4cf4>] (nand_default_bbt+0x11c/0x640)
[    6.003876] [<c02b4cf4>] (nand_default_bbt) from [<c02af1b0>] (nand_scan_tail+0x990/0xabc)
[    6.012373] [<c02af1b0>] (nand_scan_tail) from [<c02b7e7c>] (marvell_nfc_probe+0x3ac/0x9b8)
[    6.020838] [<c02b7e7c>] (marvell_nfc_probe) from [<c028bb54>] (platform_drv_probe+0x38/0x94)
[    6.029598] [<c028bb54>] (platform_drv_probe) from [<c0289de0>] (driver_probe_device+0x2e8/0x4b4)
[    6.038676] [<c0289de0>] (driver_probe_device) from [<c028a090>] (__driver_attach+0xe4/0x124)
[    6.047417] [<c028a090>] (__driver_attach) from [<c0287e44>] (bus_for_each_dev+0x64/0x94)
[    6.055807] [<c0287e44>] (bus_for_each_dev) from [<c02890b8>] (bus_add_driver+0x198/0x264)
[    6.064290] [<c02890b8>] (bus_add_driver) from [<c028aa50>] (driver_register+0x78/0xf8)
[    6.072513] [<c028aa50>] (driver_register) from [<c00099f8>] (do_one_initcall+0x3c/0x17c)
[    6.080795] [<c00099f8>] (do_one_initcall) from [<c053fd80>] (kernel_init_freeable+0x104/0x1c0)
[    6.089716] [<c053fd80>] (kernel_init_freeable) from [<c0423a38>] (kernel_init+0x8/0xf8)
[    6.098699] [<c0423a38>] (kernel_init) from [<c000a780>] (ret_from_fork+0x14/0x34)
[    6.106511] nand: ->exec_op() parser: pattern not found!
[    6.112110] Bad block table not found for chip 0
[    6.116762] Scanning device for bad blocks
[    6.121060] nand: nand_do_read_oob: from = 0x00000000, len = 64
[    6.127086] marvell-nfc pxa3xx-nand: 
[    6.127086] NDCR:  0x9d079fff
[    6.127086] NDCB0: 0x000d3000
[    6.127086] NDCB1: 0x00000000
[    6.127086] NDCB2: 0x00000000
[    6.127086] NDCB3: 0x00000000
[    6.145988] Bad eraseblock 0 at 0x000000000000
