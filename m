From: bharat.kumar.gogada@xilinx.com (Bharat Kumar Gogada)
Date: Fri, 16 Oct 2015 12:05:04 +0000
Subject: Need help with device tree formation
References: <loom.20151016T121454-619@post.gmane.org>
 <3760709.3HqJjr2Sog@wuerfel>
Message-ID: <8520D5D51A55D047800579B094147198016917C6@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> >
> > On Friday 16 October 2015 11:27:15 bharat kumar gogada wrote:
> > > nwl_pcie: pcie at fd0e0000 {
> > >                         #address-cells = >;
> > >                         #size-cells = <2>;
> > >                         compatible = "xlnx,nwl-pcie-2.11";
> > >                         #interrupt-cells = <1>;
> > >                         interrupt-controller;
> > >                         msi-controller;
> > >                         device_type = "pci";
> > >                         interrupt-parent = <&gic>;
> > >                         interrupts = < 0 118 4
> > >                                        0 116 4
> > >                                        0 115 4          // MSI_1 [63...32]
> > >                                        0 114 4 >;       // MSI_0 [31...0]
> > >                         interrupt-names = "misc", "intx", "msi_1", "msi_0";
> > >                         interrupt-map-mask = <0x0 0x0 0x0 0x7>;
> > >                         interrupt-map = <0x0 0x0 0x0 0x1 &gic 0x0 116 0x4
> > >                                          0x0 0x0 0x0 0x2 &gic 0x0 116 0x4
> > >                                          0x0 0x0 0x0 0x3 &gic 0x0 116 0x4
> > >                                          0x0 0x0 0x0 0x4 &gic 0x0
> > > 116
> > > 0x4>;
> >
> > The interrupt-map looks wrong, as you point to the gic rather than
> > &nwl_pcie here. Also, you seem to have only one interrupt for all
> > INTx, so you use an all-zeroes interrupt-map-mask and only one entry
> here.
Yes I was confused with the interrupt mapping property documentation, I will correct the mapping we have all four INTx, I will change it accordingly. Thanks for pointing out.
> >
> > >                         msi-parent = <&nwl_pcie>;
> > >                         reg = <0x0 0xfd0e0000 0x1000
> > >                                0x0 0xfd480000 0x1000
> > >                                0x0 0xE0000000 0x1000000>;
> > >                         reg-names = "breg", "pcireg", "cfg";
> > >                         ranges = <0x02000000 0x00000000 0xE1000000
> > > 0x00000000 0xE1000000 0 0x0F000000>;
> > >
> > > };
> > >
> > > I have the above device tree node in root port driver i have two
> > > separate domains one for legacy and other is MSI hierarchy domain;
> > > in both domains I'm using same node to create domain, what i observed
> is:
> > >
> > > MSI interrupts are working only without interrupt-controller
> > > property, legacy is working with interrupt-controller property this
> > > is due to logic in  of_irq_parse_and_map_pci.
> >
> > Do you know what causes the MSI to not work when there is an
> > interrupt- controller property?
> >
> > 	Arnd
> 
> I'm not exactly sure but this is what happening when I do interface up:
> 
> [  267.167825] tg3 0000:01:00.0 eth1: No interrupt was generated using MSI.
> Switching to INTx mode. Please report this failure to the PCI maintainer and
> include system chipset information
> 
> [  267.204327] Unable to handle kernel NULL pointer dereference at virtual
> address 0000000c [  267.213116] pgd = ffffffc0366d5000 [  267.217173]
> [0000000c] *pgd=000000003646f003, *pud=000000003646f003,
> *pmd=0000000000000000 [  267.227273] Internal error: Oops: 96000006 [#1]
> SMP [  267.232849] Modules linked in:
> [  267.237266] CPU: 1 PID: 1419 Comm: ifconfig Not tainted 4.2.0-rc2-00001-
> g3dec4f4-dirty #153 [  267.246283] Hardware name: ZynqMP EP108 (DT) [
> 267.251564] task: ffffffc039005080 ti: ffffffc036668000 task.ti: ffffffc036668000
> [  267.260846] PC is at pci_msi_domain_write_msg+0x10/0x34
> [  267.267292] LR is at msi_domain_activate+0x34/0x70
> 
> [  267.850610] [<ffffffc00047e16c>] pci_msi_domain_write_msg+0x10/0x34
> [  267.857996] [<ffffffc0000f78c4>] msi_domain_activate+0x30/0x70 [
> 267.864914] [<ffffffc0000f653c>] irq_domain_activate_irq+0x40/0x50 [
> 267.872089] [<ffffffc0000f3cb8>] irq_startup+0x34/0x90 [  267.878169]
> [<ffffffc0000f2328>] __setup_irq+0x478/0x4ec [  267.884395]
> [<ffffffc0000f24fc>] request_threaded_irq+0xc8/0x17c [  267.891479]
> [<ffffffc0005668a0>] tg3_request_irq+0x94/0x178 [  267.898132]
> [<ffffffc00057d518>] tg3_start+0xdf4/0xe4c [  267.904257]
> [<ffffffc00057d664>] tg3_open+0xf4/0x21c [  267.910369]
> [<ffffffc000654d88>] __dev_open+0xb0/0x120 [  267.916514]
> [<ffffffc000655048>] __dev_change_flags+0x88/0x150 [  267.923333]
> [<ffffffc00065512c>] dev_change_flags+0x1c/0x5c
> 
> [  267.930032] [<ffffffc0006b089c>] devinet_ioctl+0x690/0x74c [  267.936566]
> [<ffffffc0006b1f18>] inet_ioctl+0x88/0xb0 [  267.942738] [<ffffffc000638bbc>]
> sock_ioctl+0x20c/0x2fc [  267.949118] [<ffffffc0001b8fbc>]
> do_vfs_ioctl+0x318/0x5bc [  267.955538] [<ffffffc0001b92e0>]
> SyS_ioctl+0x80/0x98
> 
> 
> That means it is receiving msi_desc pointer null in
> pci_msi_domain_write_msg
> 
> This is the domain initialization code  (showing whats required)
> 
> pcie->legacy_irq_domain = irq_domain_add_linear(node, 4,
>                                                  &legacy_domain_ops,
>                                                  pcie);
> 
> msi->dev_domain = irq_domain_add_linear (NULL, INT_PCI_MSI_NR,
>                                                 &dev_msi_domain_ops, pcie);
> 
> msi->msi_chip.domain = pci_msi_create_irq_domain (node,
> &nwl_msi_domain_info,
>                                                                 msi->dev_domain);
> 
> Im using same devicetree node for for both domains registration.
> 
> This is what im having I did not debug more.
> 
> bharat
