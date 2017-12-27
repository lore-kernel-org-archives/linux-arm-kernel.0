From: sricharan@codeaurora.org (Sricharan R)
Date: Wed, 27 Dec 2017 15:50:52 +0530
Subject: [PATCH v5 15/15] devicetree: bindings: Document qcom,pvs
In-Reply-To: <CAL_JsqJTBgr2ctyRXGyzkRLztoy=qtvEh3AC79RjENBS=6yQRg@mail.gmail.com>
References: <1513698900-10638-1-git-send-email-sricharan@codeaurora.org>
 <1513698900-10638-16-git-send-email-sricharan@codeaurora.org>
 <20171220032614.GQ19815@vireshk-i7>
 <b0d8147a-46e1-0787-ae37-9c1ef957d190@codeaurora.org>
 <20171220211817.mpkkj747blr4qkqm@rob-hp-laptop>
 <864b6cfd-d3eb-d876-82e2-ebc79c5a6956@codeaurora.org>
 <CAL_JsqJTBgr2ctyRXGyzkRLztoy=qtvEh3AC79RjENBS=6yQRg@mail.gmail.com>
Message-ID: <4fdb2ab5-1dca-c44c-b647-3388a8ecea81@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On 12/26/2017 11:06 PM, Rob Herring wrote:
> On Thu, Dec 21, 2017 at 5:53 AM, Sricharan R <sricharan@codeaurora.org> wrote:
>> Hi Rob,
>>
>> On 12/21/2017 2:48 AM, Rob Herring wrote:
>>> On Wed, Dec 20, 2017 at 11:55:33AM +0530, Sricharan R wrote:
>>>> Hi Viresh,
>>>>
>>>> On 12/20/2017 8:56 AM, Viresh Kumar wrote:
>>>>> On 19-12-17, 21:25, Sricharan R wrote:
>>>>>> +  cpu at 0 {
>>>>>> +          compatible = "qcom,krait";
>>>>>> +          enable-method = "qcom,kpss-acc-v1";
>>>>>> +          device_type = "cpu";
>>>>>> +          reg = <0>;
>>>>>> +          qcom,acc = <&acc0>;
>>>>>> +          qcom,saw = <&saw0>;
>>>>>> +          clocks = <&kraitcc 0>;
>>>>>> +          clock-names = "cpu";
>>>>>> +          cpu-supply = <&smb208_s2a>;
>>>>>> +          operating-points-v2 = <&cpu_opp_table>;
>>>>>> +  };
>>>>>> +
>>>>>> +  qcom,pvs {
>>>>>> +          qcom,pvs-format-a;
>>>>>> +  };
>>>>>
>>>>> Not sure what Rob is going to say on that :)
>>>>>
>>>>
>>>>  Yes. Would be good to know the best way.
>>>
>>> Seems like this should be a property of an efuse node either implied by
>>> the compatible or a separate property. What determines format A vs. B?
>>>
>>
>>  Yes, this efuse registers are part of the eeprom (qfprom) tied to the soc.
>>  So this property (details like bitfields and register offsets that it represents)
>>  can be put soc specific and nvmem apis can be used to read
>>  the registers. Does something like below look ok ?
>>
>>  qcom,pvs {
>>         compatible = "qcom,pvs-ipq8064";
>>         nvmem-cells = <&pvs_efuse>;
>>  }
> 
> Why do you need this node? It doesn't look like it corresponds to a
> h/w block. It looks like you are just creating it to instantiate a
> driver.
> 
>>  qfprom: qfprom at 700000 {
>>         compatible      = "qcom,qfprom";
> 
> Either this or...
> 
>>         reg             = <0x00700000 0x1000>;
>>         #address-cells  = <1>;
>>         #size-cells     = <1>;
>>         ranges;
>>         pvs_efuse: pvs {
> 
> a compatible here should be specific enough so the OS can know what
> the bits are.

 Infact the above "qcom,pvs" node is required mainly to act as a consumer
 for the nvmem data provider ("qcom,qfprom") (using nvmem-cells = <&pvs_efuse>)
 Then "qfprom" can be made to contain a "format_a" or "format_b" specific cell.

 So all that is needed is, nvmem-cells = <&pvs_efuse_phandle> needs to be available
 somewhere. The requirement is similar what is now done by "operating-points-v2-ti-cpu"
 and the ti-cpufreq.c. There "operating-points-v2-ti-cpu" node, contains the syscon
 register to read the efuse values. Similarly does defining a new 
 "operating-points-v2-krait-cpu" which would contain the nvmem-cells property look ok ? 
 This would avoid defining a new qcom,pvs node.
 
	cpu at 0 {
		compatible = "qcom,krait";
		enable-method = "qcom,kpss-acc-v1";
		device_type = "cpu";
		reg = <0>;
		qcom,acc = <&acc0>;
		qcom,saw = <&saw0>;
		clocks = <&kraitcc 0>;
		clock-names = "cpu";
		cpu-supply = <&smb208_s2a>;
		operating-points-v2 = <&cpu_opp_table>;
	};

	cpu_opp_table: opp_table {
		compatible = "operating-points-v2-krait-cpu";

		nvmem-cells = <&pvs_efuse_format_a>;
		/*
		 * Missing opp-shared property means CPUs switch DVFS states
		 * independently.
		 */

		opp-1400000000 {
			opp-hz = /bits/ 64 <1400000000>;
			opp-microvolt-speed0-pvs0-v0 = <1250000>;
			opp-microvolt-speed0-pvs1-v0 = <1175000>;
			opp-microvolt-speed0-pvs2-v0 = <1125000>;
			opp-microvolt-speed0-pvs3-v0 = <1050000>;

		};
		...
	}
 
	qfprom: qfprom at 700000 {
		compatible      = "qcom,qfprom";
		reg             = <0x00700000 0x1000>;
		#address-cells  = <1>;
		#size-cells     = <1>;
		ranges;
		pvs_efuse_format_a: pvs {
			reg = <0xc0 0x8>;
		};
	}

Regards,
 Sricharan

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
