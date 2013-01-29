From: horms@verge.net.au (Simon Horman)
Date: Tue, 29 Jan 2013 09:22:09 +0900
Subject: [PATCH 12/15] ARM: mach-shmobile: sh73a0: Allow initialisation
 of GIC by DT
In-Reply-To: <20130128105933.GC7754@e106331-lin.cambridge.arm.com>
References: <1359086133-23357-1-git-send-email-horms+renesas@verge.net.au>
 <1359086133-23357-13-git-send-email-horms+renesas@verge.net.au>
 <20130125102210.GJ3075@e106331-lin.cambridge.arm.com>
 <20130128004819.GE3423@verge.net.au>
 <20130128105933.GC7754@e106331-lin.cambridge.arm.com>
Message-ID: <20130129002208.GB27948@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 28, 2013 at 10:59:33AM +0000, Mark Rutland wrote:
> On Mon, Jan 28, 2013 at 12:48:19AM +0000, Simon Horman wrote:
> > On Fri, Jan 25, 2013 at 10:22:10AM +0000, Mark Rutland wrote:
> > > On Fri, Jan 25, 2013 at 03:55:30AM +0000, Simon Horman wrote:
> > > > This allows the GIC interrupt controller of the sh73a0 SoC to be
> > > > initialised using a flattened device tree blob.
> > > > 
> > > > It does not allow the INTC interrupt controller which is also present on
> > > > the sh73a0 SoC to be enabled via device tree.  Nor does it handle sharing
> > > > of interrupts between the GIC and INTC interrupt controllers.
> > > > 
> > > > This limits the usefulness of this code to applications which only wish to
> > > > access devices which use interrupts that can be handled by the GIC
> > > > interrupt controller. Other applications should, for now, continue using
> > > > non-device tree initialisation of the sh72a0 interrupt controllers.
> > > > 
> > > > Includes update to use irqchip_init() by Thierry Reding
> > > > 
> > > > Cc: Thierry Reding <thierry.reding@avionic-design.de>
> > > > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > > > ---
> > > >  arch/arm/boot/dts/sh73a0.dtsi                |   33 ++++++++++++++++++++++++++
> > > >  arch/arm/mach-shmobile/include/mach/common.h |    1 +
> > > >  arch/arm/mach-shmobile/intc-sh73a0.c         |    9 +++++++
> > > >  3 files changed, 43 insertions(+)
> > > >  create mode 100644 arch/arm/boot/dts/sh73a0.dtsi
> > > > 
> > > > diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
> > > > new file mode 100644
> > > > index 0000000..7dae1f4
> > > > --- /dev/null
> > > > +++ b/arch/arm/boot/dts/sh73a0.dtsi
> > > > @@ -0,0 +1,33 @@
> > > > +/*
> > > > + * Device Tree Source for the SH73A0 SoC
> > > > + *
> > > > + * Copyright (C) 2012 Renesas Solutions Corp.
> > > > + *
> > > > + * This file is licensed under the terms of the GNU General Public License
> > > > + * version 2.  This program is licensed "as is" without any warranty of any
> > > > + * kind, whether express or implied.
> > > > + */
> > > > +
> > > > +/include/ "skeleton.dtsi"
> > > > +
> > > > +/ {
> > > > +	compatible = "renesas,sh73a0";
> > > > +
> > > > +	cpus {
> > > > +		cpu at 0 {
> > > > +			compatible = "arm,cortex-a9";
> > > > +		};
> > > > +		cpu at 1 {
> > > > +			compatible = "arm,cortex-a9";
> > > > +		};
> > > 
> > > I replied to v1, not realising you'd posted a v2:
> > > 
> > > It would be good to have the reg and device_type properties set here for the
> > > logical map.
> > 
> > Thanks.
> > 
> > I'd prefer to handle this as an incremental patch to be applied after the
> > pull-request in which the patch above appears. The patch below is what
> > I have in mind.
> 
> Sure. The patch looks right to me :)
> 
> > 
> > I also believe that the following files seem to be targets for a similar
> > change. The latter two are for UP boards, could you comment on if reg
> > and device_type are appropriate for them too.
> > 
> > arch/arm/boot/dts/emev2.dtsi
> 
> Yup, this one should have reg and device_type added.

Thanks, I'll prepare a patch.

> > arch/arm/boot/dts/r8a7740.dtsi
> > arch/arm/boot/dts/sh7372.dtsi
> 
> I'm not sure what the deal is with v7 UP hardware. For v6 and below, the lack
> of an MPIDR means there's nothing to describe. On v7 we should have an MPIDR
> with Aff fields at least, so there is something to describe (even if we don't
> use this currently). I don't believe this would cause any problems, and it
> would make the dts look consistent.
> 
> I've Cc'd Lorenzo in case he has any thoughts on the matter.

Understood, I'll wait to see if Lorenzo can guide me.
