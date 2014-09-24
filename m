From: lina.iyer@linaro.org (Lina Iyer)
Date: Wed, 24 Sep 2014 13:29:45 -0600
Subject: [PATCH v6 1/5] qcom: spm: Add Subsystem Power Manager driver
In-Reply-To: <4BFC9B4E-A3D0-422E-9B55-0DB9F4B04EE9@codeaurora.org>
References: <1411516281-58328-1-git-send-email-lina.iyer@linaro.org>
 <1411516281-58328-2-git-send-email-lina.iyer@linaro.org>
 <F743E5F0-28C1-4A9D-A27D-73EA70A01B46@codeaurora.org>
 <20140924172151.GD422@ilina-mac>
 <4BFC9B4E-A3D0-422E-9B55-0DB9F4B04EE9@codeaurora.org>
Message-ID: <20140924192945.GC1004@ilina-mac.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 24 2014 at 11:53 -0600, Kumar Gala wrote:
>
>On Sep 24, 2014, at 12:21 PM, Lina Iyer <lina.iyer@linaro.org> wrote:
>
>> On Wed, Sep 24 2014 at 10:33 -0600, Kumar Gala wrote:
>>>
>>> On Sep 23, 2014, at 6:51 PM, Lina Iyer <lina.iyer@linaro.org> wrote:
>>>
>>>> Based on work by many authors, available at codeaurora.org
>>>>
>>>> SPM is a hardware block that controls the peripheral logic surrounding
>>>> the application cores (cpu/l$). When the core executes WFI instruction,
>>>> the SPM takes over the putting the core in low power state as
>>>> configured. The wake up for the SPM is an interrupt at the GIC, which
>>>> then completes the rest of low power mode sequence and brings the core
>>>> out of low power mode.
>>>>
>>>> The SPM has a set of control registers that configure the SPMs
>>>> individually based on the type of the core and the runtime conditions.
>>>> SPM is a finite state machine block to which a sequence is provided and
>>>> it interprets the bytes  and executes them in sequence. Each low power
>>>> mode that the core can enter into is provided to the SPM as a sequence.
>>>>
>>>> Configure the SPM to set the core (cpu or L2) into its low power mode,
>>>> the index of the first command in the sequence is set in the SPM_CTL
>>>> register. When the core executes ARM wfi instruction, it triggers the
>>>> SPM state machine to start executing from that index. The SPM state
>>>> machine waits until the interrupt occurs and starts executing the rest
>>>> of the sequence until it hits the end of the sequence. The end of the
>>>> sequence jumps the core out of its low power mode.
>>>>
>>>> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
>>>> [lina: simplify the driver for initial submission, clean up and update
>>>> commit text]
>>>> ---
>>>> Documentation/devicetree/bindings/arm/msm/spm.txt |  43 +++
>>>> drivers/soc/qcom/Kconfig                          |   8 +
>>>> drivers/soc/qcom/Makefile                         |   1 +
>>>> drivers/soc/qcom/spm.c                            | 388 ++++++++++++++++++++++
>>>> include/soc/qcom/spm.h                            |  38 +++
>>>> 5 files changed, 478 insertions(+)
>>>> create mode 100644 Documentation/devicetree/bindings/arm/msm/spm.txt
>>>> create mode 100644 drivers/soc/qcom/spm.c
>>>> create mode 100644 include/soc/qcom/spm.h
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/arm/msm/spm.txt b/Documentation/devicetree/bindings/arm/msm/spm.txt
>>>> new file mode 100644
>>>> index 0000000..2ff2454
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/arm/msm/spm.txt
>>>> @@ -0,0 +1,43 @@
>>>> +* Subsystem Power Manager (SPM)
>>>> +
>>>> +Qualcomm Snapdragons have SPM hardware blocks to control the Application
>>>> +Processor Sub-System power. These SPM blocks run individual state machine
>>>> +to determine what the core (L2 or Krait/Scorpion) would do when the WFI
>>>> +instruction is executed by the core.
>>>> +
>>>> +The devicetree representation of the SPM block should be:
>>>> +
>>>> +Required properties
>>>> +
>>>> +- compatible: Must be -
>>>> +		 "qcom,spm-v2.1"
>>>> +- reg: The physical address and the size of the SPM's memory mapped registers
>>>> +- qcom,cpu: phandle for the CPU that the SPM block is attached to.
>>>> +	This field is required on only for SPMs that control the CPU.
>>>
>>> Let?s make this just cpu-handle instead of qcom,cpu.  The concept of a handle to a cpu is pretty generic.
>>>
>> Okay. Will look into it.
>> You mean just the property name, right?
>
>Correct.
>
>>
>>>> +- qcom,saw2-clk-div: SAW2 configuration register to program the SPM runtime
>>>> +	clocks. The register for this property is MSM_SPM_REG_SAW2_CFG.
>>>
>>> (add details on how this is used to compute timer tick.  Is it timer tick = saw_clk/saw2-clk-div?  What is valid range of values)
>>>
>> The SPM spec is not available for open use. The range of values is
>> irrelevant for the SPM clocks, usually, its a constant for an SoC, but
>> may vary between the SoC. Its how the SPM on the SoC interprets it.
>
>Does the meaning of the divisor value change from SoC to SoC (not the value itself)?
>
>Is it not always:
>
>timer tick = sys_ref_clk / (qcom,saw2-clk-div + 1)
>
It is, in this case. But its not something you deviate from the spec.

