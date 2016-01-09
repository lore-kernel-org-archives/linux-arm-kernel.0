From: hzpeterchen@gmail.com (Peter Chen)
Date: Sat, 9 Jan 2016 17:05:12 +0800
Subject: [RFC PATCH 1/2] USB: core: let USB device know device node
In-Reply-To: <CAL_JsqKwATxGiqJ_MNV6_pur1dUEVOzH+iB8yY+kWA0y2gWbNg@mail.gmail.com>
References: <1452231864-11171-1-git-send-email-peter.chen@freescale.com>
 <1452231864-11171-2-git-send-email-peter.chen@freescale.com>
 <CAL_JsqKwATxGiqJ_MNV6_pur1dUEVOzH+iB8yY+kWA0y2gWbNg@mail.gmail.com>
Message-ID: <20160109090512.GD27759@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 08, 2016 at 08:32:45AM -0600, Rob Herring wrote:
> On Thu, Jan 7, 2016 at 11:44 PM, Peter Chen <peter.chen@freescale.com> wrote:
> > Although most of USB devices are hot-plug's, there are still some devices
> > are hard wired on the board, eg, for HSIC and SSIC interface USB devices.
> > If these kinds of USB devices are multiple functions, and they can supply
> > other interfaces like i2c, gpios for other devices, we may need to
> > descirbe these at device tree.
> >
> > In this commit, it uses "reg" in dts as port number to match the port
> > number decided by USB core, if they are the same, then the device node
> > is for the device we are creating for USB core.
> >
> > Signed-off-by: Peter Chen <peter.chen@freescale.com>
> > ---
> >  .../devicetree/bindings/usb/usb-device.txt         |  8 ++++
> >  drivers/usb/core/Makefile                          |  2 +-
> >  drivers/usb/core/of.c                              | 48 ++++++++++++++++++++++
> >  drivers/usb/core/usb.c                             |  8 +++-
> >  include/linux/usb.h                                |  2 +
> >  include/linux/usb/of.h                             |  6 +++
> >  6 files changed, 71 insertions(+), 3 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/usb/usb-device.txt
> >  create mode 100644 drivers/usb/core/of.c
> >
> > diff --git a/Documentation/devicetree/bindings/usb/usb-device.txt b/Documentation/devicetree/bindings/usb/usb-device.txt
> > new file mode 100644
> > index 0000000..d35facd
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/usb/usb-device.txt
> > @@ -0,0 +1,8 @@
> > +Generic USB Device Properties
> > +
> > +Usually, we only use device tree for hard wired USB device.
> > +The reference binding doc is from:
> > +http://playground.sun.com/1275/bindings/usb/usb-1_0.ps.
> 
> This path doesn't exist anymore. Use
> http://www.firmware.org/1275/bindings/usb/usb-1_0.ps
> 

Ok.

> > +
> > +Required properties:
> > +- reg: the port number which this device is connecting to.
> 
> At least compatible should also be here.
> 

What format for USB device compatible string has still not been decided.
Would you suggest something? At my example, I use "vid,pid".

> > + */
> > +struct device_node *usb_of_find_node(struct device_node *parent, int portnum)
> > +{
> > +       struct device_node *node;
> > +       u32 port;
> > +
> > +       for_each_child_of_node(parent, node) {
> > +               if (!of_property_read_u32(node, "reg", &port)) {
> > +                       if (port == portnum)
> > +                               return node;
> 
> This needs to match on the compatible string too. Otherwise, this
> could match in lots of cases.
> 

No, the port number is unique under the USB HUB (including host
controller, which is roothub), and there are some many compatible
string for USB devices.

-- 

Best Regards,
Peter Chen
