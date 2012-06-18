From: sebastian.hesselbarth@googlemail.com (Sebastian Hesselbarh)
Date: Mon, 18 Jun 2012 22:38:41 +0200
Subject: Dove clock support
In-Reply-To: <20120618101100.GN4799@lunn.ch>
References: <1339978054-8464-1-git-send-email-mkl@blackshift.org>
 <20120618074258.GI4799@lunn.ch> <4FDEDEAE.30502@blackshift.org>
 <20120618080449.GK4799@lunn.ch> <4FDEE6C6.2060101@blackshift.org>
 <20120618084300.GL4799@lunn.ch> <4FDEF7E9.4030504@googlemail.com>
 <4FDEFAE2.7000303@blackshift.org> <4FDEFC6A.7030300@googlemail.com>
 <20120618101100.GN4799@lunn.ch>
Message-ID: <4FDF91D1.1040301@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/18/2012 12:11 PM, Andrew Lunn wrote:
 >> But I'd prefer the driver to take care of clks _and_ PHYs.
 >
 > That would be nice, but we have to remember that the driver is used
 > for a number of different Marvell SoC and discreet devices. Only a few
 > have the ability to turn on/off there clocks and PHYs. So you need to
 > abstract this in such a way it does not break older chipsets.

Well, I'd suggest to find a good name for clk and PHY, e.g.
"pcie.0","clk" and "pcie.0","phy", and let the driver decide if it
enables/disables clk/PHY when it gets a valid struct clk back.

Although struct clk is meant for clocks there is no difference
between clocks and PHYs. Moreover, dove handles PHY control in
it's clock control register sometimes. (Well, it is maybe external
clock to PHY so it's ok)

But first I suggest to have a drivers/clk/clk-orion (which I have
somehow) and I already sent you a proposal some weeks ago.

I wasn't sure how to hook up drivers/clk/clk-orion with the platform
itself but now that there are some other clock drivers available I'll
have another look.

I have the datasheets for dove and kirkwood but with other orion-based
platforms I cannot tell the differences. Maybe someone can comment on
the different other platforms.

 >> One more: I suggest to clean the clk names of orion platforms,
 >> they are a mess
 >
 > Do you have a proposal?

Hmm, well if you look at mach-kirkwood/common.c there is:
- orion_spi.0/NULL (underscore)
- orion-ehci.0/NULL (dash)
- pcie/0
- kirkwood-i2s/NULL

First, I suggest to choose either underscore or dash. Second, pcie/0
should be kirkwood-pcie.0/NULL (or orion-pcie.0) and if we consider
having PHY "clocks" it should be kirkwood-pcie.0/clk.

With kirkwood-i2s/NULL there is mach-dove that has two i2s controllers
so it should be kirkwood-i2s.0. Moreover, the i2s controller can have
an external clk instead of internal clock divider, so the clock names
should be kirkwood-i2s.0/clk and kirkwood-i2s.0/extclk.

With external i2s clock it _could_ be possible to have high bitrate
audio on spdif by overclocking the i2s controller.

Sebastian
