From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 18 Feb 2014 10:34:36 -0700
Subject: [PATCH 1/2] clk: fixed-rate: use full DT node name
In-Reply-To: <20140218112323.GB6051@e106331-lin.cambridge.arm.com>
References: <1392358613-19962-1-git-send-email-swarren@wwwdotorg.org>
 <20140214103556.GC9907@e106331-lin.cambridge.arm.com>
 <52FE4798.3010605@wwwdotorg.org>
 <20140218112323.GB6051@e106331-lin.cambridge.arm.com>
Message-ID: <530399AC.2070204@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/18/2014 04:23 AM, Mark Rutland wrote:
> On Fri, Feb 14, 2014 at 04:43:04PM +0000, Stephen Warren wrote:
>> On 02/14/2014 03:35 AM, Mark Rutland wrote:
>>> On Fri, Feb 14, 2014 at 06:16:52AM +0000, Stephen Warren wrote:
>>>> clk-fixed-rate currently names clocks according to a node's name without
>>>> the unit address. When faced with the legal and technically correct DT
>>>> structure below, this causes rgistration attempts for 3 clocks with the
>>>> same name, 2 of which fail.
>>>>
>>>> 	clocks {
>>>> 		compatible = "simple-bus";
>>>> 		#address-cells = <1>;
>>>> 		#size-cells = <0>;
>>>>
>>>> 		clk_mmc: clock at 0 {
>>>> 			compatible = "fixed-clock";
>>>> 			reg = <0>;
>>>> ...
>>>> 		clk_i2c: clock at 1 {
>>>> 			compatible = "fixed-clock";
>>>> 			reg = <1>;
>>>> ...
>>>> 		clk_spi: clock at 2 {
>>>> 			compatible = "fixed-clock";
>>>> 			reg = <2>;
>>>> ...
>>>
>>> I'd argue that this case isn't valid.
>>
>> Well, it's very widely used, and was the result of numerous discussions
>> of how this kind of thing should be represented:-/
> 
> Maybe we have to live with it then. :/

Great:-)

...
>>> It's just nonsensical; rename them to clock_{0,1,..} instead and get rid
>>> of the reg properties. Then they're named uniquely.
>>
>> That's not legal either. DT node names are supposed to represent the
>> type of device/object (i.e. just "clock"), not the identity of the
>> device/object (i.e. not include IDs etc.). Hence, the node name needs to
>> be "clock" for all of them, and the unit address must be used to
>> differentiate them.
> 
> As far as I can see from ePAPR, the only requriement is:
> 
>   The node-name shall start with a lower or uppercase character and
>   should describe the general class of device.
> 
> IMO clock_1 describes the general class of device as well as clock at 1,
> while also not filling a unexpected property with a meaningless value.

I believe section 2.2.2 "Generic Names Recommendation" is the source of
the rule that nodes should be named after the type of object rather than
the identity.

"""
The name of a node should be somewhat generic, reflecting the function
of the device and not its precise programming model. If appropriate, the
name should be one of the following choices:

* atm
* cache-controller
* compact-flash
* can
* cpu
...
"""

(I note e.g. "cpu" not "cpu-1", "cpu_2", etc.)
