From: gabriele.paoloni@huawei.com (Gabriele Paoloni)
Date: Tue, 13 Oct 2015 14:49:07 +0000
Subject: [PATCH v10 4/6] PCI: hisi: Add PCIe host support for HiSilicon
 SoC Hip05
In-Reply-To: <6336414.HvfCQcuT3Y@wuerfel>
References: <1444445957-239522-1-git-send-email-wangzhou1@hisilicon.com>
 <1444445957-239522-5-git-send-email-wangzhou1@hisilicon.com>
 <20151012213545.GA17479@localhost> <6336414.HvfCQcuT3Y@wuerfel>
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E16242C92@lhreml503-mbs>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd at arndb.de]
> Sent: Tuesday, October 13, 2015 12:12 PM
> To: Bjorn Helgaas
> Cc: Wangzhou (B); Bjorn Helgaas; jingoohan1 at gmail.com;
> pratyush.anand at gmail.com; linux at arm.linux.org.uk;
> thomas.petazzoni at free-electrons.com; Gabriele Paoloni;
> lorenzo.pieralisi at arm.com; james.morse at arm.com; Liviu.Dudau at arm.com;
> jason at lakedaemon.net; robh at kernel.org; gabriel.fernandez at linaro.org;
> Minghuan.Lian at freescale.com; linux-pci at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; devicetree at vger.kernel.org; linux-
> kernel at vger.kernel.org; zhangjukuo; qiuzhenfa; liudongdong (C);
> qiujiang; xuwei (O); Liguozhu (Kenneth); Wangkefeng (Kevin); Rob
> Herring
> Subject: Re: [PATCH v10 4/6] PCI: hisi: Add PCIe host support for
> HiSilicon SoC Hip05
> 
> On Monday 12 October 2015 16:35:45 Bjorn Helgaas wrote:
> >
> > > +{
> > > +     u64 addr;
> > > +     struct device_node *msi_node;
> > > +     struct resource res;
> > > +     struct device_node *np = pp->dev->of_node;
> > > +     struct hisi_pcie *pcie = to_hisi_pcie(pp);
> > > +
> > > +     msi_node = of_parse_phandle(np, "msi-parent", 0);
> > > +     if (!msi_node) {
> > > +             dev_err(pp->dev, "failed to find msi-parent\n");
> > > +             return -EINVAL;
> > > +     }
> > > +     of_address_to_resource(msi_node, 0, &res);
> >
> > Does this use the "msi-parent" node in the same way as other drivers
> > do?  I'm sure there must be other places where we extract struct
> > resource information from an "msi-parent" node, but I don't see them.
> >
> > I'm trying to verify that this isn't some kind of incompatible
> > extension of the "msi-parent" property.  I cc'd Arnd and Rob (DT
> > experts).
> 
> This is not ok, what this does is that it relies on a particular
> implementation of the MSI controller and directly accesses its
> registers.

Hi Arnd, thanks for reviewing.

What we do is to retrieve the msi-parent physical address and we store it
in our internal PCIe register locations...

So we do not operate directly on the msi controller registers...

So I wonder if the current implementation is Ok to retrieve the
msi-parent address....

Thanks

Gab


> 
> Instead, it should reference only the msi irq domain and let the
> driver for the MSI controller access the registers. Otherwise this
> code has to be rewritten once the same PCI host code appears in
> a machine that has a real GICv2m or GICv3.
> 
> 	Arnd
