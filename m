From: zhiqiang.hou@nxp.com (Z.q. Hou)
Date: Thu, 12 Oct 2017 03:17:57 +0000
Subject: [PATCH 1/2] PCI: Disable MSI for Freescale PCIe RC mode
In-Reply-To: <20171011193737.GP25517@bhelgaas-glaptop.roam.corp.google.com>
References: <20170922072522.36306-1-Zhiqiang.Hou@nxp.com>
 <20170922072522.36306-2-Zhiqiang.Hou@nxp.com>
 <20171011193737.GP25517@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <AM5PR0402MB2771384AB34878A38DD9ABD2844B0@AM5PR0402MB2771.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bjorn,

Thanks a lot for your comments!

> -----Original Message-----
> From: Bjorn Helgaas [mailto:helgaas at kernel.org]
> Sent: 2017?10?12? 3:38
> To: Z.q. Hou <zhiqiang.hou@nxp.com>
> Cc: linux-kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> linux-pci at vger.kernel.org; bhelgaas at google.com; Roy Zang
> <roy.zang@nxp.com>; Mingkai Hu <mingkai.hu@nxp.com>; M.h. Lian
> <minghuan.lian@nxp.com>
> Subject: Re: [PATCH 1/2] PCI: Disable MSI for Freescale PCIe RC mode
> 
> On Fri, Sep 22, 2017 at 03:25:21PM +0800, Zhiqiang Hou wrote:
> > From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> >
> > The Freescale PCIe controller advertises the MSI/MSI-X capability in
> > both RC and Endpoint mode, but in RC mode it doesn't support MSI/MSI-X
> > by it self, it can only transfer MSI/MSI-X from downstream
> 
> s/it self,/itself;/

I'll fix this typo in next version.

> > devices. So add this quirk to prevent use of MSI/MSI-X in RC mode.
> >
> > Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> > ---
> >  drivers/pci/quirks.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c index
> > a4d33619a7bb..c1063a420f0c 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -4799,3 +4799,11 @@ static void quirk_no_ats(struct pci_dev *pdev)
> >  /* AMD Stoney platform GPU */
> >  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x98e4, quirk_no_ats);
> > #endif /* CONFIG_PCI_ATS */
> > +
> > +/* Freescale PCIe doesn't support MSI in RC mode */ static void
> > +quirk_fsl_no_msi(struct pci_dev *pdev) {
> > +	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT)
> > +		pdev->no_msi = 1;
> > +}
> > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_FREESCALE, PCI_ANY_ID,
> > +quirk_fsl_no_msi);
> 
> This disables MSI for all Freescale root ports, past, present, and future.  Is
> that really what you want?  This is a bug (the root port shouldn't advertise
> MSI if it doesn't support it), and presumably it might be fixed in some future
> device?

For the past and present, there isn't Freescale root ports supporting MSI. If the future Freescale root port support MSI, I'll add a patch for it checking the PCI device ID to determine if apply the quirk.
And it should be ok for the root ports without this bug.

> 
> This needs an ack from Minghuan or Mingkai (based on MAINTAINERS).
> 

Thanks,
Zhiqiang
