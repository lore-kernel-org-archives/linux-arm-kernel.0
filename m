From: robherring2@gmail.com (Rob Herring)
Date: Wed, 17 Jun 2015 08:23:52 -0500
Subject: [PATCH V7 2/3] OPP: Allow multiple OPP tables to be passed via DT
In-Reply-To: <263c128844f5a3c9280c8be71f6c9eb1869a5188.1433434659.git.viresh.kumar@linaro.org>
References: <cover.1433434659.git.viresh.kumar@linaro.org>
 <263c128844f5a3c9280c8be71f6c9eb1869a5188.1433434659.git.viresh.kumar@linaro.org>
Message-ID: <CAL_Jsq+EOOeQw42wZi+H82ovLn8LcQUuK9HGT+FvewdhTf7Q1w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 4, 2015 at 11:20 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On some platforms (Like Qualcomm's SoCs), it is not decided until
> runtime on what OPPs to use. The OPP tables can be fixed at compile
> time, but which table to use is found out only after reading some efuses
> (sort of an prom) and knowing characteristics of the SoC.
>
> To support such platform we need to pass multiple OPP tables per device
> and hardware should be able to choose one and only one table out of
> those.
>
> Update OPP-v2 bindings to support that.
>
> Acked-by: Nishanth Menon <nm@ti.com>
> Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  Documentation/devicetree/bindings/power/opp.txt | 52 +++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/power/opp.txt b/Documentation/devicetree/bindings/power/opp.txt
> index 259bf00edf7d..2938c52dbf84 100644
> --- a/Documentation/devicetree/bindings/power/opp.txt
> +++ b/Documentation/devicetree/bindings/power/opp.txt
> @@ -45,6 +45,9 @@ Devices supporting OPPs must set their "operating-points-v2" property with
>  phandle to a OPP table in their DT node. The OPP core will use this phandle to
>  find the operating points for the device.
>
> +Devices may want to choose OPP tables at runtime and so can provide a list of
> +phandles here. But only *one* of them should be chosen at runtime.
> +
>  If required, this can be extended for SoC vendor specfic bindings. Such bindings
>  should be documented as Documentation/devicetree/bindings/power/<vendor>-opp.txt
>  and should have a compatible description like: "operating-points-v2-<vendor>".
> @@ -63,6 +66,9 @@ This describes the OPPs belonging to a device. This node can have following
>    reference an OPP.
>
>  Optional properties:
> +- opp-name: Name of the OPP table, to uniquely identify it if more than one OPP
> +  table is supplied in "operating-points-v2" property of device.
> +
>  - opp-shared: Indicates that device nodes using this OPP Table Node's phandle
>    switch their DVFS state together, i.e. they share clock/voltage/current lines.
>    Missing property means devices have independent clock/voltage/current lines,
> @@ -396,3 +402,49 @@ Example 4: Handling multiple regulators
>                 };
>         };
>  };
> +
> +Example 5: Multiple OPP tables
> +
> +/ {
> +       cpus {
> +               cpu at 0 {
> +                       compatible = "arm,cortex-a7";
> +                       ...
> +
> +                       cpu-supply = <&cpu_supply>
> +                       operating-points-v2 = <&cpu0_opp_table_slow>, <&cpu0_opp_table_fast>;

You've made a fundamental change here in that this can now be a list
of phandles. There should be some description on what a list means
(merge the tables?, select one?).

I think this needs to have a defined order and the platform should
know what that is. For example, if you read the efuses and decide you
need the "slow" table, you know to pick the first entry. Then you
don't need opp-name. Does that work for QCom?

Rob
