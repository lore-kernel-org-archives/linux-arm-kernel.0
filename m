From: stanimir.varbanov@linaro.org (Stanimir Varbanov)
Date: Tue, 24 Nov 2015 11:17:14 +0200
Subject: [PATCH v3 3/6] DT: PCI: qcom: Document PCIe devicetree bindings
In-Reply-To: <20151123181329.GN30882@usrtlx11787.corpusers.net>
References: <cover.1448270813.git.stanimir.varbanov@linaro.org>
 <8fd3e7d1662f37abe549127d179c315dff3210d8.1448270813.git.stanimir.varbanov@linaro.org>
 <20151123181329.GN30882@usrtlx11787.corpusers.net>
Message-ID: <56542B1A.5060306@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bjorn, thanks for the comments!

On 11/23/2015 08:13 PM, Bjorn Andersson wrote:
> On Mon 23 Nov 01:29 PST 2015, Stanimir Varbanov wrote:
> 
>> From: Stanimir Varbanov <svarbanov@mm-sol.com>
>>
>> Document Qualcomm PCIe driver devicetree bindings.
>>
>> Signed-off-by: Stanimir Varbanov <svarbanov@mm-sol.com>
>> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
>> ---
>>  .../devicetree/bindings/pci/qcom,pcie.txt          |  231 ++++++++++++++++++++
>>  1 file changed, 231 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/pci/qcom,pcie.txt
>>
>> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.txt b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
>> new file mode 100644
>> index 000000000000..d7640d45fa31
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
>> @@ -0,0 +1,231 @@
>> +* Qualcomm PCI express root complex
>> +
>> +- compatible:
>> +	Usage: required
>> +	Value type: <stringlist>
>> +	Definition: Value shall include
>> +		    - "qcom,pcie-v0" for apq/ipq8064
>> +		    - "qcom,pcie-v1" for apq8084
> 
> Do you know if we have the same v1 of this block in 8994?

I have no idea, but looking in caf msm-3.18 it should be possible to
reuse the code for v1.

> 
> [..]
>> +- clock-names:
>> +	Usage: required
>> +	Value type: <stringlist>
>> +	Definition: Should contain the following entries
>> +		    * should be populated for v0 and v1
>> +		    	- "iface"      Configuration AHB clock
>> +
>> +		    * should be populated for v0
>> +		    	- "core"       Clocks the pcie hw block
>> +		    	- "phy"        Clocks the pcie PHY block
>> +
>> +		    * should be populated for v1
>> +			- "aux"        Auxiliary (AUX) clock
>> +		    	- "bus_master" Master AXI clock
>> +		    	- "bus_slave"  Slave AXI clock
> 
> You have white spaces among your tabs here.

Ops, I forgot to remove the white spaces.

> 
> [..]
>> +- <name>-supply:
>> +	Usage: required
>> +	Value type: <phandle>
>> +	Definition: List of phandles to the power supply regulator(s)
>> +		    * should be populated for v0 and v1
>> +			- "vdda"        core analog power supply
>> +
>> +		    * should be populated for v0
>> +			- "vdda_phy"    analog power supply for PHY
>> +			- "vdda_refclk" analog power supply for IC which generate
>> +					reference clock
> 
> Exploding these into 3 different property descriptions would make it
> easier to read, and you can say "required for v0" for the latter
> two and simply "required" on the vdda.

yes, that is a good idea.

> 
> [..]
>> +- <name>-gpio:
>> +	Usage: optional
>> +	Value type: <prop-encoded-array>
>> +	Definition: List of phandle and gpio specifier pairs. Should contain
>> +		    - "perst"  PCIe endpoint reset signal line
>> +		    - "pewake" PCIe endpoint wake signal line
> 
> This property should be pluralized, i.e. it's <name>-gpios.

I hope you mean :

- "perst-gpios" PCIe endpoint reset signal line
- "pewake-gpios" PCIe endpoint wake signal line


> 
> Are these identifiers coming from some data sheet? Or could we simply
> name them "reset" and "wakeup"?

In the pcie express card electromechanical specification we have signal
names PERST# and WAKE#, so I'd like to keep as they are in the
specification, thus the wake# is wrong and I will rename it to wake-gpios.

> 
>> +
>> +- pinctrl-0:
>> +	Usage: required
>> +	Value type: <phandle>
>> +	Definition: List of phandles pointing at a pin(s) configuration
> 
> This is not required and as it's a property applicable to all devices we
> normally don't mention them.

agreed.

> 
>> +
>> +- pinctrl-names
>> +	Usage: required
>> +	Value type: <stringlist>
>> +	Definition: List of names of pinctrl-0 state
>> +
> 
> dito
> 
> Regards,
> Bjorn
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


-- 
regards,
Stan
