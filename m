From: jcrouse@codeaurora.org (Jordan Crouse)
Date: Wed, 10 Oct 2018 08:27:23 -0600
Subject: [PATCH 6/9] PM / OPP: dt-bindings: Add opp-interconnect-bw
In-Reply-To: <20181010095951.hgeiy7yxsqi6behd@vireshk-i7>
References: <20180827151112.25211-1-jcrouse@codeaurora.org>
 <20180827151112.25211-7-jcrouse@codeaurora.org>
 <0998a374-6cb0-9218-d2e3-92f8ee9861ed@linaro.org>
 <20181010095951.hgeiy7yxsqi6behd@vireshk-i7>
Message-ID: <20181010142723.GA9977@jcrouse-lnx.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 10, 2018 at 03:29:51PM +0530, Viresh Kumar wrote:
> On 27-09-18, 11:23, Georgi Djakov wrote:
> > On 08/27/2018 06:11 PM, Jordan Crouse wrote:
> > > Add the "opp-interconnect-bw" property to specify the
> > > average and peak bandwidth for an interconnect path for
> > > a specific operating power point. A separate bandwidth
> > > pair can be specified for each of the interconnects
> > > defined for the device by appending the interconnect
> > > name to the property.
> > > 
> > > Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> > > ---
> > >  Documentation/devicetree/bindings/opp/opp.txt | 36 +++++++++++++++++++
> > >  1 file changed, 36 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
> > > index c396c4c0af92..d714c084f36d 100644
> > > --- a/Documentation/devicetree/bindings/opp/opp.txt
> > > +++ b/Documentation/devicetree/bindings/opp/opp.txt
> > > @@ -170,6 +170,11 @@ Optional properties:
> > >    functioning of the current device at the current OPP (where this property is
> > >    present).
> > >  
> > > +- opp-interconnect-bw-<name>: This is an array of pairs specifying the average
> > > +  and peak bandwidth in bytes per second for the interconnect path known by
> > > +  'name'.  This should match the name(s) specified by interconnect-names in the
> > > +  device definition.
> > > +
> > >  Example 1: Single cluster Dual-core ARM cortex A9, switch DVFS states together.
> > >  
> > >  / {
> > > @@ -543,3 +548,34 @@ Example 6: opp-microvolt-<name>, opp-microamp-<name>:
> > >  		};
> > >  	};
> > >  };
> > > +
> > > +Example 7: opp-interconnect-bw:
> > > +(example: leaf device with frequency and BW quotas)
> > > +
> > > +/ {
> > > +	soc {
> > > +		gpu at 5000000 {
> > > +			...
> > > +			interconnects = <&qnoc 26 &qnoc 512>;
> > > +			interconnect-names = "port0";
> > > +			...
> > > +			operating-points-v2 = <&gpu_opp_table>;
> > > +		};
> > > +	};
> > > +
> > > +	gpu_opp_table: opp_table0 {
> > > +		compatible = "operating-points-v2";
> > > +
> > > +		opp-710000000 {
> > > +			op-hz = /bits/ 64 <710000000>;
> > > +			/* Set peak bandwidth @ 7216000 KB/s */
> > > +			opp-interconnect-bw-port0 = /bits/ 64 <0 7216000000>;
> > 
> > This seems a bit long. I would suggest the following instead.
> > If there is only one path:
> > 	/* average bandwidth = 0 KB/s,  peak bandwidth = 7216000 KB/s */
> > 	opp-bw-KBps = <0 7216000>;
> > or 	
> > 	opp-bw-MBps = <0 7216>;
> > 
> > If there are multiple paths:
> > 	opp-bw-KBps-port0 = <0 7216000>;
> > 	opp-bw-KBps-port1 = <0 1000000>;
> > 
> > The above follows a convention similar to opp-microvolt, where at
> > runtime the platform can pick a <name> and a matching opp-bw-KBps-<name>
> > property. If the platform doesn't pick a specific <name> or <name> does
> > not match with any of the opp-bw-KBps-<name> properties, then
> > opp-bw-KBps shall be used if present.
> > For now supporting only KBps values seems enough to cover all present
> > platforms, so we can start with this and based on the requirements of
> > future platforms we can add MBps etc.
> 
> +1
> 
> And yes I am fine with such bindings getting introduced to the OPP
> core.
> 
> I am not sure if this would fit well, but have a look at
> "required-opps" property in OPP bindings and see if that can be used
> instead of adding new bindings here. Again, I am not sure if that
> should be done :)

I'm not convinced that required-opps would work. I'm worried that the
format is too vague if we need to use it for multiple paths and possibly
other uses too, consider this:

required-opp = <&mdp_path0_opp3, &mdp_path1_opp5, &mdp_rpmh_opp1>;

This has ordering problems and IMO pollutes the DT namespace for no
great technical advantage. I appreciate the hesitation for opening up
the flood gates for new OPP bindings but we are entering a new era
of hyper power aware devices and some concessions will need to be made.

Jordan
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
