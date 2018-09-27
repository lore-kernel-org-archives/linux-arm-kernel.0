From: zhang.lyra@gmail.com (Chunyan Zhang)
Date: Thu, 27 Sep 2018 17:18:50 +0800
Subject: [PATCH v2 04/11] arm64: dts: sc9836/sc9860: Update coresight
 bindings for hardware ports
In-Reply-To: <ccc61e1b-768c-2a6d-3ff5-95b72bc58a6f@arm.com>
References: <20180912135352.19722-1-suzuki.poulose@arm.com>
 <20180912135352.19722-5-suzuki.poulose@arm.com>
 <ccc61e1b-768c-2a6d-3ff5-95b72bc58a6f@arm.com>
Message-ID: <CAAfSe-swWPgCWN6cZbQxLL6fwaJ1qLXnC_X7A0zeYuHDaZ_A1Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Suzuki,

On 27 September 2018 at 16:51, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
> +To: Chunyan Zhang
>
> Chunyan Zhang,
>
> On 09/12/2018 02:53 PM, Suzuki K Poulose wrote:
>>
>> Switch to the new coresight bindings for hw ports
>>
>
> How can we push this patch ? Do you generally send the spreadtrum
> specific changes to ARM soc folks ? Or would you like me to post
> this directly to ARM soc folks ?

