From: moinejf@free.fr (Jean-Francois Moine)
Date: Wed, 26 Jun 2013 18:42:50 +0200
Subject: Armada DRM driver on OLPC XO
In-Reply-To: <20130625204726.BF65C12647A@dev.laptop.org>
References: <20130625204726.BF65C12647A@dev.laptop.org>
Message-ID: <20130626184250.43f36e47@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 25 Jun 2013 16:47:26 -0400 (EDT)
Daniel Drake <dsd@laptop.org> wrote:

> Hi Russell,
> 
> Thanks a lot for writing the Armada DRM driver.
> 
> I have tested it on OLPC XO-1.75 (MMP2 aka Armada610) and OLPC XO-4 (MMP3
> aka PXA2128). After a bit of fighting, I have it running. Could you share your
> X driver, or your methodology for testing hardware cursors? I'd like to test
> your work there too.
> 
> It's probably easiest to get your cubox driver merged before adding MMP2/MMP3
> complications into the mix. At that point, I will hopefully have time to
> follow up developing MMP2/MMP3 support, which will involve the points
> mentioned below.
> 
> A hacky patch is also included below, which makes the driver run on this
> platform. I'm prepared to do the heavy lifting in implementing these changes
> properly, but any high level guidance would be appreciated, especially as I
> am new to the world of graphics.
> 
> Ordered roughly from highest to lowest importance:
> 
> 
> 1. Device tree support
	[snip]
> 
> 2. Panel support.
	[snip]
> 
> 3. Register space conflicts
	[snip]
> 
> 4. Video memory
	[snip]
> 
> 5. Output paths
	[snip]
> 
> I will work on getting you an XO in case you are interested in testing the
> driver there from time to time or even helping to develop support. But first I
> need to get it bootable on mainline kernels (patches posted, waiting for
> review).
> 
> Thanks!
> Daniel

Hi Daniel,

Do you know that there are 2 drm drivers for the Cubox? I posted mine
(http://lists.infradead.org/pipermail/linux-arm-kernel/2013-May/168732.html)
before Russell, but I got no return about it yet.

As it uses the CMA helper (no handling of the Cubox GPU/VPU), my
driver is simpler and does not need any specific memory reservation.

It has full DT support. The Cubox specific drivers are build as
loadable modules (dove-drm driver, tda998x hdmi slave encoder, si5351
clock driver and kirkwood i2s/spdif audio driver). The synchronization
of module loading at startup time is done by EPROBE_DEFER. The DT
permits each CRTC to use any of up to 4 clocks.

It is designed to handle 2 CTRCs and 2 couples of encoder/connector
only. LCD panel description (modeline / dimension) is done in the DT.

If you are interested or simply curious, I put my whole Cubox work in
http://moinejf.free.fr/cubox/ (I have some fixes that I will upload as
soon as I have a running 3.10.0-rc7 kernel compiled with gcc 4.8.1!).
The big kernel patch contains the dove-drm driver (in
drivers/gpu/drm/dove/) and the Cubox DT (arch/arm/boot/dts/dove.dtsi
and dove-cubox.dts).

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
