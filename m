From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Thu, 7 Mar 2013 11:11:44 -0800
Subject: RFC: Zynq Clock Controller
In-Reply-To: <51385FA3.8080105@metafoo.de>
References: <37032699-343e-485c-80e0-9b23e3706c58@VA3EHSMHS013.ehs.local>
 <1362570681.5269.98.camel@coredoba.hi.pengutronix.de>
 <f288874c-d0ae-4581-8d0f-2b9abe4d3117@CO9EHSMHS002.ehs.local>
 <51385FA3.8080105@metafoo.de>
Message-ID: <2a91857c-473f-4f92-b2b1-e7ac4679b72a@AM1EHSMHS007.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 07, 2013 at 10:36:35AM +0100, Lars-Peter Clausen wrote:
> On 03/06/2013 06:27 PM, S?ren Brinkmann wrote:
> > Hi Jan,
> >  
> > what a small world. Good to hear from you.
> > 
> > On Wed, Mar 06, 2013 at 12:51:21PM +0100, Jan L?bbe wrote:
> >> Hi S?ren,
> >>
> >> On Tue, 2013-03-05 at 12:04 -0800, S?ren Brinkmann wrote:
> >>> For this reasons, I'd like to propose moving Zynq into the same
> >>> direction. I.e. adding a clock controller with the following DT
> >>> description (details may change but the general idea should become
> >>> clear):
> >>> 	clkc: clkc {
> >>>                 #clock-cells = <1>;
> >>>                 compatible = "xlnx,ps7-clkc";
> >>>                 ps_clk_frequency = <33333333>;	# board x-tal
> >>>                 # optional props
> >>>                 gem0_emio_clk_freq = <125000000>;
> >>>                 gem1_emio_clk_freq = <50000000>;
> >>>                 can_mio_clk_freq_xx = <1234>; # this is possible 54 times with xx = 00..53
> >>>         };
> 
> I definitely prefer the way it is right now in upstream, where we have one
> dt node per clock. It is more descriptive and also more extensible. And you
> also don't have to remember the clock index, and can use the phandle
> directly instead.
The problems I see with that are:
 - with the clock controller we can model the clock tree as we need without changing the DT all the time
 - w/o a clock controller there is no block which has knowledge of the whole clock tree (unless we parse the DT), and could conduct reparent operations and similar
 - once the clock controller is properly defined the clock connection should be contained in a dtsi which never changes. So, regarding remembering outputs, I don't see a problem. I rather see issues with having a pile of clocks described in the DT. I have currently 44 outputs proposed, and to model the whole tree a lot of more clocks are used (I started modeling everything with the clock primitives and removed custom clock implementations, except for the PLLs). Having all those in the DT does not really help, IMHO.

> 
> >>
> >> The clock controller should only contain properties for input frequency
> >> (which can obviously not be calculated at run-time).
> >>
> >> Are the gem*, can* properties inputs? If they are actually outputs, the
> >> corresponding frequencies should be requested by the clock consumers and
> >> not hard-coded in DT.
> > They are inputs. GEM and CAN have the option to be clocked through (E)MIO pins, i.e. some external clock input which cannot be derived from ps_clk like all other clocks. I plan to register a fixed rate, root clock for each of those properties, if present.
> 
> If it is a static external input clock use a "fixed-clock" dt node to
> describe it. This also has the advantage that is is also possible to use a
> non-static clock.
I thought about this too, and it's probably a valid use-case.

What comes to my mind to support this would be:
 - clocks and clock-names properties to the controller
 - those two properties hold a list of available external clock sources

 e.g:
 	clocks = <&foo>, <&bar 2>, <&foobar 0>;
	clock-names = "can_emio_clk_44", "gem1_emio_clk", "can_emio_clk_00";

 Then the clock controller would go through the possible clock names trying a 'clk_get(NULL, "gem0_emio_clk"', etc. making available connections.

 	S?ren
