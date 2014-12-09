From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 9 Dec 2014 21:21:59 +0530
Subject: [RFC] OPP: Redefine bindings to overcome shortcomings
In-Reply-To: <52c403454c3b8fc201abe7ac74cf657638479311.1417691389.git.viresh.kumar@linaro.org>
References: <52c403454c3b8fc201abe7ac74cf657638479311.1417691389.git.viresh.kumar@linaro.org>
Message-ID: <CAKohpokUXvhqt+z4EPC9k=O8ZnQOqNSGGi8w6w4shYtbvv8mTw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 December 2014 at 16:44, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> The shortcomings we are trying to solve here:
>
> - Some kind of compatibility string to probe the right cpufreq driver for
>   platforms, when multiple drivers are available. For example: how to choose
>   between cpufreq-dt and arm_big_little drivers.
>
> - Getting clock sharing information between CPUs. Single shared clock vs.
>   independent clock per core vs. shared clock per cluster.
>
> - Support for turbo modes
>
> - Other per OPP settings: transition latencies, disabled status, etc.?

Some updates on the structure of bindings which I got up to with help of Arnd
and Rob over IRC, have got better examples to show how things would look
like:

diff --git a/Documentation/devicetree/bindings/power/opp.txt
b/Documentation/devicetree/bindings/power/opp.txt
index 74499e5033fc..8ae574b84650 100644
--- a/Documentation/devicetree/bindings/power/opp.txt
+++ b/Documentation/devicetree/bindings/power/opp.txt
@@ -1,9 +1,292 @@
-* Generic OPP Interface
+Generic OPP (Operating Performance Points) Interface
+----------------------------------------------------

 SoCs have a standard set of tuples consisting of frequency and
 voltage pairs that the device will support per voltage domain. These
 are called Operating Performance Points or OPPs.

