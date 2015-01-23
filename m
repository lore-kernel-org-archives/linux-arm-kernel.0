From: l.stach@pengutronix.de (Lucas Stach)
Date: Fri, 23 Jan 2015 12:39:14 +0100
Subject: [RFC V2] OPP: Redefine bindings to overcome shortcomings
In-Reply-To: <cbe949d7a69c3b16a3e9d6e5429eb81d3ae9d8b9.1422009157.git.viresh.kumar@linaro.org>
References: <cbe949d7a69c3b16a3e9d6e5429eb81d3ae9d8b9.1422009157.git.viresh.kumar@linaro.org>
Message-ID: <1422013154.29475.11.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, den 23.01.2015, 16:14 +0530 schrieb Viresh Kumar:
> Rob et al,
> 
> This is another attempt to redefine OPP bindings which we concluded to after
> first round of reviews.
> 
> Current OPP (Operating performance point) DT bindings are proven to be
> insufficient at multiple instances.
> 
> There had been multiple band-aid approaches to get them fixed (The latest one
> being: http://www.mail-archive.com/devicetree at vger.kernel.org/msg53398.html).
> For obvious reasons Rob rejected them and shown the right path forward.
> 
> The shortcomings we are trying to solve here:
> 
> - How to select which driver to probe for a platform, when multiple drivers are
>   available. For example: how to choose between cpufreq-dt and arm_big_little
>   drivers.
> 
> - Getting clock sharing information between CPUs. Single shared clock vs
>   independent clock per core vs shared clock per cluster.
> 
> - Support for turbo modes
> 
> - Support for intermediate frequencies
> 
> - Other per OPP settings: transition latencies, disabled status, etc.?
> 
> Please see the below bindings for further details.
> 
> I haven't incorporated the comments given by Mark Brown as I had some doubts.
> @broonie: Is this what you wanted to mention earlier ? : http://pastebin.com/1RZTccmm
> 

I think we should work this out for the new bindings, as
voltage-tolerance is a completely bogus value.

> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> 
>  Documentation/devicetree/bindings/power/opp.txt | 309 +++++++++++++++++++++++-
>  1 file changed, 308 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/power/opp.txt b/Documentation/devicetree/bindings/power/opp.txt
> index 74499e5033fc..9cdc0c9b09af 100644
> --- a/Documentation/devicetree/bindings/power/opp.txt
> +++ b/Documentation/devicetree/bindings/power/opp.txt
> @@ -1,9 +1,316 @@
> -* Generic OPP Interface
> +Generic OPP (Operating Performance Points) Interface
> +----------------------------------------------------
>  
>  SoCs have a standard set of tuples consisting of frequency and
>  voltage pairs that the device will support per voltage domain. These
>  are called Operating Performance Points or OPPs.
>  
> +This documents defines OPP bindings with its required/optional properties. OPPs
> +can be defined for any device, this file uses CPU as an example to illustrate
> +how to define OPPs.
> +
> +opp nodes and opp-lists
> +
> +- opp-listN:
> +  List of nodes defining performance points. Following belong to the nodes
> +  within the opp-lists.
> +
> +  Required properties:
> +  - opp-khz: Frequency in kHz
> +  - opp-microvolt: voltage in micro Volts

Each OPP voltage should be defined by the triplet of minimum,
nominal/typical, maximum. This lets you specify exact tolerances in each
direction and should cover most use-cases.

IMHO it would make sense to just define opp-microvolt as an array of
those 3 values, so the DT doesn't get bloated with a lot more
properties.

A typical value for a CPU could then look like this:
opp-microvolt = <800000 850000 1100000>

For devices without any tolerance you can just specify the same value
three times and be done with it:
opp-microvolt = <900000 900000 900000>

> +
> +  Optional properties:
> +  - turbo-mode: Marks the volt-freq pair as turbo pair.
> +  - status: Marks the node enabled/disabled.
> +  - voltage-tolerance: Specify the CPU voltage tolerance in percentage.

Please let's drop this.

> +  - clock-latency-ns: Specify the possible maximum transition latency (in
> +    nanoseconds) for switching to this opp from any other opp.
> +
> +- oppN:
> +  Operating performance point node per device. Devices using it should have its
> +  phandle in their "operating-points-v2" property.
> +
> +  Required properties:
> +  - compatible: allow OPPs to express their compatibility.
> +  - opp-list: phandle to opp-list defined above.
> +
> +  Optional properties:
> +  - opp-intermediate: Stable opp we *must* switch to, before switching to the
> +    target opp. Contains phandle of one of the opp-node present in opp-list.
> +
[...]

Regards,
Lucas
