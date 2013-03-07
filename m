From: lars@metafoo.de (Lars-Peter Clausen)
Date: Thu, 07 Mar 2013 10:36:35 +0100
Subject: RFC: Zynq Clock Controller
In-Reply-To: <f288874c-d0ae-4581-8d0f-2b9abe4d3117@CO9EHSMHS002.ehs.local>
References: <37032699-343e-485c-80e0-9b23e3706c58@VA3EHSMHS013.ehs.local>
 <1362570681.5269.98.camel@coredoba.hi.pengutronix.de>
 <f288874c-d0ae-4581-8d0f-2b9abe4d3117@CO9EHSMHS002.ehs.local>
Message-ID: <51385FA3.8080105@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/06/2013 06:27 PM, S?ren Brinkmann wrote:
> Hi Jan,
>  
> what a small world. Good to hear from you.
> 
> On Wed, Mar 06, 2013 at 12:51:21PM +0100, Jan L?bbe wrote:
>> Hi S?ren,
>>
>> On Tue, 2013-03-05 at 12:04 -0800, S?ren Brinkmann wrote:
>>> For this reasons, I'd like to propose moving Zynq into the same
>>> direction. I.e. adding a clock controller with the following DT
>>> description (details may change but the general idea should become
>>> clear):
>>> 	clkc: clkc {
>>>                 #clock-cells = <1>;
>>>                 compatible = "xlnx,ps7-clkc";
>>>                 ps_clk_frequency = <33333333>;	# board x-tal
>>>                 # optional props
>>>                 gem0_emio_clk_freq = <125000000>;
>>>                 gem1_emio_clk_freq = <50000000>;
>>>                 can_mio_clk_freq_xx = <1234>; # this is possible 54 times with xx = 00..53
>>>         };

I definitely prefer the way it is right now in upstream, where we have one
dt node per clock. It is more descriptive and also more extensible. And you
also don't have to remember the clock index, and can use the phandle
directly instead.

>>
>> The clock controller should only contain properties for input frequency
>> (which can obviously not be calculated at run-time).
>>
>> Are the gem*, can* properties inputs? If they are actually outputs, the
>> corresponding frequencies should be requested by the clock consumers and
>> not hard-coded in DT.
> They are inputs. GEM and CAN have the option to be clocked through (E)MIO pins, i.e. some external clock input which cannot be derived from ps_clk like all other clocks. I plan to register a fixed rate, root clock for each of those properties, if present.

If it is a static external input clock use a "fixed-clock" dt node to
describe it. This also has the advantage that is is also possible to use a
non-static clock.

- Lars
