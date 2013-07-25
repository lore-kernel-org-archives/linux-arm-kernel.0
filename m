From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Thu, 25 Jul 2013 09:40:01 +0300
Subject: OMAP2430 SDP boot broken after Linus' rmk merge
In-Reply-To: <20130724145237.GB21614@n2100.arm.linux.org.uk>
References: <alpine.DEB.2.02.1307221801110.10891@utopia.booyaka.com>
 <20130722184325.GA21614@n2100.arm.linux.org.uk>
 <alpine.DEB.2.02.1307222005370.26048@utopia.booyaka.com>
 <51EE2AA7.5060503@ti.com>
 <alpine.DEB.2.02.1307230705000.27017@utopia.booyaka.com>
 <51EE474D.5070804@ti.com> <20130724135617.GI11072@mudshark.cambridge.arm.com>
 <51EFE1DD.8070801@ti.com> <20130724145237.GB21614@n2100.arm.linux.org.uk>
Message-ID: <51F0C841.8000900@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/07/13 17:52, Russell King - ARM Linux wrote:

> I also continue to be disappointed by the lack of things working on the
> 4430 - it's been a number of years now and _still_ the on-board LCDs do
> not work.  People have tried to blame that on hardware faults and the
> like, but they're just being idiotic when they say stuff like that.  It
> can't be hardware faults when the kernel supplied with the board is able
> to make them work to the extent that userspace can play back video on all
> three output devices simultaneously, without hiccup or any imperfection.
> I don't know whether it's just that the backlight support isn't working
> or what - because any information on the 4430 seems to be a tightly
> controlled secret that only a few select people are permitted to know
> about.  As far as I'm concerned, much of the hardware is a black box to
> me.

The 4430SDP's backlight hasn't been working in the mainline due to
missing support from the TWL driver. But we finally did get that in for
3.10 (or maybe 3.9), and booting 3.10 non-DT kernel brings up the
backlights. However, the BL doesn't work yet with DT boot, so again with
3.11, with no board files, the BL is out... Sigh.

The panel driver itself have been working as long as it has been in the
mainline kernel (for me). I think there was a mixup at some point with
pinmuxing due to TRM having wrong information, but for some reason my
board works fine with both right and wrong muxing. If I recall right,
your board did not. But that's also solved some kernel versions ago.

But even with the above fixed, you could observe that your panel doesn't
work. The reason is that the panels in the 4430SDP board were chosen a
bit oddly: they are so called manual update panels, meant to be
explicitly updated by the software only when required. The phones that
have such panels (which, I guess, is what 4430SDP is designed to
resemble) have software doing that, but obviously the standard linux
software does not.

There's a hack to enable a non-optimal automatic update for testing
purposes:

echo 1 > /sys/class/graphics/fb0/update_mode

This makes omapfb update the display 20 times per second. Or via a
module parameter: omapfb.auto_update=y

We could implement a better auto-update system for manual-update panels,
but I have opted not to:

- It's not easy to implement efficiently and reliably (in fact, we did
have auto-update support at some point in the kernel, but it was removed
as it was rather troublesome to keep working).

- Manual-update panels are meant to be updated manually, only when
needed. That's the whole point of the manual-update feature. Doing
auto-update with a manual-update panel is inefficient. So such a feature
would only be useful for testing purposes.

- Manual-update panels are quite rare, and the trend to use them seems
to be coming even rarer.

> And yes, my 4430 has the projector module on it.  Never ever seen that
> work, and no idea how to make it work because there's no information
> available on the hardware.

I don't have that one. PicoDLP shares resources (DSS pins, at least, if
I recall right, and some power line) with the second LCD, and we don't
have support to manage sharing those resources. So the PicoDLP is left
disabled in the board file.

I don't have any clear idea how to implement management of those
resources, and no one has ever asked about PicoDLP from me, so it's
never been a very high priority.

So 4430SDP is a bit difficult on the display side: non-standard panels
and a pico projector that is mutually exclusive with the LCD2.

> And no, I don't want another Beagle board or Panda board or whatever, I
> have those (I think I have one of each), and they've never been powered up
> because they have no ethernet on them, and I have no USB to ethernet still,
> partly because I don't really do USB here *at* *all*, so I don't know what
> works well and what doesn't with Linux.  Even if I did provide them with a
> USB ethernet, I doubt they'd be able to boot a kernel via the network.

Beagle xM and Panda have ethernet. I boot Panda via the network (load
kernel and use nfsroot). But they don't have panels, so you need an
external display for those.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130725/b7d54168/attachment.sig>
