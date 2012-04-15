From: robherring2@gmail.com (Rob Herring)
Date: Sat, 14 Apr 2012 22:04:26 -0500
Subject: [PATCH 4/7] dt/clock: Add handling for fixed clocks and a clock
 node setup iterator
In-Reply-To: <20120409232723.GD18692@S2101-09.ap.freescale.net>
References: <1331680947-29861-1-git-send-email-robherring2@gmail.com>
 <1331680947-29861-5-git-send-email-robherring2@gmail.com>
 <20120314075930.GF21337@S2101-09.ap.freescale.net>
 <4F81A53B.7020804@gmail.com>
 <20120409084930.GA18692@S2101-09.ap.freescale.net> <4F82EFB3.80402@gmail.com>
 <20120409232723.GD18692@S2101-09.ap.freescale.net>
Message-ID: <4F8A3ABA.2080201@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/09/2012 06:27 PM, Shawn Guo wrote:
> On Mon, Apr 09, 2012 at 09:18:27AM -0500, Rob Herring wrote:
> ...
>> You still haven't given any benefits of supporting multiple clocks. It's
>> slightly fewer dts lines, but not really anything else.
>>
> What's more important than fewer dts lines is fewer nodes.  Isn't it
> the whole point of #clock-cells?  In the real imx example I gave, with
> #clock-cells support, I can have only one node to represent 3 fixed
> clocks.

So you want to have generic bindings for every clock which implies a
bunch of nodes if not a node per clock anyway, but then object to 3
nodes for fixed clocks.

I don't think I've ever seen a chip with more than 3 clock inputs
anyway. There are cases with additional clocks like a CMOS sensor or
audio chip which provides a fixed input clock, but those clocks should
reside with the nodes that generate them.

> ...
>> I don't think people are going to define clocks generically in DT at the
>> mux, clk gate and divider level anyway. If you only have a few clocks
>> then you may, and 1 clock output per node is probably okay. If you have
>> hundreds of clocks then you probably won't, and will have a SOC specific
>> binding anyway.
>>
> Why?
> 
> Take a look at clk-imx6q.c[1], you will find except pll and pfd, all
> the imx6q clocks are represented as gate, divider and mux, and we
> should not need a SoC specific binding for them.
> 

I'm talking about the bindings and you are pointing me to an
implementation with no bindings. It's 2 different things. The
implementation can fully be the generic clk implementations, but the
clock bindings can still be either a node per clock or a monolithic
clock module node. There is no fixed rule here and there should not be.
We can each chose what works best for us.

I see a couple of examples that your clocks are still SoC specific
despite your claims.

Your clock gates may reuse clk_gate struct, but they still have custom
ops to handle the 2-bit field. Obviously, you decided not to merge 2-bit
field support into the existing clk gate code (the correct decision
IMHO). I made a similar decision.

For practically every clock, you need to set the spinlock to
imx_ccm_lock. How are you going to know which clocks to set this lock
for with a "generic" binding? You have to distinguish those from IPU
clocks for example.

Rob
