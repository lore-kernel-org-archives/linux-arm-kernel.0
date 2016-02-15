From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 15 Feb 2016 16:12:28 +0000
Subject: arm qemu test failures due to 'driver-core: platform: probe
 of-devices only using list of compatibles'
In-Reply-To: <56C1F19F.8090100@roeck-us.net>
References: <20160214165010.GA3189@roeck-us.net>
 <20160215105909.GH12289@pengutronix.de>
 <56C1F19F.8090100@roeck-us.net>
Message-ID: <20160215161228.GH10826@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 15, 2016 at 07:41:19AM -0800, Guenter Roeck wrote:
> On 02/15/2016 02:59 AM, Uwe Kleine-K?nig wrote:
> >Hello Guenter,
> >
> >On Sun, Feb 14, 2016 at 08:50:10AM -0800, Guenter Roeck wrote:
> >>Uwe,
> >>
> >>Your patch 'driver-core: platform: probe of-devices only using list of
> >>compatibles' causes the following qemu tests to crash in -next.
> >>
> >>arm:vexpress-a9:vexpress_defconfig:vexpress-v2p-ca9
> >>arm:vexpress-a15:vexpress_defconfig:vexpress-v2p-ca15-tc1
> >>arm:vexpress-a9:multi_v7_defconfig:vexpress-v2p-ca9
> >>arm:vexpress-a15:multi_v7_defconfig:vexpress-v2p-ca15-tc1
> >>
> >>Crash log:
> >>
> >>VFS: Cannot open root device "mmcblk0" or unknown-block(0,0): error -6
> >>Please append a correct "root=" boot option; here are the available partitions:
> >>1f00          131072 mtdblock0  (driver?)
> >>1f01           32768 mtdblock1  (driver?)
> >>Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0)
> >
> >Can you provide a complete boot log? This might already reveal which
> >device is failing. It might not be the mmci device but something it
> >depends on (clock, bus parent, irq).
> >
> 
> Sure, something else may be failing, but why does reverting your patch
> fix the problem ?
> 
> Anyway, complete logs are at http://kerneltests.org/builders.
> 
> http://kerneltests.org/builders/qemu-arm-next/builds/376/steps/qemubuildcommand/logs/stdio
> 
> is the most recent log (next-20120215). Look for the vexpress crashes; the overo
> crash bisected to to 'PM / OPP: Disable OPPs that aren't supported by the regulator',
> in next-20160212, which I have not fully analyzed yet, and the beagle crashes
> as well as the 'new' overo crash are brand new.

Looking at the vexpress-ca9 one, nothing stands out to me apart from the
lack of messages about a MMC driver.  I don't see anything there which
indicates why that would be.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
