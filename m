From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Fri, 01 May 2015 11:22:31 +0100
Subject: [PATCH] arm64: dts: Add idle-states for Juno
In-Reply-To: <20150501015502.GA4679@leoy-linaro>
References: <1430402268.2868.20.camel@linaro.org>
 <20150501015502.GA4679@leoy-linaro>
Message-ID: <1430475751.3045.40.camel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2015-05-01 at 09:55 +0800, Leo Yan wrote:
[...]
> >  arch/arm64/boot/dts/arm/juno.dts | 28 ++++++++++++++++++++++++++++
> >  1 file changed, 28 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/arm/juno.dts b/arch/arm64/boot/dts/arm/juno.dts
> > index 133ee59..7a9a449 100644
> > --- a/arch/arm64/boot/dts/arm/juno.dts
> > +++ b/arch/arm64/boot/dts/arm/juno.dts
> > @@ -34,12 +34,35 @@
> >  		#address-cells = <2>;
> >  		#size-cells = <0>;
> >  
> > +		idle-states {
> > +			entry-method = "arm,psci";
> > +
> > +			CPU_SLEEP_0: cpu-sleep-0 {
> > +				compatible = "arm,idle-state";
> > +				arm,psci-suspend-param = <0x0010000>;
> > +				local-timer-stop;
> 
> Just want to figure out the best way for big.LITTLE system; so have
> one question: CA53 and CA57 have different power domain for arch
> timer, right?

I'm not sure of the answer to that. The documentation I have does seem
to state the timer is lost on cluster power down, which would imply that
it's not when just powering down a cpu, but I'm not at all clear on the
matter.

>  If this is the case, should we define two kinds of cpu
> sleep states, one of them will not migrate to broadcast timer and
> keep using arch timer after cpu has been powered down?

Do you mean that if the local timer is not lost (and so we should not
have local-timer-stop above), then we should have another identical idle
state except that it _does_ specify local-timer-stop to force the
broadcast time to be used? If so, would that second state ever be more
power efficient than the first? (I don't know the answer to that, this
whole area is pretty new to me).

-- 
Tixy
