From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 27 Nov 2015 12:23:15 -0500 (EST)
Subject: Building an uImage with appended DTB
In-Reply-To: <20151126012034.GW8644@n2100.arm.linux.org.uk>
References: <5655DED0.5000601@free.fr>
 <CACxGe6t0RD-z=duiP+=sbWm_JY7_OjjTmBL7jLZRRuLBSMan6g@mail.gmail.com>
 <20151125184556.GP8644@n2100.arm.linux.org.uk> <5656392D.8030904@free.fr>
 <20151126012034.GW8644@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.20.1511271215590.22569@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 26 Nov 2015, Russell King - ARM Linux wrote:

> On Wed, Nov 25, 2015 at 11:41:49PM +0100, Mason wrote:
> > On 25/11/2015 19:45, Russell King - ARM Linux wrote:
> > > It got nacked because we don't want these special boot loader specific
> > > formats in the kernel, and it's getting beyond a joke.  It was a mistake
> > > to merge the uImage target in the first place IMHO.
> > > 
> > > Previous to uboot, boot loaders were perfectly happy with zImage.  Today,
> > > all boot loaders are perfectly happy with a zImage - it's only the old
> > > legacy uboot versions that insist on uImage now.  There's now even less
> > > of a reason to think about merging some uImage based DT munging than there
> > > was several years ago.
> > 
> > Actually, I'm using a fairly recent version of U-Boot (2014.04)
> > IIUC, bootz should do the trick... But I'm not finding much doc
> > about it... <confused>
> > 
> > If I pass U-Boot a zImage, where should I load it, and how does
> > U-Boot know where to relocate it? (LOADADDR?)
> > And why is LOADADDR 0x80008000 and not 0x80000000 (the start
> > of the RAM)?
> 
> I no longer remember all the details, but the reason we avoid the first
> 32K is because we need to have some place to put some page tables so we
> can turn the caches on - and I decided it was all round easier to place
> the page tables below the image, and these need to be aligned to 16K.
> IIRC, in the distant past, I also needed to reserve space for other
> things as well, so the base of the kernel became RAM start plus 32K.

These days you may load zImage anywhere and it will relocate itself out 
of the way from either the decompressed Image and the initial page 
table.  It is not smart enough to relocate the DTB and the initrd 
though.

U-Boot shouldn't have to relocate anything. I don't know how to convince 
it not to relocate things though.

As a rule of thumb, you can load all the pieces you need above the 32MB 
mark from start of RAM. And then you can start zImage regardless of its 
address in memory simply by branching to it, with the address of your 
DTB in r2.


Nicolas
