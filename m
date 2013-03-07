From: lars@metafoo.de (Lars-Peter Clausen)
Date: Thu, 07 Mar 2013 23:02:58 +0100
Subject: RFC: Zynq Clock Controller
In-Reply-To: <2a91857c-473f-4f92-b2b1-e7ac4679b72a@AM1EHSMHS007.ehs.local>
References: <37032699-343e-485c-80e0-9b23e3706c58@VA3EHSMHS013.ehs.local>
 <1362570681.5269.98.camel@coredoba.hi.pengutronix.de>
 <f288874c-d0ae-4581-8d0f-2b9abe4d3117@CO9EHSMHS002.ehs.local>
 <51385FA3.8080105@metafoo.de>
 <2a91857c-473f-4f92-b2b1-e7ac4679b72a@AM1EHSMHS007.ehs.local>
Message-ID: <51390E92.2080806@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/07/2013 08:11 PM, S?ren Brinkmann wrote:
> On Thu, Mar 07, 2013 at 10:36:35AM +0100, Lars-Peter Clausen wrote:
>> On 03/06/2013 06:27 PM, S?ren Brinkmann wrote:
>>> Hi Jan,
>>>  
>>> what a small world. Good to hear from you.
>>>
>>> On Wed, Mar 06, 2013 at 12:51:21PM +0100, Jan L?bbe wrote:
>>>> Hi S?ren,
>>>>
>>>> On Tue, 2013-03-05 at 12:04 -0800, S?ren Brinkmann wrote:
>>>>> For this reasons, I'd like to propose moving Zynq into the same
>>>>> direction. I.e. adding a clock controller with the following DT
>>>>> description (details may change but the general idea should become
>>>>> clear):
>>>>> 	clkc: clkc {
>>>>>                 #clock-cells = <1>;
>>>>>                 compatible = "xlnx,ps7-clkc";
>>>>>                 ps_clk_frequency = <33333333>;	# board x-tal
>>>>>                 # optional props
>>>>>                 gem0_emio_clk_freq = <125000000>;
>>>>>                 gem1_emio_clk_freq = <50000000>;
>>>>>                 can_mio_clk_freq_xx = <1234>; # this is possible 54 times with xx = 00..53
>>>>>         };
>>
>> I definitely prefer the way it is right now in upstream, where we have one
>> dt node per clock. It is more descriptive and also more extensible. And you
>> also don't have to remember the clock index, and can use the phandle
>> directly instead.
> The problems I see with that are:
>  - with the clock controller we can model the clock tree as we need without changing the DT all the time

When do we need to change the clock tree? The clock tree is pretty much fixed
in hardware. And the DT describes the hardware, so I don't so a problem there.

>  - w/o a clock controller there is no block which has knowledge of the whole clock tree (unless we parse the DT), and could conduct reparent operations and similar

The clk framework builds a representation of the clock tree. Each clock should
be able to handle re-parenting on it's own, without knowing about the other
clocks in the tree, the parent is selected by a field in the clocks register.
It doesn't even have to know who the parents are, the clk framework will take
care of all of this and just say, ok, switch your input clock to X, where X is
a simple integer number The clk framework will also take care of re-calculating
all the updates frequencies after re-parenting.

>  - once the clock controller is properly defined the clock connection should be contained in a dtsi which never changes. So, regarding remembering outputs, I don't see a problem. I rather see issues with having a pile of clocks described in the DT. I have currently 44 outputs proposed, and to model the whole tree a lot of more clocks are used (I started modeling everything with the clock primitives and removed custom clock implementations, except for the PLLs). Having all those in the DT does not really help, IMHO.

Well, except if you want to use external clocks for ethernet or CAN. Also you
don't need to change the dtsi either if you have a separate node for each clock.

To avoid misunderstandings let me clarify that I don't want to have one node
per clock, but rather one node per clock block (or whatever they are called).
The combination of input select + divider + output gate. E.g. the UART clock
block with it's 3 inputs and two outputs.

Also the APER clocks should probably be one node with 24 outputs.

- Lars
