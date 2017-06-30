From: mika.westerberg@linux.intel.com (Mika Westerberg)
Date: Fri, 30 Jun 2017 12:05:15 +0300
Subject: [PATCH v9 5/7] ACPI: Translate the I/O range of non-MMIO devices
 before scanning
In-Reply-To: <808a7db0-7844-b263-0216-1fe943ac819a@huawei.com>
References: <20170612155700.GA31930@red-moon>
 <20170613084831.GP3187@lahna.fi.intel.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E40AAE3DA@FRAEML521-MBX.china.huawei.com>
 <20170613151013.GT3187@lahna.fi.intel.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E40AAF0BF@FRAEML521-MBX.china.huawei.com>
 <20170613200339.GX3187@lahna.fi.intel.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E40AB537A@FRAEML521-MBX.china.huawei.com>
 <20170616083313.GY3187@lahna.fi.intel.com>
 <CAJZ5v0gWGL=M1+T2DxFfwAi=gCbBBnLFVyp4u+1EVem-mcSNQg@mail.gmail.com>
 <808a7db0-7844-b263-0216-1fe943ac819a@huawei.com>
Message-ID: <20170630090515.GU629@lahna.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 29, 2017 at 05:16:15PM +0100, John Garry wrote:
> On 16/06/2017 12:24, Rafael J. Wysocki wrote:
> > > > > >> >
> > > > > >> > It causes acpi_default_enumeration() to be called but it should be fine
> > > > > >> > as we are dealing with platform device anyway.
> > > > >>
> > > > >> I do not quite understand how declaring such MFD cell above would make sure
> > > > >> that the LPC probe is called before the IPMI device is enumerated...
> > > >
> > > > In fact it may be that it is not sufficient in this case because the
> > > > ACPI core might enumerate child devices before the LPC driver even gets
> > > > a chance to probe so you would need to add also scan handler to the
> > > > child devices and mark them already enumerated or something like that.
> > Or extend the special I2C/SPI handling to them.
> > 
> 
> For this, is it possible to just configure the ACPI table so we spoof that
> the LPC slave (IPI0001), is an i2c/spi slave? Could we just add a resource
> of type ACPI_RESOURCE_TYPE_SERIAL_BUS, and common serial bus type i2c/spi to
> solve this?

But is the device connected to a I2C or SPI bus? If not, then it does
not make much sense to declare it as I2C or SPI slave. Instead it should
be platform device which is the type we use when there is no explicit
bus specified in ACPI.
