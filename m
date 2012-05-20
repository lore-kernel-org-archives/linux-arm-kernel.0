From: shawn.guo@freescale.com (Shawn Guo)
Date: Sun, 20 May 2012 11:06:54 +0800
Subject: [GIT PULL] DT clk binding support
In-Reply-To: <4FB80F32.5090309@gmail.com>
References: <4FB80F32.5090309@gmail.com>
Message-ID: <20120520030653.GB5810@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 19, 2012 at 04:22:58PM -0500, Rob Herring wrote:
> Grant Likely (2):
>       clk: add DT clock binding support

I just checked your branch and found that a couple of comments that
I put on this patch haven't get addressed.  The most notable one would
be the "clocks" property of clock consumers.

+==Clock consumers==
+
+Required properties:
+clocks:                List of phandle and clock specifier pairs, one pair
+               for each clock input to the device.  Note: if the
+               clock provider specifies '0' for #clock-cells, then
+               only the phandle portion of the pair will appear.
+
+Optional properties:
+clock-names:   List of clock input name strings sorted in the same
+               order as the clocks property.  Consumers drivers
+               will use clock-names to match clock input names
+               with clocks specifiers.

As I said, any clock in the clock tree except root clock is not only
a clock provider but also a consumer.  If you define "clocks" as a
required property for clock consumers, you are essentially asking users
to either define the whole clock tree in the device tree or stay away
from device tree completely.

Are you sure this is the right thing to do?  If I remember correctly,
Grant's position is it should be pretty reasonable to have most of
the clock tree defined in clock driver and only define those leaf
clocks which are very likely to become the clock providers for other
peripherals.

Let me put a terrible example here.  Since clock tree is actually SoC
specific, I can reasonably choose to define the entire imx6q clock tree
and all the clk lookups for imx6q peripherals in clk-imx6q driver.
On imx6q-sabrelite board, the audio codec sgtl5000 uses cko (an imx6q
clock available on pad) as the clock source.  That said, I need a board
specific clk lookup here, which should be the best user of clock DT
bindings.  But sadly, with the current bindings, I can not give the
required "clocks" property for sgtl5000 node.

-- 
Regards,
Shawn
