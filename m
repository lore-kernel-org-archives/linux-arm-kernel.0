From: swarren@nvidia.com (Stephen Warren)
Date: Fri, 2 Sep 2011 10:07:11 -0700
Subject: [PATCH] usb: ehci: make HC see up-to-date qh/qtd descriptor ASAP
In-Reply-To: <4E60A702.1060504@arm.com>
References: <1314720193-26577-1-git-send-email-ming.lei@canonical.com>
	<201108311855.27711.marc.dietrich@ap.physik.uni-giessen.de>
	<4E5F5FA9.3010305@arm.com> <201109011313.42547.marvin24@gmx.de>
	<74CDBE0F657A3D45AFBB94109FB122FF04B327A383@HQMAIL01.nvidia.com>
	<4E60A702.1060504@arm.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF04B327A5C1@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc Zyngier wrote at Friday, September 02, 2011 3:51 AM:
> On 01/09/11 20:08, Stephen Warren wrote:
> > Marc Dietich wrote at Thursday, September 01, 2011 5:14 AM:
> >> I'll add Stephen Warren from NVIDIA to the CC list. He has more HW to test on.
> >
> > Here are the results I found:
> >
> > Harmony:
> > Tegra USB3 -> SMSC9514 hub: NOT affected
> > (Unplugging LAN cable, or disabling SMSC9514 LAN driver doesn't change this)
...
> I just noticed something else. Harmony is fast *most of the time*. In
> about one in 3 reboots, I get the slow behavior. When USB is fast, I
> also have I2C interrupts "screaming":
> 
>  85:     294321          0       GIC  tegra-i2c
> 116:          0          0       GIC  tegra-i2c
> 118:      98542          0       GIC  tps6586x
> 
> This is a couple of seconds after boot.
> 
> When USB is slow, I see the following:
> [    0.385270] tps6586x 3-0034: Chip ID read failed: -121
> [    0.390584] tps6586x: probe of 3-0034 failed with error -5
> 
> ... and I2C interrupt is quiet.
> 
> The I2C interrupt handler calls writel(), which does a cache sync. That
> would explain the "fast" behavior of Harmony.
> 
> Do you see the same this on your board?

Yes, I re-ran the test a few more times and see those exact same symptoms.

In a case with the screaming I2C interrupts and fast USB, I then did:

echo 3-0034 > /sys/bus/i2c/drivers/tps6586x/unbind
(I got a kernel BUG and bash crashed here, but just logged back in)

which caused the I2C interrupt handler to stop, then re-ran the test.
I then saw the slow USB speed.

So, now I think *all* platforms(boards) are affected, right?

-- 
nvpublic
