From: ml@communistcode.co.uk (Jack Mitchell)
Date: Mon, 04 Feb 2013 11:36:36 +0000
Subject: [BUG] kernel oops in pin_request
Message-ID: <510F9D44.2000700@communistcode.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I am developing a driver located at [1]. The driver has two devices on a 
single SPI bus. When the devices are probed the pins for the SPI bus get 
requested twice, as so:

   pinctrl = devm_pinctrl_get_select_default(&spi->dev);
     if (IS_ERR(pinctrl))
   {
         pr_debug("%s: Setting pins failed: %d\n", __func__, (s32) pinctrl);
   }

The driver is DT only, and as such gets it's pins and setup from the DT 
[2]. When the second request happens I get the following output the 
kernel log:

Jan 25 15:04:54 beaglebone user.err kernel: [   67.319188] 
pinctrl-single 44e10800.pinmux: pin 44e1099c already requested by 
48030000.spi; cannot claim for spi2.1
Jan 25 15:04:54 beaglebone user.err kernel: [   67.330496] 
pinctrl-single 44e10800.pinmux: pin-103 (spi2.1) status -22
Jan 25 15:04:54 beaglebone user.err kernel: [   67.337555] 
pinctrl-single 44e10800.pinmux: could not request pin 103 on device 
pinctrl-single

Which I guess is ok as the first probe already setup the pins, 
everything then works as it should. Now, when I come to unload + reload 
the module I get an oops regarding the strmcmp() in pin_request:

