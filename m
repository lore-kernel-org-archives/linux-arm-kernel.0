From: dave@chronolytics.com (David F. Carlson)
Date: Fri, 25 Sep 2009 08:47:18 -0400 (EDT)
Subject: Announcing s3c64xx XWindows fbdrv w/ XAA+XVideo+HWcursor
In-Reply-To: <20090924210958.GI31920@trinity.fluff.org>
Message-ID: <200909251247.n8PClIil011167@chronolytics.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to Ben Dooks:
> 
> On Thu, Sep 24, 2009 at 01:42:20PM -0400, David F. Carlson wrote:
> > 
> > S3C6410 based Xwindows fbdev with
> >    o  XAA accelerated fills, lines, expands, blits, offscreen pixmaps/stipples
> >    o  Alpha-blended HWCursor 
> >    o  XVideo Support (using the Samsung Post-Processor colorspace driver)
> >    o  Tested with the Maemo Mer kernel 2.6.24.7 because...
> > 
> Are the necessary changes for the s3cfb postable to the list to start
> the review process for them?

I have a near-term problem which is that I am still developing on 2.6.24.7
because my attempts to use next-s3c failed to produce an image that would 
start XWindows.  (SDHC, pwm, lcd support, etc.)  I am not complaining, just
explaining.  Patching without testing is not a good place to be.

That being said, you seem to have a preferred direction for what should be
in the s3c-fb.  Allocation of offscreen memory at config time seems doable
with static testing.  Is a per-screen Kconfig desirable?  How should DBE and
offscreen memory play nice?  (Or should they be mutually exclusive?)  With 
a PP handling color space conversion and onscreen bit, I am not sure 
DBE buys much.

Adding the MMIO mmap interface is also "trivial".  (If it is desirable.
I will not waste my time if it is "pre-rejected")

It also appears that even Samsung latests gits omit the g2d driver.  Is the 
plan to fold that register space into s3c-fb or "something else"?  I need 
suspend/resume support in the kernel for the XAA to "work".  But a contig
vaddr mmap of the display controller and g2d dis-contig physical spaces 
would suit me fine.  We need an answer to "how do we access the g2d space?"

I am not a huge fan of the PP driver API, but it works.  I also think that 
XVideo is the right way for user space to access the PP.  XWindows will "own"
the device (ie., baseband not shared).  I would be willing to get you diffs 
for PP (or Samsung could).

>  
> > This driver is pretty much hardcoded for s3c64xx.  If kernel hooks for 
> > describing configuration this driver base could be expanded to 
> > support many s3c variants (with g2d and pp).
> 
> It would be good to get the discussion about these items going before
> we get too much further down the development process.

I have tried to contact Samsung but I get dead-air.

I know you (Ben) and Harald have had some discussion, but I am out of the 
loop as to how Samsung/Harald/Ben/others want this thing to look when we 
are done.

I have placed a marker.  

And I am very willing to "get this right".  But part of my problem is that I 
have access to 6410 only.  I do not understand the differences amongst the 
10+ devices in the s3c family.  With very few exceptions (Ben? :-) I am not 
sure any out of Samsung really understands the whole s3c family.

David F. Carlson    Chronolytics, Inc.  Rochester, NY
mailto:dave at chronolytics.com            http://www.chronolytics.com

"The faster I go, the behinder I get." --Lewis Carroll
