From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 25 Nov 2015 18:45:57 +0000
Subject: Building an uImage with appended DTB
In-Reply-To: <CACxGe6t0RD-z=duiP+=sbWm_JY7_OjjTmBL7jLZRRuLBSMan6g@mail.gmail.com>
References: <5655DED0.5000601@free.fr>
 <CACxGe6t0RD-z=duiP+=sbWm_JY7_OjjTmBL7jLZRRuLBSMan6g@mail.gmail.com>
Message-ID: <20151125184556.GP8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 25, 2015 at 04:38:35PM +0000, Grant Likely wrote:
> On Wed, Nov 25, 2015 at 4:16 PM, Mason <slash.tmp@free.fr> wrote:
> > Hello,
> >
> > Per Russell's advice (IIRC) I have a script to generate a uImage
> > of a kernel with an appended DTB:
> >
> > export LOADADDR=0x80008000
> > MAKE="make -j2 ARCH=arm"
> > $MAKE dtbs zImage && \
> > cat arch/arm/boot/zImage arch/arm/boot/dts/tango4-vantage-1172.dtb >zImage.tmp && \
> > mv zImage.tmp arch/arm/boot/zImage && \
> > $MAKE uImage
> >
> > Russell's version uses an explicit mkimage instead of "MAKE uImage"
> > perhaps in part to get around the following limitation:
> >
> > if there is nothing to be done, cat+mv will update arch/arm/boot/zImage
> > thus the uImage will be rebuilt even when it's not necessary.
> >
> > Doesn't the top-level Makefile support a target to build a uImage
> > with appended DTB?
> >
> > (I suppose someone has submitted a patch for that. Was it perhaps
> > never merged? Or did I just miss the feature?)
> 
> I don't remember what happened there. That was a long time ago. I
> think it got nacked, but cannot remember the reason.

It got nacked because we don't want these special boot loader specific
formats in the kernel, and it's getting beyond a joke.  It was a mistake
to merge the uImage target in the first place IMHO.

Previous to uboot, boot loaders were perfectly happy with zImage.  Today,
all boot loaders are perfectly happy with a zImage - it's only the old
legacy uboot versions that insist on uImage now.  There's now even less
of a reason to think about merging some uImage based DT munging than there
was several years ago.

Just do it in an external script, like I do here for platforms where it's
necessary.  Absolutely no need to hack around in the kernel with special
crap, like passing environment variables to make (which, you need a script
for anyway, because its laborious to have to keep on typing them.)

If you're writing a build script so you don't have to remember lots of
environment variables for the kernel, you might as well write the build
script to do the mkimage step for you.

So having it in the kernel is totally pointless and insane.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
