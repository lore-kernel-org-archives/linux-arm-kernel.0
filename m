From: gabriele.paoloni@huawei.com (Gabriele Paoloni)
Date: Tue, 23 Feb 2016 02:47:22 +0000
Subject: [RFC PATCH v3 3/3] PCI/ACPI: hisi: Add ACPI support for
 HiSilicon SoCs Host Controllers
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E1ECB1D30@lhreml503-mbs>
References: <1455039260-6040-1-git-send-email-gabriele.paoloni@huawei.com>
 <1455039260-6040-4-git-send-email-gabriele.paoloni@huawei.com>
 <20160209182429.GD4348@leverpostej>
 <EE11001F9E5DDD47B7634E2F8A612F2E1ECB1591@lhreml503-mbs>
 <20160210111234.GC2632@leverpostej>
 <EE11001F9E5DDD47B7634E2F8A612F2E1ECB1D30@lhreml503-mbs>
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E1ECC5F00@lhreml503-mbs>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark

> -----Original Message-----
> From: Gabriele Paoloni
> Sent: 10 February 2016 22:45
> To: Mark Rutland
> Cc: Guohanjun (Hanjun Guo); Wangzhou (B); liudongdong (C); Linuxarm;
> qiujiang; bhelgaas at google.com; arnd at arndb.de; Lorenzo.Pieralisi at arm.com;
> tn at semihalf.com; linux-pci at vger.kernel.org; linux-
> kernel at vger.kernel.org; xuwei (O); linux-acpi at vger.kernel.org;
> jcm at redhat.com; zhangjukuo; Liguozhu (Kenneth); linux-arm-
> kernel at lists.infradead.org
> Subject: RE: [RFC PATCH v3 3/3] PCI/ACPI: hisi: Add ACPI support for
> HiSilicon SoCs Host Controllers
> 
> > -----Original Message-----
> > From: linux-kernel-owner at vger.kernel.org [mailto:linux-kernel-
> > owner at vger.kernel.org] On Behalf Of Mark Rutland
> > Sent: 10 February 2016 11:13
> > To: Gabriele Paoloni
> > Cc: Guohanjun (Hanjun Guo); Wangzhou (B); liudongdong (C); Linuxarm;
> > qiujiang; bhelgaas at google.com; arnd at arndb.de;
> > Lorenzo.Pieralisi at arm.com; tn at semihalf.com; linux-pci at vger.kernel.org;
> > linux-kernel at vger.kernel.org; xuwei (O); linux-acpi at vger.kernel.org;
> > jcm at redhat.com; zhangjukuo; Liguozhu (Kenneth); linux-arm-
> > kernel at lists.infradead.org
> > Subject: Re: [RFC PATCH v3 3/3] PCI/ACPI: hisi: Add ACPI support for
> > HiSilicon SoCs Host Controllers
> >
> > On Wed, Feb 10, 2016 at 09:52:36AM +0000, Gabriele Paoloni wrote:
> > > Hi Mark
> > >
> > > > On Tue, Feb 09, 2016 at 05:34:20PM +0000, Gabriele Paoloni wrote:
> > > > > From: gabriele paoloni <gabriele.paoloni@huawei.com>
> > > > > +/*
> > > > > + * Retrieve rc_dbi base and size from _DSD
> > > > > + * Name (_DSD, Package () {
> > > > > + *	ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> > > > > + *	Package () {
> > > > > + *	Package () {"rc-dbi", Package () { 0x0, 0xb0080000, 0x0,
> > 0x10000
> > > > }},
> > > > > + *	}
> > > > > + *	})
> > > > > + */
> > > >
> > > > As above, this does not look right. ACPI has standard mechanisms
> > for
> > > > describing addresses. Making something up like this is not a good
> > idea.
> > >
> > > I am quite new to ACPI, may I ask you to explain a bit?
> >
> > ACPI has standard mechanisms for describing certain resources, and
> > these
> > should not be described in _DSD. Memory or IO address regions are
> such
> > resources (in _CRS, IIRC), and should not be described in _DSD.
> 
> Hi Mark,
> 
> In my case I think in need to look into the MCFG object as the problem
> I have is RC using a different range than the rest of the hierarchy.
> 
> I'll investigate this and try to come with a solution in v4

I have looked into this and in our case we cannot use the
standard MCFG object to pass the RC config space addresses.

The reason is that in our HW we have the config base addresses of the 
root complex ports that are less than 0x100000 byte distant one from
the other as we only map the first 0x10000 bytes.

Now the MCFG acpi framework always fix the MCFG resource size to 0x100000
for each bus; therefore if we pass our RC addresses through MCFG we end
up with a resource conflict.

To give you a practical example we are in a situation where we have:

port0: [0x00000000b0080000 - 0x00000000b0080000 + 0x10000]
port1: [0x00000000b0090000 - 0x00000000b0090000 + 0x10000]
port2: [0x00000000b00A0000 - 0x00000000b00A0000 + 0x10000]
port3: [0x00000000b00B0000 - 0x00000000b00B0000 + 0x10000]
  
So if we pass the base addresses through MCFG the resources
will overlap as MCFG will consider 0x100000 size for each base
address of the root complex (only the RC bus uses that address)

So far I do not see many option other than using _DSD to pass
these RC config base addresses.

Thanks and Regards

Gab 

> 
> Many Thanks
> 
> Gab
> 
> >
> > Thanks,
> > Mark.
