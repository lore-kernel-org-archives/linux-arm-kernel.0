From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 16 Nov 2014 13:34:46 +0100
Subject: Bug in clk_mux_set_parent for CLK_MUX_INDEX_BIT muxes ?
Message-ID: <546899E6.6040306@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

While looking at what I believe is a bug in the sunxi gmac clk code
(more on that later), I believe I've also found a bug in

clk_mux_set_parent for the CLK_MUX_INDEX_BIT case.

AFAIK if CLK_MUX_INDEX_BIT is set, then each bit turns
on / off a single parent, so theoretically multiple
parents could be enabled at the same time, but in practice
only one bit should ever be 1. So to select parent 0, set
the register (*) to 0x01, to select parent 1 set it 0x02,
parent 2, 0x04, parent 3, 0x08, etc.

Correct ?

Assuming I got that right, then this bit of code in
clk_mux_set_parent is wrong:

                if (mux->flags & CLK_MUX_INDEX_BIT)
                        index = (1 << ffs(index));

For an input index of 0, ffs returns 0, so we set the register
to 0x01, ok.

For an input index of 1, ffs returns 1, so we set the register
to 0x02, ok.

For an input index of 2, ffs returns 2, so we set the register
to 0x04, ok.

For an input index of 3, ffs returns 1, so we set the register
to 0x02, not good!

I believe this code should simply be:

                if (mux->flags & CLK_MUX_INDEX_BIT)
                        index = 1 << index;

I guess we've been getting away by this because the input index
so far has never gotten above 2.

If I'm right about this, I can whip up a patch to fix this. Note
I don't really have hardware to properly exercise this code-path
AFAIK.

Regards,

Hans


*) This assumes a shift of 0
