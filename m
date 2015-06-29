From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Mon, 29 Jun 2015 08:36:06 -0600
Subject: [PATCH V2 1/1] ARM: dts: imx7d: add cortex-a7 coresight component
In-Reply-To: <20150628133953.GE10332@tiger>
References: <1433192081-1131-1-git-send-email-Frank.Li@freescale.com>
 <20150628133953.GE10332@tiger>
Message-ID: <CANLsYkydQWTLn8LaOrHc0F=ESzS8k+2qxxpqoGeF4JVOUGC1Jg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 June 2015 at 07:39, Shawn Guo <shawnguo@kernel.org> wrote:
> On Tue, Jun 02, 2015 at 04:54:41AM +0800, Frank.Li at freescale.com wrote:
>> From: Frank Li <Frank.Li@freescale.com>
>>
>> Added etm, etb, funnel and replicator
>>
>> usage example:
>>
>>     echo 1 >/sys/bus/coresight/devices/30086000.etr/enable_sink
>>     echo 1 >/sys/bus/coresight/devices/3007c000.etm/enable_source
>>
>>         coresight-tmc 30086000.etr: TMC enabled
>>         coresight-replicator replicator.1: REPLICATOR enabled
>>         coresight-tmc 30084000.tmc: TMC enabled
>>         coresight-funnel 30083000.funnel: FUNNEL inport 0 enabled
>>         coresight-funnel 30041000.funnel: FUNNEL inport 0 enabled
>>         coresight-etm3x 3007c000.etm: ETM tracing enabled
>>
>>     etm enable here.
>>     trace data save at /dev/30086000.etr
>>
>>     cat /dev/30086000.etr > trace.data
>>
>>         coresight-tmc 30086000.etr: TMC read start
>>         coresight-tmc 30086000.etr: TMC read end
>>
>>     use ptm2human(https://github.com/hwangcc23/ptm2human) to show trace data
>>
>>     ptm2human -i trace.data
>>
>> Signed-off-by: Frank Li <Frank.Li@freescale.com>
>> ---
>> Change from V1 to V2
>>  - remove "0" after @
>>  - add comments about unused funnel input port
>>  - add comments about add  arm,primecell-periphid
>>
>>  arch/arm/boot/dts/imx7d.dtsi | 202 +++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 202 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
>> index b4cd8fd..d715501 100644
>> --- a/arch/arm/boot/dts/imx7d.dtsi
>> +++ b/arch/arm/boot/dts/imx7d.dtsi
>> @@ -121,6 +121,208 @@
>>               clock-output-names = "osc";
>>       };
>>
>> +     etr at 30086000 {
>> +             compatible = "arm,coresight-tmc", "arm,primecell";
>> +             reg = <0x30086000 0x1000>;
>> +
>
> Drop this new line.
>
>> +             clocks = <&clks IMX7D_MAIN_AXI_ROOT_CLK>;
>> +             clock-names = "apb_pclk";
>> +
>> +             port {
>> +                     etr_in_port: endpoint {
>> +                             slave-mode;
>> +                             remote-endpoint = <&replicator_out_port1>;
>> +                     };
>> +             };
>> +     };
>> +
>> +     tpiu at 30087000 {
>> +             compatible = "arm,coresight-tpiu", "arm,primecell";
>> +             reg = <0x30087000 0x1000>;
>> +
>
> Ditto
>
>> +             clocks = <&clks IMX7D_MAIN_AXI_ROOT_CLK>;
>> +             clock-names = "apb_pclk";
>
> Have a new line here.
>
>> +             port {
>> +                     tpiu_in_port: endpoint at 0 {
>
> Why do we need a @unit-address here?

Good catch - The "@0" is indeed not required.

>
>> +                             slave-mode;
>> +                             remote-endpoint = <&replicator_out_port1>;
>> +                     };
>> +             };
>> +     };
>> +
>> +     replicator {
>> +             /* non-configurable replicators don't show up on the
>> +              * AMBA bus.  As such no need to add "arm,primecell"
>> +              */
>
>                 /*
>                  * Multiple-line comment
>                  */
>
>> +             compatible = "arm,coresight-replicator";
>> +
>> +             ports {
>> +                     #address-cells = <1>;
>> +                     #size-cells = <0>;
>> +
>> +                     /* replicator output ports */
>> +                     port at 0 {
>> +                             reg = <0>;
>> +                             replicator_out_port0: endpoint {
>> +                                     remote-endpoint = <&tpiu_in_port>;
>> +                             };
>> +                     };
>> +
>> +                     port at 1 {
>> +                             reg = <1>;
>> +                             replicator_out_port1: endpoint {
>> +                                     remote-endpoint = <&etr_in_port>;
>> +                             };
>> +                     };
>> +
>> +                     /* replicator input port */
>> +                     port at 2 {
>> +                             reg = <0>;
>> +                             replicator_in_port0: endpoint {
>> +                                     slave-mode;
>> +                                     remote-endpoint = <&etf_out_port>;
>> +                             };
>> +                     };
>> +             };
>> +     };
>> +
>> +     etf at 30084000 {
>> +             compatible = "arm,coresight-tmc", "arm,primecell";
>> +             reg = <0x30084000 0x1000>;
>> +             clocks = <&clks IMX7D_MAIN_AXI_ROOT_CLK>;
>> +             clock-names = "apb_pclk";
>> +
>> +             ports {
>> +                     #address-cells = <1>;
>> +                     #size-cells = <0>;
>> +
>> +                     port at 0 {
>> +                             reg = <0>;
>> +                             etf_in_port: endpoint {
>> +                                     slave-mode;
>> +                                     remote-endpoint = <&hugo_funnel_out_port0>;
>> +                             };
>> +                     };
>> +
>> +                     port at 1 {
>> +                             reg = <0>;
>> +                             etf_out_port: endpoint {
>> +                                     remote-endpoint = <&replicator_in_port0>;
>> +                             };
>> +                     };
>> +             };
>> +     };
>> +
>> +     funnel at 30083000 {
>> +             compatible = "arm,coresight-funnel", "arm,primecell";
>> +             reg = <0x30083000 0x1000>;
>> +             clocks = <&clks IMX7D_MAIN_AXI_ROOT_CLK>;
>> +             clock-names = "apb_pclk";
>> +
>> +             ports {
>> +                     #address-cells = <1>;
>> +                     #size-cells = <0>;
>> +
>> +                     /* funnel input ports */
>> +                     port at 0 {
>> +                             reg = <0>;
>> +                             hugo_funnel_in_port0: endpoint {
>> +                                     slave-mode;
>> +                                     remote-endpoint = <&ca_funnel_out_port0>;
>> +                             };
>> +                     };
>> +
>> +                     port at 1 {
>> +                             reg = <1>;
>> +                             hugo_funnel_in_port1: endpoint {
>> +                                     slave-mode; /* M4 input */
>> +                             };
>> +                     };
>> +
>> +                     port at 2 {
>> +                             reg = <0>;
>> +                             hugo_funnel_out_port0: endpoint {
>> +                                     remote-endpoint = <&etf_in_port>;
>> +                             };
>> +                     };
>> +
>> +                     /* the other input ports are not connect to anything */
>> +             };
>> +     };
>> +
>> +     funnel at 30041000 {
>> +             compatible = "arm,coresight-funnel", "arm,primecell";
>> +             reg = <0x30041000 0x1000>;
>> +             clocks = <&clks IMX7D_MAIN_AXI_ROOT_CLK>;
>> +             clock-names = "apb_pclk";
>> +
>> +             ports {
>> +                     #address-cells = <1>;
>> +                     #size-cells = <0>;
>> +
>> +                     /* funnel input ports */
>> +                     port at 0 {
>> +                             reg = <0>;
>> +                             ca_funnel_in_port0: endpoint {
>> +                                     slave-mode;
>> +                                     remote-endpoint = <&etm0_out_port>;
>> +                             };
>> +                     };
>> +
>> +                     port at 1 {
>> +                             reg = <1>;
>> +                             ca_funnel_in_port1: endpoint {
>> +                                     slave-mode;
>> +                                     remote-endpoint = <&etm1_out_port>;
>> +                             };
>> +                     };
>> +
>> +                     /* funnel output port */
>> +                     port at 2 {
>> +                             reg = <0>;
>> +                             ca_funnel_out_port0: endpoint {
>> +                                     remote-endpoint = <&hugo_funnel_in_port0>;
>> +                             };
>> +                     };
>> +
>> +                     /* the other input ports are not connect to anything */
>> +             };
>> +     };
>> +
>> +     etm at 3007c000 {
>> +             compatible = "arm,coresight-etm3x", "arm,primecell";
>> +             reg = <0x3007c000 0x1000>;
>> +             cpu = <&cpu0>;
>> +             clocks = <&clks IMX7D_MAIN_AXI_ROOT_CLK>;
>> +             clock-names = "apb_pclk";
>> +
>> +             port {
>> +                     etm0_out_port: endpoint {
>> +                             remote-endpoint = <&ca_funnel_in_port0>;
>> +                     };
>> +             };
>> +     };
>> +
>> +     etm at 3007d000 {
>> +             compatible = "arm,coresight-etm3x", "arm,primecell";
>> +             reg = <0x3007d000 0x1000>;
>> +
>> +             /* System will hang if added nosmp in kernel command line
>> +              * without arm,primecell-periphid because amba bus try to
>> +              * read id and core1 power off at this time.
>> +              */
>
>                 /*
>                  * Multiple-line comment
>                  */
>
>> +             arm,primecell-periphid =  <0xbb956>;
>
> One space after '='
>
> Shawn
>
>> +             cpu = <&cpu1>;
>> +             clocks = <&clks IMX7D_MAIN_AXI_ROOT_CLK>;
>> +             clock-names = "apb_pclk";
>> +
>> +             port {
>> +                     etm1_out_port: endpoint {
>> +                             remote-endpoint = <&ca_funnel_in_port1>;
>> +                     };
>> +             };
>> +     };
>> +
>>       soc {
>>               #address-cells = <1>;
>>               #size-cells = <1>;
>> --
>> 1.9.1
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