+This documents defines OPP bindings with its required/optional properties.
+OPPs can be defined for any device, this file uses CPU device as an example to
+illustrate how to define OPPs.
+
+opp nodes and opp-lists
+
+- opp-listN:
+  List of nodes defining performance points. Following belong to the nodes
+  within the opp-lists.
+
+  Required properties:
+  - frequency-kHz: Frequency in kHz
+  - voltage-uV: voltage in micro Volts
+
+  Optional properties:
+  - turbo-mode: Marks the volt-freq pair as turbo pair.
+  - status: Marks the node enabled/disabled.
+
+- oppN:
+  Operating performance point node per device. Devices using it should have its
+  phandle in their "operating-points-v2" property.
+
+  Required properties:
+  - compatible: allow OPPs to express their compatibility
+  - opp-list: phandle to opp-list defined above.
+
+  Optional properties:
+  - clocks: Tuple of clock providers
+  - clock-names: Clock names
+  - opp-supply: phandle to the parent supply/regulator node
+  - voltage-tolerance: Specify the CPU voltage tolerance in percentage.
+  - clock-latency: Specify the possible maximum transition latency for clock,
+    in unit of nanoseconds.
+
+Example 1: Simple case of dual-core cortex A9-single cluster, sharing
clock line.
+
+/ {
+       cpus {
+               #address-cells = <1>;
+               #size-cells = <0>;
+
+               cpu at 0 {
+                       compatible = "arm,cortex-a9";
+                       reg = <0>;
+                       next-level-cache = <&L2>;
+                       operating-points-v2 = <&opp0>;
+
+                       opp0: opp0 {
+                               compatible = "linux,cpu-dvfs";
+                               clocks = <&clk-controller 0>;
+                               clock-names = "cpu";
+                               opp-supply = <&cpu-supply0>;
+                               voltage-tolerance = <2>; /* percentage */
+                               clock-latency = <300000>;
+                               opp-list = <&opplist0>;
+
+                               opplist0: opp-list0 {
+                                       entry00 {
+                                               frequency-kHz = <1000000>;
+                                               voltage-uV = <975000>;
+                                               status = "okay";
+                                       };
+                                       entry01 {
+                                               frequency-kHz = <1100000>;
+                                               voltage-uV = <1000000>;
+                                               status = "okay";
+                                       };
+                                       entry01 {
+                                               frequency-kHz = <1200000>;
+                                               voltage-uV = <1025000>;
+                                               status = "okay";
+                                               turbo-mode;
+                                       };
+                               };
+                       };
+               };
+
+               cpu at 1 {
+                       compatible = "arm,cortex-a9";
+                       reg = <1>;
+                       next-level-cache = <&L2>;
+                       operating-points-v2 = <&opp0>;
+               };
+       };
+};
+
+Example 2: Quad-core krait (All CPUs have independent clock lines but
have same set of OPPs)
+
+/ {
+       cpus {
+               #address-cells = <1>;
+               #size-cells = <0>;
+
+               cpu at 0 {
+                       compatible = "qcom,krait";
+                       reg = <0>;
+                       next-level-cache = <&L2>;
+                       operating-points-v2 = <&opp0>;
+
+                       opp0: opp0 {
+                               compatible = "linux,cpu-dvfs";
+                               clocks = <&clk-controller 0>;
+                               clock-names = "cpu";
+                               opp-supply = <&cpu-supply0>;
+                               voltage-tolerance = <2>; /* percentage */
+                               clock-latency = <300000>;
+                               opp-list = <&opplist0>;
+
+                               opplist0: opp-list0 {
+                                       entry00 {
+                                               frequency-kHz = <1000000>;
+                                               voltage-uV = <975000>;
+                                               status = "okay";
+                                       };
+                                       entry01 {
+                                               frequency-kHz = <1100000>;
+                                               voltage-uV = <1000000>;
+                                               status = "okay";
+                                       };
+                                       entry01 {
+                                               frequency-kHz = <1200000>;
+                                               voltage-uV = <1025000>;
+                                               status = "okay";
+                                               turbo-mode;
+                                       };
+                               };
+                       };
+               };
+
+               cpu at 1 {
+                       compatible = "qcom,krait";
+                       reg = <1>;
+                       next-level-cache = <&L2>;
+                       operating-points-v2 = <&opp1>;
+
+                       opp1: opp1 {
+                               compatible = "linux,cpu-dvfs";
+                               clocks = <&clk-controller 1>;
+                               clock-names = "cpu";
+                               opp-supply = <&cpu-supply1>;
+                               voltage-tolerance = <2>; /* percentage */
+                               clock-latency = <300000>;
+                               opp-list = <&opplist0>;
+                       };
+               };
+
+               cpu at 2 {
+                       compatible = "qcom,krait";
+                       reg = <2>;
+                       next-level-cache = <&L2>;
+                       operating-points-v2 = <&opp2>;
+
+                       opp2: opp2 {
+                               compatible = "linux,cpu-dvfs";
+                               clocks = <&clk-controller 2>;
+                               clock-names = "cpu";
+                               opp-supply = <&cpu-supply2>;
+                               voltage-tolerance = <2>; /* percentage */
+                               clock-latency = <300000>;
+                               opp-list = <&opplist0>;
+                       };
+               };
+
+               cpu at 3 {
+                       compatible = "qcom,krait";
+                       reg = <3>;
+                       next-level-cache = <&L2>;
+                       operating-points-v2 = <&opp3>;
+
+                       opp3: opp3 {
+                               compatible = "linux,cpu-dvfs";
+                               clocks = <&clk-controller 3>;
+                               clock-names = "cpu";
+                               opp-supply = <&cpu-supply3>;
+                               voltage-tolerance = <2>; /* percentage */
+                               clock-latency = <300000>;
+                               opp-list = <&opplist0>;
+                       };
+               };
+       };
+};
+
+Example 3: Multi-cluster system with separate clock line per cluster.
+
+/ {
+       cpus {
+               #address-cells = <1>;
+               #size-cells = <0>;
+
+               cpu at 0 {
+                       compatible = "arm,cortex-a7";
+                       reg = <0>;
+                       next-level-cache = <&L2>;
+                       operating-points-v2 = <&opp0>;
+
+                       opp0: opp0 {
+                               compatible = "linux,cpu-dvfs";
+                               clocks = <&clk-controller 0>;
+                               clock-names = "cpu";
+                               opp-supply = <&cpu-supply0>;
+                               voltage-tolerance = <2>; /* percentage */
+                               clock-latency = <300000>;
+                               opp-list = <&opplist0>;
+
+                               opplist0: opp-list0 {
+                                       entry00 {
+                                               frequency-kHz = <1000000>;
+                                               voltage-uV = <975000>;
+                                               status = "okay";
+                                       };
+                                       entry01 {
+                                               frequency-kHz = <1100000>;
+                                               voltage-uV = <1000000>;
+                                               status = "okay";
+                                       };
+                                       entry01 {
+                                               frequency-kHz = <1200000>;
+                                               voltage-uV = <1025000>;
+                                               status = "okay";
+                                               turbo-mode;
+                                       };
+                               };
+                       };
+               };
+
+               cpu at 1 {
+                       compatible = "arm,cortex-a7";
+                       reg = <1>;
+                       next-level-cache = <&L2>;
+                       operating-points-v2 = <&opp0>;
+               };
+
+               cpu at 100 {
+                       compatible = "arm,cortex-a15";
+                       reg = <100>;
+                       next-level-cache = <&L2>;
+                       operating-points-v2 = <&opp1>;
+
+                       opp1: opp1 {
+                               compatible = "linux,cpu-dvfs";
+                               clocks = <&clk-controller 1>;
+                               clock-names = "cpu";
+                               opp-supply = <&cpu-supply1>;
+                               voltage-tolerance = <2>; /* percentage */
+                               clock-latency = <400000>;
+                               opp-list = <&opplist1>;
+
+                               opplist1: opp-list1 {
+                                       entry10 {
+                                               frequency-kHz = <1300000>;
+                                               voltage-uV = <1050000>;
+                                               status = "okay";
+                                       };
+                                       entry11 {
+                                               frequency-kHz = <1400000>;
+                                               voltage-uV = <1075000>;
+                                               status = "disabled";
+                                       };
+                                       entry12 {
+                                               frequency-kHz = <1500000>;
+                                               voltage-uV = <1100000>;
+                                               status = "okay";
+                                               turbo-mode;
+                                       };
+                               };
+                       };
+               };
+
+               cpu at 101 {
+                       compatible = "arm,cortex-a15";
+                       reg = <101>;
+                       next-level-cache = <&L2>;
+                       operating-points-v2 = <&opp1>;
+               };
+       };
+};
+
+
+
+Deprecated Bindings
+-------------------
+
