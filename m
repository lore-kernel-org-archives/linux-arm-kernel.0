From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 1 May 2015 11:45:06 +0100
Subject: [PATCH] arm64: dts: Add idle-states for Juno
In-Reply-To: <1430475751.3045.40.camel@linaro.org>
References: <1430402268.2868.20.camel@linaro.org>
 <20150501015502.GA4679@leoy-linaro>
 <1430475751.3045.40.camel@linaro.org>
Message-ID: <20150501104506.GA12330@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 01, 2015 at 11:22:31AM +0100, Jon Medhurst (Tixy) wrote:
> On Fri, 2015-05-01 at 09:55 +0800, Leo Yan wrote:
> [...]
> > >  arch/arm64/boot/dts/arm/juno.dts | 28 ++++++++++++++++++++++++++++
> > >  1 file changed, 28 insertions(+)
> > > 
> > > diff --git a/arch/arm64/boot/dts/arm/juno.dts b/arch/arm64/boot/dts/arm/juno.dts
> > > index 133ee59..7a9a449 100644
> > > --- a/arch/arm64/boot/dts/arm/juno.dts
> > > +++ b/arch/arm64/boot/dts/arm/juno.dts
> > > @@ -34,12 +34,35 @@
> > >  		#address-cells = <2>;
> > >  		#size-cells = <0>;
> > >  
> > > +		idle-states {
> > > +			entry-method = "arm,psci";
> > > +
> > > +			CPU_SLEEP_0: cpu-sleep-0 {
> > > +				compatible = "arm,idle-state";
> > > +				arm,psci-suspend-param = <0x0010000>;
> > > +				local-timer-stop;
> > 
> > Just want to figure out the best way for big.LITTLE system; so have
> > one question: CA53 and CA57 have different power domain for arch
> > timer, right?
> 
> I'm not sure of the answer to that. The documentation I have does seem
> to state the timer is lost on cluster power down, which would imply that
> it's not when just powering down a cpu, but I'm not at all clear on the
> matter.
> 
> >  If this is the case, should we define two kinds of cpu
> > sleep states, one of them will not migrate to broadcast timer and
> > keep using arch timer after cpu has been powered down?
> 
> Do you mean that if the local timer is not lost (and so we should not
> have local-timer-stop above), then we should have another identical idle
> state except that it _does_ specify local-timer-stop to force the
> broadcast time to be used? If so, would that second state ever be more
> power efficient than the first? (I don't know the answer to that, this
> whole area is pretty new to me).

Ok, to start with, if we want the generic CPUidle driver to work on bL
systems, we should get this patch merged:

http://www.spinics.net/lists/arm-kernel/msg412790.html

Architected timer is always lost on power down, unless we are talking
about a logic retention state (or if we are talking about local timers
that are not the architected ones). Anyway, with the patch above, different
cpus can have different idle states, so different behaviours when it
comes to the local timer behaviour. If, say, on a A53/A57 system, A53
cpus lose the local timer on idle state entry and A57 cpus do not
(that's a non-existing example though), those cpus will have different
idle states so different local-timer-stop flags.

I hope this helps.

Lorenzo
