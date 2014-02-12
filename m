From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 12 Feb 2014 12:43:13 -0700
Subject: [PATCH 2/3] PCI: ARM: add support for virtual PCI host controller
In-Reply-To: <2006726.HhIT01YuXY@wuerfel>
References: <1391532784-1953-1-git-send-email-will.deacon@arm.com>
 <201402092130.25615.arnd@arndb.de>
 <20140210173450.GA5554@obsidianresearch.com>
 <2006726.HhIT01YuXY@wuerfel>
Message-ID: <20140212194313.GA17248@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 11, 2014 at 11:42:52AM +0100, Arnd Bergmann wrote:
> I looked briefly at the code and found that mach-kirkwood/pcie.c does
> both request_resource() and pci_add_resource_offset(), while
> drivers/pci/host/pci-mvebu.c only does the latter. Does the patch
> below restore the previous behavior?

It gets closer:

e0000000-f0000000 : <BAD>
  e0000000-e00fffff : PCI Bus 0000:01
    e0000000-e001ffff : 0000:01:00.0
      e0001000-e0001fff : /mbus/pex at e0000000/pcie at 1,0/fpga at 0/fpga_sysmon at 1000

This patch:

diff --git a/drivers/bus/mvebu-mbus.c b/drivers/bus/mvebu-mbus.c
index 2394e97..7fd54e9 100644
--- a/drivers/bus/mvebu-mbus.c
+++ b/drivers/bus/mvebu-mbus.c
@@ -876,14 +876,14 @@ static void __init mvebu_mbus_get_pcie_resources(struct device_node *np,
        ret = of_property_read_u32_array(np, "pcie-mem-aperture", reg, ARRAY_SIZE(reg));
        if (!ret) {
                mem->start = reg[0];
-               mem->end = mem->start + reg[1];
+               mem->end = mem->start + reg[1] - 1;
                mem->flags = IORESOURCE_MEM;
        }
 
        ret = of_property_read_u32_array(np, "pcie-io-aperture", reg, ARRAY_SIZE(reg));
        if (!ret) {
                io->start = reg[0];
-               io->end = io->start + reg[1];
+               io->end = io->start + reg[1] - 1;
                io->flags = IORESOURCE_IO;
        }
 }

Fixes the wrong length (e0000000-f0000000 should be e0000000-efffffff)

And this fixes the <BAD>:

diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index ef8691a..fbb89cb 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -109,7 +109,9 @@ struct mvebu_pcie {
        struct mvebu_pcie_port *ports;
        struct msi_chip *msi;
        struct resource io;
+       char io_name[30];
        struct resource realio;
+       char mem_name[30];
        struct resource mem;
        struct resource busn;
        int nports;
@@ -681,10 +683,29 @@ static int mvebu_pcie_setup(int nr, struct pci_sys_data *sys)
 {
        struct mvebu_pcie *pcie = sys_to_pcie(sys);
        int i;
+       int domain = 0;
 
+#ifdef CONFIG_PCI_DOMAINS
+       domain = sys->domain;
+#endif
+
+       snprintf(pcie->mem_name, sizeof(pcie->mem_name), "PCI MEM %04x", domain);
+       pcie->mem.name = pcie->mem_name;
+
+       snprintf(pcie->io_name, sizeof(pcie->io_name), "PCI I/O %04x", domain);
+       pcie->realio.name = pcie->io_name;


Still missing release_region..

Thoughts on upstreamining these bits?

> Since the mvebu_pcie_setup() function seems very generic at this,
> we should probably try to factor out that code into a common
> helper, at least for arm64, but ideally shared with arm32
> as well.

Yah, especially since people are not getting it completely right..

But some of the trouble here is a lack of a generic pci host driver
structure, eg I have to pull the domain number out of the ARM32
specific structure ..

Jason
