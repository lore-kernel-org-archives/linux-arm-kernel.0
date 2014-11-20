From: tony@atomide.com (Tony Lindgren)
Date: Thu, 20 Nov 2014 08:25:29 -0800
Subject: [GIT PULL 2/3] omap gpmc changes for v3.19
In-Reply-To: <20141120160836.GO7046@atomide.com>
References: <pull-1415814409-868361> <pull-1415814409-868361-2>
 <201411201202.41698.arnd@arndb.de>
 <20141120160836.GO7046@atomide.com>
Message-ID: <20141120162529.GP7046@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [141120 08:11]:
> * Arnd Bergmann <arnd@arndb.de> [141120 03:04]:
> > On Wednesday 12 November 2014, Tony Lindgren wrote:
> > > GPMC (General Purpose Memory Controller) changes for omaps. These
> > > changes allow us to drop dependencies to bootloader timings now
> > > that the known device tree entries have been fixed. So we can now
> > > require proper timings to be configured and get rid of the legacy
> > > smsc91x code.
> > > 
> > > Note that this branch has a dependency to the related device tree
> > > branch sent in a separate pull request as timings are now required.
> > 
> > Does this mean you are breaking compatibility with old dtb files?
> > 
> > Can you be more specific which machines are affected?
> 
> Not breaking compability. We had timings missing in the .dts files
> for a few devices that caused all kinds of hacks in the GPMC code.

Hmm actually I take it back, this is breaking compability for booting
with old .dtb for smc91x on 2430sdp and 8250 on zoom3. In those cases
these devices would now refuse to probe because of the missing
timings because of the extra checks in the GPMC code.

However, these two boards are only used in three automated build and
boot test systems AFAIK. And almost certainly they are using appended
dtb anyways because of the lack of support for them in current
u-boot.
 
> Now those are all fixed up and we are actually using the bindings.

For reference, the .dts files with missing timings were smc91x on
omap2430-sdp.dts 8250 in omap-zoom-common.dtsi. So the dependencies
are:

b5399ea8453a ("ARM: dts: Add GPMC timings for omap zoom serial port")
1bb37404397d ("ARM: dts: Add smc91x GPMC configuration for 2430sdp")

Regards,

Tony
