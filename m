From: sricharan@codeaurora.org (Sricharan R)
Date: Thu, 21 Dec 2017 17:23:01 +0530
Subject: [PATCH v5 15/15] devicetree: bindings: Document qcom,pvs
In-Reply-To: <20171220211817.mpkkj747blr4qkqm@rob-hp-laptop>
References: <1513698900-10638-1-git-send-email-sricharan@codeaurora.org>
 <1513698900-10638-16-git-send-email-sricharan@codeaurora.org>
 <20171220032614.GQ19815@vireshk-i7>
 <b0d8147a-46e1-0787-ae37-9c1ef957d190@codeaurora.org>
 <20171220211817.mpkkj747blr4qkqm@rob-hp-laptop>
Message-ID: <864b6cfd-d3eb-d876-82e2-ebc79c5a6956@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On 12/21/2017 2:48 AM, Rob Herring wrote:
> On Wed, Dec 20, 2017 at 11:55:33AM +0530, Sricharan R wrote:
>> Hi Viresh,
>>
>> On 12/20/2017 8:56 AM, Viresh Kumar wrote:
>>> On 19-12-17, 21:25, Sricharan R wrote:
>>>> +	cpu at 0 {
>>>> +		compatible = "qcom,krait";
>>>> +		enable-method = "qcom,kpss-acc-v1";
>>>> +		device_type = "cpu";
>>>> +		reg = <0>;
>>>> +		qcom,acc = <&acc0>;
>>>> +		qcom,saw = <&saw0>;
>>>> +		clocks = <&kraitcc 0>;
>>>> +		clock-names = "cpu";
>>>> +		cpu-supply = <&smb208_s2a>;
>>>> +		operating-points-v2 = <&cpu_opp_table>;
>>>> +	};
>>>> +
>>>> +	qcom,pvs {
>>>> +		qcom,pvs-format-a;
>>>> +	};
>>>
>>> Not sure what Rob is going to say on that :)
>>>
>>
>>  Yes. Would be good to know the best way.
> 
> Seems like this should be a property of an efuse node either implied by 
> the compatible or a separate property. What determines format A vs. B?
> 

 Yes, this efuse registers are part of the eeprom (qfprom) tied to the soc.
 So this property (details like bitfields and register offsets that it represents)
 can be put soc specific and nvmem apis can be used to read
 the registers. Does something like below look ok ?

 qcom,pvs {
	compatible = "qcom,pvs-ipq8064";
	nvmem-cells = <&pvs_efuse>;
 }

 qfprom: qfprom at 700000 {
 	compatible      = "qcom,qfprom";
 	reg             = <0x00700000 0x1000>;
 	#address-cells  = <1>;
 	#size-cells     = <1>;
 	ranges;
 	pvs_efuse: pvs {
 	reg = <0xc0 0x8>;
 	};
 };


Regards,
 Sricharan
 
 

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
