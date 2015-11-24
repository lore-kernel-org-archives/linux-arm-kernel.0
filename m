From: gabriele.paoloni@huawei.com (Gabriele Paoloni)
Date: Tue, 24 Nov 2015 12:08:17 +0000
Subject: PCIe regression with DRA7xx in 4.4-rc1
In-Reply-To: <56545183.8000507@ti.com>
References: <56545183.8000507@ti.com>
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E162C92FB@lhreml503-mbs>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kishon

> -----Original Message-----
> From: Kishon Vijay Abraham I [mailto:kishon at ti.com]
> Sent: 24 November 2015 12:01
> To: linux-pci at vger.kernel.org; linux-kernel at vger.kernel.org; linux-
> omap at vger.kernel.org; james.morse at arm.com; gabriel.fernandez at st.com;
> Minghuan.Lian at freescale.com; Wangzhou (B); Gabriele Paoloni; arnd at arndb.de;
> bhelgaas at google.com; pratyush.anand at gmail.com; Nori, Sekhar;
> jingoohan1 at gmail.com; linux-arm-kernel at lists.infradead.org
> Subject: PCIe regression with DRA7xx in 4.4-rc1
> 
> Hi,
> 
> I'm seeing a regression with <d1b9cf31252e905ad563b9e863fd4470f6c3dd1c>("PCI:
> designware: Make driver arch-agnostic").
> 
> Logs using a SATA PCIe card [1]. The PCIe card enumerates fine but after that
> I
> observe "ata3.00: qc timeout (cmd 0xec), ata3.00: failed to IDENTIFY (I/O
> error, err_mask=0x4)"
> 

May this be related to the bug flagged in:

[PATCH] PCI: designware: remove wrong io_base assignment

[...]
diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 540f077c37ea..02a7452bdf23 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -440,7 +440,6 @@ int dw_pcie_host_init(struct pcie_port *pp)
 					 ret, pp->io);
 				continue;
 			}
-			pp->io_base = pp->io->start;
 			break;
 		case IORESOURCE_MEM:
 			pp->mem = win->res;
-- 
1.7.9.5
[...]

Can you try to see if applying the patch above solves the issue?

Thanks

Gab

> Logs using a Ethenet PCIe card [2]. Again here the PCIe card enumerates fine
> but when I give ifconfig up, it fails.
> 
> If I just revert commit <d1b9cf31252e905ad563b9e863fd4470f6c3dd1c>, the PCIe
> cards starts to work fine again
> 
> Logs using a SATA PCIe card [3]. Here the KINGSTON SSD gets detected fine.
> Logs using a Ethernet PCIe card [4]. I'm able to do ping tests now.
> 
> Actually I'm not able to find any obvious problems with the patch and the irq
> number and the memory resource also looks fine. Any idea what could be the
> problem?
> 
> [1] -> http://pastebin.ubuntu.com/13491456/
> [2] -> http://pastebin.ubuntu.com/13491526/
> 
> [3] -> http://pastebin.ubuntu.com/13491658/
> [4] -> http://pastebin.ubuntu.com/13491593/
> 
> Thanks
> Kishon
