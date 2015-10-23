From: Minghuan.Lian@freescale.com (Lian M.H.)
Date: Fri, 23 Oct 2015 05:48:11 +0000
Subject: [PATCH v4 5/6] PCI: layerscape: add PCIe support for LS1043a and
 LS2080a
In-Reply-To: <20151022154715.GB16360@localhost>
References: <1444979960-24100-1-git-send-email-Minghuan.Lian@freescale.com>
 <1444979960-24100-5-git-send-email-Minghuan.Lian@freescale.com>
 <20151022154715.GB16360@localhost>
Message-ID: <DM2PR0301MB0640558021E0936464D93237E2260@DM2PR0301MB0640.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bjorn,

Our LTSSM mask is 0x3f because it includes the following states:
0x20 S_RCVRY_EQ0
0x21 S_RCVRY_EQ1
0x22 S_RCVRY_EQ2
0x23 S_RCVRY_EQ3

And I checked DesignWare Cores PCI Express Controller Databook v4.21a and found the following descriptor:
[5:0]: smlh_ltssm_state: LTSSM current state. Encoding is defined in workspace/src/include/cxpl_defs.vh

So could we use the mask 0x3f for all SoCs?

Anyway, LTSSM_PCIE_L0 in pci-layerscape.c can be replaced by LTSSM_STATE_L0 defined in pcie-designware.h.

Thanks,
Minghuan

> -----Original Message-----
> From: Bjorn Helgaas [mailto:helgaas at kernel.org]
> Sent: Thursday, October 22, 2015 11:47 PM
> To: Lian Minghuan-B31939 <Minghuan.Lian@freescale.com>
> Cc: linux-pci at vger.kernel.org; linux-arm-kernel at lists.infradead.org; Zang
> Roy-R61911 <tie-fei.zang@freescale.com>; Hu Mingkai-B21284
> <Mingkai.Hu@freescale.com>; Yoder Stuart-B08248
> <stuart.yoder@freescale.com>; Li Yang-Leo-R58472 <LeoLi@freescale.com>;
> Arnd Bergmann <arnd@arndb.de>; Bjorn Helgaas <bhelgaas@google.com>;
> Jingoo Han <jg1.han@samsung.com>; Zhou Wang
> <wangzhou1@hisilicon.com>; Estevam Fabio-R49496
> <Fabio.Estevam@freescale.com>; Lucas Stach <l.stach@pengutronix.de>
> Subject: Re: [PATCH v4 5/6] PCI: layerscape: add PCIe support for LS1043a and
> LS2080a
> 
> [+cc Fabio, Lucas]
> 
> Hi Minghuan,
> 
> On Fri, Oct 16, 2015 at 03:19:19PM +0800, Minghuan Lian wrote:
> > Both LS1043a and LS2080a are based on ARMv8 64-bit architecture and
> > have similar PCIe implementation. LUT is added to controller.
> > The patch removes the necessary fields from struct ls_pcie.
> >
> > Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
> > ---
> > This patch is based on v4.3-rc4 and [PATCH v10 3/6]
> > PCI: designware: Add ARM64 support.
> >
> > change log
> > v4:
> > 1. split to 6 patches.
> > 2. use ARCH_LAYERSCAPE instead of ARM64
> >
> > v3:
> > 1. Use 8 or 16 bit access function to simplify code 2. Add
> > ls_add_pcie_port in accordance with other DesignWare-based drivers
> >
> > v2:
> > 1. Rename ls2085a to ls2080a
> > 2. Add ls_pcie_msi_host_init()
> >
> >  drivers/pci/host/Kconfig          |  2 +-
> >  drivers/pci/host/pci-layerscape.c | 72
> > +++++++++++++++++++++++++++++++++++----
> >  2 files changed, 67 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig index
> > ae873be..8eb09ea 100644
> > --- a/drivers/pci/host/Kconfig
> > +++ b/drivers/pci/host/Kconfig
> > @@ -105,7 +105,7 @@ config PCI_XGENE_MSI
> >
> >  config PCI_LAYERSCAPE
> >  	bool "Freescale Layerscape PCIe controller"
> > -	depends on OF && ARM
> > +	depends on OF && (ARM || ARCH_LAYERSCAPE)
> >  	select PCIE_DW
> >  	select MFD_SYSCON
> >  	help
> > diff --git a/drivers/pci/host/pci-layerscape.c
> > b/drivers/pci/host/pci-layerscape.c
> > index 891e504..c53692a 100644
> > --- a/drivers/pci/host/pci-layerscape.c
> > +++ b/drivers/pci/host/pci-layerscape.c
> > @@ -31,23 +31,26 @@
> >  #define LTSSM_STATE_MASK	0x3f
> 
> BTW, not related to *this* patch, but does LTSSM_STATE_MASK really need to
> be 0x3f (6 bits), or could it be 0x1f (5 bits)?
> 
> I'd like to include Layerscape in the LTSSM_STATE_MASK cleanup done by
> Fabio:
> 
> https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/commit/?h=pci/host
> -designware&id=4788fe6ebf4594c9a95b620cbff05147c8504823
> 
> I don't have specs for any of these devices, so I don't know if this is really
> something that can vary between the different DesignWare-based devices, or if
> they all should use a mask of 0x1f.
> 
> Bjorn
