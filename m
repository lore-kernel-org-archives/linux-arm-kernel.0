From: gabriele.paoloni@huawei.com (Gabriele Paoloni)
Date: Mon, 3 Jul 2017 16:08:02 +0000
Subject: [PATCH v9 5/7] ACPI: Translate the I/O range of non-MMIO
 devices before scanning
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E40ACFC3D@FRAEML521-MBX.china.huawei.com>
References: <EE11001F9E5DDD47B7634E2F8A612F2E40AAE3DA@FRAEML521-MBX.china.huawei.com>
 <20170613151013.GT3187@lahna.fi.intel.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E40AAF0BF@FRAEML521-MBX.china.huawei.com>
 <20170613200339.GX3187@lahna.fi.intel.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E40AB537A@FRAEML521-MBX.china.huawei.com>
 <20170616083313.GY3187@lahna.fi.intel.com>
 <CAJZ5v0gWGL=M1+T2DxFfwAi=gCbBBnLFVyp4u+1EVem-mcSNQg@mail.gmail.com>
 <20170616120048.GC629@lahna.fi.intel.com>
 <CAJZ5v0g+qVui6RU=Hy3c_3qAAWngqaAu6B3JxGOpqF06kitbzA@mail.gmail.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E40ACFB8D@FRAEML521-MBX.china.huawei.com>
 <20170619100209.GC629@lahna.fi.intel.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E40ACFC3D@FRAEML521-MBX.china.huawei.com>
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E40B10487@FRAEML521-MBX.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mika

> -----Original Message-----
> From: linux-pci-owner at vger.kernel.org [mailto:linux-pci-
> owner at vger.kernel.org] On Behalf Of Gabriele Paoloni
> Sent: 19 June 2017 11:05
> To: Mika Westerberg
> Cc: Rafael J. Wysocki; Lorenzo Pieralisi; Rafael J. Wysocki;
> catalin.marinas at arm.com; will.deacon at arm.com; robh+dt at kernel.org;
> frowand.list at gmail.com; bhelgaas at google.com; arnd at arndb.de; linux-arm-
> kernel at lists.infradead.org; mark.rutland at arm.com;
> brian.starkey at arm.com; olof at lixom.net; benh at kernel.crashing.org; linux-
> kernel at vger.kernel.org; linux-acpi at vger.kernel.org; Linuxarm; linux-
> pci at vger.kernel.org; minyard at acm.org; John Garry; xuwei (O)
> Subject: RE: [PATCH v9 5/7] ACPI: Translate the I/O range of non-MMIO
> devices before scanning
> 
> Hi Mika
> 
> > -----Original Message-----
> > From: Mika Westerberg [mailto:mika.westerberg at linux.intel.com]
> > Sent: 19 June 2017 11:02
> > To: Gabriele Paoloni
> > Cc: Rafael J. Wysocki; Lorenzo Pieralisi; Rafael J. Wysocki;
> > catalin.marinas at arm.com; will.deacon at arm.com; robh+dt at kernel.org;
> > frowand.list at gmail.com; bhelgaas at google.com; arnd at arndb.de; linux-
> arm-
> > kernel at lists.infradead.org; mark.rutland at arm.com;
> > brian.starkey at arm.com; olof at lixom.net; benh at kernel.crashing.org;
> linux-
> > kernel at vger.kernel.org; linux-acpi at vger.kernel.org; Linuxarm; linux-
> > pci at vger.kernel.org; minyard at acm.org; John Garry; xuwei (O)
> > Subject: Re: [PATCH v9 5/7] ACPI: Translate the I/O range of non-MMIO
> > devices before scanning
> >
> > On Mon, Jun 19, 2017 at 09:50:49AM +0000, Gabriele Paoloni wrote:
> > > Many thanks for your response and your help here.
> > >
> > > I guess that as conclusion with respect to the current v9 patchset
> we
> > can
> > > disregard the idea of MFD and modify the current v9 so that it
> > doesn't
> > > touch directly ACPI resources.
> > > Instead as I proposed before we can have the scan handler to
> > enumerate
> > > the children devices and translate its addresses filling dev-
> > >resources[] and
> > > at the same time we can modify acpi_default_enumeration to check
> > > acpi_device_enumerated() before continuing with device
> > enumeration...?
> > >
> > > Do you think it as a viable solution?
> >
> > No, I think MFD + scan handler inside the MFD driver is the way to
> go.
> > We don't want to trash ACPI core with stuff that does not belong
> there
> > IMHO.
> 
> Ok Many thanks I will investigate this direction

I had a look into the MFD framework. If my understanding is correct the mfd
framework create a platform device for each declared mfd_cell that is passed
to mfd_add_devices().
However there is something that I do not quite understand:
from
http://elixir.free-electrons.com/linux/latest/source/drivers/mfd/mfd-core.c#L207
it seems that mfd_add_device() will create the platform device using the
resources that are statically declared in the respective mfd_cell.

In my case I'd like to have a platform device using the resources that are
parsed from the ACPI table (i.e. as it is done now by 
acpi_create_platform_device()).

If my understanding is correct, if I declared an mfd_cell for my IPMI child
the mfd subsystem would create a platform device for such child and
therefore acpi_create_platform_device() would fail to create a new platform
device as adev->physical_node_count will be non zero.
However as things stand now mfd_cell devices can only use the resources
that are statically defined in the code (and therefore not the ones in the
ACPI nodes)...am I right?

Thanks
Gab

> 
> >
> > Also you don't need to modify acpi_default_enumeration() because you
> > can
> > mark your device enumerated in the MFD driver. So all the dirty
> details
> > will be in the MFD driver and not in ACPI core.
> 
> Ok got it :)
> 
> Cheers
> Gab
