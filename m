From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 25 Mar 2013 17:29:33 -0600
Subject: RFC v2: Zynq Clock Controller
In-Reply-To: <128fc723-ace7-4f4c-95d9-971b42a52080@CH1EHSMHS028.ehs.local>
References: <27dae808-1d3a-4001-8eb2-b0a6e2a34b8f@AM1EHSMHS013.ehs.local>
 <514B5254.50101@metafoo.de>
 <128fc723-ace7-4f4c-95d9-971b42a52080@CH1EHSMHS028.ehs.local>
Message-ID: <5150DDDD.9010904@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/22/2013 04:41 PM, S?ren Brinkmann wrote:
> Hi Lars,
> 
> On Thu, Mar 21, 2013 at 07:32:52PM +0100, Lars-Peter Clausen wrote:
>> On 03/21/2013 12:56 AM, S?ren Brinkmann wrote:
>>> Hi,
>>>
>>> I spent some time working on this and incorporating feedback. Here's an updated proposal for a clock controller for Zynq:
>>>
>>> Required properties:
>>>  - #clock-cells : Must be 1
>>>  - compatible : "xlnx,ps7-clkc"  (this may become 'xlnx,zynq-clkc' terminology differs a bit between Xilinx internal and mainline)
>>>  - ps-clk-frequency : Frequency of the oscillator providing ps_clk in HZ
>>>                      (usually 33 MHz oscillators are used for Zynq platforms)
>>>  - clock-output-names : List of strings used to name the clock outputs. Shall be a list of the outputs given below.
>>>
>>> Optional properties:
>>>  - clocks : as described in the clock bindings
>>>  - clock-names : as described in the clock bindings
>>>
>>> Clock inputs:
>>> The following strings are optional parameters to the 'clock-names' property in
>>> order to provide optional (E)MIO clock sources.
>>>  - swdt_ext_clk
>>>  - gem0_emio_clk
>>>  - gem1_emio_clk
>>>  - mio_clk_XX          # with XX = 00..53
>>>
>>> Example:
>>>         clkc: clkc {
>>>                 #clock-cells = <1>;
>>>                 compatible = "xlnx,ps7-clkc";
>>>                 ps-clk-frequency = <33333333>;
>>
>> The input frequency should be a clock as well.
>
> Again, monolithic vs split. I don't see a reason not to just internally
> call clk_register_fixed_rate(). That way its children do not have to
> cope with a variable name for the xtal.
> Also, with my proposal 'clocks' and 'clock-names' would be purely
> optional properties, only required if optional external inputs are
> present. Having the xtal defined externally would add mandatory entries for
> those props.

But isn't the clock source board-specific? It's a completely separate
object from Zynq's own clock controller HW, and as such should be
represented by a separate DT node, right?

The issue with parent clock names is simply a red herring. A solution is
needed to registered clock with a parent clock object, rather than a
parent clock name. Then, the parent names are completely irrelevant.
