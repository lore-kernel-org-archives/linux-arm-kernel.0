From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 23 Jan 2013 10:36:14 +0000
Subject: [PATCH] ARM: dts: specify all the per-cpu interrupts of arch
 timer for exynos5440
In-Reply-To: <063f01cdf8ec$926cda30$b7468e90$@samsung.com>
References: <1358818887-16870-1-git-send-email-kgene.kim@samsung.com>
 <20130122101554.GA18876@e106331-lin.cambridge.arm.com>
 <063f01cdf8ec$926cda30$b7468e90$@samsung.com>
Message-ID: <20130123103614.GD32237@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 22, 2013 at 10:05:18PM +0000, Kukjin Kim wrote:
> Mark Rutland wrote:
> >
> + devicetree-discuss, Grant Likely, Rob Herring and Tony Lindgren
>  
> > On Tue, Jan 22, 2013 at 01:41:27AM +0000, Kukjin Kim wrote:
> > > From: Thomas Abraham <thomas.ab@samsung.com>
> > >
> > > Need to be changed requirements in the 'cpus' node for exynos5440
> > > to specify all the per-cpu interrupts of arch timer.
> > 
> > The node(s) for the arch timer should not be in the cpus/cpu at N nodes.
> > Instead, there should be one node (in the root of the tree).
> > 
> Well, I don't think so. As per my understanding, the local timers are
> attached to every ARM cores (cpus) and it generates certain interrupt to the
> GIC. So the correct representation for this in device tree is to include the
> interrupts in the cpu nodes in dts file. Your comments  refer to a
> limitation in the Linux kernel implementation of the arch_timer and it
> should not result in representing the hardware details incorrectly in the
> dts file.

I disagree. The "correct representation" is whatever the devicetree binding
documentation describes. It does not describe placing timer nodes in the cpu
nodes.

> 
> > If this works currently it's only because the driver picks up one of the
> nodes,
> > and luckily it's the same as the others. This is not guaranteed to work in
> > future, and will likely break.
> > 
> It is up to the Linux kernel implementation of arch_timer to handle the
> hardware details in dts file accordingly.

The binding specification does not specify that there should be multiple timer
nodes, nor does it specify that they should be under cpu nodes. The timers,
being a banked resource, can be described with one node.

It is not up to the Linux kernel to handle undocumented variations of bindings.

> 
> > >
> > > Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
> > > Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> > > ---
> > >  arch/arm/boot/dts/exynos5440.dtsi |   20 ++++++++++++++++----
> > >  1 file changed, 16 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/arch/arm/boot/dts/exynos5440.dtsi
> > b/arch/arm/boot/dts/exynos5440.dtsi
> > > index 5406689..c5bd8ed 100644
> > > --- a/arch/arm/boot/dts/exynos5440.dtsi
> > > +++ b/arch/arm/boot/dts/exynos5440.dtsi
> > > @@ -28,7 +28,10 @@
> > >  			compatible = "arm,cortex-a15";
> > >  			timer {
> > >  				compatible = "arm,armv7-timer";
> > > -				interrupts = <1 13 0xf08>;
> > > +				interrupts = <1 13 0xf08>,
> > > +					     <1 14 0xf08>,
> > > +					     <1 11 0xf08>,
> > > +					     <1 10 0xf08>;
> > 
> > Also, this interrupts list is updated differently to all the other nodes.
> Typo?
> > 
> Hmm, I think this should be fine. If any concerns, please let me know in
> detail.

Sorry, I misread the diff. Your patch in fact corrects them to be consistent
where they weren't previously.

> 
> [...]
> 
> Thanks.
> 
> - Kukjin
> 
> 

Thanks,
Mark.
