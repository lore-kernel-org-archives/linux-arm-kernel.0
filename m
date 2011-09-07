From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 7 Sep 2011 15:23:50 +0100
Subject: [PATCH 2/6] arm/imx6q: add core definitions and low-level
	debug uart
In-Reply-To: <20110907123635.GT28816@pengutronix.de>
References: <1315303120-24203-1-git-send-email-shawn.guo@linaro.org>
	<1315303120-24203-3-git-send-email-shawn.guo@linaro.org>
	<20110906202555.GQ28816@pengutronix.de>
	<20110907110001.GI8148@S2100-06.ap.freescale.net>
	<20110907123635.GT28816@pengutronix.de>
Message-ID: <20110907142350.GU6619@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 07, 2011 at 02:36:35PM +0200, Uwe Kleine-K?nig wrote:
> But only if the image doesn't support imx6q, right? Anyhow, I hope
> imx6q_map_io isn't called for pre-imx6q SoCs. Ah, and I hope we don't
> need to argue here as Russell doesn't like the new DEBUG_LL changes :-)

I have no problem with the Kconfig menu approach or existing approaches
to DEBUG_LL.  What I have an objection to is trying to stuff the
information for it into places which ultimately render the facility
useless for its intended purpose - to permit debugging the _really_
_early_ assembly code.

That is what it was written for: if we introduce complicated ways to
put behind it, we'll need to come up with a completely new debugging
infrastructure to debug the now buggered debugging infrastructure.

And then people will want to do the same to the debug debugging
infrastructure.  Then we'll have to invent the debug debugging debugging
infrastructure.  Repeat until you've nested it a million times.

It's supposed to be _simple_ and _obviously_ correct so that it _works_
with minimal fuss.  Making it complicated by picking out information
from device trees will kill that, and at that point its not worth keeping
around anymore.

Let me give you an instance: your kernel doesn't boot.  Early printk
doesn't work.  You want to find out if control is even getting to the
very first instruction in head.S.  You can do that with DEBUG_LL as it
stands today because we know exactly where the serial port is supposed
to be.

If you have to pick the DEBUG_LL information out of a DT, you can no
longer do that - you first have to obtain the pointer to DT, and then
parse the DT table to find out where the hell the port is.  What if
the reason your kernel isn't booting is because the DT pointer is
wrong?  What if the reason your kernel isn't booting is because the
information contained within DT is wrong?

How do you debug that?  You probably end up having to write your own
debugging infrastructure using a fixed address for the port.
Congratulations - you just reinvented what DEBUG_LL was designed to
be doing before someone came along and totally buggered it up.

The fact that DEBUG_LL is hard-coded to a certain port address is one
of its strongest points.  It means that if you know that the port
address is correct (which is a matter of looking at the SoCs data
sheets and confirming that the hex digits match) then you can be
reasonably sure that you're going to get some output from it.  No
need to wonder "Is the DT pointer correct?  Are we parsing DT
properly?" etc.

So, either we keep it in its current form or we throw it out from
mainline entirely and I keep it as a separate add-on patch for those
who want to use it.
