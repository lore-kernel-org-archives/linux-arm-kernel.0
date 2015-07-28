From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 28 Jul 2015 15:55:10 -0700
Subject: [PATCH v4 2/2] dt: power: st: Provide bindings for ST's OPPs
In-Reply-To: <20150728022936.GB1229@linux>
References: <1438010430-5802-1-git-send-email-lee.jones@linaro.org>
 <1438010430-5802-2-git-send-email-lee.jones@linaro.org>
 <20150728022936.GB1229@linux>
Message-ID: <20150728225510.GB3159@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/28, Viresh Kumar wrote:
> Cc'ing few people (whom I cc'd last time as well :)).
> 
> On 27-07-15, 16:20, Lee Jones wrote:
> > These OPPs are used in ST's CPUFreq implementation.
> > 
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> > 
> > Changelog:
> >  - None, new patch
> > 
> >  Documentation/devicetree/bindings/power/opp-st.txt | 76 ++++++++++++++++++++++
> >  1 file changed, 76 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/power/opp-st.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/power/opp-st.txt b/Documentation/devicetree/bindings/power/opp-st.txt
> > new file mode 100644
> > index 0000000..6eb2a91
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/power/opp-st.txt
> > @@ -0,0 +1,76 @@
> > +STMicroelectronics OPP (Operating Performance Points) Bindings
> > +--------------------------------------------------------------
> > +
> > +Frequency Scaling only
> > +----------------------
> > +
> > +Located in CPU's node:
> > +
> > +- operating-points	: [See: ./opp.txt]
> > +
> > +Example [safe]
> > +--------------
> > +
> > +cpus {
> > +	cpu at 0 {
> > +				 /* kHz     uV   */
> > +		operating-points = <1500000 0
> > +				    1200000 0
> > +				    800000  0
> > +				    500000  0>;
> > +	};
> > +};
> > +
> > +Dynamic Voltage and Frequency Scaling (DVFS)
> > +--------------------------------------------
> > +
> > +Located in 'cpu0-opp-list' node [to be provided ONLY by the bootloader]:
> > +
> > +- compatible		: Should be "operating-points-v2-sti"
> > +- opp{1..N} 		: Each 'oppX' subnode will contain the following properties:
> 
> Or should we mention:
> - opp{1..N} 		: Each 'oppX' subnode shall contain below properties,
>                           over what ./opp.txt defines:
> 
> ?
> 
> 
> > + - opp-hz		: CPU frequency [Hz] for this OPP [See: ./opp.txt]
> > + - st,avs		: List of available voltages [uV] indexed by process code
> > + - st,cuts		: Cut version this OPP is suitable for [0xFF means ALL]
> > + - st,substrate		: Substrate version this OPP is suitable for [0xFF means ALL]
> > +- st,syscfg		: Phandle to Major number register
> > +				First cell: offset to major number
> > +- st,syscfg-eng		: Phandle to Minor number and Pcode registers
> > +				First cell: offset to process code
> > +				Second cell: offset to minor number
> > +
> > +WARNING: The opp{1..N} nodes will be provided by the bootloader.  Do not attempt to
> > +	 artificially synthesise the opp{1..N} nodes or any of their descendants.
> > +	 They are very platform specific and may damage the hardware if created
> > +	 incorrectly.
> > +
> > +Example [unsafe]
> > +----------------
> > +
> > +cpus {
> > +	cpu at 0 {
> > +		operating-points-v2	= <&cpu0_opp_list>;
> > +	};
> > +};
> > +
> > +/* ############################################################ */
> > +/* # WARNING: Do not attempt to copy/replicate this node,     # */
> > +/* #          it is only to be supplied by the bootloader !!! # */
> > +/* ############################################################ */
> > +cpu0-opp-list {
> > +	compatible	= "operating-points-v2-sti";
> > +	st,syscfg	= <&syscfg [major_offset]>;
> > +	st,syscfg-eng   = <&syscfg_eng [pcode_offset] [minor_offset]>;
> > +
> > +	opp0 {
> > +		opp-hz		= <1200000000>;
> > +		st,avs		= <1110 1150 1100 1080 1040 1020 980 930>;
> > +		st,substrate	= <0xff>;
> > +		st,cuts		= <0xff>;
> > +	};
> > +	opp1 {
> > +		opp-hz		= <1500000000>;
> > +		st,avs		= <1200 1200 1200 1200 1170 1140 1100 1070>;
> > +		st,substrate	= <0xff>;
> > +		st,cuts		= <0x2>;
> > +	};
> > +};
> 
> I don't see more problems here, unless we can move some of this to the
> generic bindings.
> 
> @Rob/Stephen: Please respond before it is late :)
> 

It's interesting to have vendor specific properties like avs,
cuts, and substrate. That could replace our planned usage of the
opp-names property where we encode similar information (speed
bin, revision, etc.) into a string that we look for.

So I wonder why the avs/cut/substrate information can't be
encoded into the opp name? That would make these properties
obsolete, given that all they're used for is to pick out the
correct OPP?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
