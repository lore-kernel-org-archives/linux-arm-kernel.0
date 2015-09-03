From: treding@nvidia.com (Thierry Reding)
Date: Thu, 3 Sep 2015 11:39:12 +0200
Subject: [PATCH v3 2/2] drm: bridge/dw_hdmi: add dw hdmi i2c bus adapter
 support
In-Reply-To: <20150903091900.GX21084@n2100.arm.linux.org.uk>
References: <1440970470-7155-1-git-send-email-vladimir_zapolskiy@mentor.com>
 <CAD=FV=WvUp7xhsmXJgVzm1Awqej12hNF_QPJhrQq7z=Fa4Nnuw@mail.gmail.com>
 <20150902225008.GQ21084@n2100.arm.linux.org.uk>
 <CAD=FV=VuyQXNGt7dgF-YF7D7MDu31B-QuBdGpeC_+0b1F2=dKg@mail.gmail.com>
 <20150903091900.GX21084@n2100.arm.linux.org.uk>
Message-ID: <20150903093910.GA4151@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 03, 2015 at 10:19:00AM +0100, Russell King - ARM Linux wrote:
> On Wed, Sep 02, 2015 at 04:43:38PM -0700, Doug Anderson wrote:
> > Russell,
> > 
> > On Wed, Sep 2, 2015 at 3:50 PM, Russell King - ARM Linux
> > <linux@arm.linux.org.uk> wrote:
> > > Never copy the of_node from one device to another.  That allows the
> > > bus matching to unintentionally match the of_node against the wrong
> > > driver.
> > 
> > Can you be more specific about what problems you'd expect.  It seems
> > like a terribly common practice to do this, but maybe I'm
> > misunderstanding:
> 
> The problem with copying an of_node from one struct device to another
> struct device is of_match_device().
> 
> Devices in a DT setup are bound to drivers using dev->of_node - when a
> new device or driver is registered onto a bus, the new object is matched
> against all un-bound objects (devices or drivers as appropriate)
> comparing the compatible string gained from dev->of_node against the
> list of of_device_id strings provided by the driver.
> 
> When a match is found, the two are attempted to be bound together.
> 
> Consider what happens when you have a platform device with an of_node,
> and you bind that to a driver matched via the compatible string.  The
> driver creates a new platform device, and copies the of_node to this
> new device so the new device can have access to the properties of the
> of_node.
> 
> What happens next?  Does the new device bind to the same driver (and
> thus we enter an infinite loop) or does it bind to some other driver
> as the author originally hoped?  Depends whether the other driver is
> earlier in the list of drivers or later, whether it's in the kernel
> or not.
> 
> It's less of a problem when you copy the of_node between two different
> buses, because they won't match the same driver, but this is a dangerous
> act - if stuff copies it in one direction, what's to stop someone copying
> it back to a new device on the original bus.  As soon as that happens,
> things can go awol.
> 
> It would be a good idea if either:
> 1) this never happened
> or
> 2) we had a flag which said "ignore the of_node for driver matching"
> 
> And yes, we do have drivers which do exactly what I said above.  They
> work through luck rather than design.

Perhaps the I2C core needs to be taught to look at the adapter's
->dev.parent->of_node in of_find_i2c_adapter_by_node(). As I understand
it the purpose for registering a separate struct device for each I2C
controller is so that there's an I2C parent for all slaves. At the same
time every controller sets up ->dev.parent, and that parent's OF node is
what we really want when we look up an I2C adapter by OF node. In other
words, the OF node by which I2C adapters are referenced is always that
of its parent device, as far as I can tell.

Wolfram, do you know of any cases where adapter->dev.of_node would not
be the same as adapter->dev.parent->of_node?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150903/80388b69/attachment.sig>
