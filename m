From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 21 May 2014 11:06:44 -0600
Subject: [PATCH v7 0/3] Add support for PCI in AArch64
In-Reply-To: <20140521113421.GB13511@bart.dudau.co.uk>
References: <1394811258-1500-1-git-send-email-Liviu.Dudau@arm.com>
 <CA+sq2Ccok5wtKjCZUkBhhj3WsiqFAoMgHK7LY210aBtMku+8SA@mail.gmail.com>
 <20140516132451.GK967@e106497-lin.cambridge.arm.com>
 <CA+sq2CejJFg--0rS1arr4Sactp-ssENB8Y3g4b61JPGPBCms=A@mail.gmail.com>
 <CA+sq2Ccp0_4hgbbWa27bkYcqiXY6Ckr8eckWnHwANvhWNo97fg@mail.gmail.com>
 <20140521113421.GB13511@bart.dudau.co.uk>
Message-ID: <20140521170644.GJ8775@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 21, 2014 at 12:34:21PM +0100, Liviu Dudau wrote:
> On Wed, May 21, 2014 at 04:45:29PM +0530, Sunil Kovvuri wrote:
> > Hi Liviu,
> > 
> > Sorry for the trouble.
> > I got why 'res->parent' is not set in my case.
> > Basically my SR-IOV device has fixed resources, so resources will not
> > be allocated/assigned and hence parent resource is not set.
> > I will move the resource claiming to host controller driver as a fixup
> > so that parent resource hierarchy is set.
> > 
> > Thanks for the support.
> 
> Glad you worked out the cause for the problem. I will still at to my list of
> ToDo things to investigate resource parenting with my patchset.

We recently fixed some things in this area on mvebu. It is important
to ensure that the aperature in the host driver has a proper resource
associated with it, or the PCI core won't create sub resources.

commit 2613ba480fb7b40c67eea36d03c9946977828623
Author: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Date:   Wed Feb 12 15:57:08 2014 -0700

    PCI: mvebu: Call request_resource() on the apertures
    
    It is typical for host drivers to request a resource for the aperture; once
    this is done the PCI core will properly populate resources for all BARs in
    the system.
    
    With this patch cat /proc/iomem will now show:
    
      e0000000-efffffff : PCI MEM 0000
        e0000000-e00fffff : PCI Bus 0000:01
          e0000000-e001ffff : 0000:01:00.0
    
    Tested on Kirkwood.
    
    Signed-off-by: Arnd Bergmann <arnd@arndb.de>
    Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Acked-by: Jason Cooper <jason@lakedaemon.net>

diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index 05e352889868..d3d1cfd51e09 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -101,7 +101,9 @@ struct mvebu_pcie {
        struct mvebu_pcie_port *ports;
        struct msi_chip *msi;
        struct resource io;
+       char io_name[30];
        struct resource realio;
+       char mem_name[30];
        struct resource mem;
        struct resource busn;
        int nports;
@@ -672,10 +674,30 @@ static int mvebu_pcie_setup(int nr, struct pci_sys_data *sys)
 {
        struct mvebu_pcie *pcie = sys_to_pcie(sys);
        int i;
+       int domain = 0;
 
-       if (resource_size(&pcie->realio) != 0)
+#ifdef CONFIG_PCI_DOMAINS
+       domain = sys->domain;
+#endif
+
+       snprintf(pcie->mem_name, sizeof(pcie->mem_name), "PCI MEM %04x",
+                domain);
+       pcie->mem.name = pcie->mem_name;
+
+       snprintf(pcie->io_name, sizeof(pcie->io_name), "PCI I/O %04x", domain);
+       pcie->realio.name = pcie->io_name;
+
+       if (request_resource(&iomem_resource, &pcie->mem))
+               return 0;
+
+       if (resource_size(&pcie->realio) != 0) {
+               if (request_resource(&ioport_resource, &pcie->realio)) {
+                       release_resource(&pcie->mem);
+                       return 0;
+               }
                pci_add_resource_offset(&sys->resources, &pcie->realio,
                                        sys->io_offset);
+       }
        pci_add_resource_offset(&sys->resources, &pcie->mem, sys->mem_offset);
        pci_add_resource(&sys->resources, &pcie->busn);
