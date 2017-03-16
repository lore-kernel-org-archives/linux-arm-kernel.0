From: olivier.moysan@st.com (Olivier MOYSAN)
Date: Thu, 16 Mar 2017 10:50:37 +0000
Subject: [RESEND PATCH v2 1/2] ASoC: stm32: add bindings for SAI
In-Reply-To: <20170315174606.rrvhuuzplzwwucph@rob-hp-laptop>
References: <1488879872-7839-1-git-send-email-olivier.moysan@st.com>
 <1488879872-7839-2-git-send-email-olivier.moysan@st.com>
 <20170315174606.rrvhuuzplzwwucph@rob-hp-laptop>
Message-ID: <ecc50cac-46a6-5e89-d07c-05f34a12d997@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Rob,

Thanks for your feedback.

On 03/15/2017 06:46 PM, Rob Herring wrote:
> On Tue, Mar 07, 2017 at 10:44:31AM +0100, olivier moysan wrote:
>> This patch adds documentation of device tree bindings for the
>> STM32 SAI ASoC driver.
>>
>> Signed-off-by: olivier moysan <olivier.moysan@st.com>
>> ---
>>  .../devicetree/bindings/sound/st,stm32-sai.txt     | 79 ++++++++++++++++++++++
>>  1 file changed, 79 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/sound/st,stm32-sai.txt
>>
>> diff --git a/Documentation/devicetree/bindings/sound/st,stm32-sai.txt b/Documentation/devicetree/bindings/sound/st,stm32-sai.txt
>> new file mode 100644
>> index 0000000..b3be26d
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/sound/st,stm32-sai.txt
>> @@ -0,0 +1,79 @@
>> +STMicroelectronics STM32 Serial Audio Interface (SAI).
>> +
>> +The SAI interface (Serial Audio Interface) offers a wide set of audio protocols
>> +as I2S standards, LSB or MSB-justified, PCM/DSP, TDM, and AC'97.
>> +The SAI contains two independent audio sub-blocks. Each sub-block has
>> +its own clock generator and I/O lines controller.
>> +
>> +Required properties:
>> +  - compatible: Should be "st,stm32f4-sai"
>> +  - reg: Base address and size of SAI common register set.
>> +  - clocks: Must contain phandle and clock specifier pairs for each entry
>> +	in clock-names.
>> +  - clock-names: Must contain "clk_x8k" and "clk_x11k"
>> +	"clk_x8k": SAI parent clock for sampling rates multiple of 8kHz.
>> +	"clk_x11k": SAI parent clock for sampling rates multiple of 11.025kHz.
>
> clk_ is redundant.
>

Do you mean, removing clk_ prefix ?

>> +  - interrupts: cpu DAI interrupt line shared by SAI sub-blocks
>> +
>> +Note: Each SAI controller should have an alias correctly numbered
>> +in "aliases" node, to provide explicit name to CPU DAI.
>
> No, it shouldn't. Why do you need that?
>

Yes, this is not mandatory. This is convenient to identify sai 
controller, as we may have up to 8 instances.
I can make it optional, or remove it if you think it is not relevant.

>
>> +
>> +Optional properties:
>> +  - resets: Reference to a reset controller asserting the SAI
>> +
>> +SAI subnodes:
>> +Two subnodes corresponding to SAI sub-block instances A et B can be defined.
>> +Subnode can be omitted for unsused sub-block.
>> +
>> +SAI subnodes required properties:
>> +  - compatible: Should be "st,stm32-sai-sub-a" or "st,stm32-sai-sub-b"
>> +	for SAI sub-block A or B respectively.
>> +  - reg: Base address and size of SAI sub-block register set.
>> +  - clocks: Must contain one phandle and clock specifier pair
>> +	for sai_ck which feeds the internal clock generator.
>> +  - clock-names: Must contain "sai_ck".
>> +  - dmas: see Documentation/devicetree/bindings/dma/stm32-dma.txt
>> +  - dma-names: identifier string for each DMA request line
>> +	"tx": if sai sub-block is configured as playback DAI
>> +	"rx": if sai sub-block is configured as capture DAI
>> +  - pinctrl-names: should contain only value "default"
>> +  - pinctrl-0: see Documentation/devicetree/bindings/pinctrl/pinctrl-stm32.txt
>> +
>> +Example:
>> +sai1: sai1 at 40015800 {
>> +	compatible = "st,stm32f4-sai";
>> +	reg = <0x40015800 0x400>;

	reg = <0x40015800 0x4>;

>> +	clocks = <&rcc 1 CLK_SAIQ_PDIV>, <&rcc 1 CLK_I2SQ_PDIV>;
>> +	clock-names = "clk_x8k", "clk_x11k";
>> +	interrupts = <87>;
>> +	resets = <&rcc 310>;
>> +
>> +	sai1b: sai at 1 {
>
> unit address needs a reg property.
>
> audio-controller at 1
>

Right. This needs to be updated as follows:
	sai1b: sai1b at 40015824 {
		...
		reg = <0x40015824 0x1C>;
		...
	};

>> +		#sound-dai-cells = <0>;
>> +		compatible = "st,stm32-sai-sub-b";
>> +		clocks = <&rcc 1 CLK_SAI2>;
>> +		clock-names = "sai_ck";
>> +		dmas = <&dma2 5 0 0x400 0x1>;
>> +		dma-names = "tx";
>> +	};
>> +};
>> +
>> +sound {
>> +	compatible = "simple-audio-card";
>
> Perhaps you want to use the graph-card here. It's getting close to
> merging.
>

mclk-fs property is required when SAI is configured as master.
It seems that mclk-fs is not supported in current version
of audio graph card. So I thing I should keep simple card for the time 
being. Anyway, I plan further updates for SAI, so I will
have opportunity to change to graph card at that time.

>> +	simple-audio-card,name = "STM32-Sound-Card";
>> +	status = "okay";
>> +
>> +	simple-audio-card,dai-link at 0 {
>> +		format = "i2s";

		mclk-fs = <256>;

>> +		cpu {
>> +			sound-dai = <&sai1b>;
>> +		};
>> +		codec {
>> +			sound-dai = <&codec>;
>> +		};
>> +	};
>> +};
>> +
>> +aliases {
>> +	sai1 = &sai1;
>> +};
>> --
>> 1.9.1
>>

regards
olivier
