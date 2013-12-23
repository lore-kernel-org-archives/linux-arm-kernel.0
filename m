From: emilio@elopez.com.ar (=?ISO-8859-1?Q?Emilio_L=F3pez?=)
Date: Mon, 23 Dec 2013 13:52:56 -0300
Subject: [PATCH 2/4] ARM: dts: sun7i: external clock outputs
In-Reply-To: <CAGb2v6607N5k+h4ym62ZGvHEhAOPoABog8ep1gwkE++FB5CWDg@mail.gmail.com>
References: <1387787827-11341-1-git-send-email-wens@csie.org>
 <1387787827-11341-3-git-send-email-wens@csie.org>
 <52B862F2.1020406@elopez.com.ar>
 <CAGb2v6607N5k+h4ym62ZGvHEhAOPoABog8ep1gwkE++FB5CWDg@mail.gmail.com>
Message-ID: <52B86A68.1070607@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

El 23/12/13 13:43, Chen-Yu Tsai escribi?:
> Hi,
>
> On Tue, Dec 24, 2013 at 12:21 AM, Emilio L?pez <emilio@elopez.com.ar> wrote:
>> Hi,
>>
>> El 23/12/13 05:37, Chen-Yu Tsai escribi?:
>>
>>> This commit adds the two external clock outputs available on A20 to
>>> its device tree. A dummy fixed factor clock is also added to serve as
>>> the first input of the clock outputs, which according to AW's A20 user
>>> manual, is the 24MHz oscillator divided by 750.
>>>
>>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>>> ---
>>
>> (,,,)
>>
>>> +               clk_out_a: clk_out_a at 01c201f0 {
>>> +                       #clock-cells = <0>;
>>> +                       compatible = "allwinner,sun7i-a20-out-clk";
>>> +                       reg = <0x01c201f0 0x4>;
>>> +                       clocks = <&osc24M_32k>, <&osc32k>, <&osc24M>;
>>> +               };
>>
>>
>> These nodes should, as per Maxime's recommendation, look more like
>>
>>          clk_out_a: clk at 01c201f0 {
>>                  #clock-cells = <0>;
>>                  compatible = "allwinner,sun7i-a20-out-clk";
>>                  reg = <0x01c201f0 0x4>;
>>
>>                  clocks = <&osc24M_32k>, <&osc32k>, <&osc24M>;
>>                  clk-output-names = "clk_out_a";
>>          };
>
> I see. I was following the structure for the main clocks,
> such as pll* or axi/ahb/apb, as the output clocks do not
> have a specific device tied to them, and no worries that
> a node name collision might happen. Do you plan to convert
> the other clocks to this scheme as well? Or are they
> considered reserved or special names?

Yes, with time they should be renamed. A quote from 
http://devicetree.org/Device_Tree_Usage to give a bit of background

"""
It is worth taking a moment to talk about naming conventions. Every node 
must have a name in the form <name>[@<unit-address>].
<name> is a simple ascii string and can be up to 31 characters in 
length. In general, nodes are named according to what kind of device it 
represents. ie. A node for a 3com Ethernet adapter would be use the name 
ethernet, not 3com509. [...]
Sibling nodes must be uniquely named, but it is normal for more than one 
node to use the same generic name so long as the address is different 
(ie, serial at 101f1000 & serial at 101f2000).
"""

Have a look at the last iteration of my patches, where I remade all the 
mod0 nodes to fit with this.

Cheers,

Emilio
