From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Thu, 14 May 2015 16:14:25 +0100
Subject: [PATCH 5/5] arm64: Add DT support for Juno r1 board.
In-Reply-To: <20150514141817.GF494@leverpostej>
References: <1431537092-19597-1-git-send-email-Liviu.Dudau@arm.com>
 <1431537092-19597-6-git-send-email-Liviu.Dudau@arm.com>
 <1431612451.2881.54.camel@linaro.org> <20150514141817.GF494@leverpostej>
Message-ID: <1431616465.2881.61.camel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2015-05-14 at 15:18 +0100, Mark Rutland wrote:
> On Thu, May 14, 2015 at 03:07:31PM +0100, Jon Medhurst (Tixy) wrote:
> > On Wed, 2015-05-13 at 18:11 +0100, Liviu Dudau wrote:
> > > This board is based on Juno r0 with updated Cortex A5x revisions
> > > and board errata fixes. It also contains coherent ThinLinks ports
> > > on the expansion slot that allow for an AXI master on the daughter
> > > card to participate in a coherency domain.
> > > 
> > > Support for SoC PCIe host bridge will be added as a separate series.
> > > 
> > > Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
> > > ---
> > >  arch/arm64/boot/dts/arm/Makefile    |   2 +-
> > >  arch/arm64/boot/dts/arm/juno-r1.dts | 123 ++++++++++++++++++++++++++++++++++++
> > >  2 files changed, 124 insertions(+), 1 deletion(-)
> > >  create mode 100644 arch/arm64/boot/dts/arm/juno-r1.dts
> > > 
> > > diff --git a/arch/arm64/boot/dts/arm/Makefile b/arch/arm64/boot/dts/arm/Makefile
> > > index 301a0da..c5c98b9 100644
> > > --- a/arch/arm64/boot/dts/arm/Makefile
> > > +++ b/arch/arm64/boot/dts/arm/Makefile
> > > @@ -1,5 +1,5 @@
> > >  dtb-$(CONFIG_ARCH_VEXPRESS) += foundation-v8.dtb
> > > -dtb-$(CONFIG_ARCH_VEXPRESS) += juno.dtb
> > > +dtb-$(CONFIG_ARCH_VEXPRESS) += juno.dtb juno-r1.dtb
> > >  dtb-$(CONFIG_ARCH_VEXPRESS) += rtsm_ve-aemv8a.dtb
> > >  
> > >  always		:= $(dtb-y)
> > > diff --git a/arch/arm64/boot/dts/arm/juno-r1.dts b/arch/arm64/boot/dts/arm/juno-r1.dts
> > > new file mode 100644
> > > index 0000000..f6bc073
> > > --- /dev/null
> > > +++ b/arch/arm64/boot/dts/arm/juno-r1.dts
> > > @@ -0,0 +1,123 @@
> > > +/*
> > > + * ARM Ltd. Juno Platform
> > > + *
> > > + * Copyright (c) 2015 ARM Ltd.
> > > + *
> > > + * This file is licensed under a dual GPLv2 or BSD license.
> > > + */
> > > +
> > > +/dts-v1/;
> > > +
> > > +#include <dt-bindings/interrupt-controller/arm-gic.h>
> > > +
> > > +/ {
> > > +	model = "ARM Juno development board (r1)";
> > > +	compatible = "arm,juno", "arm,vexpress";
> > 
> > Is there scope for adding "arm,juno-r1" to the front of that list?
> > Reason I ask, is that I can't help but think [1] that userside code
> > (like Android) which wants to select device-specific configuration,
> > should use something like the devices compatible string rather than what
> > they currently propose [2].
> 
> > [1] https://lists.linaro.org/pipermail/linaro-android/2015-April/002743.html
> > [2] https://lists.linaro.org/pipermail/linaro-android/2015-April/002742.html
> 
> Ideally, userspace shouldn't need to know what specific device they're
> running on (though obviously there will always be cases...). To that
> end, it would be interesting to know what this data would be used for.
> If it's just a string for some "About device" menu, the model string
> should be ok.

The 'hardware name' is used to selected the correct init scripts, fstab,
userside graphics/audio drivers for the device.

> I'm a bit lost with the suggestion in [2]. It doesn't seem to have
> anything to do with firmware, though perhaps I'm missing something?

That was my reaction. Before they were parsing /proc/cpuinfo to get the
device name. But that information got removed.

-- 
Tixy
