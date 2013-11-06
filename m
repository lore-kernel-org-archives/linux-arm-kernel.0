From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 6 Nov 2013 12:50:15 -0700
Subject: address translation for PCIe-to-localbus bridge
In-Reply-To: <20246965-EEE8-4EF0-A632-0633774A572A@antoniou-consulting.com>
References: <527A1983.6020603@keymile.com>
 <20131106173649.GA25515@obsidianresearch.com>
 <20131106190308.01f7a4a9@skate>
 <334037D0-02FB-459F-9E40-129EC830AF65@antoniou-consulting.com>
 <20131106185658.GC25879@obsidianresearch.com>
 <20246965-EEE8-4EF0-A632-0633774A572A@antoniou-consulting.com>
Message-ID: <20131106195015.GA26881@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 06, 2013 at 09:16:13PM +0200, Pantelis Antoniou wrote:
> > Your camera driver attaches to the 'my device' node, not to the chip
> > select node. The chip select node is used only by the bus bridge
> > driver to setup that specific chip select.
> 
> No. I get the point about the bridge driver, but that's not what I want.
> 
> I agree that the bridge driver configures the chip selects, address ranges
> and timings, but it shouldn't do that at the time the bridge driver is
> instantiated. 

But that is normal Linux behavior. The bus driver controls the bus,
and it takes control when it is instantiated.

> That would mean that all configuration is fixed at boot time.

No, it means at boot time the configuration data in the DT is
programmed into the hardware at boot time.

If you hotplug the environment later during run time then you have to
notify the bridge driver and have it make whatever changes. This is no
different than PCI which requires notifying the PCI layer to have it
reprogram bridge devices.

This is why the nodes must be under the bridge, only the bridge knows
when it is safe to create struct device's for the children.

> All the drivers that are controlled by a chip select and/or bus
> access method are written without ever dealing with the bridge; they
> just expect the configuration to be valid and need to only know the
> address range they reside.

That is exactly what my example is showing. The driver has no idea
about the bridge. Ezequiel's MVEBU version does this today, IIRC, he
has the standard every day memory mapped NOR driver working as a node
under the bridge, with full configurability, and no changes to the NOR
driver.

> As you pointed the i2c component, which was a child of the device
> node, it is better to become a phandle reference.

Again, the DT parent/child reflects bus ownership/address
translation.

It is incorrect to put an i2c device below any node other than the i2c
bus it is attached to.

> That's what I'm proposing for the bridge configuration as well, so
> that the configuration is applied only when a device requests
> it. This is important for hot-plugging, and or when using stuff like
> device overlays.

If there is no children to a chip select then the bridge can leave it
turned off and keep address space deallocated.

The bridge driver simply has to be involved in the hot plug process,
which is again normal in Linux.

Device tree overlays provide a mechanism to create new chip select
nodes under the bridge, I don't see the problem you do :)

Jason
