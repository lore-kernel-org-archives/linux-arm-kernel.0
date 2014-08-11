From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 11 Aug 2014 23:43:28 +0100
Subject: Building kernel for more than one SoC
In-Reply-To: <lsbbp9$j4n$1@ger.gmane.org>
References: <lrdi48$ls1$1@ger.gmane.org>
 <20140804201712.GK30282@n2100.arm.linux.org.uk> <53E8E469.9050807@atmel.com>
 <lsaoih$e9$1@ger.gmane.org>
 <CAOCHtYgPoxveSjYpWWo8W+_0WwQdaCBga0piazg_Oq6aeZ=w-g@mail.gmail.com>
 <lsb9tn$nnv$1@ger.gmane.org> <20140811205909.GC30401@n2100.arm.linux.org.uk>
 <lsbbp9$j4n$1@ger.gmane.org>
Message-ID: <20140811224328.GD30401@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 11, 2014 at 09:15:22PM +0000, Grant Edwards wrote:
> On 2014-08-11, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> > On Mon, Aug 11, 2014 at 08:43:35PM +0000, Grant Edwards wrote:
> >> On 2014-08-11, Robert Nelson <robertcnelson@gmail.com> wrote:
> >> >> Now it's up to somebody else to decide if the price difference between
> >> >> a G20 and G25 is worth the engineering time to upgrade U-Boot and
> >> >> Linux kernel to versions that know about device trees...
> >> >
> >> > http://cateee.net/lkddb/web-lkddb/ARM_APPENDED_DTB.html
> >> 
> >> Interesting.  That would still require modifying U-Boot so that at
> >> run-time it detects the SoC type and appends the proper DTB to the
> >> kernel image, but it that may be less work than "real" DTB support in
> >> U-Boot.
> >
> > The idea of that feature is:
> >
> > - You take the kernel zImage
> > - You take the appropriate dtb file
> > - You concatenate the dtb file into the zImage
> > - You run mkimage on the resulting combined image to create the special
> >   uboot format file for uboot to load
> 
> The problem is now you've got a kernel image that won't run on both
> the '9g20 and the '9g25.  The requirement is to have a kernel image
> that will run on either.

It depends what you call a kernel image.

As far as I'm concerned (and as I've been concerned from day one of uboot
coming into ARM), the kernel image is the zImage, not the crap that uboot
decides to dictate that you must provide for it to use.

I've been pretty clear over the years that I utterly despise uboot's
custom format - and you're starting to find out why.  Welcome to the
inflexibility has caused. :)

> > - You use it with uboot as you have done in the past with non-DT
> >   kernels.
> 
> Logistically, there's little difference between that and compiling the
> kernel twice.  It's more elegant than compiling the kernel twice, but 
> in the end it requires the maintenance of two separate kernel images
> and some way for customers to figure out which one they should
> download (and no matter what you do, when given a choice between two
> files, they will download and attempt to install the wrong one more
> than half of the time).

While you have a point there, that's a choice of how you do your kernel
upgrades.

If you supply a zImage, all the dtbs, a script which does the
programming of the kernel onto the target, and a copy of mkimage, then
you can do all the steps I've highlighted above on the target - without
the customer even having to know what platform they're on, because your
script can work it out.

If you don't have a shell on the target, then write a C program to do it
instead.

There's plenty of workarounds possible for the old uboot dilemma...

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
