From: galak@codeaurora.org (Kumar Gala)
Date: Mon, 18 May 2015 13:52:40 -0500
Subject: [PATCH v3] arm64: dts: qcom: Add msm8916 CoreSight components
In-Reply-To: <CANLsYkyKrtyMicsNs2CDd4=GfrQJOPJkAqSUiTB=5hRs3+d=tQ@mail.gmail.com>
References: <1431333119-13626-1-git-send-email-ivan.ivanov@linaro.org>
 <CANLsYkyKrtyMicsNs2CDd4=GfrQJOPJkAqSUiTB=5hRs3+d=tQ@mail.gmail.com>
Message-ID: <7F8B0480-06A8-4381-90C8-3F2A35F14FCD@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On May 11, 2015, at 2:21 PM, Mathieu Poirier <mathieu.poirier@linaro.org> wrote:
> 
> On 11 May 2015 at 02:31, Ivan T. Ivanov <ivan.ivanov@linaro.org> wrote:
>> Add initial set of CoreSight components found on Qualcomm's 8x16 chipset.
>> 
>> Signed-off-by: Ivan T. Ivanov <ivan.ivanov@linaro.org>
>> ---
>> 
>> Changes since v2 [1]:
>> * Added "1x" to "qcom,coresight-replicator" compatible string, to match what
>>  devicetree bindings documentations says.
>> 
>> [1] http://www.spinics.net/lists/devicetree/msg77768.html
>> 
>> arch/arm64/boot/dts/qcom/msm8916-coresight.dtsi | 254 ++++++++++++++++++++++++
>> 1 file changed, 254 insertions(+)
>> create mode 100644 arch/arm64/boot/dts/qcom/msm8916-coresight.dtsi
>> 
>> diff --git a/arch/arm64/boot/dts/qcom/msm8916-coresight.dtsi b/arch/arm64/boot/dts/qcom/msm8916-coresight.dtsi
>> new file mode 100644
>> index 0000000..900f1f4
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/msm8916-coresight.dtsi
>> @@ -0,0 +1,254 @@
>> +/*
>> + * Copyright (c) 2013 - 2015, The Linux Foundation. All rights reserved.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 and
>> + * only version 2 as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + */
>> +
>> +&soc {
>> +
>> +       tpiu at 820000 {
>> +               compatible = "arm,coresight-tpiu", "arm,primecell";
>> +               reg = <0x820000 0x1000>;
>> +
>> +               clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
>> +               clock-names = "apb_pclk", "atclk";
>> +
>> +               port {
>> +                       tpiu_in: endpoint {
>> +                               slave-mode;
>> +                               remote-endpoint = <&replicator_out1>;
>> +                       };
>> +               };
>> +       };
>> +
>> +       funnel at 821000 {
>> +               compatible = "arm,coresight-funnel", "arm,primecell";
>> +               reg = <0x821000 0x1000>;
>> +
>> +               clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
>> +               clock-names = "apb_pclk", "atclk";
>> +
>> +               ports {
>> +                       #address-cells = <1>;
>> +                       #size-cells = <0>;
>> +
>> +                       /*
>> +                        * Not described input ports:
>> +                        * 0 - connected to Resource and Power Manger CPU ETM
>> +                        * 1 - not-connected
>> +                        * 2 - connected to Modem CPU ETM
>> +                        * 3 - not-connected
>> +                        * 5 - not-connected
>> +                        * 6 - connected trought funnel to Wireless CPU ETM
>> +                        * 7 - connected to STM component
>> +                        */
>> +                       port at 4 {
>> +                               reg = <4>;
>> +                               funnel0_in4: endpoint {
>> +                                       slave-mode;
>> +                                       remote-endpoint = <&funnel1_out>;
>> +                               };
>> +                       };
>> +                       port at 8 {
>> +                               reg = <0>;
>> +                               funnel0_out: endpoint {
>> +                                       remote-endpoint = <&etf_in>;
>> +                               };
>> +                       };
>> +               };
>> +       };
>> +
>> +       replicator at 824000 {
>> +               compatible = "qcom,coresight-replicator1x", "arm,primecell";
>> +               reg = <0x824000 0x1000>;
>> +
>> +               clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
>> +               clock-names = "apb_pclk", "atclk";
>> +
>> +               ports {
>> +                       #address-cells = <1>;
>> +                       #size-cells = <0>;
>> +
>> +                       port at 0 {
>> +                               reg = <0>;
>> +                               replicator_out0: endpoint {
>> +                                       remote-endpoint = <&etr_in>;
>> +                               };
>> +                       };
>> +                       port at 1 {
>> +                               reg = <1>;
>> +                               replicator_out1: endpoint {
>> +                                       remote-endpoint = <&tpiu_in>;
>> +                               };
>> +                       };
>> +                       port at 2 {
>> +                               reg = <0>;
>> +                               replicator_in: endpoint {
>> +                                       slave-mode;
>> +                                       remote-endpoint = <&etf_out>;
>> +                               };
>> +                       };
>> +               };
>> +       };
>> +
>> +       etf at 825000 {
>> +               compatible = "arm,coresight-tmc", "arm,primecell";
>> +               reg = <0x825000 0x1000>;
>> +
>> +               clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
>> +               clock-names = "apb_pclk", "atclk";
>> +
>> +               ports {
>> +                       #address-cells = <1>;
>> +                       #size-cells = <0>;
>> +
>> +                       port at 0 {
>> +                               reg = <0>;
>> +                               etf_out: endpoint {
>> +                                       slave-mode;
>> +                                       remote-endpoint = <&funnel0_out>;
>> +                               };
>> +                       };
>> +                       port at 1 {
>> +                               reg = <0>;
>> +                               etf_in: endpoint {
>> +                                       remote-endpoint = <&replicator_in>;
>> +                               };
>> +                       };
>> +               };
>> +       };
>> +
>> +       etr at 826000 {
>> +               compatible = "arm,coresight-tmc", "arm,primecell";
>> +               reg = <0x826000 0x1000>;
>> +
>> +               clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
>> +               clock-names = "apb_pclk", "atclk";
>> +
>> +               port {
>> +                       etr_in: endpoint {
>> +                               slave-mode;
>> +                               remote-endpoint = <&replicator_out0>;
>> +                       };
>> +               };
>> +       };
>> +
>> +       funnel at 841000 { /* APSS funnel only 4 inputs are used */
>> +               compatible = "arm,coresight-funnel", "arm,primecell";
>> +               reg = <0x841000 0x1000>;
>> +
>> +               clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
>> +               clock-names = "apb_pclk", "atclk";
>> +
>> +               ports {
>> +                       #address-cells = <1>;
>> +                       #size-cells = <0>;
>> +
>> +                       port at 0 {
>> +                               reg = <0>;
>> +                               funnel1_in0: endpoint {
>> +                                       slave-mode;
>> +                                       remote-endpoint = <&etm0_out>;
>> +                               };
>> +                       };
>> +                       port at 1 {
>> +                               reg = <1>;
>> +                               funnel1_in1: endpoint {
>> +                                       slave-mode;
>> +                                       remote-endpoint = <&etm1_out>;
>> +                               };
>> +                       };
>> +                       port at 2 {
>> +                               reg = <2>;
>> +                               funnel1_in2: endpoint {
>> +                                       slave-mode;
>> +                                       remote-endpoint = <&etm2_out>;
>> +                               };
>> +                       };
>> +                       port at 3 {
>> +                               reg = <3>;
>> +                               funnel1_in3: endpoint {
>> +                                       slave-mode;
>> +                                       remote-endpoint = <&etm3_out>;
>> +                               };
>> +                       };
>> +                       port at 4 {
>> +                               reg = <0>;
>> +                               funnel1_out: endpoint {
>> +                                       remote-endpoint = <&funnel0_in4>;
>> +                               };
>> +                       };
>> +               };
>> +       };
>> +
>> +       etm at 85c000 {
>> +               compatible = "arm,coresight-etm4x", "arm,primecell";
>> +               reg = <0x85c000 0x1000>;
>> +
>> +               clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
>> +               clock-names = "apb_pclk", "atclk";
>> +
>> +               cpu = <&CPU0>;
>> +
>> +               port {
>> +                       etm0_out: endpoint {
>> +                               remote-endpoint = <&funnel1_in0>;
>> +                       };
>> +               };
>> +       };
>> +
>> +       etm at 85d000 {
>> +               compatible = "arm,coresight-etm4x", "arm,primecell";
>> +               reg = <0x85d000 0x1000>;
>> +
>> +               clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
>> +               clock-names = "apb_pclk", "atclk";
>> +
>> +               cpu = <&CPU1>;
>> +
>> +               port {
>> +                       etm1_out: endpoint {
>> +                               remote-endpoint = <&funnel1_in1>;
>> +                       };
>> +               };
>> +       };
>> +
>> +       etm at 85e000 {
>> +               compatible = "arm,coresight-etm4x", "arm,primecell";
>> +               reg = <0x85e000 0x1000>;
>> +
>> +               clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
>> +               clock-names = "apb_pclk", "atclk";
>> +
>> +               cpu = <&CPU2>;
>> +
>> +               port {
>> +                       etm2_out: endpoint {
>> +                               remote-endpoint = <&funnel1_in2>;
>> +                       };
>> +               };
>> +       };
>> +
>> +       etm at 85f000 {
>> +               compatible = "arm,coresight-etm4x", "arm,primecell";
>> +               reg = <0x85f000 0x1000>;
>> +
>> +               clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
>> +               clock-names = "apb_pclk", "atclk";
>> +
>> +               cpu = <&CPU3>;
>> +
>> +               port {
>> +                       etm3_out: endpoint {
>> +                               remote-endpoint = <&funnel1_in3>;
>> +                       };
>> +               };
>> +       };
>> +};
>> --
>> 1.9.1
>> 
> 
> Kumar, I'm happy with this DT specification for Coresight.  Since I'm
> taking the driver it would likely make more sense for this to go
> through my tree.  Could you please have a look and give me your ack?

It looks ok, however I don?t see us including this file anywhere, so that?s my only concern.

- k
-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
