From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 26 Nov 2015 01:20:34 +0000
Subject: Building an uImage with appended DTB
In-Reply-To: <5656392D.8030904@free.fr>
References: <5655DED0.5000601@free.fr>
 <CACxGe6t0RD-z=duiP+=sbWm_JY7_OjjTmBL7jLZRRuLBSMan6g@mail.gmail.com>
 <20151125184556.GP8644@n2100.arm.linux.org.uk>
 <5656392D.8030904@free.fr>
Message-ID: <20151126012034.GW8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 25, 2015 at 11:41:49PM +0100, Mason wrote:
> On 25/11/2015 19:45, Russell King - ARM Linux wrote:
> > It got nacked because we don't want these special boot loader specific
> > formats in the kernel, and it's getting beyond a joke.  It was a mistake
> > to merge the uImage target in the first place IMHO.
> > 
> > Previous to uboot, boot loaders were perfectly happy with zImage.  Today,
> > all boot loaders are perfectly happy with a zImage - it's only the old
> > legacy uboot versions that insist on uImage now.  There's now even less
> > of a reason to think about merging some uImage based DT munging than there
> > was several years ago.
> 
> Actually, I'm using a fairly recent version of U-Boot (2014.04)
> IIUC, bootz should do the trick... But I'm not finding much doc
> about it... <confused>
> 
> If I pass U-Boot a zImage, where should I load it, and how does
> U-Boot know where to relocate it? (LOADADDR?)
> And why is LOADADDR 0x80008000 and not 0x80000000 (the start
> of the RAM)?

I no longer remember all the details, but the reason we avoid the first
32K is because we need to have some place to put some page tables so we
can turn the caches on - and I decided it was all round easier to place
the page tables below the image, and these need to be aligned to 16K.
IIRC, in the distant past, I also needed to reserve space for other
things as well, so the base of the kernel became RAM start plus 32K.

> > Just do it in an external script, like I do here for platforms where it's
> > necessary.  Absolutely no need to hack around in the kernel with special
> > crap, like passing environment variables to make (which, you need a script
> > for anyway, because its laborious to have to keep on typing them.)
> 
> How do you prevent your script from rebuilding the uImage every
> time it is invoked?

I don't, but if you wanted to do that look at the tests you can do with
'test' aka '['.  You'll find the -nt test which will allow you to test
for one file being newer than the other.  You probably ought to also
test for the existence of the target file too.  So, something like:

if [ ! -e "$uimage" -o "$zimage" -nt "$uimage" ]; then
   mkimage...
fi

You only need the double-quotes around $uimage and $zimage if these
variables may be empty or contain spaces in their expansion.

> > If you're writing a build script so you don't have to remember lots of
> > environment variables for the kernel, you might as well write the build
> > script to do the mkimage step for you.
> > 
> > So having it in the kernel is totally pointless and insane.
> 
> I understand.

It gets even more fun when you've developed this idea to the extent
of building and packaging up a kernel with modules into a tarball,
transferring it to a number of platforms, and then having the platforms
reboot into the new kernel - with everything from the build right the
way through to the reboots all resulting from running one script with
no user interaction needed. :)

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
