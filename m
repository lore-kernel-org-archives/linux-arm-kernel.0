From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 24 Mar 2010 12:19:30 +0000
Subject: Device probe order (i2c regulator vs. platform device)
In-Reply-To: <4BA9F724.8070901@warmcat.com>
References: <E4D3F24EA6C9E54F817833EAE0D912AC09C80E05C7@bssrvexch01.BS.local>
	<20100324102144.GA21935@rakim.wolfsonmicro.main>
	<005401cacb41$821d46f0$8657d4d0$%szyprowski@samsung.com>
	<20100324110820.GA5831@opensource.wolfsonmicro.com>
	<4BA9F724.8070901@warmcat.com>
Message-ID: <20100324121930.GD5831@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 24, 2010 at 11:27:32AM +0000, Andy Green wrote:

> You're missing the point.

No, I'm not.  Much of what you're saying appears to be predicated on the
idea that there is some explicit suspend and resume activity done by the
PMIC driver which needs to happen before anything else can run.

> On any board with a PMU if you look at the schematic you will see
> most of the assets on the board are totally dependent on the PMU
> power arrangements.

Right, clearly - and the fact that this includes things like the
processor and the RAM makes life a lot eaiser for us.

> Take for example the SD card socket with its own regulator from the PMU.

> In Linux reasonably enough MMC is not related to I2C at all in the
> default case.  Therefore during suspend, nothing stops I2C child
> suspend completing before the MMC stack suspend completes.

This only makes a practical difference if the I2C device suspend
actually exists and does something which affects power.  If it's not
doing anything then it really doesn't make any practical difference and
we don't need to worry about it in software.  This is where the CPU and
RAM involvement help us by requiring the PMICs handle much of this in
hardware.

For the bus controller itself there's a much more general issue which
most platforms resolve by either using the _noirq suspend operations,
not suspending at all (on some platforms there's just not anything to
do), or suspending as part of the arch suspend work.  I2C tends to be
used in enough applications that cause sequencing issues that this is
required anyway and has often been solved before anyone tries to use
software controlled regulators.

Note also that the suspend and resume ordering flow from the ordering
with which things appear at system startup so solving the problem at
startup tends to mean you've coped with things well enough.  See the
thread on allowing us to explicitly specify interdependencies for the
device graph that occurred during the last release cycle for Linus'
analysis of this.

> The solution is to make explicit the device hierarchy relationship
> using the parent member of struct device.  On a typical board, it
> means most of your devices are children on the PMU -- and that
> reflects the reality.

It's not just devices that depend on the PMU, it's other things like the
CPU and RAM that don't even appear in the device tree as well.

> To do that, you need a post-PMU-probe callback into the machine
> file, or some even nicer API arrangement you're in a good position
> to invent :-)

This isn't really regulator specific, it's a generic problem that
affects other areas too (this sort of multi-chip arrangement is hardly
unusual in embedded cases, and I understand there are some similar
issues on PCs) and the regulator API doesn't have the information to
deal with anyway.  You're really looking for something at the device
core level here.
