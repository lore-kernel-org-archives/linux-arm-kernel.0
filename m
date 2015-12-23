From: mika.westerberg@linux.intel.com (Mika Westerberg)
Date: Wed, 23 Dec 2015 12:17:28 +0200
Subject: [PATCH v2 0/2] i2c:dw: Add APM X-Gene ACPI I2C device support
In-Reply-To: <1450864789.7740.35.camel@kxue-X58A-UD3R>
References: <1449782357-22982-1-git-send-email-lho@apm.com>
 <566F6485.2000508@amd.com>
 <20151215132721.GJ1762@lahna.fi.intel.com>
 <56702923.9010305@amd.com>
 <20151215145953.GK1762@lahna.fi.intel.com>
 <1450863241.7740.30.camel@kxue-X58A-UD3R>
 <20151223095237.GJ1758@lahna.fi.intel.com>
 <1450864789.7740.35.camel@kxue-X58A-UD3R>
Message-ID: <20151223101728.GL1758@lahna.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 23, 2015 at 05:59:49PM +0800, Ken Xue wrote:
> On Wed, 2015-12-23 at 11:52 +0200, Mika Westerberg wrote:
> > On Wed, Dec 23, 2015 at 05:34:01PM +0800, Ken Xue wrote:
> > > 1) Regarding
> > > https://msdn.microsoft.com/en-us/library/windows/hardware/dn919852(v=vs.85).aspx
> > > , Window I2C driver should pass MITT test. There are 5 I2C devices
> > > connect to one I2C bus for test. And those devices defined different
> > > "ConnectionSpeed" over the I2C bus by ACPI resource "I2CSerialBus".
> > > 
> > > During test, I2C bus should run in different "ConnectionSpeed" of
> > > device.
> > > 
> > > That means windows driver can modify I2C bus speed to match the
> > > "ConnectionSpeed" of device on-the-fly. Static value from SSCN and FMCN
> > > can not work for WITT test cases.
> > 
> > That is why there are *CNT methods for all supported I2C modes:
> > 
> >   - SSCN() - returns for standard mode (100kHz)
> >   - FMCN() - returns for fast mode (400kHz)
> >   - FPCN() - returns for fast mode+ (1MHz)
> >  
> > for High-speed mode I'm not sure what the method name is ;-)
> > 
> > Then the Windows driver switches between those based on what the
> > ConnectionSpeed is in the ACPI I2C connector.
> 
> Window driver can set Bus speed based on "ConnectionSpeed". But Current
> Linux driver only sets Bus speed during probe. How can Linux diver
> determine which Bus speed should be applied, if all *CNT methods return
> non-zero? 

By default Linux driver uses 400kHz so it picks values returned from
FMCN(). You can hack clk_freq in the driver to use 100kHz which then
picks SSCN().

There is no support for reading ConnectionSpeed in Linux yet.
