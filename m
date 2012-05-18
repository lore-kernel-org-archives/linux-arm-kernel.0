From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Fri, 18 May 2012 11:50:42 +0200
Subject: kirkwood, nand, clocks and device-tree
Message-ID: <87fwaxes25.fsf@lebrac.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I wanted to convert iconnect to use the new nand DT support on kirkwood
but my system was freezing hard during boot. So, I've debugged it a
little bit and have several questions.

The first one is about were is defined the nand. It's defined as a leaf
of the "ocp" bus. I would have expected to see it at the same level but
I've seen nothing proving if it's wrong or right when comparing with
hardware. Can anyone give me some information about that ?

Now, the real questions about my problem. It's hanging because the nand
platform device created throught DT is called f4000000.nand and not
orion_nand. This means that the clock gets disabled by
clk_disable_unused() so first access to the nand fails badly.
To workaround, I've added into mach-kirkwood/common.c:

+       orion_clkdev_add(NULL, "f4000000.nand", runit);


So the clock stays enabled and my system is booting. Would a patch
doing that would be accepted or would it be better to add a "orion_nand"
id so that one can get the clock either with the device or with the id,
avoiding to add extra clocks for each SoC ?

The bonus question is that while debugging this issue, I've disabled
all nand declarations in kirkwood.dtsi and my localy modified
kirkwood-iconnect.dts but I was still getting a hard freeze. I think
that means that the "runit" clock is doing more than NAND and SPI but
I've found no details in the 6281 manual about what's using this
clock. Again, does someone have more details about this (which would
explain why disabling this runit clock will freeze my system) ?

Thanks,
Arnaud
