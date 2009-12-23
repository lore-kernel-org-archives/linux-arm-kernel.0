From: ole.reinhardt@embedded-it.de (Ole Reinhardt)
Date: Wed, 23 Dec 2009 03:01:58 +0100
Subject: imx27 external data abort on ehci init
Message-ID: <1261533718.24694.30.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I'm porting the kernel to a new i.MX27 based board, which has connected
a SMSC USB3320 ulpi phy to USB Host 2.

The kernel is a 2.6.31.6 with the patches from the recent phytec oselas
bsp.

I'm facing (two) problem(s), when initialising the host.

1.)

When not using the ulpi tools and just have a ehci2 platform init
function, the kernel is crashing (see log below).

It fails in ehci-hub.c, function ehci_hub_control, at ehci_writel in:

case USB_PORT_FEAT_POWER:
	if (HCS_PPC (ehci->hcs_params))
		ehci_writel(ehci,
			  temp & ~(PORT_RWC_BITS | PORT_POWER),
			  status_reg);


2.)

When first trying to talk to the ulpi bus, I just get ulpi timeouts (the
read does not succeed).

I know that similar problems were just discussed some time ago on this
list, but I did not find a final answer / solution.

So any help ist very much appreciated!

Regards,

Ole Reinhardt


Here is my code:

static int dlt2_usbh2_init(struct platform_device *pdev)
{
	int ret;
	uint32_t temp;
	uint32_t flags;

	/* request phy /reset line and disable it (reset) */
	ret = gpio_request(GPIO_PORTC + 19, "usb-host-phy-reset");
	if (ret)
		return ret;
	/* reset phy, phy will be disabled */
	gpio_direction_output(GPIO_PORTC + 19, 0);
	mdelay(10);

	temp = readl(IO_ADDRESS(OTG_BASE_ADDR) + 0x600);
	temp &= ~(3 << 21);
//	temp &= ~((3 << 21) | 1);
//	temp |= (1 << 5) | (1 << 16) | (1 << 19) | (1 << 11) | (1 << 20);
	temp |= (1 << 5) | (1 << 16) | (1 << 19) | (1 << 20);
	writel(temp, IO_ADDRESS(OTG_BASE_ADDR) + 0x600);

	/* Enable ULPI mode in PORTSC register */
	temp = readl(IO_ADDRESS(OTG_BASE_ADDR) + 0x584);
	temp &= ~(3 << 30);
	temp |= 2 << 30;
	writel(temp, IO_ADDRESS(OTG_BASE_ADDR) + 0x584);
	mdelay(10);

	/* enable phy */
	gpio_set_value(GPIO_PORTC + 19, 1);
	mdelay(10);
// Enabling this will result in timeouts
//	ret = usb3320_set_vbus_power(IO_ADDRESS(OTG_BASE_ADDR + 0x570), 1);
	return ret;
}

