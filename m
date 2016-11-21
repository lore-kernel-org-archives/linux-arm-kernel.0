From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 21 Nov 2016 14:03:49 +0000
Subject: [BUG] hdlcd gets confused about base address
In-Reply-To: <20161121135031.GK1005@e106497-lin.cambridge.arm.com>
References: <20161118233733.GP1041@n2100.armlinux.org.uk>
 <20161121110604.GC1005@e106497-lin.cambridge.arm.com>
 <20161121112030.GC1041@n2100.armlinux.org.uk>
 <20161121113212.GF1005@e106497-lin.cambridge.arm.com>
 <20161121122556.GE1041@n2100.armlinux.org.uk>
 <20161121125653.GJ1005@e106497-lin.cambridge.arm.com>
 <20161121132419.GF1041@n2100.armlinux.org.uk>
 <20161121135031.GK1005@e106497-lin.cambridge.arm.com>
Message-ID: <20161121140349.GG1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 21, 2016 at 01:50:31PM +0000, Liviu Dudau wrote:
> On Mon, Nov 21, 2016 at 01:24:19PM +0000, Russell King - ARM Linux wrote:
> > On Mon, Nov 21, 2016 at 12:56:53PM +0000, Liviu Dudau wrote:
> > > That is mostly due to the check in hdlcd_crtc_disable() which I should
> > > remove, I've added it because I was getting a ->disable() hook call
> > > before any ->enable() was called at startup time. I need to revisit
> > > this as I remember Daniel was commenting that this was not needed.
> > 
> > Removing that test results in:
> > 
> > [drm:drm_atomic_helper_commit_cleanup_done] *ERROR* [CRTC:24:crtc-0] flip_done timed out
> > 
> > and the kernel hanging, seemingly in an IRQs-off region.
> 
> Right, I need to sort this one out. Are you doing these tests out of
> some tagged branch that I can get in sync with?

No, not yet, and some of the changes I have are rather hacky.

I do always build my full tree of patches (which is currently running at
around 320 patches at the moment) but I never share that entire patch
set.  However, none of those touch i2c (apart from the ones I've recently
posted) and the only patches touching hdlcd are those I've posted so far.

Most of the problems I'm finding are through trying basic stuff - I'm not
doing anything special or unusual to find them, at the moment quite
literally just starting Xorg up and shutting it down.  For example, the
above was caused by logging in on serial, running:

	Xorg -terminate -verbose

and then hitting ^C.  (I have lxdm disabled so systemd boots to VT login
prompts on both the "framebuffer" and serial - I don't want Xorg coming
up when the machine is booting for its nightly KVM boot tests.)

I'm afraid that when I try someone elses code, I have a tendency to find
loads of seemingly trivial bugs when I try putting it through some basic
tests.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
