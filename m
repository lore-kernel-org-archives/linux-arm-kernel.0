From: bharatku@xilinx.com (bharat kumar gogada)
Date: Thu, 15 Oct 2015 09:00:37 +0000 (UTC)
Subject: msi domains code giving segemntation fault
Message-ID: <loom.20151015T103656-178@post.gmane.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Im using follwoing devictree for pcie msi domains code for root port driver, 

nwl_pcie: pcie at fd0e0000 {
                        #address-cells = <3>;
                        #size-cells = <2>;    
                        compatible = "xlnx,nwl-pcie-2.11";
                        #interrupt-cells = <1>;
                        interrupt-controller;
                        msi-controller;
                        device_type = "pci";
                        interrupt-parent = <&gic>;
                        interrupts = < 0 118 4    
                                       0 116 4    
                                       0 115 4          // MSI_1 [63...32]
                                       0 114 4 >;       // MSI_0 [31...0]
                        interrupt-names = "misc", "intx", "msi_1", "msi_0";    
                        interrupt-map-mask = <0x0 0x0 0x0 0x7>;
                        interrupt-map = <0x0 0x0 0x0 0x1 &gic 0x0 116 0x4 
                                         0x0 0x0 0x0 0x2 &gic 0x0 116 0x4 
                                         0x0 0x0 0x0 0x3 &gic 0x0 116 0x4 
                                         0x0 0x0 0x0 0x4 &gic 0x0 116 0x4>;
                        msi-parent = <&nwl_pcie>;
                        reg = <0x0 0xfd0e0000 0x1000
                               0x0 0xfd480000 0x1000
                               0x0 0xE0000000 0x1000000>;
                        reg-names = "breg", "pcireg", "cfg";
                        ranges = <0x02000000 0x00000000 0xE1000000
0x00000000 0xE1000000 0 0x0F000000>;
                        
                };

since we don't have any seperate reg space i'm making pcie node as
msi-contrller and msi-parent pcie node itself. Is my deicetree node correct ?

I'm using following api's to create hierarchical doamins: (code reference
from pci-xgene-msi.c)
irq_domain_add_linear,
pci_msi_create_irq_domain

when i do my endpoint interface up im get following call trace 

Call trace:
[  270.908719] [<ffffffc00047e268>] pci_msi_domain_write_msg+0x4c/0x98
[  270.916295] [<ffffffc0000f795c>] msi_domain_activate+0x44/0x84
[  270.923256] [<ffffffc0000f65c8>] irq_domain_activate_irq+0x6c/0x74
[  270.930435] [<ffffffc0000f3d18>] irq_startup+0x54/0xb0
[  270.936521] [<ffffffc0000f2398>] __setup_irq+0x4e8/0x4fc
[  270.942753] [<ffffffc0000f2590>] request_threaded_irq+0x14c/0x1ac
[  270.949955] [<ffffffc0005669e8>] tg3_request_irq+0xd0/0x17c
[  270.956613] [<ffffffc0005789f0>] tg3_start+0x80c/0xedc
[  270.962740] [<ffffffc0005791b4>] tg3_open+0xf4/0x21c
[  270.968836] [<ffffffc000654e38>] __dev_open+0xb0/0x120
[  270.974988] [<ffffffc0006550f8>] __dev_change_flags+0x88/0x150
[  270.981795] [<ffffffc0006551dc>] dev_change_flags+0x1c/0x5c
[  270.988520] [<ffffffc0006b094c>] devinet_ioctl+0x690/0x74c
[  270.995053] [<ffffffc0006b1fc8>] inet_ioctl+0x88/0xb0
[  271.001227] [<ffffffc000638c6c>] sock_ioctl+0x20c/0x2fc
[  271.007620] [<ffffffc0001b9054>] do_vfs_ioctl+0x318/0x5bc
[  271.014026] [<ffffffc0001b9378>] SyS_ioctl+0x80/0x98
[  271.020030] Code: aa1303e1 91302000 940d8f3a b9400662 (b9400e81) 
[  271.030077] ---[ end trace 0aefb4737c9cffaf ]---
Segmentation fault

When i debugged what i found is, in pci_msi_domain_write_msg; mis_desc
pointer is having null, in msi_controller flow virq is given to
irq_set_msi_desc and msi descriptor is set, in msi domain flow who does this
and at what point of time. 
