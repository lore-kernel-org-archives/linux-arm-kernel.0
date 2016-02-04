From: gabriele.paoloni@huawei.com (Gabriele Paoloni)
Date: Thu, 4 Feb 2016 16:44:12 +0000
Subject: [RFC PATCH 0/4] Add ACPI support for HiSilicon PCIe Host
 Controllers
In-Reply-To: <76564455.dlc1WHiVY2@wuerfel>
References: <1454585860-60709-1-git-send-email-gabriele.paoloni@huawei.com>
 <2387127.DMZaDnZvEW@wuerfel>
 <EE11001F9E5DDD47B7634E2F8A612F2E1EC9EC12@lhreml503-mbs>
 <76564455.dlc1WHiVY2@wuerfel>
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E1EC9EF4B@lhreml503-mbs>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd at arndb.de]
> Sent: 04 February 2016 16:07
> To: Gabriele Paoloni
> Cc: Guohanjun (Hanjun Guo); Wangzhou (B); liudongdong (C); Linuxarm;
> qiujiang; bhelgaas at google.com; Lorenzo.Pieralisi at arm.com;
> tn at semihalf.com; zhangjukuo; xuwei (O); Liguozhu (Kenneth); linux-
> pci at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux-
> acpi at vger.kernel.org; linux-kernel at vger.kernel.org; jcm at redhat.com
> Subject: Re: [RFC PATCH 0/4] Add ACPI support for HiSilicon PCIe Host
> Controllers
> 
> On Thursday 04 February 2016 15:11:18 Gabriele Paoloni wrote:
> > >
> > > ACPI has its own PCI support, and should not need drivers for host
> > > bridges. I don't think we can really mix the two things, as ACPI
> > > needs to have access to things like PCI config space way before
> > > we are probing normal device drivers.
> > >
> > > Please put this in drivers/acpi/pci*.c.
> >
> > I can put pcie-hisi-acpi.c under drivers/acpi/
> >
> > However if you look at the driver it is made up of three parts:
> > pcie-hisi.c --> the DT based driver
> > pcie-hisi-acpi.c --> the ACPI based hook and ACPI specific init
> callback
> > pcie-hisi-common.c --> common functions shared between DT and ACPI
> versions
> >                        of the driver
> >
> > Now I think that moving pcie-hisi-acpi.c under drivers/acpi/
> > would make it hard to read as you need to jump across directories
> > and it seems a bit unnatural...
> >
> > However it is not a big issue to me...
> 
> That's not really what I meant though: the pcie-hisi driver uses the
> pcie-designware.c library, most of which makes no sense in an
> environment
> where you have ACPI, e.g. link training, custom MSI support, initial
> register setup, platform driver hooks, etc.
> 
> You should add a very minimal set of hacks for the parts in this driver
> that diverge from a standard SBSA compliant PCIe host that ACPI expects.

Effectively the ACPI version of the HiSilicon driver does not rely on
Designware as much as the DT version (that calls dw_pcie_host_init());
however in order to do what you suggest I'd need to copy and paste and
modify dw_pcie_rd_conf and dw_pcie_wr_conf.
Also I'd need to declare duplicate version of the functions in
pcie-hisi-common.c (if I do not want to split the object across
different paths "drivers/pci/host" and "drivers/acpi/")

Now I can do it but I thought it was more correct to pass &dw_pcie_ops
as input pointer in DECLARE_ACPI_MCFG_FIXUP(); this is also because maybe in
future other Designware based controllers may need to support ACPI and it
would be easier for them to reuse their DT based driver functions

Honestly I am a bit confused...

Thanks

Gab

> 
> 	Arnd
