From: balbi@ti.com (Felipe Balbi)
Date: Thu, 25 Sep 2014 09:09:55 -0500
Subject: [PATCH v6 07/12] usb: chipidea: add a usb2 driver for ci13xxx
In-Reply-To: <2990737.4KzKXPZhaB@wuerfel>
References: <1411468088-5702-1-git-send-email-antoine.tenart@free-electrons.com>
 <62705234.gKJDtUQLyT@wuerfel> <20140924022736.GA5307@peterchendt>
 <2990737.4KzKXPZhaB@wuerfel>
Message-ID: <20140925140955.GB28045@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Sep 24, 2014 at 09:44:19AM +0200, Arnd Bergmann wrote:
> > It is a good suggestion for adding DT support for core driver, Since we did
> > not do it at the first, it is a little embarrass at current situation.
> > 
> > - For the new chipidea glue drivers, it is ok we can have a child node
> > for core device at glue device node, and some common entries can be there
> > like: phy, vbus, dr_mode, etc. We need to add support for getting
> > these common things for both through device tree and platform data
> > (parent is DT support and parent is non-DT support) at core driver.
> 
> I don't really want to see the child devices show up in DT, as this is
> really an implementation detail of the way that the driver currently works,
> and IMHO we should change that.
> 
> I know that Felipe disagrees with me on this, but almost every other
> driver that has soc-specific specializations does not use parent/child
> nodes, neither in DT nor in Linux. Instead you have a single device
> node that gets distinguished by "compatible" string.

I have two answers for this:

1) We need to let different buses use the same device. The same IP can
be used on PCI, platform, OMAP (yes, OMAP is pretty much a bus, even
though we're using platform-bus with a bunch of code to match things),
AMBA, etc.

2) I like to mode the HW in code and if you look into RTL you'll see
that PCIe, OMAP, QCOM, Exynos, etc, take a semi-bus-agnostic core IP and
write a wrapper IP to make it fit into the SoC. That Wrapper is also an
IP of its own and has its own clocks, sometimes its own IRQs. Not to
mention that PM requirements for different architectures might be (and
actually are) different, while PM requirements for the core IP is
"generic" because it comes from IP provider.

By using a parent device, we can hide all platform-/bus-specific details
on the parent driver and keep core driver "pristine". I see many, many
benefits of doing things this way and many of the benefits are already
cooked into the driver model itself, so why not use it ?

> > - For the existing glue drivers, since we can't change existed dts, we can
> > only do it from future SoC support. Then, in this kinds of glue drivers,
> > we need to support for both create core driver by node and by current
> > calling platform_device_add way.
> 
> We should be able to easily change the ci_hdrc_add_device call into
> a different exported function that calls a version of the probe()
> code directly, as we do in all sorts of other drivers (ehci, ohci,
> dwc2, ..., but not dwc3 and musb as they are maintained by Felipe).

Go back a few commits and you'll see EHCI couldn't even be built with
different glues (say ehci-omap and ehci-pci).

> We can also gradually move in some of the other glue drivers into
> the main driver if the differences are small enough.

you'll end up with a bunch of conflicting requirements very soon. In
fact that's one reason for MUSB being a mess. It was, originally, a
single driver with platform-specific glue chosen in build-time. To this
day, we still can't have different DMA glues on the kernel and
TUSB6010-glue doesn't work with anybody else.

When you have a single driver like that, you end up accepting
platform-specific details into the core IP just because the changes are
small enough.

> Moving the PCI driver over to this model requires a little more
> work but is absolutely doable (again, see ehci, ahci, sdhci examples)
> by moving the platform_device handling out of core.c and changing
> it just operate on the plain 'struct device', with an exported
> probe function that gets called on either the platform device
> or the pci device.

sounds like a disaster waiting to happen for me.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140925/884ce1f4/attachment.sig>