Jan 25 15:13:25 beaglebone user.debug kernel: [  578.600746] 
r0005spi_probe: SPI Bus 2 probed
Jan 25 15:13:25 beaglebone user.alert kernel: [  578.605991] Unable to 
handle kernel NULL pointer dereference at virtual address 00000000
Jan 25 15:13:25 beaglebone user.alert kernel: [  578.614641] pgd = cf570000
Jan 25 15:13:25 beaglebone user.alert kernel: [  578.617578] [00000000] 
*pgd=8d93a831, *pte=00000000, *ppte=00000000
Jan 25 15:13:25 beaglebone user.emerg kernel: [  578.624347] Internal 
error: Oops: 17 [#1] SMP ARM
Jan 25 15:13:25 beaglebone user.warn kernel: [  578.629303] Modules 
linked in: r0005spi(O+) [last unloaded: r0005spi]
Jan 25 15:13:25 beaglebone user.warn kernel: [  578.636135] CPU: 0    
Tainted: G           O  (3.8.0-rc5-00538-g2431418-dirty #7)
Jan 25 15:13:25 beaglebone user.warn kernel: [  578.644031] PC is at 
strcmp+0x4/0x3c
Jan 25 15:13:25 beaglebone user.warn kernel: [  578.647807] LR is at 
pin_request+0xb0/0x1e8
Jan 25 15:13:25 beaglebone user.warn kernel: [  578.652224] pc : 
[<c0295ac0>]    lr : [<c02a94fc>]    psr: a0000013
Jan 25 15:13:25 beaglebone user.warn kernel: [  578.652224] sp : 
cf4dfd38  ip : 00000000  fp : ffffffff
Jan 25 15:13:25 beaglebone user.warn kernel: [  578.664290] r10: 
00000000  r9 : 00000000  r8 : 00000059
Jan 25 15:13:25 beaglebone user.warn kernel: [  578.669792] r7 : 
cf33fe00  r6 : c08413f0  r5 : cf0bb680  r4 : cf0a2280
Jan 25 15:13:25 beaglebone user.warn kernel: [  578.676659] r3 : 
00000000  r2 : 00000000  r1 : cf33fe00  r0 : 00000000
Jan 25 15:13:25 beaglebone user.warn kernel: [  578.683531] Flags: NzCv  
IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Jan 25 15:13:25 beaglebone user.warn kernel: [  578.691038] Control: 
10c5387d  Table: 8f570019  DAC: 00000015
Jan 25 15:13:25 beaglebone user.emerg kernel: [  578.697087] Process 
insmod (pid: 566, stack limit = 0xcf4de240)
Jan 25 15:13:25 beaglebone user.emerg kernel: [  578.703318] Stack: 
(0xcf4dfd38 to 0xcf4e0000)
Jan 25 15:13:25 beaglebone user.emerg kernel: [  578.708307] fd20: 
cf0a2280 00000059
Jan 25 15:13:25 beaglebone user.emerg kernel: [  578.717039] fd40: 
cf33fe00 00000000 cf0a2280 cf52ebc0 c0af6010 c08413f0 00000000 00000000
Jan 25 15:13:25 beaglebone user.emerg kernel: [  578.725735] fd60: 
00000001 c02a99d8 cf756e90 00000003 cf4dfda0 cf52ebc0 cf52ed0c cf756cc0
Jan 25 15:13:25 beaglebone user.emerg kernel: [  578.734427] fd80: 
c0af6010 cf52ed00 bf005650 c02a8018 cf5dfac0 c08411c4 cf756cc0 cf52ed00
Jan 25 15:13:25 beaglebone user.emerg kernel: [  578.743121] fda0: 
c0af6010 c02a8074 cf756c00 cf756cc0 cf335600 bf005218 cf335600 00000000
Jan 25 15:13:25 beaglebone user.emerg kernel: [  578.751862] fdc0: 
cf335600 bf005b8c bf005b8c c031e1c0 00000001 c037e678 c037e660 c031dfac
Jan 25 15:13:25 beaglebone user.emerg kernel: [  578.764322] fde0: 
bf005b8c cf335600 cf335600 cf335634 bf005b8c c031e228 00000000 cf4dfe08
Jan 25 15:13:25 beaglebone user.emerg kernel: [  578.773168] fe00: 
bf005b8c c031c53c cf0b5478 cf334880 bf005b8c bf005b8c c0852258 cf4155c0
Jan 25 15:13:25 beaglebone user.emerg kernel: [  578.781877] fe20: 
00000000 c031d5c4 bf00594c cf0a2488 bf005b8c cf4dff58 00000000 bf005d3c
Jan 25 15:13:25 beaglebone user.emerg kernel: [  578.790570] fe40: 
00000001 c031e71c 00000000 bf005d30 cf4dff58 00000000 bf005d3c 00000001
Jan 25 15:13:25 beaglebone user.emerg kernel: [  578.799262] fe60: 
bf005650 c0008878 bf005650 00000000 00000001 bf005d30 bf005d30 cf4dff58
Jan 25 15:13:25 beaglebone user.emerg kernel: [  578.817450] fe80: 
00000000 bf005d3c 00000001 cf6e9880 bf005d78 c008b928 bf005d3c 00007fff
Jan 25 15:13:25 beaglebone user.emerg kernel: [  578.826624] fea0: 
c02a5ed0 00000053 c0875738 0000001c 00000000 c0088aac c07fab0c bf005e84
Jan 25 15:13:25 beaglebone user.emerg kernel: [  578.835756] fec0: 
c0534e14 d09f6970 cf4dfee4 00022008 20000013 c0753164 cf4dff14 c0529a18
Jan 25 15:13:25 beaglebone user.emerg kernel: [  578.844875] fee0: 
d09f9000 b6fca000 00000751 00000000 00000000 00000000 00000000 00000000
Jan 25 15:13:25 beaglebone user.emerg kernel: [  578.853984] ff00: 
00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
Jan 25 15:13:25 beaglebone user.emerg kernel: [  578.863087] ff20: 
00000000 00000000 000000d2 b6fc0000 0000a7d1 00022008 00000080 c000e364
Jan 25 15:13:25 beaglebone user.debug kernel: [  578.600746] 
r0005spi_probe: SPI Bus 2 probed
Jan 25 15:13:25 beaglebone user.alert kernel: [  578.605991] Unable to 
handle kernel NULL pointer dereference at virtual address 00000000
Jan 25 15:13:25 beaglebone user.alert kernel: [  578.614641] pgd = cf570000
Jan 25 15:13:25 beaglebone user.alert kernel: [  578.617578] [00000000] 
*pgd=8d93a831, *pte=00000000, *ppte=00000000
Jan 25 15:13:25 beaglebone user.emerg kernel: [  578.624347] Internal 
error: Oops: 17 [#1] SMP ARM
Jan 25 15:13:25 beaglebone user.warn kernel: [  578.629303] Modules 
linked in: r0005spi(O+) [last unloaded: r0005spi]
Jan 25 15:13:25 beaglebone user.warn kernel: [  578.636135] CPU: 0    
Tainted: G           O  (3.8.0-rc5-00538-g2431418-dirty #7)
Jan 25 15:13:25 beaglebone user.warn kernel: [  578.644031] PC is at 
strcmp+0x4/0x3c
Jan 25 15:13:25 beaglebone user.warn kernel: [  578.647807] LR is at 
pin_request+0xb0/0x1e8
Jan 25 15:13:25 beaglebone user.warn kernel: [  578.652224] pc : 
[<c0295ac0>]    lr : [<c02a94fc>]    psr: a0000013
Jan 25 15:13:25 beaglebone user.warn kernel: [  578.652224] sp : 
cf4dfd38  ip : 00000000  fp : ffffffff
Jan 25 15:13:25 beaglebone user.warn kernel: [  578.664290] r10: 
00000000  r9 : 00000000  r8 : 00000059
Jan 25 15:13:25 beaglebone user.warn kernel: [  578.669792] r7 : 
cf33fe00  r6 : c08413f0  r5 : cf0bb680  r4 : cf0a2280
Jan 25 15:13:25 beaglebone user.warn kernel: [  578.676659] r3 : 
00000000  r2 : 00000000  r1 : cf33fe00  r0 : 00000000
Jan 25 15:13:25 beaglebone user.warn kernel: [  578.683531] Flags: NzCv  
IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Jan 25 15:13:25 beaglebone user.warn kernel: [  578.691038] Control: 
10c5387d  Table: 8f570019  DAC: 00000015
Jan 25 15:13:25 beaglebone user.emerg kernel: [  578.697087] Process 
insmod (pid: 566, stack limit = 0xcf4de240)
Jan 25 15:13:25 beaglebone user.emerg kernel: [  578.703318] Stack: 
(0xcf4dfd38 to 0xcf4e0000)
Jan 25 15:13:25 beaglebone user.emerg kernel: [  578.708307] fd20: 
cf0a2280 00000059
Jan 25 15:13:25 beaglebone user.emerg kernel: [  578.717039] fd40: 
cf33fe00 00000000 cf0a2280 cf52ebc0 c0af6010 c08413f0 00000000 00000000
Jan 25 15:13:25 beaglebone user.emerg kernel: [  578.725735] fd60: 
00000001 c02a99d8 cf756e90 00000003 cf4dfda0 cf52ebc0 cf52ed0c cf756cc0
Jan 25 15:13:25 beaglebone user.emerg kernel: [  578.734427] fd80: 
c0af6010 cf52ed00 bf005650 c02a8018 cf5dfac0 c08411c4 cf756cc0 cf52ed00
Jan 25 15:13:25 beaglebone user.emerg kernel: [  578.743121] fda0: 
c0af6010 c02a8074 cf756c00 cf756cc0 cf335600 bf005218 cf335600 00000000
Jan 25 15:13:25 beaglebone user.emerg kernel: [  578.751862] fdc0: 
cf335600 bf005b8c bf005b8c c031e1c0 00000001 c037e678 c037e660 c031dfac
Jan 25 15:13:25 beaglebone user.emerg kernel: [  578.764322] fde0: 
bf005b8c cf335600 cf335600 cf335634 bf005b8c c031e228 00000000 cf4dfe08
Jan 25 15:13:25 beaglebone user.emerg kernel: [  578.773168] fe00: 
bf005b8c c031c53c cf0b5478 cf334880 bf005b8c bf005b8c c0852258 cf4155c0
Jan 25 15:13:25 beaglebone user.emerg kernel: [  578.781877] fe20: 
00000000 c031d5c4 bf00594c cf0a2488 bf005b8c cf4dff58 00000000 bf005d3c
Jan 25 15:13:25 beaglebone user.emerg kernel: [  578.790570] fe40: 
00000001 c031e71c 00000000 bf005d30 cf4dff58 00000000 bf005d3c 00000001
Jan 25 15:13:25 beaglebone user.emerg kernel: [  578.799262] fe60: 
bf005650 c0008878 bf005650 00000000 00000001 bf005d30 bf005d30 cf4dff58
Jan 25 15:13:25 beaglebone user.emerg kernel: [  578.817450] fe80: 
00000000 bf005d3c 00000001 cf6e9880 bf005d78 c008b928 bf005d3c 00007fff
Jan 25 15:13:25 beaglebone user.emerg kernel: [  578.826624] fea0: 
c02a5ed0 00000053 c0875738 0000001c 00000000 c0088aac c07fab0c bf005e84
Jan 25 15:13:25 beaglebone user.emerg kernel: [  578.835756] fec0: 
c0534e14 d09f6970 cf4dfee4 00022008 20000013 c0753164 cf4dff14 c0529a18
Jan 25 15:13:25 beaglebone user.emerg kernel: [  578.844875] fee0: 
d09f9000 b6fca000 00000751 00000000 00000000 00000000 00000000 00000000
Jan 25 15:13:25 beaglebone user.emerg kernel: [  578.853984] ff00: 
00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
Jan 25 15:13:25 beaglebone user.emerg kernel: [  578.863087] ff20: 
00000000 00000000 000000d2 b6fc0000 0000a7d1 00022008 00000080 c000e364
Jan 25 15:13:25 beaglebone user.emerg kernel: [  578.872190] ff40: 
cf4de000 00000000 00000000 c008bce8 00000002 c0529780 d09ef000 0000a7d1
Jan 25 15:13:25 beaglebone user.emerg kernel: [  578.881468] ff60: 
d09f6420 d09f62c8 d09f92f8 00000e98 00001218 bf005bc8 0000000f 00000000
Jan 25 15:13:25 beaglebone user.emerg kernel: [  578.890834] ff80: 
00000022 00000023 0000000e 00000009 00000007 00000000 00000000 00000000
Jan 25 15:13:25 beaglebone user.emerg kernel: [  578.899961] ffa0: 
00022da8 c000e1e0 00000000 00000000 b6fc0000 0000a7d1 00022008 00022da8
Jan 25 15:13:25 beaglebone user.emerg kernel: [  578.909073] ffc0: 
00000000 00000000 00022da8 00000080 00022098 0000a7d1 00022008 00000000
Jan 25 15:13:25 beaglebone user.emerg kernel: [  578.918243] ffe0: 
4ff71978 bed65ba8 4ff60790 4fe2e870 60000010 b6fc0000 00000000 00000000
Jan 25 15:13:25 beaglebone user.warn kernel: [  578.927032] [<c0295ac0>] 
(strcmp+0x4/0x3c) from [<c02a94fc>] (pin_request+0xb0/0x1e8)
Jan 25 15:13:25 beaglebone user.warn kernel: [  578.935371] [<c02a94fc>] 
(pin_request+0xb0/0x1e8) from [<c02a99d8>] 
(pinmux_enable_setting+0x74/0x1a4)
Jan 25 15:13:25 beaglebone user.warn kernel: [  578.945369] [<c02a99d8>] 
(pinmux_enable_setting+0x74/0x1a4) from [<c02a8018>] 
(pinctrl_select_state_locked+0xb8/0xf0)
Jan 25 15:13:25 beaglebone user.warn kernel: [  578.956637] [<c02a8018>] 
(pinctrl_select_state_locked+0xb8/0xf0) from [<c02a8074>] 
(pinctrl_select_state+0x24/0x3c)
Jan 25 15:13:25 beaglebone user.warn kernel: [  578.967743] [<c02a8074>] 
(pinctrl_select_state+0x24/0x3c) from [<bf005218>] 
(r0005spi_probe+0xfc/0x310 [r0005spi])
Jan 25 15:13:25 beaglebone user.warn kernel: [  578.978751] [<bf005218>] 
(r0005spi_probe+0xfc/0x310 [r0005spi]) from [<c037e678>] 
(spi_drv_probe+0x18/0x1c)
Jan 25 15:13:25 beaglebone user.warn kernel: [  578.989093] [<c037e678>] 
(spi_drv_probe+0x18/0x1c) from [<c031dfac>] 
(driver_probe_device+0x11c/0x330)
Jan 25 15:13:25 beaglebone user.warn kernel: [  578.998970] [<c031dfac>] 
(driver_probe_device+0x11c/0x330) from [<c031e228>] 
(__driver_attach+0x68/0x8c)
Jan 25 15:13:25 beaglebone user.warn kernel: [  579.009125] [<c031e228>] 
(__driver_attach+0x68/0x8c) from [<c031c53c>] (bus_for_each_dev+0x48/0x80)
Jan 25 15:13:25 beaglebone user.warn kernel: [  579.018774] [<c031c53c>] 
(bus_for_each_dev+0x48/0x80) from [<c031d5c4>] (bus_add_driver+0xf0/0x248)
Jan 25 15:13:25 beaglebone user.warn kernel: [  579.028379] [<c031d5c4>] 
(bus_add_driver+0xf0/0x248) from [<c031e71c>] (driver_register+0x9c/0x12c)
Jan 25 15:13:25 beaglebone user.warn kernel: [  579.037982] [<c031e71c>] 
(driver_register+0x9c/0x12c) from [<c0008878>] (do_one_initcall+0x90/0x160)
Jan 25 15:13:25 beaglebone user.warn kernel: [  579.047681] [<c0008878>] 
(do_one_initcall+0x90/0x160) from [<c008b928>] (load_module+0x1b64/0x1e28)
Jan 25 15:13:25 beaglebone user.warn kernel: [  579.057284] [<c008b928>] 
(load_module+0x1b64/0x1e28) from [<c008bce8>] (sys_init_module+0xfc/0x11c)
Jan 25 15:13:25 beaglebone user.warn kernel: [  579.066891] [<c008bce8>] 
(sys_init_module+0xfc/0x11c) from [<c000e1e0>] (ret_fast_syscall+0x0/0x30)

The pin_request portion of that driver where the traceback points to is 
as so:

   dev_dbg(pctldev->dev, "request pin %d (%s) for %s\n",
     pin, desc->name, owner);

   if (gpio_range) {
     /* There's no need to support multiple GPIO requests */
     if (desc->gpio_owner) {
       dev_err(pctldev->dev,
         "pin %s already requested by %s; cannot claim for %s\n",
         desc->name, desc->gpio_owner, owner);
       goto out;
     }

     desc->gpio_owner = owner;
   } else {
     if (desc->mux_usecount && strcmp(desc->mux_owner, owner)) {
       dev_err(pctldev->dev,
         "pin %s already requested by %s; cannot claim for %s\n",
         desc->name, desc->mux_owner, owner);
       goto out;
     }

     desc->mux_usecount++;
     if (desc->mux_usecount > 1)
       return 0;

     desc->mux_owner = owner;
   }

 From what I can gather that means that desc->mux_owner or owner must be 
an invalid pointer. Is this a bug, or am I abusing the interface in some 
subtle way?

[1] https://pastee.org/vyaz4
[2] https://pastee.org/6e2nt

Regards,
Jack.

-- 

   Jack Mitchell (jack at embed.me.uk)
   Embedded Systems Engineer
   http://www.embed.me.uk

--
