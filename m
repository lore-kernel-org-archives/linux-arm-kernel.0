From: robherring2@gmail.com (Rob Herring)
Date: Mon, 09 Apr 2012 09:34:46 -0500
Subject: [PATCH 2/7] of: add clock providers
In-Reply-To: <20120409141347.GC18692@S2101-09.ap.freescale.net>
References: <1331680947-29861-1-git-send-email-robherring2@gmail.com>
 <1331680947-29861-3-git-send-email-robherring2@gmail.com>
 <20120409115549.GB18692@S2101-09.ap.freescale.net>
 <4F82E9A3.1030606@gmail.com>
 <20120409141347.GC18692@S2101-09.ap.freescale.net>
Message-ID: <4F82F386.7080303@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/09/2012 09:13 AM, Shawn Guo wrote:
> On Mon, Apr 09, 2012 at 08:52:35AM -0500, Rob Herring wrote:
>> On 04/09/2012 06:55 AM, Shawn Guo wrote:
>>> On Tue, Mar 13, 2012 at 06:22:22PM -0500, Rob Herring wrote:
>>> ...
>>>> +==Clock consumers==
>>>> +
>>>> +Required properties:
>>>> +clocks:		List of phandle and clock specifier pairs, one pair
>>>> +		for each clock input to the device.  Note: if the
>>>> +		clock provider specifies '0' for #clock-cells, then
>>>> +		only the phandle portion of the pair will appear.
>>>
>>> Per discussion[1], the parent of the clock could be reasonably
>>> represented in C code instead of in device tree.  Then how can
>>> this "clocks" property be "Required"?  Or to put it another way,
>>> if this is "Required", the whole clock tree will have to be represented
>>> in device tree, no?
>>>
>>
>> I'm not sure I follow. All of this only applies if you are doing clock
>> setup from DT. Whether you represent all clocks or only the outputs to
>> devices in DT is up to you. So you could have a CCM node for imx with 50
>> clock outputs and all the intermediate clocks within the CCM are
>> represented with C code.
>>
> Ok, now I have uart clock being one of the 50 clocks represented in
> device tree, while the parent of uart clock ipg_per is represented in
> C code.  That said, I do not have a ipg_per clock node in device tree.
> My question is how I should give that required "clocks" property for
> the uart clock node.
>
> 	uart_serial_clk: uart-baud {
> 		compatible = "fsl,imx6q-clock";
> 		#clock-cells = <0>;
> 		/* clocks = <&ipg_per_clk>; */
> 		clocks = <???>;

This is a provider node not a consumer, so you don't have a clocks
property. You could, but then you need the parent clock defined in the DT.

The compatible property here looks too generic. In the CCM code, how do
you match it to the uart baud clock? You shouldn't be using the name.

You need to first decide if you are going to define each clock in the DT
or just the whole CCM as a node. You can't really do something in the
middle or be evolving it over time. You could perhaps make the PLLs be
separate nodes and inputs to the CCM. As they really are separate h/w
blocks.

Rob

> 	};
> 
> 	uart: serial at 02020000 {
> 		compatible = "fsl,imx6q-uart", "fsl,imx21-uart";
> 		reg = <0x02020000 0x4000>;
> 		interrupts = <0 26 0x04>;
> 		clocks = <&uart_serial_clk>
> 	}
> 
> Regards,
> Shawn
> 
>> In other words, at minimum you are just replacing the clkdev lookup with
>> a DT lookup.
>>
