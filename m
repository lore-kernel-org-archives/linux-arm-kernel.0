From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 19 Jun 2012 21:25:18 +0200
Subject: Dove clock support
In-Reply-To: <4FDF91D1.1040301@googlemail.com>
References: <20120618074258.GI4799@lunn.ch> <4FDEDEAE.30502@blackshift.org>
 <20120618080449.GK4799@lunn.ch> <4FDEE6C6.2060101@blackshift.org>
 <20120618084300.GL4799@lunn.ch> <4FDEF7E9.4030504@googlemail.com>
 <4FDEFAE2.7000303@blackshift.org> <4FDEFC6A.7030300@googlemail.com>
 <20120618101100.GN4799@lunn.ch> <4FDF91D1.1040301@googlemail.com>
Message-ID: <20120619192518.GQ26034@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 18, 2012 at 10:38:41PM +0200, Sebastian Hesselbarh wrote:
> On 06/18/2012 12:11 PM, Andrew Lunn wrote:
> >> But I'd prefer the driver to take care of clks _and_ PHYs.
> >
> > That would be nice, but we have to remember that the driver is used
> > for a number of different Marvell SoC and discreet devices. Only a few
> > have the ability to turn on/off there clocks and PHYs. So you need to
> > abstract this in such a way it does not break older chipsets.
> 
> Well, I'd suggest to find a good name for clk and PHY, e.g.
> "pcie.0","clk" and "pcie.0","phy", and let the driver decide if it
> enables/disables clk/PHY when it gets a valid struct clk back.
> 
> Although struct clk is meant for clocks there is no difference
> between clocks and PHYs. Moreover, dove handles PHY control in
> it's clock control register sometimes. (Well, it is maybe external
> clock to PHY so it's ok)
> 
> But first I suggest to have a drivers/clk/clk-orion (which I have
> somehow) and I already sent you a proposal some weeks ago.
> 
> I wasn't sure how to hook up drivers/clk/clk-orion with the platform
> itself but now that there are some other clock drivers available I'll
> have another look.
> 
> I have the datasheets for dove and kirkwood but with other orion-based
> platforms I cannot tell the differences. Maybe someone can comment on
> the different other platforms.
> 
> >> One more: I suggest to clean the clk names of orion platforms,
> >> they are a mess
> >
> > Do you have a proposal?

Hi Sebastian

> Hmm, well if you look at mach-kirkwood/common.c there is:
> - orion_spi.0/NULL (underscore)
> - orion-ehci.0/NULL (dash)
> - pcie/0
> - kirkwood-i2s/NULL
> 
> First, I suggest to choose either underscore or dash. Second, pcie/0
> should be kirkwood-pcie.0/NULL (or orion-pcie.0) and if we consider
> having PHY "clocks" it should be kirkwood-pcie.0/clk.

Are you aware these names are not free choice.

The code does:

 hpriv->clk = clk_get(&pdev->dev, NULL);

meaning the name needs to match the name in the platform device
structure. This platform device structure is created in
plat-orion/common.c. The driver also uses this name in its
platform_driver structure. Boards which make use of device tree will
also use this name in the auxdata to translate the DT name.

So, it would be nice to have uniform names, but it is a lot of work.

    Andrew
