From: robherring2@gmail.com (Rob Herring)
Date: Thu, 29 Jan 2015 10:22:32 -0600
Subject: [RFC V2] OPP: Redefine bindings to overcome shortcomings
In-Reply-To: <cbe949d7a69c3b16a3e9d6e5429eb81d3ae9d8b9.1422009157.git.viresh.kumar@linaro.org>
References: <cbe949d7a69c3b16a3e9d6e5429eb81d3ae9d8b9.1422009157.git.viresh.kumar@linaro.org>
Message-ID: <CAL_JsqKrjvOw4hwOfS_V1g8As0N1xTbf4S1wKnxHdeoHyxH66A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 23, 2015 at 4:44 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
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

I'd like to see acks from Qualcomm folks to make sure this works for them.

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

I still don't think we need this extra level. More below on this.

> +
> +  Required properties:
> +  - opp-khz: Frequency in kHz
> +  - opp-microvolt: voltage in micro Volts

This can be optional as it is valid to have frequency scaling without
voltage scaling. More so for bus scaling than cpu scaling.

> +  Optional properties:
> +  - turbo-mode: Marks the volt-freq pair as turbo pair.
> +  - status: Marks the node enabled/disabled.
> +  - voltage-tolerance: Specify the CPU voltage tolerance in percentage.
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

What about cases where perhaps you have a more complex sequencing
arrangement? For example, what if you have to hit each step (to go
from A -> D you have to go A -> B -> C -> D). Perhaps each OPP could
have an opp-next property which lists other OPPs you can transition to
(and no property means no restriction).

Do you have a specific user in mind? If not, I think we can defer this
issue. I think the binding is flexible enough to accommodate this in
the future.

[...]

> +Example 2: Quad-core krait (All CPUs have independent clock lines but have same set of OPPs)
> +
> +/ {
> +       cpus {
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               cpu at 0 {
> +                       compatible = "qcom,krait";
> +                       reg = <0>;
> +                       next-level-cache = <&L2>;
> +                       clocks = <&clk_controller 0>;
> +                       clock-names = "cpu";
> +                       opp-supply = <&cpu_supply0>;
> +                       operating-points-v2 = <&cpu0_opp>;
> +               };
> +
> +               cpu at 1 {
> +                       compatible = "qcom,krait";
> +                       reg = <1>;
> +                       next-level-cache = <&L2>;
> +                       clocks = <&clk_controller 1>;
> +                       clock-names = "cpu";
> +                       opp-supply = <&cpu_supply1>;
> +                       operating-points-v2 = <&cpu1_opp>;
> +               };
> +
> +               cpu at 2 {
> +                       compatible = "qcom,krait";
> +                       reg = <2>;
> +                       next-level-cache = <&L2>;
> +                       clocks = <&clk_controller 2>;
> +                       clock-names = "cpu";
> +                       opp-supply = <&cpu_supply2>;
> +                       operating-points-v2 = <&cpu2_opp>;
> +               };
> +
> +               cpu at 3 {
> +                       compatible = "qcom,krait";
> +                       reg = <3>;
> +                       next-level-cache = <&L2>;
> +                       clocks = <&clk_controller 3>;
> +                       clock-names = "cpu";
> +                       opp-supply = <&cpu_supply3>;
> +                       operating-points-v2 = <&cpu3_opp>;
> +               };
> +       };
> +
> +       cpu0_opp: opp0 {
> +               compatible = "linux,cpu-dvfs";

As I said before, drop the linux part. I'm not sure about cpu-dvfs
either. Nothing is specific to cpus and you are necessarily doing
voltage scaling. You could want to find all cpu OPPs though. Perhaps:
"cpu-operating-point", "operating-point";

It is not documented either.

> +               opp-list = <&cpu0_opplist>;
> +               opp-intermediate = <&cpu0_intermediate>;
> +
> +               cpu0_opplist: opp-list0 {
> +                       entry00 {
> +                               opp-khz = <1000000>;
> +                               opp-microvolt = <975000>;
> +                               voltage-tolerance = <2>;
> +                               clock-latency-ns = <300000>;
> +                               status = "okay";
> +                       };
> +                       cpu0_intermediate: entry01 {
> +                               opp-khz = <1100000>;
> +                               opp-microvolt = <1000000>;
> +                               voltage-tolerance = <2>;
> +                               clock-latency-ns = <300000>;
> +                               status = "okay";
> +                       };
> +                       entry02 {
> +                               opp-khz = <1200000>;
> +                               opp-microvolt = <1025000>;
> +                               voltage-tolerance = <2>;
> +                               clock-latency-ns = <300000>;
> +                               status = "okay";
> +                               turbo-mode;
> +                       };
> +               };
> +       };
> +
> +       cpu1_opp: opp1 {
> +               compatible = "linux,cpu-dvfs";
> +               opp-list = <&cpu0_opplist>;
> +               opp-intermediate = <&cpu0_intermediate>;
> +       };

This doesn't add anything other than some indirection to imply
independent OPPs. The only way I know the clocks are not shared is you
told me so in the example. I'd still prefer to determine from the
clock api whether 2 clocks can be changed independently. That didn't
seem to be agreed on, so you could simply add a "shared-opp" property
to opp0 to mark an OPP as shared or not. Then you can remove the
opp-list and these other cpuX_opp nodes.

Rob
