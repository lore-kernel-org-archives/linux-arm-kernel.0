From: rafael@kernel.org (Rafael J. Wysocki)
Date: Fri, 16 Jun 2017 13:24:32 +0200
Subject: [PATCH v9 5/7] ACPI: Translate the I/O range of non-MMIO devices
 before scanning
In-Reply-To: <20170616083313.GY3187@lahna.fi.intel.com>
References: <20170530132408.GA2556@red-moon>
 <EE11001F9E5DDD47B7634E2F8A612F2E40A7B677@FRAEML521-MBX.china.huawei.com>
 <20170606085553.GA20085@red-moon> <20170612155700.GA31930@red-moon>
 <20170613084831.GP3187@lahna.fi.intel.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E40AAE3DA@FRAEML521-MBX.china.huawei.com>
 <20170613151013.GT3187@lahna.fi.intel.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E40AAF0BF@FRAEML521-MBX.china.huawei.com>
 <20170613200339.GX3187@lahna.fi.intel.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E40AB537A@FRAEML521-MBX.china.huawei.com>
 <20170616083313.GY3187@lahna.fi.intel.com>
Message-ID: <CAJZ5v0gWGL=M1+T2DxFfwAi=gCbBBnLFVyp4u+1EVem-mcSNQg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 16, 2017 at 10:33 AM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> On Thu, Jun 15, 2017 at 06:01:02PM +0000, Gabriele Paoloni wrote:
>> Hi Mika
>>
>> > -----Original Message-----
>> > From: linux-pci-owner at vger.kernel.org [mailto:linux-pci-
>> > owner at vger.kernel.org] On Behalf Of Mika Westerberg
>> > Sent: 13 June 2017 21:04
>> > To: Gabriele Paoloni
>> > Cc: Lorenzo Pieralisi; rafael at kernel.org; Rafael J. Wysocki;
>> > catalin.marinas at arm.com; will.deacon at arm.com; robh+dt at kernel.org;
>> > frowand.list at gmail.com; bhelgaas at google.com; arnd at arndb.de; linux-arm-
>> > kernel at lists.infradead.org; mark.rutland at arm.com;
>> > brian.starkey at arm.com; olof at lixom.net; benh at kernel.crashing.org; linux-
>> > kernel at vger.kernel.org; linux-acpi at vger.kernel.org; Linuxarm; linux-
>> > pci at vger.kernel.org; minyard at acm.org; John Garry; xuwei (O)
>> > Subject: Re: [PATCH v9 5/7] ACPI: Translate the I/O range of non-MMIO
>> > devices before scanning
>> >
>> > On Tue, Jun 13, 2017 at 07:01:38PM +0000, Gabriele Paoloni wrote:
>> > > I am not very familiar with Linux MFD however the main issue here is
>> > that
>> > > 1) for IPMI we want to re-use the standard IPMI driver without
>> > touching it:
>> > >    see
>> > >
>> > >    static const struct acpi_device_id acpi_ipmi_match[] = {
>> > >          { "IPI0001", 0 },
>> > >          { },
>> > >    };
>> > >
>> > >    in "drivers/char/ipmi/ipmi_si_intf.c" (and in general any standard
>> > driver
>> > >    of an LPC child)
>> > >
>> > > 2) We need a way to guarantee that all LPC children are not
>> > enumerated
>> > >    by acpi_default_enumeration() (so for example if an ipmi node is
>> > an LPC#
>> > >    child it should not be enumerated, otherwise it should be)
>> > >    Currently acpi_default_enumeration() skips spi/i2c slaves by
>> > checking:
>> > >    1) if the acpi resource type is a serial bus
>> > >    2) if the type of serial bus descriptor is I2C or SPI
>> > >
>> > >    For LPC we cannot leverage on any ACPI property to "recognize"
>> > that our
>> > >    devices are LPC children; hence before I proposed for
>> > acpi_default_enumeration()
>> > >    to skip devices that have already been enumerated (by calling
>> > >    acpi_device_enumerated() ).
>> > >
>> > > So in the current scenario, how do you think that MFD can help?
>> >
>> > If you look at Documentation/acpi/enumeration.txt there is a chapter
>> > "MFD devices". I think it pretty much maches what you have here. An LPC
>> > device (MFD device) and bunch of child devices. The driver for your LPC
>> > device can specify _HID for each child device. Those are then mached by
>> > the MFD ACPI code to the corresponding ACPI nodes from which platform
>> > devices are created including "IPI0001".
>>
>> So I guess here in the LPC driver I would have an MFD cell for IPMI. I.e.:
>>
>>       static struct mfd_cell_acpi_match hisi_lpc_ipmi_acpi_match = {
>>               .pnpid = "IPI0001",
>>       };
>>
>> correct?
>
> Yes.
>
>> >
>> > It causes acpi_default_enumeration() to be called but it should be fine
>> > as we are dealing with platform device anyway.
>>
>> I do not quite understand how declaring such MFD cell above would make sure
>> that the LPC probe is called before the IPMI device is enumerated...
>
> In fact it may be that it is not sufficient in this case because the
> ACPI core might enumerate child devices before the LPC driver even gets
> a chance to probe so you would need to add also scan handler to the
> child devices and mark them already enumerated or something like that.

Or extend the special I2C/SPI handling to them.

Thanks,
Rafael
