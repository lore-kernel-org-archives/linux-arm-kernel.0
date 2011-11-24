From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 24 Nov 2011 16:47:35 +0000
Subject: [PATCH v7 3/5] drivers/i2c/busses/i2c-at91.c: add new driver
In-Reply-To: <EF2E73589CA71846A15D0B2CDF79505D087B45007C@wm021.weinmann.com>
References: <cover.1322062555.git.n.voss@weinmann.de>
 <201111241539.06990.arnd@arndb.de>
 <EF2E73589CA71846A15D0B2CDF79505D087B45007C@wm021.weinmann.com>
Message-ID: <201111241647.35818.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 24 November 2011, Voss, Nikolaus wrote:
> > Aside from the flamewar in that thread, my impression is that in general
> > people (me certainly) prefer to have driver-local workarounds be expressed
> > in a driver specific way, not in a platform or architecture specific way
> > because that makes the driver less portable.
> 
> I guess I see your point now. So you want something like pdev.has_bugX to be
> set by mach setup and later check this flag in the driver?

Yes, that would be the idea. I would not introduce platform_data for one
driver just for this though, because we are generally moving away from
platform_data towards device tree probing.

You can do it with a match table that has two entries with different
names for the two kinds of device that you need to distinguish and
set the platform_device_id->driver_data field to '1' for the type
that needs the fixup.

> > > > #define       AT91_TWI_MMR            0x00000004
> > > > #define       AT91_TWI_IADRSZ         0x00000300
> > > > #define       AT91_TWI_IADRSZ_NO      0x00000000
> > > > #define       AT91_TWI_IADRSZ_1       0x00000100
> > > > ...
> > >
> > > I agree, but this header file was already used by the old driver and
> > > converting would add possible errors to register definitions which are
> > > not (yet) used. That's why I've left it as is and just made it a local
> > > include.
> > 
> > But you are presenting the driver as a new one, so you should be
> > prepared to get review comments like any other new code.
> > 
> > Please at least move the data into the main driver file to get rid of
> > the header file.
> 
> I didn't want to appear ignorant about this, I actually appreciate your
> comment. I just wanted to point out that there might be a reason to keep
> the old file which you weren't aware of (because I presented this as a new
> driver). So, I will move the register definitions to the main driver.

Ok, good. Moving it into the driver is really the important part anyway,
and I understand your reasoning for not wanting to modify the definitions,
it just didn't apply to the one of the two comments I made about the header.

	Arnd
