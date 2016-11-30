From: jernej.skrabec@gmail.com (Jernej =?utf-8?B?xaBrcmFiZWM=?=)
Date: Wed, 30 Nov 2016 21:41:26 +0100
Subject: [linux-sunxi] Re: [RFC PATCH] ARM: dts: sun8i: add simplefb node
 for H3
In-Reply-To: <20161130203724.a390595df0199ed19069f91d@free.fr>
References: <20161130220324.3Kg4VPEw@smtp1m.mail.yandex.net>
 <2717236.xBNAaGdqdc@jernej-laptop>
 <20161130203724.a390595df0199ed19069f91d@free.fr>
Message-ID: <185067972.ij8nq5Ea6J@jernej-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne sreda, 30. november 2016 ob 20:37:24 CET je Jean-Francois Moine 
napisal(a):
> On Wed, 30 Nov 2016 20:14:11 +0100
> 
> Jernej ?krabec <jernej.skrabec@gmail.com> wrote:
> > Dne ?etrtek, 01. december 2016 ob 03:03:14 CET je Icenowy Zheng 
napisal(a):
> > > 2016?12?1? 02:49? Jernej Skrabec <jernej.skrabec@gmail.com>???
> > > 
> > > > Hi Jean-Fran?ois,
> > > > 
> > > > Dne sreda, 30. november 2016 10.35.08 UTC+1 je oseba Jean-Fran?ois
> > > > Moine
> > 
> > napisala:
> > > >> On Tue, 29 Nov 2016 22:59:32 +0100
> > > >> 
> > > >> Maxime Ripard <maxime...@free-electrons.com> wrote:
> > > >> > > > I'm still not sure which pipeline should I use.
> > > >> > > > 
> > > >> > > > And, it seems that HDMI Slow Clock is not needed?
> > > >> > > > 
> > > >> > > > (seems that it's only for EDID, but simplefb won't use EDID)
> > > >> > > 
> > > >> > > So, I don't see how this may work.
> > > >> > > How can the u-boot know the resolutions of the HDMI display
> > > >> > > device?
> > > >> > > 
> > > >> > > In other words: I have a new H3 board with the last u-boot and
> > > >> > > kernel.
> > > >> > > I plug my (rather old or brand new) HDMI display device.
> > > >> > > After powering on the system, I hope to get something on the
> > > >> > > screen.
> > > >> > > How?
> > > >> > 
> > > >> > If it works like the driver for the first display engine in U-Boot,
> > > >> > it
> > > >> > will use the preferred mode reported by the EDID, and will fallback
> > > >> > to
> > > >> > 1024x768 if it cannot access it.
> > > >> 
> > > >> Icenowy wrote: "simplefb won't use EDID"
> > > >> 
> > > >> Then, if it is like in the kernel, the 1024x768 mode is VGA. It does
> > > >> not work with HDMI (different timings).
> > > > 
> > > > U-Boot driver now accept any timings recommended by EDID. So far it
> > > > was tested with at least following resolutions:
> > > > - 1920x1080 @ 60 Hz
> > > > - 1280x1024 @ 60 Hz
> > > > - 1280x800 @ 60 Hz (slight clock difference)
> > > > - 800x480 (not sure about frame rate)
> > > > - 3840x2160 @ 30 Hz (4K)
> > > 
> > > I tested on 1024x600 (If my memory is right, it's @ 60Hz)
> > > 
> > > > and nobody complained so far. I'm pretty sure 1024x768 would work.
> 
> Check the timings offered by the DRM core.

I'm not really familiar with DRM code, but my Linux laptop happily works with 
1024x768 @ 75 Hz and other non CEA resolutions through HDMI, so I guess it 
should be possible here too. Isn't function drm_add_edid_modes() designed 
exactly for that?

Anyway, this is off topic for simplefb. Simplefb driver will just take over 
framebuffer set up by U-Boot with some additional info like width, height, 
pitch... It doesn't have to deal with HW directly.

> 
> > > >> > Maybe it would be worth exchanging on the EDID code that has been
> > > >> > done
> > > >> > for the u-boot driver too, so that it can be fixed in your driver.
> > > >> 
> > > >> The u-boot got my code, and, up to now, I could not fix the random or
> > > >> permanent failures of EDID reading in some boards.
> > > > 
> > > > I only have one OPi2, but as I said, EDID always worked for me.
> 
> Happy guy!
> 
> > > > The only
> > > > code left from you is for DE2. HDMI stuff is basically copied from
> > > > Rockhip
> > > > driver (including EDID reading), TCON code is now reverted to the same
> > > > as
> > > > it is in sunxi_display.c. I think it is worth to take a look at EDID
> > > > code
> > > > and compare it.
> > > 
> > > So is the TCON of DE 2.0 identical to the original TCON?
> > > 
> > > If so, we should reuse sun4i-tcon ...
> > 
> > Well, TCON is splitted in two parts (two base addresses), one for HDMI and
> > one for TV. However, register offsets are same as before, so I guess
> > driver reusage make sense. I think that there are few additional
> > registers, but they can be ignored for simplefb.
> 
> The TCON1 of the H3 is not usable (no ckock). Analog TV has its own
> clock and I/O area.
> 

True, H3 user manual can be misleading sometimes. But this doesn't change the 
fact that TCON0 has same register offsets with same meaning.

> --
> Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
> Jef		|		http://moinejf.free.fr/
