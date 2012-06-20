From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 20 Jun 2012 07:43:14 +0200
Subject: Dove clock support
In-Reply-To: <20120619230610.GA3210@schnuecks.de>
References: <4FDEDEAE.30502@blackshift.org> <20120618080449.GK4799@lunn.ch>
 <4FDEE6C6.2060101@blackshift.org> <20120618084300.GL4799@lunn.ch>
 <20120618214143.GA20040@schnuecks.de>
 <4FDFA748.10905@googlemail.com> <20120619193251.GR26034@lunn.ch>
 <20120619204210.GA18128@schnuecks.de>
 <4FE0E753.3010105@googlemail.com>
 <20120619230610.GA3210@schnuecks.de>
Message-ID: <20120620054314.GC28139@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 20, 2012 at 01:06:10AM +0200, Simon Baatz wrote:
> On Tue, Jun 19, 2012 at 10:55:47PM +0200, Sebastian Hesselbarh wrote:
> > On 06/19/2012 10:42 PM, Simon Baatz wrote:
> > >Should we make this symmetric and add an enable function to gate_fn?
> > 
> > I also thought about that issue and I think that as long as PHY is
> > controlled by controller specific registers it should be handled
> > by the driver and not by common clock framework.
> > 
> > This is true for SATA and PCIe and will also remove the need for
> > gate_fn - as long as it doen't break other orion-based SoCs. ...
> 
> If PHY control is part of the driver, where do we turn off PHYs that
> are on by default and that we don't use?
> 
> Don't we still need something like gate_fn or the clk gate/phy gate
> parent/child mechanism you propose?

Hi Simon

This is the interesting part to the puzzle.

Probably the correct way for the driver to turn the PHY clk on/off is
via PM runtime functions. This interface should allow a good level of
abstraction such that Dove can do what it needs, while one older
devices, which do not require anything will just have a NOP.

The problem with runtime PM functions is that you need a device
structure. However, when turning off unused clks at boot, it is unused
because we don't have a device driver using the hardware and hence
there is no device structure we can pass to the runtime PM functions.
The same applies for device where there is a kernel module for the
hardware, but it has not been loaded yet.

We probably need both, the extended gate_fn to turn off unused
hardware, and runtime pm to control used hardware.

      Andrew
