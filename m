From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Wed, 5 Nov 2014 20:13:12 -0800
Subject: [PATCH 0/7] Pinctrl support for Zynq
In-Reply-To: <545AF05A.1040300@suse.de>
References: <1415041531-15520-1-git-send-email-soren.brinkmann@xilinx.com>
 <5459BC1C.3000807@suse.de>
 <44de30f0237545c6b62871d6c0480a67@BY2FFO11FD050.protection.gbl>
 <545AF05A.1040300@suse.de>
Message-ID: <149f300f05ec4a28bed74212a7b01529@BY2FFO11FD005.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2014-11-06 at 04:51AM +0100, Andreas F?rber wrote:
> Am 05.11.2014 um 18:03 schrieb S?ren Brinkmann:
> > On Wed, 2014-11-05 at 06:56AM +0100, Andreas F?rber wrote:
> >> I've tracked down all 54 MIO pins of the Parallella and cooked up the
> >> equivalent DT patch. [...] For testing purposes I've configured a
> >> heartbeat trigger for the USER_LED (CR10).
> >>
> >> To my disappointment these pinctrl additions did not fix one issue:
> >> Whenever a write access to be handled by the bitstream (0x808f0f04) is
> >> performed, the board hangs and the heartbeat stops. Would a bug in the
> >> bitstream allow this to happen, or are more drivers missing to actually
> >> make use of the PL in general? With a downstream ADI/Xilinx 3.12 kernel
> >> that problem does not surface.
> > 
> > This doesn't sound like being related to pinctrl at all.
> > Devices in the PL are just memory mapped on the AXI bus. There is
> > nothing needed to access those. Hangs do in most cases indicate that the
> > IP does not respond (properly). In my experience this is mostly caused
> > by 
> >  - level shifters not enabled
> >  - IP kept in reset
> >  - IP is clock gated
> > With the clock gating being the culprit in most cases. Did you check
> > those things?
> 
> Figured it out: zynq-7000.dtsi sets fclk-enable = <0>, i.e., all PL
> clocks are disabled by default. When overriding that tiny property with
> 0xf it suddenly works as expected! I'll send a patch later in the day.
> 
> Are boards expected to use clocks = <&clkc 15>, ...; on individual nodes
> relying on the PL? Or does enabling those clocks require actually
> loading a bitstream so that it is not being done by default?

Clocks are under control of drivers. Drivers are supposed to
use the clock framework to enable the clocks they use. The fclk-enable
is just a work around to enable driver-less IP and similar.

So, if your FPGA part has proper drivers, you should add the appropriate
description in DT and the drivers would need to use the CCF to enable
the clocks. Otherwise you can work around this by specifying
fclk-enable.

	S?ren
