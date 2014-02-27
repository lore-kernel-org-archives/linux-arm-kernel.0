From: robdclark@gmail.com (Rob Clark)
Date: Thu, 27 Feb 2014 08:23:26 -0500
Subject: [RFC PATCH v4 3/8] staging: imx-drm: Document updated imx-drm
 device tree bindings
In-Reply-To: <20140227130020.GJ21483@n2100.arm.linux.org.uk>
References: <1393338203-25051-1-git-send-email-p.zabel@pengutronix.de>
 <1393338203-25051-4-git-send-email-p.zabel@pengutronix.de>
 <530F1C4C.2010504@ti.com>
 <1393506385.4507.49.camel@paszta.hi.pengutronix.de>
 <20140227130020.GJ21483@n2100.arm.linux.org.uk>
Message-ID: <CAF6AEGs7P0quj50pkGLNcCrZzkJDyim+_=bCE5O5zGsZWSnAaA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 27, 2014 at 8:00 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
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

I agree with Russell here, purely hw description is not always going
to be enough information to know how to assemble a bag of parts into a
system.

Maybe there is some way we should be splitting this "meta" description
into different dt files or something like this (?) to make it easier
for alternative configurations, but if the hw description alone is not
enough information for the drivers to know what to do, some (for lack
of a better word) "use-case" configuration is needed, and that has to
go *somewhere*... better to put it in DT than hard code it in the
driver.

BR,
-R

> On the face of it, the top-level super-device node doesn't look very
> hardware-y, but it actually is - it's about how a board uses the
> hardware provided.  This is entirely in keeping with the spirit of DT,
> which is to describe what hardware is present and how it's connected
> together, whether it be at the chip or board level.
>
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
>
> Before anyone argues against "it isn't hardware-y", stop and think.
> What if I design a board with two Epson LCD controllers on board and
> put a muxing arrangement on their output.  Is that one or two devices?
> What if I want them to operate as one combined system?  What if I have
> two different LCD controllers on a board.  How is this any different
> from the two independent IPU hardware blocks integrated inside an iMX6
> SoC with a muxing arrangement on their output?
>
> It's very easy to look at a SoC and make the wrong decision...
>
> --
> FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
> improving, and getting towards what was expected from it.
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/dri-devel
