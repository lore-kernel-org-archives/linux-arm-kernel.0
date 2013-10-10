From: r65037@freescale.com (Zhu Richard-R65037)
Date: Thu, 10 Oct 2013 10:40:01 +0000
Subject: [PATCH v7 0/2] Add PCIe support for i.MX6q
In-Reply-To: <201310101225.10455.marex@denx.de>
References: <1380165887-13506-1-git-send-email-shawn.guo@linaro.org>
 <201310082256.28474.marex@denx.de>
 <0E83723C55F66F43A6041464FE31119D401869@039-SN2MPN1-011.039d.mgd.msft.net>
 <201310101225.10455.marex@denx.de>
Message-ID: <0E83723C55F66F43A6041464FE31119D408C77@039-SN2MPN1-011.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek
Thanks for your kindly help on the i.MX6 PCIe switch debug.

I encountered random panic although I add the irq_map codes pasted before.
Sometimes the switch + ep device can work well, but system maybe panic sometimes. :(

Here are the logs when system is panic.
----------------------------------------
imx-pcie 1ffc000.pcie: legacy_irq 155
imx-pcie 1ffc000.pcie: map [mem 0x01ffc000-0x01ffffff]
imx-pcie 1ffc000.pcie: starting to link pcie port.
imx-pcie 1ffc000.pcie: Link up
PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [io  0x1000-0x10000]
pci_bus 0000:00: root bus resource [mem 0x01000000-0x01efffff]
pci_bus 0000:00: No busn resource found for root bus, will use [bus 00-ff]
PCI: bus0: Fast back to back transfers disabled	
PCI: bus1: Fast back to back transfers disabled
pci 0000:01:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
PCI: bus2: Fast back to back transfers disabled
pci 0000:02:01.0: bridge configuration invalid ([bus 00-00]), reconfiguring
pci 0000:02:02.0: bridge configuration invalid ([bus 00-00]), reconfiguring
PCI: bus3: Fast back to back transfers disabled
PCI: bus4: Fast back to back transfers enabled
pci 0000:00:00.0: BAR 0: assigned [mem 0x01000000-0x010fffff]
pci 0000:00:00.0: BAR 8: assigned [mem 0x01100000-0x011fffff]
pci 0000:00:00.0: BAR 9: assigned [mem 0x01200000-0x012fffff pref]
pci 0000:00:00.0: BAR 6: assigned [mem 0x01300000-0x0130ffff pref]
pci 0000:00:00.0: BAR 7: assigned [io  0x1000-0x1fff]
pci 0000:01:00.0: BAR 8: assigned [mem 0x01100000-0x011fffff]
pci 0000:01:00.0: BAR 9: assigned [mem 0x01200000-0x012fffff pref]
pci 0000:01:00.0: BAR 7: assigned [io  0x1000-0x1fff]
pci 0000:02:01.0: BAR 8: assigned [mem 0x01100000-0x011fffff]
pci 0000:02:01.0: BAR 9: assigned [mem 0x01200000-0x012fffff pref]
pci 0000:02:01.0: BAR 7: assigned [io  0x1000-0x1fff]
pci 0000:03:00.0: BAR 1: assigned [mem 0x01100000-0x0117ffff]
pci 0000:03:00.0: BAR 6: assigned [mem 0x01200000-0x0123ffff pref]
pci 0000:03:00.0: BAR 0: assigned [mem 0x01180000-0x0119ffff]
pci 0000:03:00.0: BAR 3: assigned [mem 0x011a0000-0x011a3fff]
pci 0000:03:00.0: BAR 2: assigned [io  0x1000-0x101f]
pci 0000:02:01.0: PCI bridge to [bus 03]
pci 0000:02:01.0:   bridge window [io  0x1000-0x1fff]
pci 0000:02:01.0:   bridge window [mem 0x01100000-0x011fffff]
pci 0000:02:01.0:   bridge window [mem 0x01200000-0x012fffff pref]
pci 0000:02:02.0: PCI bridge to [bus 04]
pci 0000:01:00.0: PCI bridge to [bus 02-04]
pci 0000:01:00.0:   bridge window [io  0x1000-0x1fff]
pci 0000:01:00.0:   bridge window [mem 0x01100000-0x011fffff]
pci 0000:01:00.0:   bridge window [mem 0x01200000-0x012fffff pref]
pci 0000:00:00.0: PCI bridge to [bus 01-04]
pci 0000:00:00.0:   bridge window [io  0x1000-0x1fff]
pci 0000:00:00.0:   bridge window [mem 0x01100000-0x011fffff]
pci 0000:00:00.0:   bridge window [mem 0x01200000-0x012fffff pref]
PCI: enabling device 0000:01:00.0 (0140 -> 0143)
PCI: enabling device 0000:02:01.0 (0140 -> 0143)
PCI: enabling device 0000:02:02.0 (0140 -> 0143)  ? <--PCIe bus enumeration  is finished.
...

------------------------[device driver is loaded here]---------------------------
e1000e: Intel(R) PRO/1000 Network Driver - 2.3.2-k
e1000e: Copyright(c) 1999 - 2013 Intel Corporation.
e1000e 0000:03:00.0: Disabling ASPM L0s L1
PCI: enabling device 0000:03:00.0 (0140 -> 0142)
e1000e 0000:03:00.0: Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
e1000e 0000:03:00.0 eth1: registered PHC clock
e1000e 0000:03:00.0 eth1: (PCI Express:2.5GT/s:Width x1) 00:1b:21:3a:18:8b
e1000e 0000:03:00.0 eth1: Intel(R) PRO/1000 Network Connection
e1000e 0000:03:00.0 eth1: MAC: 3, PHY: 8, PBA No: E42641-005
...
e1000e: eth1 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: Rx/Tx  ? PCIe device is ready
IPv6: ADDRCONF(NETDEV_CHANGE): eth1: link becomes ready
...
----------------------------------------
...
IP-Config: Got DHCP answer from 10.192.242.252, my address is 10.192.242.95
IP-Config: Complete:
     device=eth0, hwaddr=00:04:9f:02:18:df, ipaddr=10.192.242.95, mask=255.255.255.0, gw=10.192.242.254
     host=10.192.242.95, domain=ap.freescale.net, nis-domain=(none)
     bootserver=0.0.0.0, rootserver=10.192.225.216, rootpath=
     nameserver0=10.192.130.201, nameserver1=10.211.0.3, nameserver2=10.196.51.200
ALSA device list:
  #0: wm8962-audio
  #1: imx-hdmi-soc
VFS: Mounted root (nfs filesystem) on device 0:11.
devtmpfs: mounted
Freeing unused kernel memory: 300K (80c29000 - 80c74000)
Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b  ? <--System panic here sometimes. :(

CPU2: stopping
CPU: 2 PID: 0 Comm: swapper/2 Not tainted 3.10.9-15963-ge0eed42-dirty #133
[<80014764>] (unwind_backtrace+0x0/0xf4) from [<8001159c>] (show_stack+0x10/0x14)
[<8001159c>] (show_stack+0x10/0x14) from [<80013968>] (handle_IPI+0x108/0x130)
[<80013968>] (handle_IPI+0x108/0x130) from [<800085dc>] (gic_handle_irq+0x58/0x5c)
[<800085dc>] (gic_handle_irq+0x58/0x5c) from [<8000dc00>] (__irq_svc+0x40/0x50)
Exception stack(0x9c09bf50 to 0x9c09bf98)
bf40:                                     9c09bf98 00000008 3a3491de 00000002
bf60: 39d2f97e 00000002 8134f080 80c83f90 00000000 00000000 9c09a000 80c7e4d8
bf80: 00000017 9c09bf98 8005a4b4 80470c90 60000013 ffffffff
[<8000dc00>] (__irq_svc+0x40/0x50) from [<80470c90>] (cpuidle_enter_state+0x50/0xe0)
[<80470c90>] (cpuidle_enter_state+0x50/0xe0) from [<80470dd0>] (cpuidle_idle_call+0xb0/0x148)
[<80470dd0>] (cpuidle_idle_call+0xb0/0x148) from [<8000ebbc>] (arch_cpu_idle+0x10/0x54)
[<8000ebbc>] (arch_cpu_idle+0x10/0x54) from [<80059d48>] (cpu_startup_entry+0xfc/0x140)
[<80059d48>] (cpu_startup_entry+0xfc/0x140) from [<10646ca4>] (0x10646ca4)
CPU3: stopping
CPU: 3 PID: 0 Comm: swapper/3 Not tainted 3.10.9-15963-ge0eed42-dirty #133
[<80014764>] (unwind_backtrace+0x0/0xf4) from [<8001159c>] (show_stack+0x10/0x14)
[<8001159c>] (show_stack+0x10/0x14) from [<80013968>] (handle_IPI+0x108/0x130)
[<80013968>] (handle_IPI+0x108/0x130) from [<800085dc>] (gic_handle_irq+0x58/0x5c)
[<800085dc>] (gic_handle_irq+0x58/0x5c) from [<8000dc00>] (__irq_svc+0x40/0x50)
Exception stack(0x9c09df50 to 0x9c09df98)
df40:                                     9c09df98 00000008 3a3491de 00000002
df60: 39cdfad9 00000002 81357080 80c83f90 00000000 00000000 9c09c000 80c7e4d8
df80: 00000017 9c09df98 8005a4b4 80470c90 60000113 ffffffff
[<8000dc00>] (__irq_svc+0x40/0x50) from [<80470c90>] (cpuidle_enter_state+0x50/0xe0)
[<80470c90>] (cpuidle_enter_state+0x50/0xe0) from [<80470dd0>] (cpuidle_idle_call+0xb0/0x148)
[<80470dd0>] (cpuidle_idle_call+0xb0/0x148) from [<8000ebbc>] (arch_cpu_idle+0x10/0x54)
[<8000ebbc>] (arch_cpu_idle+0x10/0x54) from [<80059d48>] (cpu_startup_entry+0xfc/0x140)
[<80059d48>] (cpu_startup_entry+0xfc/0x140) from [<10646ca4>] (0x10646ca4)
CPU1: stopping
CPU: 1 PID: 0 Comm: swapper/1 Not tainted 3.10.9-15963-ge0eed42-dirty #133
[<80014764>] (unwind_backtrace+0x0/0xf4) from [<8001159c>] (show_stack+0x10/0x14)
[<8001159c>] (show_stack+0x10/0x14) from [<80013968>] (handle_IPI+0x108/0x130)
[<80013968>] (handle_IPI+0x108/0x130) from [<800085dc>] (gic_handle_irq+0x58/0x5c)
[<800085dc>] (gic_handle_irq+0x58/0x5c) from [<8000dc00>] (__irq_svc+0x40/0x50)
Exception stack(0x9c099f50 to 0x9c099f98)
9f40:                                     9c099f98 00000008 3a3491de 00000002
9f60: 39cdf83e 00000002 81347080 80c83f90 00000000 00000000 9c098000 80c7e4d8
9f80: 00000017 9c099f98 8005a4b4 80470c90 60000013 ffffffff
[<8000dc00>] (__irq_svc+0x40/0x50) from [<80470c90>] (cpuidle_enter_state+0x50/0xe0)
[<80470c90>] (cpuidle_enter_state+0x50/0xe0) from [<80470dd0>] (cpuidle_idle_call+0xb0/0x148)
[<80470dd0>] (cpuidle_idle_call+0xb0/0x148) from [<8000ebbc>] (arch_cpu_idle+0x10/0x54)
[<8000ebbc>] (arch_cpu_idle+0x10/0x54) from [<80059d48>] (cpu_startup_entry+0xfc/0x140)
[<80059d48>] (cpu_startup_entry+0xfc/0x140) from [<10646ca4>] (0x10646ca4)

Any ideas? 
Thanks in advance.

Best Regards
Richard Zhu


-----Original Message-----
From: Marek Vasut [mailto:marex at denx.de] 
Sent: Thursday, October 10, 2013 6:25 PM
To: Zhu Richard-R65037
Cc: linux-arm-kernel at lists.infradead.org; Bjorn Helgaas; Shawn Guo; linux-pci at vger.kernel.org; tharvey at gateworks.com; Frank Li; Sean Cross; Sascha Hauer
Subject: Re: [PATCH v7 0/2] Add PCIe support for i.MX6q

Hi Richard,

> Hi Marek:
> Thanks for your kindly tests.
> 
> Regarding to my experience on 3.0.35 kernel, besides the programming 
> the
> RdWr0 vs. RdWr1 mode into the iATU. The INTx should be configured 
> properly, for example, like the following one:
> 
> static int __init imx_pcie_map_irq(struct pci_dev *dev, u8 slot, u8 
> pin) {
>        switch (pin) {
>        case 1: return MXC_INT_PCIE_3;
>        case 2: return MXC_INT_PCIE_2;
>        case 3: return MXC_INT_PCIE_1;
>        case 4: return MXC_INT_PCIE_0;
>        default: return -1;
>        }
> }
> 
> static struct hw_pci imx_pci __initdata = {
>         .nr_controllers = 1,
>         .swizzle        = pci_std_swizzle,
>         .setup          = imx_pcie_setup,
>         .scan           = imx_pcie_scan_bus,
>         .map_irq        = imx_pcie_map_irq,
> };
> Best Regards
> Richard Zhu

Thanks for pointing this out, I'll check this. Are there plans to implement the PCIe switch support already so I won't step into someone else's work?

In the meantime, this is what I see upon probe with V6 of the patches:

Linux version 3.12.0-rc2-next-20130927+
[...]
imx6q-pcie 1ffc000.pcie: phy link never came up PCI host bridge to bus 0000:00 pci_bus 0000:00: root bus resource [io  0x1000-0x10000] pci_bus 0000:00: root bus resource [mem 0x01000000-0x01efffff] pci_bus 0000:00: No busn resource found for root bus, will use [bus 00-ff]
PCI: bus0: Fast back to back transfers disabled
PCI: bus1: Fast back to back transfers enabled
PCI: Device 0000:00:00.0 not available because of resource collisions
pcieport: probe of 0000:00:00.0 failed with error -22 pci 0000:00:00.0: BAR 0: assigned [mem 0x01000000-0x010fffff] pci 0000:00:00.0: BAR 6: assigned [mem 0x01100000-0x0110ffff pref] pci 0000:00:00.0: PCI bridge to [bus 01] pci 0000:00:00.0: PCI bridge to [bus 01]

Is this line normal/expected? Is this related to the PCIe switch I have there?
pcieport: probe of 0000:00:00.0 failed with error -22

Thank you for your help!

Best regards,
Marek Vasut