Yeah, at present sprd dts files generally got merged through arm-soc
(I've added arm at kernel.org).

Thanks,
Chunyan

>
> Suzuki
>
>
>> Cc: orsonzhai at gmail.com
>> Cc: zhang.lyra at gmail.com
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>   arch/arm64/boot/dts/sprd/sc9836.dtsi |  82 +++++-----
>>   arch/arm64/boot/dts/sprd/sc9860.dtsi | 215 ++++++++++++++-------------
>>   2 files changed, 153 insertions(+), 144 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/sprd/sc9836.dtsi
>> b/arch/arm64/boot/dts/sprd/sc9836.dtsi
>> index 63894c456969..4bcdbb709c01 100644
>> --- a/arch/arm64/boot/dts/sprd/sc9836.dtsi
>> +++ b/arch/arm64/boot/dts/sprd/sc9836.dtsi
>> @@ -50,10 +50,11 @@
>>                 reg = <0 0x10003000 0 0x1000>;
>>                 clocks = <&clk26mhz>;
>>                 clock-names = "apb_pclk";
>> -               port {
>> -                       etf_in: endpoint {
>> -                               slave-mode;
>> -                               remote-endpoint = <&funnel_out_port0>;
>> +               in-ports {
>> +                       port {
>> +                               etf_in: endpoint {
>> +                                       remote-endpoint =
>> <&funnel_out_port0>;
>> +                               };
>>                         };
>>                 };
>>         };
>> @@ -63,55 +64,50 @@
>>                 reg = <0 0x10001000 0 0x1000>;
>>                 clocks = <&clk26mhz>;
>>                 clock-names = "apb_pclk";
>> -               ports {
>> +
>> +               out-ports {
>> +                       port {
>> +                               funnel_out_port0: endpoint {
>> +                                       remote-endpoint = <&etf_in>;
>> +                               };
>> +                       };
>> +               };
>> +
>> +               in-ports {
>>                         #address-cells = <1>;
>>                         #size-cells = <0>;
>>   -                     /* funnel output port */
>>                         port at 0 {
>> -                               reg = <0>;
>> -                               funnel_out_port0: endpoint {
>> -                                       remote-endpoint = <&etf_in>;
>> -                               };
>> -                       };
>> -
>> -                       /* funnel input port 0-4 */
>> -                       port at 1 {
>>                                 reg = <0>;
>>                                 funnel_in_port0: endpoint {
>> -                                       slave-mode;
>>                                         remote-endpoint = <&etm0_out>;
>>                                 };
>>                         };
>>   -                     port at 2 {
>> +                       port at 1 {
>>                                 reg = <1>;
>>                                 funnel_in_port1: endpoint {
>> -                                       slave-mode;
>>                                         remote-endpoint = <&etm1_out>;
>>                                 };
>>                         };
>>   -                     port at 3 {
>> +                       port at 2 {
>>                                 reg = <2>;
>>                                 funnel_in_port2: endpoint {
>> -                                       slave-mode;
>>                                         remote-endpoint = <&etm2_out>;
>>                                 };
>>                         };
>>   -                     port at 4 {
>> +                       port at 3 {
>>                                 reg = <3>;
>>                                 funnel_in_port3: endpoint {
>> -                                       slave-mode;
>>                                         remote-endpoint = <&etm3_out>;
>>                                 };
>>                         };
>>   -                     port at 5 {
>> +                       port at 4 {
>>                                 reg = <4>;
>>                                 funnel_in_port4: endpoint {
>> -                                       slave-mode;
>>                                         remote-endpoint = <&stm_out>;
>>                                 };
>>                         };
>> @@ -126,9 +122,11 @@
>>                 cpu = <&cpu0>;
>>                 clocks = <&clk26mhz>;
>>                 clock-names = "apb_pclk";
>> -               port {
>> -                       etm0_out: endpoint {
>> -                               remote-endpoint = <&funnel_in_port0>;
>> +               out-ports {
>> +                       port {
>> +                               etm0_out: endpoint {
>> +                                       remote-endpoint =
>> <&funnel_in_port0>;
>> +                               };
>>                         };
>>                 };
>>         };
>> @@ -140,9 +138,11 @@
>>                 cpu = <&cpu1>;
>>                 clocks = <&clk26mhz>;
>>                 clock-names = "apb_pclk";
>> -               port {
>> -                       etm1_out: endpoint {
>> -                               remote-endpoint = <&funnel_in_port1>;
>> +               out-ports {
>> +                       port {
>> +                               etm1_out: endpoint {
>> +                                       remote-endpoint =
>> <&funnel_in_port1>;
>> +                               };
>>                         };
>>                 };
>>         };
>> @@ -154,9 +154,11 @@
>>                 cpu = <&cpu2>;
>>                 clocks = <&clk26mhz>;
>>                 clock-names = "apb_pclk";
>> -               port {
>> -                       etm2_out: endpoint {
>> -                               remote-endpoint = <&funnel_in_port2>;
>> +               out-ports {
>> +                       port {
>> +                               etm2_out: endpoint {
>> +                                       remote-endpoint =
>> <&funnel_in_port2>;
>> +                               };
>>                         };
>>                 };
>>         };
>> @@ -168,9 +170,11 @@
>>                 cpu = <&cpu3>;
>>                 clocks = <&clk26mhz>;
>>                 clock-names = "apb_pclk";
>> -               port {
>> -                       etm3_out: endpoint {
>> -                               remote-endpoint = <&funnel_in_port3>;
>> +               out-ports {
>> +                       port {
>> +                               etm3_out: endpoint {
>> +                                       remote-endpoint =
>> <&funnel_in_port3>;
>> +                               };
>>                         };
>>                 };
>>         };
>> @@ -182,9 +186,11 @@
>>                 reg-names = "stm-base", "stm-stimulus-base";
>>                 clocks = <&clk26mhz>;
>>                 clock-names = "apb_pclk";
>> -               port {
>> -                       stm_out: endpoint {
>> -                               remote-endpoint = <&funnel_in_port4>;
>> +               out-ports {
>> +                       port {
>> +                               stm_out: endpoint {
>> +                                       remote-endpoint =
>> <&funnel_in_port4>;
>> +                               };
>>                         };
>>                 };
>>         };
>> diff --git a/arch/arm64/boot/dts/sprd/sc9860.dtsi
>> b/arch/arm64/boot/dts/sprd/sc9860.dtsi
>> index 48f5928ed45c..5f57bf055cde 100644
>> --- a/arch/arm64/boot/dts/sprd/sc9860.dtsi
>> +++ b/arch/arm64/boot/dts/sprd/sc9860.dtsi
>> @@ -304,30 +304,29 @@
>>                         reg = <0 0x10001000 0 0x1000>;
>>                         clocks = <&ext_26m>;
>>                         clock-names = "apb_pclk";
>> -                       ports {
>> -                               #address-cells = <1>;
>> -                               #size-cells = <0>;
>> -
>> -                               port at 0 {
>> -                                       reg = <0>;
>> +                       out-ports {
>> +                               port {
>>                                         soc_funnel_out_port: endpoint {
>>                                                 remote-endpoint =
>> <&etb_in>;
>>                                         };
>>                                 };
>> +                       };
>>   -                             port at 1 {
>> +                       in-ports {
>> +                               #address-cells = <1>;
>> +                               #size-cells = <0>;
>> +
>> +                               port at 0 {
>>                                         reg = <0>;
>>                                         soc_funnel_in_port0: endpoint {
>> -                                               slave-mode;
>>                                                 remote-endpoint =
>>                                                 <&main_funnel_out_port>;
>>                                         };
>>                                 };
>>   -                             port at 2 {
>> +                               port at 4 {
>>                                         reg = <4>;
>>                                         soc_funnel_in_port1: endpoint {
>> -                                               slave-mode;
>>                                                 remote-endpoint =
>>                                                         <&stm_out_port>;
>>                                         };
>> @@ -340,11 +339,12 @@
>>                         reg = <0 0x10003000 0 0x1000>;
>>                         clocks = <&ext_26m>;
>>                         clock-names = "apb_pclk";
>> -                       port {
>> -                               etb_in: endpoint {
>> -                                       slave-mode;
>> -                                       remote-endpoint =
>> -                                               <&soc_funnel_out_port>;
>> +                       out-ports {
>> +                               port {
>> +                                       etb_in: endpoint {
>> +                                               remote-endpoint =
>> +
>> <&soc_funnel_out_port>;
>> +                                       };
>>                                 };
>>                         };
>>                 };
>> @@ -356,10 +356,12 @@
>>                         reg-names = "stm-base", "stm-stimulus-base";
>>                         clocks = <&ext_26m>;
>>                         clock-names = "apb_pclk";
>> -                       port {
>> -                               stm_out_port: endpoint {
>> -                                       remote-endpoint =
>> -                                               <&soc_funnel_in_port1>;
>> +                       out-ports {
>> +                               port {
>> +                                       stm_out_port: endpoint {
>> +                                               remote-endpoint =
>> +
>> <&soc_funnel_in_port1>;
>> +                                       };
>>                                 };
>>                         };
>>                 };
>> @@ -369,38 +371,36 @@
>>                         reg = <0 0x11001000 0 0x1000>;
>>                         clocks = <&ext_26m>;
>>                         clock-names = "apb_pclk";
>> -                       ports {
>> -                               #address-cells = <1>;
>> -                               #size-cells = <0>;
>> -
>> -                               port at 0 {
>> -                                       reg = <0>;
>> +                       out-ports {
>> +                               port {
>>                                         cluster0_funnel_out_port: endpoint
>> {
>>                                                 remote-endpoint =
>>
>> <&cluster0_etf_in>;
>>                                         };
>>                                 };
>> +                       };
>>   -                             port at 1 {
>> +                       in-ports {
>> +                               #address-cells = <1>;
>> +                               #size-cells = <0>;
>> +
>> +                               port at 0 {
>>                                         reg = <0>;
>>                                         cluster0_funnel_in_port0: endpoint
>> {
>> -                                               slave-mode;
>>                                                 remote-endpoint =
>> <&etm0_out>;
>>                                         };
>>                                 };
>>   -                             port at 2 {
>> +                               port at 1 {
>>                                         reg = <1>;
>>                                         cluster0_funnel_in_port1: endpoint
>> {
>> -                                               slave-mode;
>>                                                 remote-endpoint =
>> <&etm1_out>;
>>                                         };
>>                                 };
>>   -                             port at 3 {
>> +                               port at 2 {
>>                                         reg = <2>;
>>                                         cluster0_funnel_in_port2: endpoint
>> {
>> -                                               slave-mode;
>>                                                 remote-endpoint =
>> <&etm2_out>;
>>                                         };
>>                                 };
>> @@ -408,7 +408,6 @@
>>                                 port at 4 {
>>                                         reg = <4>;
>>                                         cluster0_funnel_in_port3: endpoint
>> {
>> -                                               slave-mode;
>>                                                 remote-endpoint =
>> <&etm3_out>;
>>                                         };
>>                                 };
>> @@ -420,46 +419,43 @@
>>                         reg = <0 0x11002000 0 0x1000>;
>>                         clocks = <&ext_26m>;
>>                         clock-names = "apb_pclk";
>> -                       ports {
>> -                               #address-cells = <1>;
>> -                               #size-cells = <0>;
>> -
>> -                               port at 0 {
>> -                                       reg = <0>;
>> +                       out-ports {
>> +                               port {
>>                                         cluster1_funnel_out_port: endpoint
>> {
>>                                                 remote-endpoint =
>>
>> <&cluster1_etf_in>;
>>                                         };
>>                                 };
>> +                       };
>>   -                             port at 1 {
>> +                       in-ports {
>> +                               #address-cells = <1>;
>> +                               #size-cells = <0>;
>> +
>> +                               port at 0 {
>>                                         reg = <0>;
>>                                         cluster1_funnel_in_port0: endpoint
>> {
>> -                                               slave-mode;
>>                                                 remote-endpoint =
>> <&etm4_out>;
>>                                         };
>>                                 };
>>   -                             port at 2 {
>> +                               port at 1 {
>>                                         reg = <1>;
>>                                         cluster1_funnel_in_port1: endpoint
>> {
>> -                                               slave-mode;
>>                                                 remote-endpoint =
>> <&etm5_out>;
>>                                         };
>>                                 };
>>   -                             port at 3 {
>> +                               port at 2 {
>>                                         reg = <2>;
>>                                         cluster1_funnel_in_port2: endpoint
>> {
>> -                                               slave-mode;
>>                                                 remote-endpoint =
>> <&etm6_out>;
>>                                         };
>>                                 };
>>   -                             port at 4 {
>> +                               port at 3 {
>>                                         reg = <3>;
>>                                         cluster1_funnel_in_port3: endpoint
>> {
>> -                                               slave-mode;
>>                                                 remote-endpoint =
>> <&etm7_out>;
>>                                         };
>>                                 };
>> @@ -472,22 +468,18 @@
>>                         clocks = <&ext_26m>;
>>                         clock-names = "apb_pclk";
>>   -                     ports {
>> -                               #address-cells = <1>;
>> -                               #size-cells = <0>;
>> -
>> -                               port at 0 {
>> -                                       reg = <0>;
>> +                       out-ports {
>> +                               port {
>>                                         cluster0_etf_out: endpoint {
>>                                                 remote-endpoint =
>>                                                 <&main_funnel_in_port0>;
>>                                         };
>>                                 };
>> +                       };
>>   -                             port at 1 {
>> -                                       reg = <0>;
>> +                       in-ports {
>> +                               port {
>>                                         cluster0_etf_in: endpoint {
>> -                                               slave-mode;
>>                                                 remote-endpoint =
>>
>> <&cluster0_funnel_out_port>;
>>                                         };
>> @@ -501,22 +493,18 @@
>>                         clocks = <&ext_26m>;
>>                         clock-names = "apb_pclk";
>>   -                     ports {
>> -                               #address-cells = <1>;
>> -                               #size-cells = <0>;
>> -
>> -                               port at 0 {
>> -                                       reg = <0>;
>> +                       out-ports {
>> +                               port {
>>                                         cluster1_etf_out: endpoint {
>>                                                 remote-endpoint =
>>                                                 <&main_funnel_in_port1>;
>>                                         };
>>                                 };
>> +                       };
>>   -                             port at 1 {
>> -                                       reg = <0>;
>> +                       in-ports {
>> +                               port {
>>                                         cluster1_etf_in: endpoint {
>> -                                               slave-mode;
>>                                                 remote-endpoint =
>>
>> <&cluster1_funnel_out_port>;
>>                                         };
>> @@ -530,31 +518,30 @@
>>                         clocks = <&ext_26m>;
>>                         clock-names = "apb_pclk";
>>   -                     ports {
>> -                               #address-cells = <1>;
>> -                               #size-cells = <0>;
>> -
>> -                               port at 0 {
>> -                                       reg = <0>;
>> +                       out-ports {
>> +                               port {
>>                                         main_funnel_out_port: endpoint {
>>                                                 remote-endpoint =
>>
>> <&soc_funnel_in_port0>;
>>                                         };
>>                                 };
>> +                       };
>>   -                             port at 1 {
>> +                       in-ports {
>> +                               #address-cells = <1>;
>> +                               #size-cells = <0>;
>> +
>> +                               port at 0 {
>>                                         reg = <0>;
>>                                         main_funnel_in_port0: endpoint {
>> -                                               slave-mode;
>>                                                 remote-endpoint =
>>
>> <&cluster0_etf_out>;
>>                                         };
>>                                 };
>>   -                             port at 2 {
>> +                               port at 1 {
>>                                         reg = <1>;
>>                                         main_funnel_in_port1: endpoint {
>> -                                               slave-mode;
>>                                                 remote-endpoint =
>>
>> <&cluster1_etf_out>;
>>                                         };
>> @@ -569,10 +556,12 @@
>>                         clocks = <&ext_26m>;
>>                         clock-names = "apb_pclk";
>>   -                     port {
>> -                               etm0_out: endpoint {
>> -                                       remote-endpoint =
>> -
>> <&cluster0_funnel_in_port0>;
>> +                       out-ports {
>> +                               port {
>> +                                       etm0_out: endpoint {
>> +                                               remote-endpoint =
>> +
>> <&cluster0_funnel_in_port0>;
>> +                                       };
>>                                 };
>>                         };
>>                 };
>> @@ -584,10 +573,12 @@
>>                         clocks = <&ext_26m>;
>>                         clock-names = "apb_pclk";
>>   -                     port {
>> -                               etm1_out: endpoint {
>> -                                       remote-endpoint =
>> -
>> <&cluster0_funnel_in_port1>;
>> +                       out-ports {
>> +                               port {
>> +                                       etm1_out: endpoint {
>> +                                               remote-endpoint =
>> +
>> <&cluster0_funnel_in_port1>;
>> +                                       };
>>                                 };
>>                         };
>>                 };
>> @@ -599,10 +590,12 @@
>>                         clocks = <&ext_26m>;
>>                         clock-names = "apb_pclk";
>>   -                     port {
>> -                               etm2_out: endpoint {
>> -                                       remote-endpoint =
>> -
>> <&cluster0_funnel_in_port2>;
>> +                       out-ports {
>> +                               port {
>> +                                       etm2_out: endpoint {
>> +                                               remote-endpoint =
>> +
>> <&cluster0_funnel_in_port2>;
>> +                                       };
>>                                 };
>>                         };
>>                 };
>> @@ -614,10 +607,12 @@
>>                         clocks = <&ext_26m>;
>>                         clock-names = "apb_pclk";
>>   -                     port {
>> -                               etm3_out: endpoint {
>> -                                       remote-endpoint =
>> -
>> <&cluster0_funnel_in_port3>;
>> +                       out-ports {
>> +                               port {
>> +                                       etm3_out: endpoint {
>> +                                               remote-endpoint =
>> +
>> <&cluster0_funnel_in_port3>;
>> +                                       };
>>                                 };
>>                         };
>>                 };
>> @@ -629,10 +624,12 @@
>>                         clocks = <&ext_26m>;
>>                         clock-names = "apb_pclk";
>>   -                     port {
>> -                               etm4_out: endpoint {
>> -                                       remote-endpoint =
>> -
>> <&cluster1_funnel_in_port0>;
>> +                       out-ports {
>> +                               port {
>> +                                       etm4_out: endpoint {
>> +                                               remote-endpoint =
>> +
>> <&cluster1_funnel_in_port0>;
>> +                                       };
>>                                 };
>>                         };
>>                 };
>> @@ -644,10 +641,12 @@
>>                         clocks = <&ext_26m>;
>>                         clock-names = "apb_pclk";
>>   -                     port {
>> -                               etm5_out: endpoint {
>> -                                       remote-endpoint =
>> -
>> <&cluster1_funnel_in_port1>;
>> +                       out-ports {
>> +                               port {
>> +                                       etm5_out: endpoint {
>> +                                               remote-endpoint =
>> +
>> <&cluster1_funnel_in_port1>;
>> +                                       };
>>                                 };
>>                         };
>>                 };
>> @@ -659,10 +658,12 @@
>>                         clocks = <&ext_26m>;
>>                         clock-names = "apb_pclk";
>>   -                     port {
>> -                               etm6_out: endpoint {
>> -                                       remote-endpoint =
>> -
>> <&cluster1_funnel_in_port2>;
>> +                       out-ports {
>> +                               port {
>> +                                       etm6_out: endpoint {
>> +                                               remote-endpoint =
>> +
>> <&cluster1_funnel_in_port2>;
>> +                                       };
>>                                 };
>>                         };
>>                 };
>> @@ -674,10 +675,12 @@
>>                         clocks = <&ext_26m>;
>>                         clock-names = "apb_pclk";
>>   -                     port {
>> -                               etm7_out: endpoint {
>> -                                       remote-endpoint =
>> -
>> <&cluster1_funnel_in_port3>;
>> +                       out-ports {
>> +                               port {
>> +                                       etm7_out: endpoint {
>> +                                               remote-endpoint =
>> +
>> <&cluster1_funnel_in_port3>;
>> +                                       };
>>                                 };
>>                         };
>>                 };
>>
>
