From: gabriele.paoloni@huawei.com (Gabriele Paoloni)
Date: Mon, 19 Jun 2017 09:50:49 +0000
Subject: [PATCH v9 5/7] ACPI: Translate the I/O range of non-MMIO
 devices before scanning
In-Reply-To: <CAJZ5v0g+qVui6RU=Hy3c_3qAAWngqaAu6B3JxGOpqF06kitbzA@mail.gmail.com>
References: <20170606085553.GA20085@red-moon>
 <20170612155700.GA31930@red-moon> <20170613084831.GP3187@lahna.fi.intel.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E40AAE3DA@FRAEML521-MBX.china.huawei.com>
 <20170613151013.GT3187@lahna.fi.intel.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E40AAF0BF@FRAEML521-MBX.china.huawei.com>
 <20170613200339.GX3187@lahna.fi.intel.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E40AB537A@FRAEML521-MBX.china.huawei.com>
 <20170616083313.GY3187@lahna.fi.intel.com>
 <CAJZ5v0gWGL=M1+T2DxFfwAi=gCbBBnLFVyp4u+1EVem-mcSNQg@mail.gmail.com>
 <20170616120048.GC629@lahna.fi.intel.com>
 <CAJZ5v0g+qVui6RU=Hy3c_3qAAWngqaAu6B3JxGOpqF06kitbzA@mail.gmail.com>
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E40ACFB8D@FRAEML521-MBX.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rafael, Mika, Lorenzo

> -----Original Message-----
> From: rjwysocki at gmail.com [mailto:rjwysocki at gmail.com] On Behalf Of
> Rafael J. Wysocki
> Sent: 16 June 2017 13:23
> To: Mika Westerberg
> Cc: Rafael J. Wysocki; Gabriele Paoloni; Lorenzo Pieralisi; Rafael J.
> Wysocki; catalin.marinas at arm.com; will.deacon at arm.com;
> robh+dt at kernel.org; frowand.list at gmail.com; bhelgaas at google.com;
> arnd at arndb.de; linux-arm-kernel at lists.infradead.org;
> mark.rutland at arm.com; brian.starkey at arm.com; olof at lixom.net;
> benh at kernel.crashing.org; linux-kernel at vger.kernel.org; linux-
> acpi at vger.kernel.org; Linuxarm; linux-pci at vger.kernel.org;
> minyard at acm.org; John Garry; xuwei (O)
> Subject: Re: [PATCH v9 5/7] ACPI: Translate the I/O range of non-MMIO
> devices before scanning
> 
> On Fri, Jun 16, 2017 at 2:00 PM, Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> > On Fri, Jun 16, 2017 at 01:24:32PM +0200, Rafael J. Wysocki wrote:
> >> > In fact it may be that it is not sufficient in this case because
> the
> >> > ACPI core might enumerate child devices before the LPC driver even
> gets
> >> > a chance to probe so you would need to add also scan handler to
> the
> >> > child devices and mark them already enumerated or something like
> that.
> >>
> >> Or extend the special I2C/SPI handling to them.
> >
> > Sure but those have I2c/SpiSerialBus() resources which we can use to
> > identify them but for the ipmi thing there is nothing else than _HID
> so
> > we would need to keep a list of such devices in ACPI core.
> 
> OK, so adding a scan handler for that would be the way to go IMO.

Many thanks for your response and your help here.

I guess that as conclusion with respect to the current v9 patchset we can
disregard the idea of MFD and modify the current v9 so that it doesn't
touch directly ACPI resources.
Instead as I proposed before we can have the scan handler to enumerate
the children devices and translate its addresses filling dev->resources[] and
at the same time we can modify acpi_default_enumeration to check
acpi_device_enumerated() before continuing with device enumeration...?

Do you think it as a viable solution?

Thanks
Gab
