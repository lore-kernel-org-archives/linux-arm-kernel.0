From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 10 Jun 2016 17:25:55 +0100
Subject: [PATCH 3/5] arm64: dts: msm8916: Add spc compat tag
In-Reply-To: <20160610161234.GO13357@hector.attlocal.net>
References: <1463634020-17252-1-git-send-email-andy.gross@linaro.org>
 <1463634020-17252-4-git-send-email-andy.gross@linaro.org>
 <20160610154857.GA6430@leverpostej>
 <20160610161234.GO13357@hector.attlocal.net>
Message-ID: <20160610162555.GB6430@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 10, 2016 at 11:12:34AM -0500, Andy Gross wrote:
> On Fri, Jun 10, 2016 at 04:48:57PM +0100, Mark Rutland wrote:
> > [+ Lorenzo]
> > 
> > On Thu, May 19, 2016 at 12:00:18AM -0500, Andy Gross wrote:
> > > This patch adds the qcom,idle-state-spc compatible to the SPC idle
> > > state.  This compatible indicates that the state is one which supports
> > > freeze.
> > > 
> > > Signed-off-by: Andy Gross <andy.gross@linaro.org>
> > > ---
> > >  arch/arm64/boot/dts/qcom/msm8916.dtsi | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> > > index 208af00..032e411 100644
> > > --- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> > > @@ -104,7 +104,7 @@
> > >  
> > >  		idle-states {
> > >  			CPU_SPC: spc {
> > > -				compatible = "arm,idle-state";
> > > +				compatible = "qcom,idle-state-spc", "arm,idle-state";
> > >  				arm,psci-suspend-param = <0x40000002>;
> > >  				entry-latency-us = <130>;
> > >  				exit-latency-us = <150>;
> > 
> > This looks suspicious.
> > 
> > This is a PSCI idle state, and we have a PSCI driver driven by the
> > generic ARM cpuidle driver.
> > 
> > Why do we need a qcom-specific compatible here?
> > 
> > Surely we should be able to use the idle code in a generic fashion to
> > driver suspend-to-idle?
> 
> We need a way to identify specific idle states that support suspend-to-idle.  In
> addition, when we have identified the states, we may have to configure the
> enter_freeze() function.

Could you elaborate on what you mean by a state supporting
suspend-to-idle? It was my understanding that any idle state should
function for suspend-to-idle (and the choice of state is potentially
subjective).

> I chose to do this outside of the arm cpuidle driver because I didn't want to
> add any more DT information aside from the compatible, and I needed a separate
> place for the Qualcomm specific suspend code. 

Which suspend code is Qualcomm-specific? There shouldn't be anything on
the PSCI side, so I can only imagine that device management is left.
What am I missing?

> With the compatible, this makes
> my 32 and 64 bit processor suspend code identical, as we have our own cpuidle
> driver for the 32 bit procs.
> 
> An alternative would be to add some facilities to communicate this to the arm
> cpuidle driver and configure the enter_freeze() function at some later point.

I would prefer that suspend-to-idle using PSCI occurred via the generic
PSCI and cpuidle code. I am happy to extend that code if there is
something lacking, and I would prefer to not have platform-specific
hooks.

Thanks,
Mark.
