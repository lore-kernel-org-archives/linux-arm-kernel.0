From: robh@kernel.org (Rob Herring)
Date: Fri, 24 Mar 2017 09:54:31 -0500
Subject: [PATCH v4 1/7] coresight: bindings for CPU debug module
In-Reply-To: <20170317161335.GB20435@linaro.org>
References: <1489762943-25849-1-git-send-email-leo.yan@linaro.org>
 <1489762943-25849-2-git-send-email-leo.yan@linaro.org>
 <20170317161335.GB20435@linaro.org>
Message-ID: <20170324145431.5bqkpv2h27kmqimu@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 17, 2017 at 10:13:35AM -0600, Mathieu Poirier wrote:
> On Fri, Mar 17, 2017 at 11:02:17PM +0800, Leo Yan wrote:
> > According to ARMv8 architecture reference manual (ARM DDI 0487A.k)
> > Chapter 'Part H: External debug', the CPU can integrate debug module
> > and it can support self-hosted debug and external debug. Especially
> > for supporting self-hosted debug, this means the program can access
> > the debug module from mmio region; and usually the mmio region is
> > integrated with coresight.
> > 
> > So add document for binding debug component, includes binding to APB
> > clock; and also need specify the CPU node which the debug module is
> > dedicated to specific CPU.
> > 
> > Suggested-by: Mike Leach <mike.leach@linaro.org>
> > Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  .../bindings/arm/coresight-cpu-debug.txt           | 46 ++++++++++++++++++++++
> >  1 file changed, 46 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/arm/coresight-cpu-debug.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/coresight-cpu-debug.txt b/Documentation/devicetree/bindings/arm/coresight-cpu-debug.txt
> > new file mode 100644
> > index 0000000..f6855c3
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/coresight-cpu-debug.txt
> > @@ -0,0 +1,46 @@
> > +* CoreSight CPU Debug Component:
> > +
> > +CoreSight cpu debug component are compliant with the ARMv8 architecture
> > +reference manual (ARM DDI 0487A.k) Chapter 'Part H: External debug'. The
> > +external debug module is mainly used for two modes: self-hosted debug and
> > +external debug, and it can be accessed from mmio region from Coresight
> > +and eventually the debug module connects with CPU for debugging. And the
> > +debug module provides sample-based profiling extension, which can be used
> > +to sample CPU program counter, secure state and exception level, etc;
> > +usually every CPU has one dedicated debug module to be connected.
> > +
> > +Required properties:
> > +
> > +- compatible : should be
> > +	     * "arm,coresight-cpu-debug"; supplemented with "arm,primecell"
> > +	       since this driver is using the AMBA bus interface.
> 
> This description needs to be refactored - see my comment from an earlier post
> for more details.
> 
> > +
> > +- reg : physical base address and length of the register set.
> > +
> > +- clocks : the clock associated to this component.
> > +
> > +- clock-names : the name of the clock referenced by the code. Since we are
> > +                using the AMBA framework, the name of the clock providing
> > +		the interconnect should be "apb_pclk" and the clock is
> > +		mandatory. The interface between the debug logic and the
> > +		processor core is clocked by the internal CPU clock, so it
> > +		is enabled with CPU clock by default.
> > +
> > +- cpu : the cpu phandle the debug module is affined to. When omitted
> > +	the module is considered to belong to CPU0.
> > +
> > +Optional properties:
> 
> s/properties/property

I prefer it as-is. Then it doesn't need to be changed if we add 
properties.

Rob
