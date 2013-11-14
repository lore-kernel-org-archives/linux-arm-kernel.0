From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 14 Nov 2013 19:26:29 +0000
Subject: [RFC DTC PATCH] dtc: add symlink (-L) output to dtbs
In-Reply-To: <20131114162859.GX10335@titan.lakedaemon.net>
References: <1384201760-16785-1-git-send-email-jason@lakedaemon.net>
 <52814AFB.3070600@wwwdotorg.org>
 <CAL_Jsq+mAoN2Lbg+uqfLMTZBvgz28E-EioiaU4BUSL_7rS5JjA@mail.gmail.com>
 <528275B7.6050209@wwwdotorg.org>
 <20131112193012.GR10335@titan.lakedaemon.net> <52828C77.20001@wwwdotorg.org>
 <20131114162859.GX10335@titan.lakedaemon.net>
Message-ID: <20131114192629.GE16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 14, 2013 at 11:28:59AM -0500, Jason Cooper wrote:
> This is the difference between a commercial effort and a hobbyist
> effort.  I think I have a plan for how we can both get what we want.  I
> could change the argument to 'dtc ... -L arch/arm/boot ...'.  Thus:
> 
> $ cd arch/arm/boot
> $ ls -l *.dtb        # minus a few columns
> ...
> globalscale,mirabox.dtb -> dts/armada-370-mirabox.dtb
> ...
> 
> 
> This way, aftermarket users (debian installers, etc) could go to the
> same place they go for zImages, and find a standard named dtb.  They
> wouldn't need to parse the dtbs, just look at the current compatible
> string for the board they are installing on and find the matching file.

There's little point saying that they should be in arch/arm/boot.
Unless the distro is installing from a kernel source tree on every
platform, the location of the dtbs really doesn't matter.

Let's look at the typical distro build process:

- take the source
- patch it
- build it
- install it, relatively placing files according to their ultimate
  destination
- packaging the result up, adding metadata and scripts to aid installation

So, how does affecting where things are in the build tree help after all
that process?  What matters for DT files are:

(a) their names
(b) their location after installation

Where it appears in the build tree is neither here nor there, and IMHO
should not be of concern to any distro - just the same as picking the
zImage/uImage/whatever out of arch/arm/boot is none of their business.

We have ways and means to deal with the installation of kernel images
and modules.  There's well defined makefile targets for this, and
make variables which control where and how these get put.  For the
kernel image, you can specify the script to be run (which is called
with the location of the *Image file) for copying.  Pulling it manually
out of arch/arm/boot is really a failure of the distro packaging people
to get their process right.

The same goes for the DT files: if we don't provide a method for the
kernel build system to install these in a sane way, then that's our
failing.  However, distros should be asking for this, and not picking
the files out of arch/arm/boot/dts.

As for the commercial vs hobbist, there's very little difference here.
If you're a hobbist, building natively, that's where having the right
/sbin/installkernel present is a godsend, especially if you're running
some distro.  If you don't, most likely you understand what's required
to install a kernel.

Last point - on the Carrier-1, I have a fully automated setup which I
can fire off a build, walk away, and it will build a kernel including
modules, install it locally on my x86 PC in ~/systems/imx6 - including
appending the DT file, tar up the appropriate files, automatically copy
the tar file over, unpack it, update the initramfs for ubuntu 12.04,
update the vfat /boot filesystem appropriately, and reboot the platform.

Yes, I know the target system with that.  That's not my point.  The point
I'm making is that that level of automation is possible without excessive
amounts of messing about with kernel build internals - that all runs with
standard unmodified kbuild.

So, maintain a sense of perspective and separation of stages please.
