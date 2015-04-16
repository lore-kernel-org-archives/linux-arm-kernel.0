From: rjui@broadcom.com (Ray Jui)
Date: Thu, 16 Apr 2015 14:01:37 -0700
Subject: [PATCH v6 1/6] clk: iproc: define Broadcom iProc clock binding
In-Reply-To: <20150416192014.19585.9663@quantum>
References: <1426657522-2473-1-git-send-email-rjui@broadcom.com>
 <1426657522-2473-2-git-send-email-rjui@broadcom.com>
 <20150411001231.18916.93186@quantum> <552B4140.6000705@broadcom.com>
 <20150413060254.19585.59701@quantum> <552C1BA1.1020101@broadcom.com>
 <552D662B.80201@broadcom.com> <20150416192014.19585.9663@quantum>
Message-ID: <55302331.7010101@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

On 4/16/2015 12:20 PM, Michael Turquette wrote:
> Quoting Ray Jui (2015-04-14 12:10:35)
>> Hi Mike,
>>
>> On 4/13/2015 12:40 PM, Ray Jui wrote:
>>> Hi Mike,
>>>
>>> On 4/12/2015 11:02 PM, Michael Turquette wrote:
>>>> Quoting Ray Jui (2015-04-12 21:08:32)
>>>>>
>>>>>
>>>>> On 4/10/2015 5:12 PM, Michael Turquette wrote:
>>>>>> Quoting Ray Jui (2015-03-17 22:45:17)
>>>>>>> Document the device tree binding for Broadcom iProc architecture based
>>>>>>> clock controller
>>>>>>>
>>>>>>> Signed-off-by: Ray Jui <rjui@broadcom.com>
>>>>>>> Reviewed-by: Scott Branden <sbranden@broadcom.com>
>>>>>>> ---
>>>>>>>  .../bindings/clock/brcm,iproc-clocks.txt           |  171 ++++++++++++++++++++
>>>>>>>  1 file changed, 171 insertions(+)
>>>>>>>  create mode 100644 Documentation/devicetree/bindings/clock/brcm,iproc-clocks.txt
>>>>>>>
>>>>>>> diff --git a/Documentation/devicetree/bindings/clock/brcm,iproc-clocks.txt b/Documentation/devicetree/bindings/clock/brcm,iproc-clocks.txt
>>>>>>> new file mode 100644
>>>>>>> index 0000000..bf2316b
>>>>>>> --- /dev/null
>>>>>>> +++ b/Documentation/devicetree/bindings/clock/brcm,iproc-clocks.txt
>>>>>>> @@ -0,0 +1,171 @@
>>>>>>> +Broadcom iProc Family Clocks
>>>>>>> +
>>>>>>> +This binding uses the common clock binding:
>>>>>>> +    Documentation/devicetree/bindings/clock/clock-bindings.txt
>>>>>>> +
>>>>>>> +The iProc clock controller manages clocks that are common to the iProc family.
>>>>>>> +An SoC from the iProc family may have several PPLs, e.g., ARMPLL, GENPLL,
>>>>>>> +LCPLL0, MIPIPLL, and etc., all derived from an onboard crystal. Each PLL
>>>>>>> +comprises of several leaf clocks
>>>>>>> +
>>>>>>> +Required properties for PLLs:
>>>>>>> +- compatible:
>>>>>>> +    Should have a value of the form "brcm,<soc>-<pll>". For example, GENPLL on
>>>>>>> +Cygnus has a compatible string of "brcm,cygnus-genpll"
>>>>>>> +
>>>>>>> +- #clock-cells:
>>>>>>> +    Must be <0>
>>>>>>> +
>>>>>>> +- reg:
>>>>>>> +    Define the base and range of the I/O address space that contain the iProc
>>>>>>> +clock control registers required for the PLL
>>>>>>> +
>>>>>>> +- clocks:
>>>>>>> +    The input parent clock phandle for the PLL. For all iProc PLLs, this is an
>>>>>>> +onboard crystal with a fixed rate
>>>>>>> +
>>>>>>> +Example:
>>>>>>> +
>>>>>>> +       osc: oscillator {
>>>>>>> +               #clock-cells = <0>;
>>>>>>> +               compatible = "fixed-clock";
>>>>>>> +               clock-frequency = <25000000>;
>>>>>>> +       };
>>>>>>> +
>>>>>>> +       genpll: genpll {
>>>>>>> +               #clock-cells = <0>;
>>>>>>> +               compatible = "brcm,cygnus-genpll";
>>>>>>> +               reg = <0x0301d000 0x2c>,
>>>>>>> +                       <0x0301c020 0x4>;
>>>>>>> +               clocks = <&osc>;
>>>>>>> +       };
>>>>>>> +
>>>>>>> +Required properties for leaf clocks of a PLL:
>>>>>>> +
>>>>>>> +- compatible:
>>>>>>> +    Should have a value of the form "brcm,<soc>-<pll>-clk". For example, leaf
>>>>>>> +clocks derived from the GENPLL on Cygnus SoC have a compatible string of
>>>>>>> +"brcm,cygnus-genpll-clk"
>>>>>>> +
>>>>>>> +- #clock-cells:
>>>>>>> +    Have a value of <1> since there are more than 1 leaf clock of a
>>>>>>> +given PLL
>>>>>>> +
>>>>>>> +- reg:
>>>>>>> +    Define the base and range of the I/O address space that contain the iProc
>>>>>>> +clock control registers required for the PLL leaf clocks
>>>>>>> +
>>>>>>> +- clocks:
>>>>>>> +    The input parent PLL phandle for the leaf clock
>>>>>>> +
>>>>>>> +- clock-output-names:
>>>>>>> +    An ordered list of strings defining the names of the leaf clocks
>>>>>>> +
>>>>>>> +Example:
>>>>>>> +
>>>>>>> +       genpll: genpll {
>>>>>>> +               #clock-cells = <0>;
>>>>>>> +               compatible = "brcm,cygnus-genpll";
>>>>>>> +               reg = <0x0301d000 0x2c>,
>>>>>>> +                       <0x0301c020 0x4>;
>>>>>>> +               clocks = <&osc>;
>>>>>>> +       };
>>>>>>> +
>>>>>>> +       genpll_clks: genpll_clks {
>>>>>>> +               #clock-cells = <1>;
>>>>>>> +               compatible = "brcm,cygnus-genpll-clk";
>>>>>>> +               reg = <0x0301d000 0x2c>;
>>>>>>> +               clocks = <&genpll>;
>>>>>>> +               clock-output-names = "axi21", "250mhz", "ihost_sys",
>>>>>>> +                       "enet_sw", "audio_125", "can";
>>>>>>> +       };
>>>>>>
>>>>>> Hi Ray,
>>>>>>
>>>>>> Thanks for submitting the patch. It was nice meeting you at ELC as well.
>>>>>>
>>>>>> This binding doesn't conform to the norms for clock bindings. It looks
>>>>>> like for each type of controllable clock node (e.g. pll, leaf clock,
>>>>>> etc) you have a dts node. Looking at the above example it seems that
>>>>>> those two nodes (genpll and genpll_clks) share the same register.
>>>>>>
>>>>>> /me checks patch #5
>>>>>>
>>>>>> Yup, you re-use the same register address for the *pll and *pll_clks
>>>>>> nodes. I'm not a DT expert but I think this is considered Wrong.
>>>>>>
>>>>>> More generally your clock dt binding should be modeling the hardware in
>>>>>> terms of IP blocks. If you have a clock generator IP block it may
>>>>>> control many clock bits and output many clock signals. E.g. for your
>>>>>> hardware (based only on the addresses in patch #5 and not having seen
>>>>>> any data manual) I will hazard a guess that the genpll, lcpll and asiu
>>>>>> clocks are all part of the same IP block.
>>>>>
>>>>> Hi Mike,
>>>>>
>>>>> In fact, lcpll, genpll, mipipll are similar but DIFFERENT IP blocks, and
>>>>> asiu is completely different from any of them. All of these plls are
>>>>> unique and have their own register banks, as you can see from the
>>>>> bcm-cygnus-clock.dtsi file. Therefore, I think it's totally correct and
>>>>> actually necessary to represent each of them with a separate device node.
>>>>
>>>> OK, that makes sense to me, if those registers live in addresses ranges
>>>> which correspond to different IP blocks.
>>>>
>>>>>
>>>>> Regarding the relationship between a PLL clock and its leaf clocks:
>>>>> Taking the genpll as an example, physically they are connected as:
>>>>>
>>>>> xtal -> genpll -> axi21, 250mhz, ihost_sys, ...
>>>>>
>>>>> The 25 MHz crystal feeds to the genpll, and the genpll generates 6
>>>>> different leaf clocks including axi21, 250mhz, ihost_sys, and etc. One
>>>>> can choose to set the genpll's vco to one frequency, and based on that
>>>>> frequency, different leaf clock frequencies can be generated with their
>>>>> own post divider.
>>>>>
>>>>> Therefore, I think it makes sense to represent xtal, genpll, genpll_clks
>>>>> (including axi21, 250mhz, ihost_sys, and etc) each with a unique device
>>>>> node, and genpll is the parent of these leaf clocks. Basically the
>>>>> device nodes and the way how the "clocks" phandle is used represent the
>>>>> hierarchy of the clock architecture within Cygnus (and in the future
>>>>> other iProc SoCs). Does that make sense?
>>>>
>>>> This doesn't make sense to me. If I understand correctly, the register
>>>> range that controls the post-divider clock (e.g. axi21) is the same
>>>> register range that control's genpll. This is a reasonable indicator to
>>>> me that the leaf clocks are part of the same clock generator IP block as
>>>> the PLL controls. As such they should be on node.
>>>>
>>>>>
>>>>> Regarding the register address overlapping, again, taking genpll as an
>>>>> example, the genpll and the genpll_clks actually never access the same
>>>>> set of registers, but the registers are sort of scattered within one
>>>>> bank, i.e., on Cygnus, genpll uses registers at offset 0x0, 0x8 ~ 0x1c,
>>>>> and genpll_clks uses registers at offset 0x4, 0x20 - 0x24.
>>>>
>>>> Sure, my argument above doesn't hinge on the fact that the pll and child
>>>> clocks use the exact same register. It still looks to me like *pll and
>>>> it's child dividers belong in the same IP block. Is there an open data
>>>> sheet or technical reference manual I can look at for this part? That is
>>>> the best way to put my concerns at ease ;-)
>>>>
>>>> Looking over your binding again, it looks like your nodes are divided
>>>> conveniently for the different clock types (e.g. pll versus
>>>> post-divider), but our goal with DT is to accurately describe the
>>>> hardware, not the C structures.
>>>>
>>>> Regards,
>>>> Mike
>>>>
>>>
>>> Yes, the genpll and genpll_clks are controlled by the same IP block. I
>>> can make the change to combine them to use one DT node. But before doing
>>> that, I just need to get one thing clarified with you. In SW, the pll
>>> and its leaf clocks will still be registered as separate two clock
>>> providers, since we need to be able to configure the PLL vco frequency
>>> and its leaf clock frequencies separately. The pll will be the parent of
>>> its leaf clocks, and the leaf clocks will be used by various peripherals.
>>>
>>> I plan to have the combined DT looks like this:
>>>
>>> genpll_clks: genpll_clks {
>>>     #clock-cells = <1>;
>>>     compatible = "brcm,cygnus-genpll-clk";
>>>     reg = <0x0301d000 0x2c>;
>>>
>>>     assigned-clocks = <&genpll_clks>;
>>>     /* this sets the PLL rate at the time when the PLL clock is
>>> registered */
>>>     assigned-clock-rates = <4000000000>;
>>>
>>>     clocks = <&osc>;
>>>
>>>     clock-output-names = "axi21", "250mhz", "ihost_sys", "enet_sw",
>>> "audio_125", "can";
>>> };
>>>
>>> peripheralA: peripheralA {
>>>     /* use the first leaf clock of genpll */
>>>     clocks = <&genpll_clks 0>;
>>>     clock-frequency  = <100000000>;
>>> };
>>>
>>> If we register both the genpll and its leaf clocks to the clock
>>> framework as two separate clock providers, would the above DT entries
>>> still work? For example, peripheralA refers to the phandle of
>>> genpll_clks, but how does the clock framework know to link it to the pll
>>> clock or the leaf clock?
> 
> Hi Ray,
> 
> There are two options here: using clock-output-names or not using
> clock-output-names.
> 
> I would recommend against using clock-output-names. If both your
> clock driver and the peripheral devices that consume these clocks are
> all represented in DT then you can skip clock-output-names and instead
> create phandle linkage between the clocks inside of your clock provider
> and the consumer devices. String names are still important here, but now
> you only need to specify the string name as an *input* to the consumer
> device, and not as an *output* from the clock provider node. Let's look
> at how the qcom bindings do it:
> 
> gcc is a clock generator ip block.
> 
> arch/arm/boot/dts/qcom-apq8084.dtsi:
>                 gcc: clock-controller at fc400000 {
>                         compatible = "qcom,gcc-apq8084";
>                         #clock-cells = <1>;
>                         #reset-cells = <1>;
>                         reg = <0xfc400000 0x4000>;
>                 };
> 
> This same file includes this header:
> #include <dt-bindings/clock/qcom,gcc-apq8084.h>
> 
> That header creates a map of clocks by numbers. An example:
> #define GCC_BLSP2_UART2_APPS_CLK                        142
> 
> We can see how it used by the serial controller in
> arch/arm/boot/dts/qcom-apq8084.dtsi:
>                 serial at f995e000 {
>                         compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
>                         reg = <0xf995e000 0x1000>;
>                         interrupts = <0 114 0x0>;
>                         clocks = <&gcc GCC_BLSP2_UART2_APPS_CLK>, <&gcc GCC_BLSP2_AHB_CLK>;
>                         clock-names = "core", "iface";
>                         status = "disabled";
>                 };
> 
> Note the 'clock-names' property. This lists a string name which is a property
> of the *consuming* device (uart controller), not the *providing* device (gcc
> clock generator).
> 
> Finally, it all comes together in the driver simply using clk_get:
>         msm_port->clk = devm_clk_get(&pdev->dev, "core");
>         if (IS_ERR(msm_port->clk))
>                 return PTR_ERR(msm_port->clk);
> 
>         if (msm_port->is_uartdm) {
>                 msm_port->pclk = devm_clk_get(&pdev->dev, "iface");
>                 if (IS_ERR(msm_port->pclk))
>                         return PTR_ERR(msm_port->pclk);
> 
>                 clk_set_rate(msm_port->clk, 1843200);
>         }
> 
> This works because we have created linkage between the clock phandle and
> the consuming device node. The shared header is used by the Linux kernel
> to look up the clock as well as the consumer node to map the string name
> onto a clock input.
> 
> Back to clock-output-names:
> 
> If you decide to keep using clock-output-names you can still represent
> the pll clock in your "clock-output-names". In a perfect world DT nodes
> that use clock-output-names would only expose the leaf clocks that your
> peripheral devices consume, but there is no technical reason why your
> pll can't be a part of the clock-output-names array. It is simply an
> array of string names that maps to an index. There is no sense of
> parent-child hierarchy in the DT binding, so there is no problem adding
> a parent pll clock to the array of clock-output-names. I think that this
> will tactically solve your problem in the short term, but I encourage
> you to inspect the qcom binding example I gave above to see if it a
> better fit for you long term.
> 
> Regards,
> Mike
> 

Thanks for your thorough explanation. You clarified that there does not
need to be a clock parent-child hierarchy in the DT binding. I think
that's where I got really confused at. Yes, by exposing both the pll
(parent) and its leaf clocks (children) with individual indices under
the same node, that should solve the problem I have.

I will investigate and work out a new patch.

Thanks,

Ray
