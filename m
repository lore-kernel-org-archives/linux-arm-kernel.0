From: andrew.gospodarek@broadcom.com (Andy Gospodarek)
Date: Mon, 19 Dec 2016 17:15:01 -0500
Subject: [PATCH pci/host-iproc] PCI: iproc: Allow more than slot 0 on PAXC
In-Reply-To: <fdd96c8d-93ae-81e8-57e7-457a5d7f21a6@broadcom.com>
References: <1481232618-10614-1-git-send-email-gospo@broadcom.com>
 <f370a4d0-c8e8-1c71-8eca-f6ac48eb30d3@broadcom.com>
 <20161219213042.GA2862@C02RW35GFVH8>
 <fdd96c8d-93ae-81e8-57e7-457a5d7f21a6@broadcom.com>
Message-ID: <20161219221501.GB2862@C02RW35GFVH8>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 19, 2016 at 02:01:59PM -0800, Ray Jui wrote:
> 
> 
> On 12/19/2016 1:30 PM, Andy Gospodarek wrote:
> > On Mon, Dec 19, 2016 at 10:54:15AM -0800, Ray Jui wrote:
> >>
> >>
> >> On 12/8/2016 1:30 PM, Andy Gospodarek wrote:
> >>> The iproc host driver limits the number of slots that are available on
> >>> PAXC devices.  Enforcing this limit prevents VFs from being created
> >>> beyond the first port.  After this change it is possible to create VFs
> >>> associated with all four devices.
> >>>
> >>> The first four devices below are the PFs and the next four are the newly
> >>> created VFs:
> >>>
> >>> 0008:01:00.0 Ethernet controller: Broadcom Limited Device 16cd
> >>> 0008:01:00.1 Ethernet controller: Broadcom Limited Device 16cd
> >>> 0008:01:00.2 Ethernet controller: Broadcom Limited Device 16cd
> >>> 0008:01:00.3 Ethernet controller: Broadcom Limited Device 16cd
> >>> 0008:01:00.4 Ethernet controller: Broadcom Limited BCM57304 NetXtreme-C Ethernet Virtual Function
> >>> 0008:01:01.0 Ethernet controller: Broadcom Limited BCM57304 NetXtreme-C Ethernet Virtual Function
> >>> 0008:01:01.4 Ethernet controller: Broadcom Limited BCM57304 NetXtreme-C Ethernet Virtual Function
> >>> 0008:01:02.0 Ethernet controller: Broadcom Limited BCM57304 NetXtreme-C Ethernet Virtual Function
> >>>
> >>> Based on the git history around 923c6bb1f641 ("PCI: iproc: Allow multiple
> >>> devices except on PAXC") and 943ebae781f5 ("PCI: iproc: Add PAXC interface
> >>> support") I expect there may be an unmentioned or unknown-to-me reason why this
> >>> code exists.  I certainly cannot create and use VFs without some kind of change
> >>> around this space, so I would like to see the current limitation simply removed.
> >>>
> >>> Fixes: 923c6bb1f641 ("PCI: iproc: Allow multiple devices except on PAXC")
> >>
> >>> Signed-off-by: Andy Gospodarek <gospo@broadcom.com>
> >>> ---
> >>>  drivers/pci/host/pcie-iproc.c | 8 --------
> >>>  1 file changed, 8 deletions(-)
> >>>
> >>> diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
> >>> index 3ebc025..9311826 100644
> >>> --- a/drivers/pci/host/pcie-iproc.c
> >>> +++ b/drivers/pci/host/pcie-iproc.c
> >>> @@ -477,14 +477,6 @@ static void __iomem *iproc_pcie_map_cfg_bus(struct pci_bus *bus,
> >>>  			return (pcie->base + offset);
> >>>  	}
> >>>  
> >>> -	/*
> >>> -	 * PAXC is connected to an internally emulated EP within the SoC.  It
> >>> -	 * allows only one device.
> >>> -	 */
> >>> -	if (pcie->ep_is_internal)
> >>> -		if (slot > 0)
> >>> -			return NULL;
> >>> -
> >>>  	/* EP device access */
> >>>  	val = (busno << CFG_ADDR_BUS_NUM_SHIFT) |
> >>>  		(slot << CFG_ADDR_DEV_NUM_SHIFT) |
> >>>
> >>
> >> With this change, standard v4.9 kernel would crash on a NS2 SVK with the
> >> log shown below. This is inline with my previous observation and
> >> therefore slot number has been limited to only zero for the PAXC
> >> interface. Does it require more than just this change in order for the
> >> kernel to boot to complete?
> >>
> >> [    2.190515] OF: PCI: host bridge /pcie at 60c00000 ranges:
> >> [    2.196400] OF: PCI:   MEM 0x60000000..0x60bfffff -> 0x00000000
> >> [    2.203135] iproc-pcie 60c00000.pcie: PCI host bridge to bus 0008:00
> >> [    2.210289] pci_bus 0008:00: root bus resource [bus 00-01]
> >> [    2.216349] pci_bus 0008:00: root bus resource [mem
> >> 0x60000000-0x60bfffff] (bus address [0x00000000-0x00bfffff])
> >> [    2.227769] iproc-pcie 60c00000.pcie: not using iProc MSI
> >> [    2.234050] pci 0008:00:00.0: bridge configuration invalid ([bus
> >> 00-00]), reconfiguring
> >> [    2.244285] Bad mode in Error handler detected on CPU1, code
> >> 0xbf000002 -- SError
> >> [    2.252661] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.9.0+ #24
> >> [    2.259430] Hardware name: Broadcom NS2 SVK (DT)
> >> [    2.264550] task: ffff8000fb488000 task.stack: ffff8000fb490000
> >> [    2.271161] PC is at pci_generic_config_read32+0x74/0xa0
> >> [    2.277043] LR is at pci_generic_config_read32+0x28/0xa0
> >> [    2.283005] pc : [<ffff00000839d984>] lr : [<ffff00000839d938>]
> >> pstate: 200000c5
> >> [    2.291225] sp : ffff8000fb4937f0
> >> [    2.294937] x29: ffff8000fb4937f0 x28: ffff8000fadb9000
> >> [    2.300884] x27: ffff8000faf27098 x26: 0000000000000000
> >> [    2.306803] x25: 0000000000000000 x24: ffff8000fadb9400
> >> [    2.312757] x23: 0000000000000040 x22: ffff0000089c55d8
> >> [    2.318730] x21: 0000000000000010 x20: ffff8000fb49391c
> >> [    2.324666] x19: 0000000000000000 x18: 000000000000077f
> >> [    2.330594] x17: ffffffffffffffff x16: ffff000008a49fff
> >> [    2.336539] x15: ffff000008a49fff x14: 0000000000000000
> >> [    2.342502] x13: 0000000000000007 x12: 0000000000000018
> >> [    2.348456] x11: 0101010101010101 x10: 7f7f7f7f7f7f7f7f
> >> [    2.354392] x9 : 0000000000000000 x8 : ffff8000fa80e680
> >> [    2.360355] x7 : 000000000000ffff x6 : ffff8000faf0ca98
> >> [    2.366300] x5 : 0000000000000002 x4 : ffff8000fb49389c
> >> [    2.372290] x3 : 0000000000000004 x2 : 0000000000100001
> >> [    2.378209] x1 : ffff000008a49000 x0 : 0000000000000000
> >> [    2.384145]
> >> [    2.385807] Internal error: Oops - bad mode: 0 [#1] PREEMPT SMP
> >> [    2.392351] Modules linked in:
> >> [    2.395770] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.9.0+ #24
> >> [    2.402529] Hardware name: Broadcom NS2 SVK (DT)
> >> [    2.407693] task: ffff8000fb488000 task.stack: ffff8000fb490000
> >> [    2.414301] PC is at pci_generic_config_read32+0x74/0xa0
> >> [    2.420299] LR is at pci_generic_config_read32+0x28/0xa0
> >> [    2.426279] pc : [<ffff00000839d984>] lr : [<ffff00000839d938>]
> >> pstate: 200000c5
> >> [    2.434552] sp : ffff8000fb4937f0
> >> [    2.438246] x29: ffff8000fb4937f0 x28: ffff8000fadb9000
> >> [    2.444209] x27: ffff8000faf27098 x26: 0000000000000000
> >> [    2.450137] x25: 0000000000000000 x24: ffff8000fadb9400
> >> [    2.456091] x23: 0000000000000040 x22: ffff0000089c55d8
> >> [    2.462037] x21: 0000000000000010 x20: ffff8000fb49391c
> >> [    2.467947] x19: 0000000000000000 x18: 000000000000077f
> >> [    2.473945] x17: ffffffffffffffff x16: ffff000008a49fff
> >> [    2.479881] x15: ffff000008a49fff x14: 0000000000000000
> >> [    2.485826] x13: 0000000000000007 x12: 0000000000000018
> >> [    2.491798] x11: 0101010101010101 x10: 7f7f7f7f7f7f7f7f
> >> [    2.497752] x9 : 0000000000000000 x8 : ffff8000fa80e680
> >> [    2.503689] x7 : 000000000000ffff x6 : ffff8000faf0ca98
> >> [    2.509643] x5 : 0000000000000002 x4 : ffff8000fb49389c
> >> [    2.515561] x3 : 0000000000000004 x2 : 0000000000100001
> >> [    2.521453] x1 : ffff000008a49000 x0 : 0000000000000000
> >> [    2.527388]
> >> [    2.529058] Process swapper/0 (pid: 1, stack limit = 0xffff8000fb490020)
> >> [    2.536607] Stack: (0xffff8000fb4937f0 to 0xffff8000fb494000)
> >> [    2.543044] 37e0:                                   ffff8000fb493820
> >> ffff0000083b65cc
> >> [    2.551830] 3800: ffff8000fadb9400 ffff00000867606c 0000000000000004
> >> ffff8000fb49389c
> >> [    2.560481] 3820: ffff8000fb493840 ffff00000839dcc8 ffff8000fadb9400
> >> ffff00000839dce0
> >> [    2.569158] 3840: ffff8000fb4938a0 ffff00000839fcb8 0000000000000000
> >> ffff8000fb49391c
> >> [    2.577915] 3860: 000000000000ea60 0000000000000001 0000000000000010
> >> 0000000000000000
> >> [    2.586718] 3880: ffff8000faef9000 0000000000000000 ffff8000fb4938b0
> >> 00000000083a94d8
> >> [    2.595548] 38a0: ffff8000fb4938e0 ffff0000083a1380 0000000000000000
> >> ffff8000fadb9400
> >> [    2.604359] 38c0: 0000000000000010 0000000000000001 ffff0000087fb000
> >> ffff8000fadb9528
> >> [    2.613180] 38e0: ffff8000fb493920 ffff0000083a1444 ffff8000fadb9400
> >> ffff8000fadb9400
> >> [    2.621938] 3900: 0000000000000010 0000000000000004 ffff8000fb493960
> >> fffffffffb493960
> >> [    2.630767] 3920: ffff8000fb493960 ffff0000083a237c 0000000000000018
> >> ffff8000fadb9400
> >> [    2.639543] 3940: 0000000000000001 0000000000000000 ffff8000fadb9000
> >> 0000000000000007
> >> [    2.648355] 3960: ffff8000fb4939b0 ffff0000083a20d8 ffff8000faf27000
> >> ffff8000fadb9400
> >> [    2.657166] 3980: 0000000000000001 0000000000000000 0000000000000000
> >> 0000000000000001
> >> [    2.665960] 39a0: 0000000000000000 0000000000000018 ffff8000fb493a30
> >> ffff0000083a23d8
> >> [    2.674789] 39c0: ffff8000faf27000 ffff8000fadb9000 ffff8000fadb9028
> >> 0000000000000000
> >> [    2.683547] 39e0: ffff0000087fb000 ffff8000fadb9128 0000000000000001
> >> ffff0000088c0460
> >> [    2.692341] 3a00: ffff0000089a4000 ffff0000088f8b60 ffff8000fb49396c
> >> 0000000000000000
> >> [    2.701117] 3a20: 0000000000000000 00ff010000000000 ffff8000fb493a80
> >> ffff0000083b731c
> >> [    2.709910] 3a40: ffff8000faf0e218 ffff8000fffe7748 ffff8000fb63f410
> >> ffff8000fadb9000
> >> [    2.718695] 3a60: ffff0000086e9000 ffff8000fffe1e00 ffff0000088f8bc0
> >> 6c6071652c6c3175
> >> [    2.727489] 3a80: ffff8000fb493bc0 ffff0000083b8774 0000000000000000
> >> ffff8000faf0e218
> >> [    2.736291] 3aa0: ffff8000fb63f410 ffff8000fb493c10 ffff8000fffe1e00
> >> ffff8000fb63f400
> >> [    2.745058] 3ac0: ffff0000088f8bc0 ffff0000088c0460 ffff0000089a4000
> >> ffff0000088f8b60
> >> [    2.753816] 3ae0: ffff8000fb493b20 ffff00000858b7b0 ffff8000fb493c08
> >> ffff000008855f08
> >> [    2.762583] 3b00: ffff0000089b6000 ffff8000fb493c10 ffff8000fffe1e00
> >> 0000000060000000
> >> [    2.771376] 3b20: ffff8000fb493bc0 ffff0000083b8744 0000000000000000
> >> ffff8000faf0e218
> >> [    2.780125] 3b40: ffff8000fb63f410 ffff8000fb493c10 ffff8000fffe1e00
> >> ffff8000fb63f400
> >> [    2.788937] 3b60: ffff8000fffe1e00 0000000000000000 ffff0000004d454d
> >> 0000000200000007
> >> [    2.797731] 3b80: ffff7dfffe8009dc ffff7dfffe8009dc 0000000200000007
> >> ffff000000000083
> >> [    2.806533] 3ba0: 0000000000000000 0000000060000000 0000000000c00000
> >> 0000000000000200
> >> [    2.815372] 3bc0: ffff8000fb493c60 ffff000008414ef8 ffff000008962258
> >> ffff8000fb63f410
> >> [    2.824121] 3be0: 0000000000000000 ffff000008962280 0000000000000000
> >> ffff0000089a4000
> >> [    2.832950] 3c00: ffff8000fb493c40 ffffffffffffffff ffff8000fb493c10
> >> ffff8000fb493c10
> >> [    2.841717] 3c20: 0000000060c00000 0000000060c00fff ffff8000fffe1ea8
> >> 0000000000000200
> >> [    2.850529] 3c40: 0000000000000000 0000000000000000 0000000000000000
> >> 0000000000000000
> >> [    2.859358] 3c60: ffff8000fb493c80 ffff000008413688 ffff8000fb63f410
> >> ffff0000089c8000
> >> [    2.868161] 3c80: ffff8000fb493cc0 ffff0000084137c0 ffff8000fb63f410
> >> ffff000008962280
> >> [    2.876919] 3ca0: ffff8000fb63f470 ffff00000896cd30 ffff00000896c000
> >> ffff00000841190c
> >> [    2.885677] 3cc0: ffff8000fb493cf0 ffff000008411900 0000000000000000
> >> ffff000008962280
> >> [    2.894497] 3ce0: ffff000008413720 ffff8000fb493d40 ffff8000fb493d30
> >> ffff000008413124
> >> [    2.903308] 3d00: ffff000008962280 ffff8000faf0e100 0000000000000000
> >> ffff00000867606c
> >> [    2.912058] 3d20: ffff8000fb43eca8 ffff8000fb625b68 ffff8000fb493d40
> >> ffff000008412d84
> >> [    2.920815] 3d40: ffff8000fb493d80 ffff000008413eb4 ffff000008962280
> >> ffff0000088e1438
> >> [    2.929591] 3d60: 0000000000000000 ffff0000088f8b30 ffff0000088aba00
> >> ffff0000089c5000
> >> [    2.938358] 3d80: ffff8000fb493db0 ffff000008414eb8 ffff8000fb490000
> >> ffff0000088e1438
> >> [    2.947134] 3da0: 0000000000000000 0000000000000000 ffff8000fb493dc0
> >> ffff0000088e1450
> >> [    2.955936] 3dc0: ffff8000fb493dd0 ffff000008083144 ffff8000fb493e40
> >> ffff0000088c0c98
> >> [    2.964658] 3de0: ffff000008907240 0000000000000006 00000000000000e7
> >> ffff0000088f8b30
> >> [    2.973506] 3e00: ffff8000fb493e00 ffff0000087f42c8 ffff8000fb493e20
> >> ffff0000087f3ae8
> >> [    2.982326] 3e20: 0000000600000006 0000000000000000 0000000000000000
> >> ffff0000088aba00
> >> [    2.991129] 3e40: ffff8000fb493ea0 ffff000008678154 ffff000008678144
> >> 0000000000000000
> >> [    2.999922] 3e60: 0000000000000000 0000000000000000 0000000000000000
> >> 0000000000000000
> >> [    3.008671] 3e80: 0000000000000000 0000000000000000 0000000000000000
> >> 0000000000000000
> >> [    3.017500] 3ea0: 0000000000000000 ffff000008082e80 ffff000008678144
> >> 0000000000000000
> >> [    3.026294] 3ec0: 0000000000000000 0000000000000000 0000000000000000
> >> 0000000000000000
> >> [    3.035043] 3ee0: 0000000000000000 0000000000000000 0000000000000000
> >> 0000000000000000
> >> [    3.043818] 3f00: 0000000000000000 0000000000000000 0000000000000000
> >> 0000000000000000
> >> [    3.052639] 3f20: 0000000000000000 0000000000000000 0000000000000000
> >> 0000000000000000
> >> [    3.061432] 3f40: 0000000000000000 0000000000000000 0000000000000000
> >> 0000000000000000
> >> [    3.070207] 3f60: 0000000000000000 0000000000000000 0000000000000000
> >> 0000000000000000
> >> [    3.079036] 3f80: 0000000000000000 0000000000000000 0000000000000000
> >> 0000000000000000
> >> [    3.087820] 3fa0: 0000000000000000 0000000000000000 0000000000000000
> >> 0000000000000000
> >> [    3.096623] 3fc0: 0000000000000000 0000000000000005 0000000000000000
> >> 0000000000000000
> >> [    3.105398] 3fe0: 0000000000000000 0000000000000000 000000017b493ff0
> >> 000000017b493ff8
> >> [    3.114173] Call trace:
> >> [    3.116920] [<ffff00000839d984>] pci_generic_config_read32+0x74/0xa0
> >> [    3.124039] [<ffff0000083b65cc>] iproc_pcie_config_read32+0x2c/0xe0
> >> [    3.131041] [<ffff00000839dcc8>] pci_bus_read_config_dword+0x80/0xb0
> >> [    3.138143] [<ffff00000839fcb8>] pci_bus_read_dev_vendor_id+0x30/0x104
> >> [    3.145459] [<ffff0000083a1380>] pci_scan_single_device+0x50/0xc4
> >> [    3.152345] [<ffff0000083a1444>] pci_scan_slot+0x50/0xf0
> >> [    3.158334] [<ffff0000083a237c>] pci_scan_child_bus+0x50/0x164
> >> [    3.164798] [<ffff0000083a20d8>] pci_scan_bridge+0x2c0/0x514
> >> [    3.171154] [<ffff0000083a23d8>] pci_scan_child_bus+0xac/0x164
> >> [    3.177690] [<ffff0000083b731c>] iproc_pcie_setup+0x71c/0xc78
> >> [    3.184172] [<ffff0000083b8774>] iproc_pcie_pltfm_probe+0x170/0x260
> >> [    3.191176] [<ffff000008414ef8>] platform_drv_probe+0x38/0x7c
> >> [    3.197640] [<ffff000008413688>] really_probe+0x1b0/0x248
> >> [    3.203701] [<ffff0000084137c0>] __driver_attach+0xa0/0xb0
> >> [    3.209878] [<ffff000008411900>] bus_for_each_dev+0x58/0x98
> >> [    3.216110] [<ffff000008413124>] driver_attach+0x20/0x28
> >> [    3.222063] [<ffff000008412d84>] bus_add_driver+0x1c8/0x22c
> >> [    3.228285] [<ffff000008413eb4>] driver_register+0x68/0x108
> >> [    3.234517] [<ffff000008414eb8>] __platform_driver_register+0x4c/0x54
> >> [    3.241772] [<ffff0000088e1450>] iproc_pcie_pltfm_driver_init+0x18/0x20
> >> [    3.249224] [<ffff000008083144>] do_one_initcall+0x38/0x128
> >> [    3.255466] [<ffff0000088c0c98>] kernel_init_freeable+0x14c/0x1ec
> >> [    3.262344] [<ffff000008678154>] kernel_init+0x10/0xfc
> >> [    3.268118] [<ffff000008082e80>] ret_from_fork+0x10/0x50
> >> [    3.274108] Code: 52800000 f9400bf3 a8c37bfd d65f03c0 (b9000080)
> >> [    3.280984] ---[ end trace d90bb74924ac9e8e ]---
> >> [    3.286202] note: swapper/0[1] exited with preempt_count 1
> >> [    3.292340] Kernel panic - not syncing: Attempted to kill init!
> >> exitcode=0x0000000b
> >> [    3.292340]
> >>
> > 
> > I originally tested this patch with the following DT change to enable
> > that PCI slot on the host-iproc branch (uname reports it as 4.9.0-rc1+).
> > I also just tested it again to be sure and I do not see the same crash
> > you see.  I'll test Linus' tree and see if I can reproduce what you are
> > seeing.  We can also share configs offline if needed.
> > 
> 
> Does this require a certain version of Chimp firmware to run on Nitro
> for it to work properly?

It _may_.  I've been testing with 0.0.7.0 -- which version are you using?
