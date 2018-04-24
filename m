From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 24 Apr 2018 17:04:10 +0100
Subject: [PATCH v5 01/23] soc: qcom dt-bindings: Add APR bus bindings
In-Reply-To: <20180424155226.fo6rgdea4kmqqjdy@rob-hp-laptop>
References: <20180418153157.1960-1-srinivas.kandagatla@linaro.org>
 <20180418153157.1960-2-srinivas.kandagatla@linaro.org>
 <20180424155226.fo6rgdea4kmqqjdy@rob-hp-laptop>
Message-ID: <de5fac3b-1a56-61d0-facd-a592715d7606@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for the review comments,

On 24/04/18 16:52, Rob Herring wrote:
> On Wed, Apr 18, 2018 at 04:31:35PM +0100, srinivas.kandagatla at linaro.org wrote:
>> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>
>> This patch add dt bindings for Qualcomm APR (Asynchronous Packet Router)
>> bus driver. This bus is used for communicating with DSP which provides
>> audio and various other services to cpu.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   .../devicetree/bindings/soc/qcom/qcom,apr.txt      | 85 ++++++++++++++++++++++
> 
> This should probably go under bindings/sound/ as it is at least mostly
> sound related.
There are other non audio dsp/modem services that will be using apr.

> 
>>   include/dt-bindings/soc/qcom,apr.h                 | 27 +++++++
>>   2 files changed, 112 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,apr.txt
>>   create mode 100644 include/dt-bindings/soc/qcom,apr.h
>>
>> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,apr.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,apr.txt
>> new file mode 100644
>> index 000000000000..85cc0433fb00
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,apr.txt
>> @@ -0,0 +1,85 @@
>> +Qualcomm APR (Asynchronous Packet Router) binding
>> +
>> +This binding describes the Qualcomm APR. APR is a IPC protocol for
>> +communication between Application processor and QDSP. APR is mainly
>> +used for audio/voice services on the QDSP.
>> +
>> +- compatible:
>> +	Usage: required
>> +	Value type: <stringlist>
>> +	Definition: must be "qcom,apr-v<VERSION-NUMBER>", example "qcom,apr-v2"
>> +
>> +- qcom,dest-domain-id
>> +	Usage: required
>> +	Value type: <prop-encoded-array>
> 
> If this is an array, what do the indexes of the array correspond to?
> 
This should be
  Value type: <u32>

these indexes point to the remote processor ID.

>> +	Definition: Destination processor ID.
>> +	Possible values are :
>> +			1 - APR simulator
>> +			2 - PC
>> +			3 - MODEM
>> +			4 - ADSP
>> +			5 - APPS
>> +			6 - MODEM2
>> +			7 - APPS2
>> +
>> += APR SERVICES
>> +Each subnode of the APR node represents service tied to this apr. The name
>> +of the nodes are not important. The properties of these nodes are defined
>> +by the individual bindings for the specific service
>> +- All APR services MUST contain the following property:
>> +
>> +- reg
>> +	Usage: required
>> +	Value type: <prop-encoded-array>
> 
> Not really an array, right?
No, again this is  Value type: <u32>

> 
>> +	Definition: APR Service ID
>> +	Possible values are :
>> +			3 - DSP Core Service
>> +			4 - Audio Front End Service.
>> +			5 - Voice Stream Manager Service.
>> +			6 - Voice processing manager.
>> +			7 - Audio Stream Manager Service.
>> +			8 - Audio Device Manager Service.
>> +			9 - Multimode voice manager.
>> +			10 - Core voice stream.
>> +			11 - Core voice processor.
>> +			12 - Ultrasound stream manager.
>> +			13 - Listen stream manager.
>> +
>> += EXAMPLE
>> +The following example represents a QDSP based sound card on a MSM8996 device
>> +which uses apr as communication between Apps and QDSP.
>> +
>> +	apr {
>> +		compatible = "qcom,apr-v2";
>> +		qcom,smd-channels = "apr_audio_svc";
> 
> Drop this?
Sure


--srini