>>>> +- qcom,saw2-delays: The SPM delay values that SPM sequences would refer to.
>>>> +	The register for this property is MSM_SPM_REG_SAW2_SPM_DLY.
>>>
>>> Didn?t Stephen asked about splitting this up? Or at least treating it as an array of 3 values?
>>>
>> Yes he did. My response was similar to the clk-div values, its not
>> something you can change without hardware spec documentation.
>> And I need to mix the three values up, anyways before I write to the
>> register. Splitting it up, doesnt help understanding/configuring the SPM
>> any better, so didnt change it.
>
>Hmm, will this value change from SPM to SPM on the same SoC?  I?m not a fan of allowing random register values to get poked into the HW from DT.  While this one case might end up being acceptable, its a terrible practice and not something I want use in the habit of doing.
>
Ah. Tough proposition! The SPM sequence is a bunch of random register
values, which is not open to interpretation without the programming
guides. I am not sure how I can use DT for saving all the register data
then.

I agree its nice to have nice readable parameters in the DT, but, isnt
the purpose of the DT, the hardware configuration? In an alternate way
to do this, I could put all these register writes into the driver itself
for each SoC. Ugly as it may be, it would solve the problem. However,
the device node then just has the compatible string in it and may be
some configurable elements. I fail to see the big picture of the use of
DT in such a case.

FWIW, I do understand your stance with DT, and for the most part agree
with it.


>>>> +- qcom,saw2-enable: The SPM control register to enable/disable the sleep state
>>>> +	machine. The register for this property is MSM_SPM_REG_SAW2_SPM_CTL.
>>>
>>> Can this just be a boolean (exist or not), if so, probably change it to qcom,saw2-disable (so lack of property means enable)?
>>>
>> Okay, sure.
>>
>>>> +
>>>> +Optional properties
>>>> +
>>>> +- qcom,saw2-spm-cmd-wfi: The WFI command sequence
>>>
>>> probably add something like: ?array of bytes ?? (want to convey the data type somehow, is there a max length?)
>>>
>> Okay.
>>
>>>> +- qcom,saw2-spm-cmd-spc: The Standalone PC command sequence
>>>
>>> probably add something like: ?array of bytes ?? (want to convey the data type somehow, is there a max length?)
>>>
>> Okay.
>>
>>>> +
>>>> +Example:
>>>> +	spm at f9089000 {
>>>> +		compatible = "qcom,spm-v2.1";
>>>> +		#address-cells = <1>;
>>>> +		#size-cells = <1>;
>>>> +		reg = <0xf9089000 0x1000>;
>>>> +		qcom,cpu = <&CPU0>;
>>>> +		qcom,saw2-clk-div = <0x1>;
>>>> +		qcom,saw2-delays = <0x20000400>;
>>>> +		qcom,saw2-enable = <0x1>;
>>>> +		qcom,saw2-spm-cmd-wfi = [03 0b 0f];
>>>> +		qcom,saw2-spm-cmd-spc = [00 20 50 80 60 70 10 92
>>>> +				a0 b0 03 68 70 3b 92 a0 b0
>>>> +				82 2b 50 10 30 02 22 30 0f];
>>>> +	};
>>>
>>> - k
>>>
>>>
>>> --
>>> Employee of Qualcomm Innovation Center, Inc.
>>> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>-- 
>Employee of Qualcomm Innovation Center, Inc.
>Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
>
