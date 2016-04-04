From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 5 Apr 2016 00:38:33 +0100
Subject: [PATCH 2/4] Documentation: Add documentation for APM X-Gene SoC
 PMU DTS binding
In-Reply-To: <CACgAJHyS+o_Nyrc7pDxVCTHK7tue9L9F2weGQt_2WqeGfZBeag@mail.gmail.com>
References: <1459467472-31561-1-git-send-email-ttnguyen@apm.com>
 <1459467472-31561-3-git-send-email-ttnguyen@apm.com>
 <20160401123000.GC29876@leverpostej>
 <CACgAJHyS+o_Nyrc7pDxVCTHK7tue9L9F2weGQt_2WqeGfZBeag@mail.gmail.com>
Message-ID: <20160404233831.GB1917@svinekod>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 04, 2016 at 04:40:33PM -0700, Tai Tri Nguyen wrote:
> On Fri, Apr 1, 2016 at 5:30 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> > On Thu, Mar 31, 2016 at 04:37:50PM -0700, Tai Nguyen wrote:
> >> +This is APM X-Gene SoC PMU (Performance Monitoring Unit) module.
> >> +The following PMU devices are supported:
> >> +
> >> +  L3C                        - L3 cache controller
> >> +  IOB                        - IO bridge
> >> +  MCB                        - Memory controller bridge
> >> +  MC                 - Memory controller
> >
> > These sound like separate units. How do these relate?
> >
> > Is there an SOC-wide PMU that aggregates counters, or are these actually
> > independent?
> >
> 
> Yes, they are independent, but sharing the same top level status interrupt.
> There's no SOC-wide PMU which aggregates these counters.

If they're just sharing the interrupt, why are they not separate nodes (and
drivers) which simply happen to share an interrupt?

Is there anything else shared?

> >> +The following section describes the SoC PMU DT node binding.
> >> +
> >> +Required properties:
> >> +- compatible         : Shall be "apm,xgene-pmu" for revision 1 or
> >> +                          "apm,xgene-pmu-v2" for revision 2.
> >
> > That name is very general. Is there not a more specific name for the SOC
> > PMU?
> >
> 
> Beside the ARMv8 core PMU which has the compatible name "arm,armv8-pmuv3",
> these are all the PMUs in X-Gene SoCs. Also, we are using the same PMU
> driver across our platforms. I think a general name is what it should be.

Depending on my prior question, I'm not sure that's necessarily true. If
there's no actual shared SoC PMU logic as such, the names below for each
individual PMU seem fine.
 
> >> +Required properties for L3C subnode:
> >> +- compatible         : Shall be "apm,xgene-pmu-l3c".
> >> +- reg                        : First resource shall be the L3C PMU resource.
> >> +- index                      : Instance number of the L3C PMU.
> >> +
> >> +Required properties for IOB subnode:
> >> +- compatible         : Shall be "apm,xgene-pmu-iob".
> >> +- reg                        : First resource shall be the IOB PMU resource.
> >> +- index                      : Instance number of the IOB PMU.
> >> +
> >> +Required properties for MCB subnode:
> >> +- compatible         : Shall be "apm,xgene-pmu-mcb".
> >> +- reg                        : First resource shall be the MCB PMU resource.
> >> +- index                      : Instance number of the MCB PMU.
> >> +
> >> +Required properties for MC subnode:
> >> +- compatible         : Shall be "apm,xgene-pmu-mc".
> >> +- reg                        : First resource shall be the MC PMU resource.
> >> +- index                      : Instance number of the MC PMU.
> >
> > What's the index property useful for?
> >
> 
> The index property is used for indicating the physical hardware PMU id.
> For example, on X-Gene1 there are 4 memory controllers (MC), each of them has
> its own PMU. The index property tells us which MC a PMU belongs to.
> The same for MCB/L3C and IOB.

Sure, but is this simply informative for the user, or does this have an impact
on the programming model?

Thanks,
Mark.
