From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Thu, 11 Jan 2018 20:21:06 +1100
Subject: [PATCH linux dev-4.10 0/6] Add support PECI and PECI hwmon drivers
In-Reply-To: <20180111084128.GA16780@kroah.com>
References: <20180109223126.13093-1-jae.hyun.yoo@linux.intel.com>
 <20180110101755.GA5822@kroah.com>
 <006c4a95-9299-bd17-6dec-52578e8461ae@linux.intel.com>
 <20180110191703.GA20248@kroah.com>
 <8997e43c-683e-418d-4e2b-1fe3fefe254e@linux.intel.com>
 <20180110202740.GA27703@kroah.com>
 <e81095ff-d491-9977-25e6-7ba6d28d5e72@linux.intel.com>
 <20180111073038.GA3600@kroah.com>
 <CACPK8Xe9Jti8S2px=QOcSMA2v+TZ4eGDGQND4qmBUBXeBpsBZQ@mail.gmail.com>
 <20180111084128.GA16780@kroah.com>
Message-ID: <1515662466.31850.44.camel@kernel.crashing.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2018-01-11 at 09:41 +0100, Greg KH wrote:
> On Thu, Jan 11, 2018 at 12:28:48AM -0800, Joel Stanley wrote:
> > On Wed, Jan 10, 2018 at 11:30 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
> > > On Wed, Jan 10, 2018 at 01:46:34PM -0800, Jae Hyun Yoo wrote:
> > > > Thanks for your pointing it out and I totally agree with you. Actually, we
> > > > are preparing 4.13 update for now and an another update will be followed up.
> > > > As I answered above, I'll rebase this patch set onto the latest kernel.org
> > > > mainline. Sorry for my misunderstanding of upstream process.
> > > 
> > > 4.13?  Why that kernel?  It too is obsolete and insecure and
> > > unsupported.
> > 
> > It contains support for our hardware that I have integrated from work
> > in progress patches and upstream commits.
> > 
> > The OpenBMC project, with myself as the kernel maintainer, have
> > intentions to regularly move to upstream releases. This takes time and
> > effort. This time and effort is balanced with submitting our drivers
> > upstream.
> 
> Of course, but please do not have your "users" use a kernel that is
> known to have bugs and can not be supported.  That would not be good at
> all, don't you think?

There is little choice, we don't have the manpower to rewrite/upstream
all the drivers in a day, and rebasing to newer kernel takes time due
to various dependencies, testing requirements etc.

That being said, 4.13 is N-1, not too bad.

> > > What keeps you all from just always tracking the latest tree from Linus?
> > 
> > Linus' tree does not contain all of the drivers required to boot
> > systems. Many of them are still under review on lkml, and others still
> > require rewrite from the vendor tree.
> 
> Merging vendor trees into your tree has got to be a complicated mess.
> Why try to keep it all together in one place?

There are no vendor trees to speak of that we could merge. At least not
yet. We've been teaching vendors about doing proper drivers that can
work with upstream, device-tree based platforms etc... but it takes
time for them to get up to speed.

So while we are rewriting the drivers (sometimes with the vendor's
help), we keep a tree with the "sub-standard" ones hacked up to work on
our DT based platform and with our other bits and pieces until we can
ditch it.

> And who is responsible for getting the vendor code upstream?  The
> individual drivers?  Individual driver submissions should be quite easy,
> what is preventing them from getting merged?

It just takes time Greg. The original vendor drivers are in no shape to
get anywhere near upstream. They have to be mostly rewritten one by
one. Sometimes we can teach the vendor and help them along, some times
we do it ourselves, but it's a time consuming process. It took 2 or 3
kernel versions just to get the clk drivers that Joel had written
upstream for example. It took me a long time as well to get ftgmac100
sorted.

> > > What is in your tree that is not upstream that requires you to have a
> > > kernel tree at all?
> > 
> > We have PECI, video compression, crypto, USB CDC, DRM (graphics),
> > serial GPIO, LPC mailbox for the ASPEED SoC.
> 
> What "USB CDC" do you have that is not upstream? 

See my other email :) 

>  I'll pick on this one
> specifically as I don't think I've seen any patches recently submitted
> for that driver at all.  Am I just missing them?
> 
> The other ones should also all be easy to get merged, with maybe the
> exception of the drm stuff due to the speed that subsystem moves at.
> But even there, the community is very helpful in getting stuff upstream,
> have you asked for help?

We can't expect the community to rewrite the drivers for us. Some of
the clk and pinmux stuff is intrinsically very complex, and took time
(and we did get valuable feedback).

Now that these basic pieces of infrastructure are in, it's a matter of
tackling the remaining drivers one at a time.

> > Another silicon vendor has recently joined the project and that brings
> > an entire SoC that is not upstream. We have patches on the ARM that
> > are under review for this SoC, with more drivers undergoing cleanup in
> > order to submit them to the relevant maintainers.
> 
> Why are you merging all SoC trees together into one place?  That seems
> like a nightmare to manage, especially with git.

There are no SoC trees per-se.

There is the OpenBMC tree which has hand-hacked vendor drivers plugged
into it, which are going away one at a time as we clean them up.
There's really one SoC family only in use (aspeed) at the moment with
one other coming around the corner (Nuvoton). For the latter, my
understanding is that we are trying to get the vendor to get their
stuff upstream directly.

> > > And if you do have out-of-tree code, why not use a process that makes it
> > > trivial to update the base kernel version so that you can keep up to
> > > date very easily?  (hint, just using 'git' is not a good way to do
> > > this...)
> > 
> > We have a process that we've been developing under for the past few
> > years. I find git to be a great tool for managing Linux kernel trees.
> > 
> > What would you recommend for managing kernel trees?
> 
> quilt is best for a tree that you can not rebase (i.e. a public git
> tree).  Otherwise you end up getting patches all mushed together and
> hard to extract in any simple way.
>
> Take a clue from the distros that have been managing kernels for decades
> and deal with an updated kernel all the time easily.
> 
> Good luck, it sounds like you will need it :)

Nah, not luck, we just need to get those drivers done one at a time,
it's not a matter of luck.

And I find git to be just fine :)

Cheers,
Ben.

> thanks,
> 
> greg k-h
