From: ken.xue@amd.com (Ken Xue)
Date: Wed, 23 Dec 2015 17:34:01 +0800
Subject: [PATCH v2 0/2] i2c:dw: Add APM X-Gene ACPI I2C device support
In-Reply-To: <20151215145953.GK1762@lahna.fi.intel.com>
References: <1449782357-22982-1-git-send-email-lho@apm.com>
 <566F6485.2000508@amd.com> <20151215132721.GJ1762@lahna.fi.intel.com>
 <56702923.9010305@amd.com> <20151215145953.GK1762@lahna.fi.intel.com>
Message-ID: <1450863241.7740.30.camel@kxue-X58A-UD3R>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2015-12-15 at 16:59 +0200, Mika Westerberg wrote:
> On Tue, Dec 15, 2015 at 08:52:19AM -0600, Suravee Suthikulpanit wrote:
> > 
> > 
> > On 12/15/2015 07:27 AM, Mika Westerberg wrote:
> > >On Mon, Dec 14, 2015 at 06:53:25PM -0600, Suravee Suthikulanit wrote:
> > >>>I'm not sure if this has been discussed earlier. But after looking at the
> > >>>the acpi_apd driver, all we need is just the platform-specific input clock
> > >>>frequency value used by the drivers/i2c/busses/i2c-designware-core.c:
> > >>>i2c_dw_init() to calculate the values to program into the DW_IC_SS_SCL_HCNT
> > >>>and DW_IC_SS_SCL_LCNT registers.
> > >There is a way to pass *CNT values already from ACPI to the driver -- It
> > >looks for method called FMCN (or SSCN) and retrieves the values from
> > >there if found.
> > 
> > Right, I also noticed this afterward. By the way, are FMCN and SSCN
> > documented anywhere in the ACPI spec?  I am trying to figure out how to
> > update the ACPI table to add this information for the AMD Seattle (ARM64)
> > platform, and I will also submit a patch to add the new HID for this driver.
> 
> No, they are Intel inventions for the Windows I2C driver.
> 
> Here is what I know about it:
>   SSCN - Standard Mode CNTs
>   FMCN - Fast Mode CNTs
> 
> They both return a package:
> 
>   Package() {
>     HCNT,
>     LCNT,
>     SDA_hold_time,
>   }

1) Regarding
https://msdn.microsoft.com/en-us/library/windows/hardware/dn919852(v=vs.85).aspx
, Window I2C driver should pass MITT test. There are 5 I2C devices
connect to one I2C bus for test. And those devices defined different
"ConnectionSpeed" over the I2C bus by ACPI resource "I2CSerialBus".

During test, I2C bus should run in different "ConnectionSpeed" of
device.

That means windows driver can modify I2C bus speed to match the
"ConnectionSpeed" of device on-the-fly. Static value from SSCN and FMCN
can not work for WITT test cases.

It sounds like odd that multi-speed can be applied over one I2C bus, But
everything goes well.
Does this behavior(multi-speed) violate the I2C spec?

2) In theory, I2C core driver also can get ACPI resource
"ConnectionSpeed" of device during creating new I2C device. 
Is it worth to add a new feature for parsing and using "ConnectionSpeed"
of device for determining bus speed?

3) For ACPI DW adapter, current driver only support Fast mode. I would
like to support other modes after previous 2 questions are clear.
