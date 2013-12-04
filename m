From: gregkh@linuxfoundation.org (Greg KH)
Date: Wed, 4 Dec 2013 11:03:12 -0800
Subject: [RFC PATCH] Documentation: devicetree: add description for
 generic bus properties
In-Reply-To: <20131204184345.GA29268@sirena.org.uk>
References: <20131127172806.GC2291@e103592.cambridge.arm.com>
 <20131128203322.GB14689@mithrandir>
 <20131128211009.GA26447@obsidianresearch.com>
 <20131128222232.GF14689@mithrandir>
 <20131128233147.GA19387@obsidianresearch.com>
 <20131129023554.GA14239@kroah.com>
 <20131204184345.GA29268@sirena.org.uk>
Message-ID: <20131204190312.GA5070@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 04, 2013 at 06:43:45PM +0000, Mark Brown wrote:
> On Thu, Nov 28, 2013 at 06:35:54PM -0800, Greg KH wrote:
> > On Thu, Nov 28, 2013 at 04:31:47PM -0700, Jason Gunthorpe wrote:
> 
> > > Greg's point makes sense, but the HW guys are not designing things
> > > this way for kicks - there are real physics based reasons for some of
> > > these choices...
> 
> > > eg An all-to-all bus cross bar (eg like Intel's ring bus) is engery
> > > expensive compared to a purpose built muxed bus tree. Doing coherency
> > > look ups on DMA traffic costs energy, etc.
> 
> > Really?  How much power exactly does it take / save?  Yes, hardware
> > people think "software is free", but when you can't actually control the
> > hardware in the software properly, well, you end up with something like
> > itanium...
> 
> If you look at the hardware design decisions this stuff tends to be
> totally sensible; there's a bunch of factors at play (complexity, area
> and isolation tend to be other ones).  There's a lot of the stuff that
> we're complaining about where they can reasonably question why this is
> so complex for us.  That doesn't mean that everything that it's possible
> to do is sensible but there's definitely limitations on the kernel side
> here.

The main reason it's so "complex" is the drive for people to have a "one
kernel image for multiple systems" and hence the need to have DT handle
all of this.  I don't think that requirement has been pushed back on the
hardware engineers yet, and they are still thinking that a custom image
per chip is ok.

If the hardware designers don't have that goal, this is just going to
get harder and harder over time, as your systems get more and more
complex.

> > > > code to deal with those descriptions and the hardware they represent. At
> > > > some point we need to start pushing some of the complexity back into
> > > > hardware so that we can keep a sane code-base.
> 
> > > Some of this is a consequence of the push to have the firmware
> > > minimal. As soon as you say the kernel has to configure the address
> > > map you've created a big complexity for it..
> 
> > Why the push to make firmware "minimal"?  What is that "saving"?  You
> > just push the complexity from one place to the other, just because ARM
> > doesn't seem to have good firmware engineers, doesn't mean they should
> > punish their kernel developers :)
> 
> These firmwares have tended to be ROMed or otherwise require expensive
> validation to change for sometimes sensible reasons, keeping the amount
> of code that's painful to change low will tend to make people happier if
> a change is needed.  Most people like the risk mitigation.

I love it how it's so easy to make the kernel be the part of the whole
system stack that is simpler to change than any other :)

I'm all for making Linux be the "firmware" and deal with these very
low-level issues directly, but again, this drives in the face of your
self-stated goal of "one image per architecture" for the kernel.  You
kind of can't have it both ways it seems, so someone needs to make up
their mind as to what it's going to be...

Best of luck with this.

greg k-h