static struct mxc_usbh_platform_data ehci2_pdata = {
	.init = dlt2_usbh2_init,
};














ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
mxc-ehci mxc-ehci.1: initializing i.MX USB Controller
mxc-ehci mxc-ehci.1: Freescale On-Chip EHCI Host Controller
mxc-ehci mxc-ehci.1: new USB bus registered, assigned bus number 1
Unhandled fault: external abort on non-linefetch (0x808) at 0xc88c2584
Internal error: : 808 [#1] PREEMPT
Modules linked in:
CPU: 0    Tainted: G        W   (2.6.31.6 #52)
PC is at ehci_hub_control+0x738/0x814
LR is@0x1
pc : [<c0247060>]    lr : [<00000001>]    psr: 00000093
sp : c7819e40  ip : 00000001  fp : 00000000
r10: 20000013  r9 : c88c2584  r8 : c79b2ed0
r7 : c7818000  r6 : c79b2e00  r5 : c88c2540  r4 : 00000000
r3 : 80000000  r2 : 00000007  r1 : 80001000  r0 : 00000001
Flags: nzcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 0005317f  Table: a0004000  DAC: 00000017
Process swapper (pid: 1, stack limit = 0xc7818270)
Stack: (0xc7819e40 to 0xc781a000)
9e40: 00001000 c79b2ef4 00000000 c79b8c00 00000000 00000037 c03f1a2c
c79b2ed0 
9e60: c79b2e00 c79b2ed0 00000000 c79b2e00 00000000 00000000 00000000
00000037 
9e80: c03f1a2c c02499fc 00000000 00000000 00000001 00000000 c79b2e00
000000a0 
9ea0: c79b8c00 c0232f7c c79bcaa0 c03f1a2c f4015200 c7819ec8 c002ffa0
00000000 
9ec0: 00000000 c03ef330 c79b2e00 c03ef328 c79bcaa0 c024a778 00000000
00000000 
9ee0: 00000000 00000037 c780f158 c03ef330 c03ef364 c040dc54 c0448fb0
c797dea0 
9f00: 00000000 c040b028 c04162cc c01eff9c c040dc54 c01eef6c c7826e28
c03ef330 
9f20: c03ef364 c040dc54 c01ef064 c01ef0e8 00000000 c7819f40 c040dc54
c01ee2a0 
9f40: c78034d8 c7859bf0 c001febc c01eea18 c001febc c040dc54 00000000
c01eeab0 
9f60: c03772d8 c001fb90 c044a210 c001febc c040dc54 00000000 c7818000
00000000 
9f80: c00186cc c01ef468 c044a210 c001febc c001fb90 00000000 c7818000
c0018734 
9fa0: c001fe2c c00262e0 c7819fb6 c00710a8 c00259c8 00000001 00000035
00000000 
9fc0: 00000000 c001fe2c c001febc c001fb90 00000000 00000000 00000000
00000000 
9fe0: 00000000 c0008744 00000000 00000000 00000000 c00273a8 08ffbf00
002ffb02 
[<c0247060>] (ehci_hub_control+0x738/0x814) from [<c02499fc>]
(ehci_mxc_setup+0)
[<c02499fc>] (ehci_mxc_setup+0x304/0x368) from [<c0232f7c>] (usb_add_hcd
+0x1c4/)
[<c0232f7c>] (usb_add_hcd+0x1c4/0x5b0) from [<c024a778>]
(ehci_mxc_drv_probe+0x)
[<c024a778>] (ehci_mxc_drv_probe+0x190/0x30c) from [<c01eff9c>]
(platform_drv_p)
[<c01eff9c>] (platform_drv_probe+0x1c/0x24) from [<c01eef6c>]
(driver_probe_dev)
[<c01eef6c>] (driver_probe_device+0x88/0x180) from [<c01ef0e8>]
(__driver_attac)
[<c01ef0e8>] (__driver_attach+0x84/0x88) from [<c01ee2a0>]
(bus_for_each_dev+0x)
[<c01ee2a0>] (bus_for_each_dev+0x54/0x80) from [<c01eeab0>]
(bus_add_driver+0xb)
[<c01eeab0>] (bus_add_driver+0xb8/0x2c4) from [<c01ef468>]
(driver_register+0x5)
[<c01ef468>] (driver_register+0x58/0x140) from [<c0018734>]
(ehci_hcd_init+0x68)
[<c0018734>] (ehci_hcd_init+0x68/0xa4) from [<c00262e0>]
(do_one_initcall+0x30/)
[<c00262e0>] (do_one_initcall+0x30/0x1b0) from [<c0008744>] (kernel_init
+0xa0/0)
[<c0008744>] (kernel_init+0xa0/0x114) from [<c00273a8>]
(kernel_thread_exit+0x0)
Code: e598300c e3130010 13c13a01 13c3302a (15893000) 
---[ end trace 1b75b31a2719ed1d ]---
note: swapper[1] exited with preempt_count 2
Kernel panic - not syncing: Attempted to kill init!


-- 

Thermotemp GmbH, Embedded-IT

Embedded Hard-/ Software and Open Source Development, 
Integration and Consulting

Gesch?ftsstelle Siegen - Steinstra?e 67 - D-57072 Siegen - 
tel +49 (0)271 5513597, +49 (0)271-73681 - fax +49 (0)271 736 97

Hauptsitz - Hademarscher Weg 7 - 13503 Berlin
Tel +49 (0)30 4315205 - Fax +49 (0)30 43665002
Gesch?ftsf?hrer: J?rg Friedrichs, Ole Reinhardt
Handelsregister Berlin Charlottenburg HRB 45978 UstID DE 156329280 
