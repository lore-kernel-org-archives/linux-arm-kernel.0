From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 26 Jun 2013 17:50:45 +0100
Subject: Armada DRM driver on OLPC XO
In-Reply-To: <20130626184250.43f36e47@armhf>
References: <20130625204726.BF65C12647A@dev.laptop.org>
 <20130626184250.43f36e47@armhf>
Message-ID: <20130626165045.GF2718@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 26, 2013 at 06:42:50PM +0200, Jean-Francois Moine wrote:
> Do you know that there are 2 drm drivers for the Cubox? I posted mine
> (http://lists.infradead.org/pipermail/linux-arm-kernel/2013-May/168732.html)
> before Russell, but I got no return about it yet.
> 
> As it uses the CMA helper (no handling of the Cubox GPU/VPU), my
> driver is simpler and does not need any specific memory reservation.

As I have previously covered, that's a *big* negative point - the big
downside of that is that it will be *much* slower when it comes to
using the GPU because the pixmap data will be accessed by the CPU via
uncacheable mappings.

Moreover, as you say you're not using the GPU, that means that every
X operation which uses a DRM allocated pixmap will be copying between
one uncached pixmap and another uncached pixmap.  That is totally
insane.

> It has full DT support. The Cubox specific drivers are build as
> loadable modules (dove-drm driver, tda998x hdmi slave encoder, si5351
> clock driver and kirkwood i2s/spdif audio driver). The synchronization
> of module loading at startup time is done by EPROBE_DEFER. The DT
> permits each CRTC to use any of up to 4 clocks.

Via a horrid hack that doesn't really justify being in the kernel, and
certainly isn't flexible because it makes use of global variables to
detect when all the different parts of the DT representation have been
registered.

I have *serious* concerns about your approach to that problem, and I
really violently detest your "solution" - which is more of a hack than
a real solution.  I've covered those points in my comments on your code
when you first published it.
