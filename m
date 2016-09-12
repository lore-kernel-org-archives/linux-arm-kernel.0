From: robh@kernel.org (Rob Herring)
Date: Mon, 12 Sep 2016 09:05:52 -0500
Subject: [linux-sunxi] Re: [RFC] misc: Add Allwinner Q8 tablet hardware
 manager
In-Reply-To: <268244d0-55c3-167d-a70f-0e35e6b3dae6@redhat.com>
References: <20160901190820.21987-1-hdegoede@redhat.com>
 <20160901190820.21987-2-hdegoede@redhat.com>
 <CAL_JsqLGS23JQxtdtUqNhkhDiV4mnKSBpMjdo4fx0=wuq_ydeg@mail.gmail.com>
 <268244d0-55c3-167d-a70f-0e35e6b3dae6@redhat.com>
Message-ID: <20160912140552.GA30379@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 10, 2016 at 08:12:32PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 09-09-16 23:41, Rob Herring wrote:
> >On Thu, Sep 1, 2016 at 2:08 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> >>Allwinnner A13 / A23 / A33 based Q8 tablets are popular cheap 7" tablets
> >>of which a new batch is produced every few weeks. Each batch uses a
> >>different mix of touchscreen, accelerometer and wifi peripherals.
> >>
> >>Given that each batch is different creating a devicetree for each variant
> >>is not desirable. This commit adds a Q8 tablet hardware manager which
> >>auto-detects the touchscreen and accelerometer so that a single generic
> >>dts can be used for these tablets.
> >>
> >>The wifi is connected to a discoverable bus (sdio or usb) and will be
> >>autodetected by the mmc resp. usb subsystems.
> >>
> >>Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> >>---
> >> .../misc/allwinner,sunxi-q8-hardwaremgr.txt        |  52 +++
> >> drivers/misc/Kconfig                               |  12 +
> >> drivers/misc/Makefile                              |   1 +
> >> drivers/misc/q8-hardwaremgr.c                      | 512 +++++++++++++++++++++
> >> 4 files changed, 577 insertions(+)
> >> create mode 100644 Documentation/devicetree/bindings/misc/allwinner,sunxi-q8-hardwaremgr.txt
> >> create mode 100644 drivers/misc/q8-hardwaremgr.c
> >>
> >>diff --git a/Documentation/devicetree/bindings/misc/allwinner,sunxi-q8-hardwaremgr.txt b/Documentation/devicetree/bindings/misc/allwinner,sunxi-q8-hardwaremgr.txt
> >>new file mode 100644
> >>index 0000000..f428bf5
> >>--- /dev/null
> >>+++ b/Documentation/devicetree/bindings/misc/allwinner,sunxi-q8-hardwaremgr.txt
> >>@@ -0,0 +1,52 @@
> >>+Q8 tablet hardware manager
> >>+--------------------------
> >>+
> >>+Allwinnner A13 / A23 / A33 based Q8 tablets are popular cheap 7" tablets of
> >>+which a new batch is produced every few weeks. Each batch uses a different
> >>+mix of touchscreen, accelerometer and wifi peripherals.
> >>+
> >>+Given that each batch is different creating a devicetree for each variant is
> >>+not desirable. The Q8 tablet hardware manager bindings are bindings for an os
> >>+module which auto-detects the touchscreen so that a single
> >>+generic dts can be used for these tablets.
> >>+
> >>+The wifi is connected to a discoverable bus and will be autodetected by the os.
> >>+
> >>+Required properties:
> >>+ - compatible         : "allwinner,sunxi-q8-hardwaremgr"
> >>+ - touchscreen        : phandle of a template touchscreen node, this must be a
> >>+                       child node of the touchscreen i2c bus
> >>+
> >>+Optional properties:
> >>+ - touchscreen-supply : regulator phandle for the touchscreen vdd supply
> >
> >While I said I think you should be using overlays here, you could also
> >do it without.
> 
> Good, because I believe that doing things without overlays will
> be much easier. If you look at the actual implementation you will
> see that it sets a lot of properties (touchscreen width, height,
> inversion, axis-swapping, firmware-name) based on various sources,
> the explosion of possible overlays from this is huge, and if
> we're going to runtime patch the overlays then why use them at all
> and not just runtime generate all the info ?

That's fine if run-time makes more sense. I'd just like to move in the 
direction of applying a hunk of changes rather than C code creating 
nodes and properties one-by-one.
 
> >However, this node has to go. It is not h/w, and you
> >are putting it here purely to instantiate a driver.
> 
> With "this" in "this node has to go", do you mean the node
> with the "allwinner,sunxi-q8-hardwaremgr" compatible, or
> do you mean the touchscreen template node ?

Given that this binding section above is concerning 
allwinner,sunxi-q8-hardwaremgr, that is what I'm referring to.

> 
> >For the
> >touchscreen property, surely you know where the touchscreen is located
> >in the DT?
> 
> Nope q8 tablets come with A13, A23 or A33 SoCs, A23/A33 are pin
> compatible with each other, but the A13 is not, this leads to
> the touchscreen being on a different i2c bus, so I cannot hardcode
> things, likewise the power-gpios and interrupt found in the
> touchscreen node differ between the A13 vs A23/A33.

Either the touchscreen node name is "touchscreen" or you can have 
compatible string for q8-touchscreen and use of_find_node_by_name or 
of_find_compatible_node. Doesn't matter what bus it is on. It only 
requires that there is only 1 node.

> I actually had a touchscreen-i2c-bus property containing a
> phandle to the i2c controller for the bus which has the
> touchscreen in an earlier revision + touchscreen-gpios
> and touchscreen-supply properties, I can switch to that
> if you prefer that over having a touchscreen template node.
> 
> > If not, of_find_node_by_name()?
> 
> Still a bit confused about what you do not like,
> (touchscreen template node vs q8-hardwaremgr node).
> 
> I guess (based on context) you do not want the
> q8-hardwaremgr node ?
> 
> So the q8-hardwaremgr code should activate based on
> the machine compatible I presume? 

Either that, or if you have the board specific compatible in the 
touchscreen node, then you could have a driver for it. That driver would 
need to probe the device and then create the "real" device.
 
> How does that
> work with module autoloading ?

Can't non-DT based platform drivers do autoloading? Regardless, not 
really my problem from a binding perspective.

> If you do not want the q8-hardwaremgr node and thus
> no touchscreen property them yes I can use
> of_find_node_by_name(), but I thought that was
> generally frowned up on?

Generally we do prefer finding things by compatible strings. But there 
are exceptions and doing fix-ups like this is a good example.

> >For touchscreen-supply, I
> >assume this is to turn on the supply so you can talk to the touch
> >controller. There's no reason the supply can't just be in the
> >touchscreen node itself.
> 
> Only a few q8 tablets actually use the regulator, so
> the hardwaremgr first tries detecting the touchscreen
> without it, and only if it does not find anything then
> tries with it, and adds a property to the touchscreen
> node for it, but I guess I can do this other way
> around and have it be present in the (incomplete /
> template) touchscreen node and delete it from it if
> not necessary.

Right.

Rob
