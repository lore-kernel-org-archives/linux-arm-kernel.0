From: will.deacon@arm.com (Will Deacon)
Date: Mon, 12 Aug 2013 14:59:03 +0100
Subject: [PATCH] drivers: CCI: add ARM CCI PMU support
In-Reply-To: <20130807014536.GF15579@mudshark.cambridge.arm.com>
References: <1374571176-11584-1-git-send-email-punit.agrawal@arm.com>
 <51FF8E84.7000108@arm.com>
 <20130807014536.GF15579@mudshark.cambridge.arm.com>
Message-ID: <20130812135903.GC25995@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 07, 2013 at 02:45:36AM +0100, Will Deacon wrote:
> On Mon, Aug 05, 2013 at 12:37:40PM +0100, Punit Agrawal wrote:
> > On 23/07/13 10:19, Punit Agrawal wrote:
> > > The CCI PMU can profile bus transactions at the master and slave
> > > interfaces of the CCI. The PMU can be used to observe an aggregated view
> > > of the bus traffic between the various components connected to the CCI.
> > >
> > > Extend the existing CCI driver to support the PMU by registering a perf
> > > backend for it.
> > >
> > > Document the device tree binding to describe the CCI PMU.
> > >
> > > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > Cc: Nicolas Pitre <nico@linaro.org>
> > > Cc: Dave Martin <dave.martin@linaro.org>
> > > Cc: Rob Herring <rob.herring@calxeda.com>
> > > Cc: Will Deacon <will.deacon@arm.com>
> > > Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
> > > Reviewed-by: Will Deacon <will.deacon@arm.com>
> > > ---
> > >   Documentation/devicetree/bindings/arm/cci.txt |   38 ++
> > >   drivers/bus/arm-cci.c                         |  642 +++++++++++++++++++++++++
> > >   2 files changed, 680 insertions(+)
> > >
> > 
> > It's been 2 rc's since this patch was posted. If there are no objections 
> > would you be ok to take this patch via your tree?
> 
> Sure. I'm currently travelling at the moment, so I'll try and get this done
> as soon as I'm back.

So, I just tried to test this patch but I'm getting issues when enabling CCI
with mainline:


ARM Versatile Express Boot Monitor
Version:    V5.1.5
Build Date: Jul 24 2012
Daughterboard Site 1: V2P-CA15 Cortex A15
Daughterboard Site 2: V2P-CA15_A7 Cortex A15
Running boot script from flash - BOOTSCRIPT
Loaded kernel - linuxtc2
Booting kernel @ 0x80008000
Command line 'ip=dhcp root=/dev/nfs nfsroot=10.1.203.36:/exports/linaro-13.06,tcp rw console=ttyAMA0,38400 mem=2G loglevel=9 user_debug=31 earlyprintk debug'
ATAGs @ 0x80000100


Fatal Error: Unhandled Exception - Undefined


We're exploding *really* early, and I have no idea why. If I remove CCI from
the equation (either in the kernel or the device-tree), then I can boot as
per usual.

Any ideas? Do I need to enable something in the TC2 board firmware?

Will
