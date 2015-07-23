From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 23 Jul 2015 15:22:54 +0530
Subject: [PATCH v3 1/1] dt: cpufreq: st: Provide bindings for ST's
 CPUFreq implementation
In-Reply-To: <1437478420-26419-1-git-send-email-lee.jones@linaro.org>
References: <1437478420-26419-1-git-send-email-lee.jones@linaro.org>
Message-ID: <20150723095254.GN5322@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc'ing few more people who were involved in opp-v2 discussions.

Guys, please take a closer look as this is the first user platform
that wants to extend opp-v2 bindings with platform specific stuff.

On 21-07-15, 12:33, Lee Jones wrote:
> Cc: devicetree at vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
> 
> Only submitting the binding document as requested by Viresh.
> 
> v2 => v3:
>  - Using OPP v2
>  - Moved OPPs out of the CPU node into their own one
>  - Using generic 'opp-hz' property
> 
>  .../devicetree/bindings/cpufreq/cpufreq-st.txt     | 77 ++++++++++++++++++++++
>  1 file changed, 77 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-st.txt
> 
> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-st.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-st.txt
> new file mode 100644
> index 0000000..a478eec
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-st.txt

These are used by cpufreq, but they aren't really cpufreq bindings.

These are opp bindings and must present at:
Documentation/devicetree/bindings/power/opp/st.txt and we should move
opp.txt in that folder as well..

> @@ -0,0 +1,77 @@
> +Binding for ST's CPUFreq driver
> +===============================
> +
> +Required properties [for working voltage scaling]:
> +-------------------------------------------------
> +
> +Located in CPU's node:

I hope below registers are used to define which OPPs are valid for the
CPU and so shouldn't these be present under opp node instead of CPU?

> +- st,syscfg		: Phandle to Major number register
> +				First cell: offset to major number
> +- st,syscfg-eng		: Phandle to Minor number and Pcode registers
> +				First cell: offset to process code
> +				Second cell: offset to minor number
> +
> +Located in 'cpu0-opp-list' node [to be provided ONLY by the bootloader]:
> +
> + - opp{1..N} 		: Each 'oppX' subnode will contain the following properties:
> +  - opp-hz		: CPU frequency [Hz] for this OPP

Not sure if you are required to re define it. In case you want to, the
please add a link here to the bindings that define it. So that we
don't think they are newer bindings.

> +  - st,avs		: List of available voltages [uV] indexed by process code
> +  - st,cuts		: Cut version this OPP is suitable for [0xFF means ALL]
> +  - st,substrate	: Substrate version this OPP is suitable for [0xFF means ALL]

@Stephen: Any idea if these can be relevant for other platforms and we
can move them to generic bindings?

> +WARNING: The cpu0-opp-list will be provided by the bootloader.  Do not attempt to
> +	 artificially synthesise the cpu0-opp-list node or any of its descendants.
> +	 They are very platform specific and may damage the hardware if created
> +	 incorrectly.
> +
> +Required properties [if voltage scaling properties are missing]:
> +-------------------------------------------------------------------
> +
> +Located in CPU's node:
> +
> +- operating-points	: [See: ../power/opp.txt]
> +
> +Example [safe]:
> +--------------
> +
> +cpus {
> +	cpu at 0 {
> +				 /* kHz     uV   */
> +		operating-points = <1500000 0
> +				    1200000 0
> +				    800000  0
> +				    500000  0>;
> +	};
> +};

Why do you want to keep these as well?

> +Example [unsafe]:
> +----------------
> +
> +cpus {
> +	cpu at 0 {
> +		st,syscfg		= <&syscfg [major_offset]>;
> +		st,syscfg-eng   	= <&syscfg_eng [pcode_offset] [minor_offset]>;
> +		operating-points-v2	= <&cpu0_opp_list>;
> +	};
> +};
> +
> +/* ############################################################ */
> +/* # WARNING: Do not attempt to copy/replicate this node,     # */
> +/* #          it is only to be supplied by the bootloader !!! # */
> +/* ############################################################ */
> +cpu0-opp-list {
> +	compatible = "operating-points-v2-sti";
> +	opp0 {
> +		opp-hz		= <1200000000>;
> +		st,avs		= <1110 1150 1100 1080 1040 1020 980 930>;
> +		st,substrate	= <0xff>;
> +		st,cuts		= <0xff>;
> +	};
> +	opp1 {
> +		opp-hz		= <1500000000>;
> +		st,avs		= <1200 1200 1200 1200 1170 1140 1100 1070>;
> +		st,substrate	= <0xff>;
> +		st,cuts		= <0x2>;
> +	};
> +};

-- 
viresh
