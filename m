From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Thu, 27 Feb 2014 15:55:05 +0200
Subject: [RFC PATCH v4 3/8] staging: imx-drm: Document updated imx-drm
 device tree bindings
In-Reply-To: <20140227130020.GJ21483@n2100.arm.linux.org.uk>
References: <1393338203-25051-1-git-send-email-p.zabel@pengutronix.de>
 <1393338203-25051-4-git-send-email-p.zabel@pengutronix.de>
 <530F1C4C.2010504@ti.com> <1393506385.4507.49.camel@paszta.hi.pengutronix.de>
 <20140227130020.GJ21483@n2100.arm.linux.org.uk>
Message-ID: <530F43B9.800@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/02/14 15:00, Russell King - ARM Linux wrote:
> On Thu, Feb 27, 2014 at 02:06:25PM +0100, Philipp Zabel wrote:
>> For the i.MX6 display subsystem there is no clear single master device,
>> and the physical configuration changes across the SoC family. The
>> i.MX6Q/i.MX6D SoCs have two separate display controller devices IPU1 and
>> IPU2, with two output ports each.
> 
> Not also forgetting that there's another scenario too: you may wish
> to drive IPU1 and IPU2 as two completely separate display subsystems
> in some hardware, but as a combined display subsystem in others.
> 
> Here's another scenario.  You may have these two IPUs on the SoC, but
> there's only one display output.  You want to leave the second IPU
> disabled, as you wouldn't want it to be probed or even exposed to
> userland.

I first want to say I don't see anything wrong with such a super node.
As you say, it does describe hardware. But I also want to say that I
still don't see a need for it. Or, maybe more exactly, I don't see a
need for it in general. Maybe there are certain cases where two devices
has to be controlled by a master device. Maybe this one is one of those.

In the imx case, why wouldn't this work, without any master node, with
the IPU nodes separate in the DT data:

- One IPU enabled, one disabled: nothing special here, just set the
other IPU to status="disabled" in the DT data. The driver for the
enabled IPU would register the required DRM entities.

- Two IPUs as separate units: almost the same as above, but both would
independently register the DRM entities.

- Two IPUs in combined mode:

Pick one IPU as the master, and one as slave. Link the IPU nodes in DT
data with phandles, say: master=<&ipu1> on the slave IPU and
slave=<&ipu0> on the master.

The master one will register the DRM entities, and the slave one will
just do what the master says.

As for the probe time "are we ready yet?" problem, the IPU driver can
just delay registering the DRM entities until all the nodes in its graph
have been probed. The component helpers can probably be used here.

> On the face of it, the top-level super-device node doesn't look very
> hardware-y, but it actually is - it's about how a board uses the
> hardware provided.  This is entirely in keeping with the spirit of DT,
> which is to describe what hardware is present and how it's connected
> together, whether it be at the chip or board level.

No disagreement there. I'm mostly put off by the naming. The binding doc
says it's a "DRM master device", compatible with "fsl,imx-drm". Now,
naming may not be the most important thing in the world, but I'd rather
use generic terms, not linux driver stack names.

> If this wasn't the case, we wouldn't even attempt to describe what devices
> we have on which I2C buses - we'd just list the hardware on the board
> without giving any information about how it's wired together.
> 
> This is no different - however, it doesn't have (and shouldn't) be
> subsystem specific... but - and this is the challenge we then face - how
> do you decide that on one board with a single zImage kernel, with both
> DRM and fbdev built-in, whether to use the DRM interfaces or the fbdev
> interfaces?  We could have both matching the same compatible string, but
> we'd also need some way to tell each other that they're not allowed to
> bind.

Yes, that's an annoying problem, we have that on OMAP. It's a clear sign
that our video support is rather messed up.

My opinion is that the fbdev and drm drivers for a single hardware
should be exclusive at compile time. We don't allow multiple drivers for
single device for other subsystems either, do we? Eventually we should
have only one driver for one hardware device.

If that's not possible, then the drivers in question could have an
option to enable or disable themselves, passed via the kernel command
line, so that the user can select which subsystem to use.

> Before anyone argues against "it isn't hardware-y", stop and think.
> What if I design a board with two Epson LCD controllers on board and
> put a muxing arrangement on their output.  Is that one or two devices?
> What if I want them to operate as one combined system?  What if I have
> two different LCD controllers on a board.  How is this any different
> from the two independent IPU hardware blocks integrated inside an iMX6
> SoC with a muxing arrangement on their output?

Well, generally speaking, I think one option is to treat the two
controllers separately and let the userspace handle it. That may or may
not be viable, depending on the hardware, but to me it resembles very
much a PC with two video cards.

If you want the two controllers to operate together more closely, you
always need special code for that particular case.

This is what CDF has been trying to accomplish: individual drivers for
each display entity, connected together via ports and endpoints. Driver
for Epson LCD controller would expose an API, that can be used handle
the LCD controller, it wouldn't make any other demands on how it's used,
is it part of DRM or fbdev, what's before or after it, etc.

Now, and I think this was your point, some kind of master device/driver
is needed to register the required DRM or fbdev entities. Usually that
can be the driver for the SoCs display controller, i.e. the first
display entity in the display pipeline. Sometimes, if it's required to
have multiple devices act together, it may be a driver specifically
designed for that purpose.

So no, I don't have a problem with master device nodes in DT. I have a
problem having pure SW stack nomenclature in the DT data (or even worse,
SW stack entities in the DT data), and I have a problem requiring
everyone to have a master device node if it's only needed for special cases.

And yes, this series is about IMX bindings, not generic ones. And I'm
also fine with requiring everyone to have a master device node, if it
can be shown that it's the only sensible approach.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140227/d9b87663/attachment-0001.sig>
