From: schen@mvista.com (Steve Chen)
Date: Thu, 21 Jan 2010 06:48:10 -0600
Subject: make PHYS_OFFSET determined at run time (unfinished)
In-Reply-To: <1264075065.3207.122.camel@linux-1lbu>
References: <20100119083803.GA17904@pengutronix.de>
	<4B561581.6060400@bluewatersys.com>
	<20100120005505.GD26562@trinity.fluff.org>
	<1263954112.3207.73.camel@linux-1lbu>
	<20100120023255.GV10014@trinity.fluff.org>
	<1263998346.3207.83.camel@linux-1lbu>
	<1b68c6791001201728ma5ce62dyb1d4825cedb8f9df@mail.gmail.com>
	<4B57B8A5.1030508@bluewatersys.com>
	<1264075065.3207.122.camel@linux-1lbu>
Message-ID: <1264078090.3207.128.camel@linux-1lbu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-01-21 at 05:57 -0600, Steve Chen wrote:
> On Thu, 2010-01-21 at 15:15 +1300, Ryan Mallon wrote:
> > jassi brar wrote:
> > > On Wed, Jan 20, 2010 at 11:39 PM, Steve Chen <schen@mvista.com> wrote:
> > >> On Wed, 2010-01-20 at 02:32 +0000, Ben Dooks wrote:
> > >>> On Tue, Jan 19, 2010 at 08:21:52PM -0600, Steve Chen wrote:
> > >>>> On Wed, 2010-01-20 at 00:55 +0000, Ben Dooks wrote:
> > >>>>> On Wed, Jan 20, 2010 at 09:26:41AM +1300, Ryan Mallon wrote:
> > >>>>>> Uwe Kleine-K?nig wrote:
> > >>>>>>> Hello,
> > >>>>>>>
> > >>>>>>> I'm looking into making PHYS_OFFSET determined at run time.  I saw a
> > >>>>>>> patch for it that already made it a few times on the list[1].
> > >>>>>>>
> > >>>>>>> I'm not yet done, but first want to announce that I look into that to
> > >>>>>>> prevent duplicate work---so if you intended to do the same let's look
> > >>>>>>> together---and to post some clean up patches that are the result up to
> > >>>>>>> now of my digging in the boot code.
> > >>>>>>>
> > >>>>>>> I will send now three patches in reply to this mail, and later hopefully
> > >>>>>>> more.
> > >>>>>>>
> > >>>>>>> Best regards
> > >>>>>>> Uwe
> > >>>>>>>
> > >>>>>>> [1] e.g. http://thread.gmane.org/gmane.linux.ports.arm.kernel/53793/
> > >>>>>>>
> > >>>>>> One of the problems that got brought up previously was the 'make uImage'
> > >>>>>> can end up generating unbootable images with runtime PHYS_OFFSET. The
> > >>>>>> older format uImage's (pre 1.3.3) encode a load address (zrealaddr), so
> > >>>>>> uImage's need to have a fixed load address encoded.
> > >>>>>>
> > >>>>>> As I stated in the previous thread, this is _not_ a kernel issue,
> > >>>>>> however it is no good having a kernel which contains support for two
> > >>>>>> boards which boot from different address and then generating a uImage
> > >>>>>> which can only boot on one of them without warning the user about this
> > >>>>>> problem. Otherwise you are going to start getting "I did make uImage and
> > >>>>>> my board won't boot" problems.
> > >>>>>>
> > >>>>>> There are a few solutions to this problem:
> > >>>>>> 1) Drop uImage make support and require users generate them manually.
> > >>>>>> 2) Have a uImage offset config option to allow uImage users to specify
> > >>>>>> what they want the load address to be. See:
> > >>>>>> http://thread.gmane.org/gmane.linux.ports.arm.kernel/53151/focus=53230
> > >>>>>> 3) Print an error if "make uImage" is run for a kernel which has more
> > >>>>>> than one boot address (possible?)
> > >>>>>> 4) Use FIT U-Boot images. This is supported from U-Boot 1.3.3 onwards,
> > >>>>>> however a number of people are still using older U-Boots.
> > >>>>> Or of course, boot zImages. I belive u-boot has support for zImage.
> > >>>> Is there a clean way to pass kernel parameters and machine type from
> > >>>> u-boot to zImage?  Last time I boot zImage in u-boot, some ugly hack was
> > >>>> needed in ARM startup code.  Just wondering if there is a better way.
> > >>> u-boot should be doing the right thing, I thought uImage was simply a
> > >>> zImage wrapped in the right uboot descriptors to tell uboot it was a
> > >>> kernel and where to load it.
> > >>>
> > >>> Certianly uboots i've used can boto zImage just fine.
> > >> I'm also able to boot zImage under u-boot.  However, I had to set r1
> > >> manually, and I don't know how to pass kernel parameters (stuff passed
> > >> into kernel uImage via bootargs) to zImage.  Any tips will be greatly
> > >> appreciated.
> > > Perhaps you use 'go' instead of 'bootm' command in u-boot?
> > > How about:-
> > > 
> > >  u-boot # <load zImage@_addr_ by some means>
> > > 
> > >  u-boot # setenv machid <your machine ID in hex without the '0x'>
> > >  u-boot # saveenv //persistently save the machid
> > >              // now you don't need to set machid even after cold reset
> > > 
> > >  u-boot # bootm _addr_
> > > 
> > > hth.
> > 
> > The problem is not having something I can boot in U-Boot since users can
> > always generate their own uImages from an image/zImage. The problem is
> > that uImages have a fixed load address, so generating a uImage which
> > contains support for several boards with different load addresses will
> > be non-bootable on some of those boards.
> I think that much everyone agrees.  One of the proposals is to use
> zImage instead of uImage which eliminates the fixed load address issue.
> In summary, the advantage is that there are already code out there that
> supports zImage that boots multiple boards.  The disadvantage is that a
> u-boot version 2.0 or later is required, so many released products won't
Uwe,

Seems like I mis-quoted you again.  My apologies.

Steve

> be able to take advantage of this feature.
> 
