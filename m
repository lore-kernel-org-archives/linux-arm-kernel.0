From: dalias@libc.org (Rich Felker)
Date: Tue, 24 Apr 2018 13:59:37 -0400
Subject: [PATCH 00/11] platform: device tree support for early platform
 drivers
In-Reply-To: <20180424175544.uq7f5x63a5il36sh@lakrids.cambridge.arm.com>
References: <20180424173051.15099-1-brgl@bgdev.pl>
 <20180424175544.uq7f5x63a5il36sh@lakrids.cambridge.arm.com>
Message-ID: <20180424175937.GD3094@brightrain.aerifal.cx>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 24, 2018 at 06:55:45PM +0100, Mark Rutland wrote:
> Hi bartosz,
> 
> On Tue, Apr 24, 2018 at 07:30:40PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > 
> > Device tree based systems often use OF_DECLARE() macros for devices
> > that need to be initialized early in the boot process such as clocks,
> > timers etc. However platform devices are more desirable.
> > 
> > This series aims at introducing support for early platform drivers for
> > OF-based systems.
> > 
> > The idea is to have a special compatible fallback string: "earlydev"
> > that similarily to "syscon" would be added to device nodes that need
> > early probing. We then need to call of_early_platform_populate() early
> > in the boot process to actually probe the registered devices.
> > 
> > I am aware that this new compatible does not strictly correspond with
> > the "hardware description only" rule of DT, but we already have many
> > functionalities that break this rule: syscon, gpio hogs etc.
> 
> I don't think we need the "earlydev" string at all, and can still keep
> the rest of this infrastrcuture if it is helpful.
> 
> So while I'm certainly oppposed to the "earlydev" string, I think that
> the infrastrcuture could be useful.

Yes. I think this agrees with my objection -- I'm not opposed to the
infrastructure in the kernel, but to semantically-wrong and
backwards-incompatible changes to the device tree contract.

> > The first user of this new functionality will be the DaVinci platform
> > for which we want to probe the pll, psc and timer drivers early in the
> > boot sequence but keep them implemented as platform drivers.
> 
> Can we have early_paltform_driver() take a reference to the driver's
> of_match_table, and put that in a special section?
> 
> Then instead of looking for "earlydev", we look for any compatible
> string in that section. No magic string required in the DT, and we can
> always mess around with probe ordering in future.

Yes, this is pretty much exactly the change I had in mind.

Rich
