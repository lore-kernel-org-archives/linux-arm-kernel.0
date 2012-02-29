From: prakash.pm@ti.com (Manjunathappa, Prakash)
Date: Wed, 29 Feb 2012 07:01:52 +0000
Subject: [PATCH v5 2/3] arm:davinci: move emif driver to mfd framework
In-Reply-To: <A73F36158E33644199EB82C5EC81C7BC3176D103@DBDE01.ent.ti.com>
References: <y> <1330005504-25321-3-git-send-email-prakash.pm@ti.com>
 <20120227142638.GN27687@sortiz-mobl>
 <A73F36158E33644199EB82C5EC81C7BC3176D103@DBDE01.ent.ti.com>
Message-ID: <A73F36158E33644199EB82C5EC81C7BC3176D90F@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Samuel,

On Tue, Feb 28, 2012 at 11:14:39, Manjunathappa, Prakash wrote:
> Hi Samuel,
> 
> On Mon, Feb 27, 2012 at 19:56:38, Samuel Ortiz wrote:
> [snip]
> > So it seems you're passing a platform devices array through your mfd aemif
> > platform data pointer. And from what I can see, it's mostly a 1 entry array
> > (for the NAND case) or a 2 entries array (for the NAND and NOR case).
> > In that case, adding an MFD driver in the middle brings basically nothing but
> > confusion and overhead (and 200+ lines of code).
> > So unless someone explains to me how this is doing any good to the kernel in
> > general, I'm not going to take this patchset.
> > 
> > Cheers,
> > Samuel.
> >
> 
> In this way we trying to isolate future modification of aemif driver not to depict
> as platform code change, the need for this is based on discussion in below thread
> http://davinci-linux-open-source.1494791.n2.nabble.com/PATCH-arm-davinci-configure-davinci-aemif-chipselects-through-OF-tt7059739.html#none
> 
> Earlier also concern was expressed to move aemif driver out of arch/arm to drivers folder.
> Here is the link for the same: http://lists.infradead.org/pipermail/linux-mtd/2011-August/037308.html
> Since aemif driver supports NAND/NOR devices, we feel MFD is the place holder.
> 
> Thanks,
> Prakash

Some more information which I missed out earlier:
DaVinci AEMIF is an async memory interface, driver for which was implemented in
arch/arm/mach-davinci/aemif.c. It can be interfaced to NAND, NOR and other
asynchronous memories. Currently it just provides an API for timing value
configuration. The API is invoked by the MTD NAND driver. 

Specification here: http://www.ti.com/lit/ug/sprue20c/sprue20c.pdf

Reason for moving it to MFD frame work:
1) AEMIF is also present on devices belonging to arch-c6x and arch-omap2 architectures.
   So having the driver in architecture neutral place seems to be the way to go.
2) Other than NAND/NOR there are use cases where people are interfacing other devices,
   for eg: FPGAs through UIO framework. So MTD is not the place for AEMIF driver.

Taking above points into consideration Arnd Bergmann suggested to move AEMIF driver to
MFD framework. Here is the link:
http://lists.ozlabs.org/pipermail/devicetree-discuss/2011-December/010295.html

Thanks,
Prakash
