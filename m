From: georgi.djakov@linaro.org (Georgi Djakov)
Date: Thu, 9 Feb 2017 14:59:51 +0200
Subject: [PATCH 2/2] ARM: dts: qcom: Add msm8974 CoreSight components
In-Reply-To: <20170206165238.GA11391@linaro.org>
References: <20170203183628.28198-1-georgi.djakov@linaro.org>
 <20170206165238.GA11391@linaro.org>
Message-ID: <814b788c-ce2f-5b44-c49e-e4e211a4f926@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/06/2017 06:52 PM, Mathieu Poirier wrote:
> Hello Georgi,
>
> Looks good to me, just a cosmetic comment below...
>
> On Fri, Feb 03, 2017 at 08:36:28PM +0200, Georgi Djakov wrote:
>> From: "Ivan T. Ivanov" <ivan.ivanov@linaro.org>
>>
>> Add initial set of CoreSight components found on Qualcomm
>> msm8974 and apq8074 based platforms, including the APQ8074
>> Dragonboard board.
>>
>> Signed-off-by: Ivan T. Ivanov <ivan.ivanov@linaro.org>
>> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
>> ---
>>  arch/arm/boot/dts/qcom-msm8974.dtsi | 280 +++++++++++++++++++++++++++++++++++-
>>  1 file changed, 276 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
>> index 4b4c61e2ee35..ab766a36a461 100644
>> --- a/arch/arm/boot/dts/qcom-msm8974.dtsi
>> +++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
[..]
>> +		replicator at fc31c000 {
>> +			compatible = "qcom,coresight-replicator1x", "arm,primecell";
>> +			reg = <0xfc31c000 0x1000>;
>> +
>> +			clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
>> +			clock-names = "apb_pclk", "atclk";
>> +
>> +			ports {
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +
>> +				port at 0 {
>> +					reg = <0>;
>> +					replicator_out0: endpoint {
>> +						remote-endpoint = <&etr_in>;
>> +					};
>> +				};
>> +				port at 1 {
>> +					reg = <1>;
>> +					replicator_out1: endpoint {
>> +						remote-endpoint = <&tpiu_in>;
>> +					};
>> +				};
>> +				port at 2 {
>> +					reg = <0>;
>> +					replicator_in: endpoint {
>> +						slave-mode;
>> +						remote-endpoint = <&etf_out>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +
>> +		etf at fc307000 {
>> +			compatible = "arm,coresight-tmc", "arm,primecell";
>> +			reg = <0xfc307000 0x1000>;
>> +
>> +			clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
>> +			clock-names = "apb_pclk", "atclk";
>> +
>> +			ports {
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +
>> +				port at 0 {
>> +					reg = <0>;
>> +					etf_out: endpoint {
>> +						remote-endpoint = <&replicator_in>;
>> +					};
>> +				};
>> +				port at 1 {
>> +					reg = <0>;
>> +					etf_in: endpoint {
>> +						slave-mode;
>> +						remote-endpoint = <&merger_out>;
>> +					};
>> +				};
>> +			};
>> +		};
>
> For the replicator and ETF above, output ports are listed before input
> ports, while the rest of the components below do the opposite.  As such
> picturing the topology of the CS components is a little more difficult but has
> no ramification on functionality.  I would suggest revising that but either way:
>
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Ok, thanks! Will update it.

BR,
Georgi
