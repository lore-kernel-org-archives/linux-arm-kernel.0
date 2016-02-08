From: gabriele.paoloni@huawei.com (Gabriele Paoloni)
Date: Mon, 8 Feb 2016 16:06:54 +0000
Subject: [RFC PATCH v2 1/3] PCI: hisi: re-architect Hip05/Hip06
 controllers driver to preapare for ACPI
In-Reply-To: <2409806.1aGBrN4l0X@wuerfel>
References: <1454935264-6076-1-git-send-email-gabriele.paoloni@huawei.com>
 <1454935264-6076-2-git-send-email-gabriele.paoloni@huawei.com>
 <2409806.1aGBrN4l0X@wuerfel>
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E1ECACFDD@lhreml503-mbs>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd

> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd at arndb.de]
> Sent: 08 February 2016 13:50
> To: linux-arm-kernel at lists.infradead.org
> Cc: Gabriele Paoloni; Guohanjun (Hanjun Guo); Wangzhou (B); liudongdong
> (C); Linuxarm; qiujiang; bhelgaas at google.com;
> Lorenzo.Pieralisi at arm.com; tn at semihalf.com; linux-pci at vger.kernel.org;
> linux-kernel at vger.kernel.org; xuwei (O); linux-acpi at vger.kernel.org;
> jcm at redhat.com; zhangjukuo; Liguozhu (Kenneth)
> Subject: Re: [RFC PATCH v2 1/3] PCI: hisi: re-architect Hip05/Hip06
> controllers driver to preapare for ACPI
> 
> On Monday 08 February 2016 12:41:02 Gabriele Paoloni wrote:
> > +
> > +/* HipXX PCIe host only supports 32-bit config access */
> > +int hisi_pcie_common_cfg_read(void __iomem *reg_base, int where, int
> size,
> > +			      u32 *val)
> > +{
> > +	u32 reg;
> > +	u32 reg_val;
> > +	void *walker = &reg_val;
> > +
> > +	walker += (where & 0x3);
> > +	reg = where & ~0x3;
> > +	reg_val = readl(reg_base + reg);
> > +
> > +	if (size == 1)
> > +		*val = *(u8 __force *) walker;
> > +	else if (size == 2)
> > +		*val = *(u16 __force *) walker;
> > +	else if (size == 4)
> > +		*val = reg_val;
> > +	else
> > +		return PCIBIOS_BAD_REGISTER_NUMBER;
> > +
> > +	return PCIBIOS_SUCCESSFUL;
> > +}
> 
> Isn't this the same hack that Qualcomm are using?

As far as I can see Qualcomm defines its own config access
mechanism only for RC config read and also it seems they're
having problems with reporting the device class...

https://github.com/torvalds/linux/blob/master/drivers/pci/host/pcie-qcom.c#L474

Our problem is that our HW can only perform 32b rd/wr accesses
So we can't use readw/readb/writew/writeb...

Thanks

Gab

> 
> 	Arnd
