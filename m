From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 20 May 2012 11:51:10 +0200
Subject: kirkwood, nand, clocks and device-tree
In-Reply-To: <87fwaxes25.fsf@lebrac.rtp-net.org>
References: <87fwaxes25.fsf@lebrac.rtp-net.org>
Message-ID: <20120520095110.GC12741@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 18, 2012 at 11:50:42AM +0200, Arnaud Patard wrote:
> Hi,
> 
> I wanted to convert iconnect to use the new nand DT support on kirkwood
> but my system was freezing hard during boot. So, I've debugged it a
> little bit and have several questions.
> 
> The first one is about were is defined the nand. It's defined as a leaf
> of the "ocp" bus. I would have expected to see it at the same level but
> I've seen nothing proving if it's wrong or right when comparing with
> hardware. Can anyone give me some information about that ?
> 
> Now, the real questions about my problem. It's hanging because the nand
> platform device created throught DT is called f4000000.nand and not
> orion_nand. This means that the clock gets disabled by
> clk_disable_unused() so first access to the nand fails badly.
> To workaround, I've added into mach-kirkwood/common.c:
> 
> +       orion_clkdev_add(NULL, "f4000000.nand", runit);

Although this works, its the wrong way to do it. Jamie Lentin figured
out the right way to do this. Jamie, care to explain please...

> The bonus question is that while debugging this issue, I've disabled
> all nand declarations in kirkwood.dtsi and my localy modified
> kirkwood-iconnect.dts but I was still getting a hard freeze. I think
> that means that the "runit" clock is doing more than NAND and SPI but
> I've found no details in the 6281 manual about what's using this
> clock.

Yes, i found the same. I tried extending the SPI driver so that it
turned the clock off between transfers. Hard crash like you. I suspect
i might have to mark this clock as not to be turned off when unused.

  Andrew
