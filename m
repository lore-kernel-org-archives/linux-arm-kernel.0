From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 3 Jul 2012 15:43:25 +0100
Subject: [PATCH 1/1] mfd: Fix runtime warning caused by duplicate device
 registration
In-Reply-To: <201207031401.36262.arnd@arndb.de>
References: <1341316788-12730-1-git-send-email-lee.jones@linaro.org>
 <4FF2EEA1.6080204@linaro.org>
 <20120703132447.GN29030@opensource.wolfsonmicro.com>
 <201207031401.36262.arnd@arndb.de>
Message-ID: <20120703144325.GR29030@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 03, 2012 at 02:01:35PM +0000, Arnd Bergmann wrote:
> On Tuesday 03 July 2012, Mark Brown wrote:

> > I'm really unconvinced that instnatiating the MFD cells from device tree
> > is in general a good idea.

> In general it's not, e.g. it makes no sense when the MFD is just
> a bunch of registers that are mapped to various distinct Linux
> devices. The two mfd devices on ux500 (prcmu and ab8500) are really
> buses by themselves that happen to be implemented using the MFD
> framework on Linux.

This is true for pretty much all MFDs except the pure MMIO ones.

> I don't see how we would get around representing the buses in
> the device tree because we have to refer to nodes under them
> from off-chip devices. Simplified we have something like

We can always refer to the parent device itself; there's two separate
things going on here which we can resolve separately.  One is
instantiating the children and the other is referencing the various
configuration that's needed which we don't need to do by mapping MFD
cells directly onto device tree nodes.  The MFD children can always look
at the DT bindings of their parents.

> Most of the stuff on the board is connected to the ab8500 regulators and
> gpio pins, which are also used as interrupts. In order to hook up
> the external devices in the device tree, we need to have something that
> we can point to as their interrupt-parent or the phandle in the gpio
> description.

Right, but there's no reason we have to instantiate a dedicated node for
each of these things and we should think carefully about what we're
doing.  One of the problems I've seen with people doing this stuff is
that the split we do for some of the cells in Linux is often not really
a good generic representation of the hardware (and some of them are actually
churning right now) so encoding it in the device tree isn't so helpful.
You also seem to get stuff where the MFD cells are all full of hard
coding for their parent so there's no way you could reuse them and again
we don't gain anything.

There will be some places where representing things directly in the DT
makes sense but we should think carefully before we go and do it.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120703/058ad2f7/attachment.sig>
