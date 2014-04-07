From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 7 Apr 2014 10:00:02 +0100
Subject: [PATCH 00/75] l2c series
In-Reply-To: <5342440E.2020301@monstr.eu>
References: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
 <533D7672.4090003@monstr.eu> <20140403193328.GY7528@n2100.arm.linux.org.uk>
 <533E5B71.20406@monstr.eu> <20140404192824.GG7528@n2100.arm.linux.org.uk>
 <5342440E.2020301@monstr.eu>
Message-ID: <20140407090002.GU7528@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 07, 2014 at 08:22:06AM +0200, Michal Simek wrote:
> On 04/04/2014 09:28 PM, Russell King - ARM Linux wrote:
> > On Fri, Apr 04, 2014 at 09:12:49AM +0200, Michal Simek wrote:
> >> On 04/03/2014 09:33 PM, Russell King - ARM Linux wrote:
> >>> On Thu, Apr 03, 2014 at 04:55:46PM +0200, Michal Simek wrote:
> >>>> Hi Russell,
> >>>>
> >>>> On 03/28/2014 04:12 PM, Russell King - ARM Linux wrote:
> >>>>> This is another posting of the L2 cache controller series.  I'm not
> >>>>> planning for this for the upcoming merge window, but the one after,
> >>>>> as people need to test it and still need to feed back to me on
> >>>>> various issues.  Hence, this is not a finalised series.
> >>>>>
> >>>>> There are still various issues which I've raised, and have had no
> >>>>> feedback on.
> >>>>>
> >>>>> This series is being posted with Cc's on the individual patches.
> >>>>
> >>>> I just want to also point you that we have sent EDAC support for pl310
> >>>> which will be good to have it for L2.
> >>>> [RFC PATCH] EDAC support for ARM PL310 cache controller
> >>>> [RFC PATCH] edac: add support for ARM PL310 L2 cache parity
> >>>> http://lkml.org/lkml/2014/3/2/85
> >>>> http://lkml.org/lkml/2014/3/2/87
> >>>
> >>> As seems to be the norm, lkml.org is broken... please find a different
> >>> archive instead. :)
> >>>
> >>
> >> Here it is:
> >> http://lkml.iu.edu/hypermail/linux/kernel/1403.0/00250.html
> >> http://lkml.iu.edu/hypermail/linux/kernel/1403.0/00251.html
> > 
> > A number of comments immediately spring to mind:
> > 
> > - the use of writel/readl rather than their ARM specific _relaxed
> >   versions is not a good idea: using the standard macros will result
> >   in another write due to the barrier.
> 
> Not a problem to use _relaxed version.
> 
> My concern about using _relaxed version is that
> everybody is still saying use COMPILE_TEST or just enable drivers
> for all archs. With using _relaxed IO helper function it is ending
> up in compilation problems for i386.
> Last time with our i2c driver.
> http://www.spinics.net/lists/arm-kernel/msg320255.html
> 
> It means shouldn't be that _relaxed version listed in asm-generic/io.h
> or just limit it to use this driver just for ARM like we have done for
> this edac driver.

As I said, it's a requirement for L2C code, because otherwise you end up
with every IO access to the L2C also invoking a second IO access to the
device.

> > - a driver coupled to the arm,pl310-cache compatible for this which is
> >   distinctly separate from the main "driver" is probably a bad idea.
> >   what if we want our existing l2 stuff to couple into the driver model
> >   to expose some properties at a later date (eg, maybe to deal with
> >   stuff like the power management settings?)  For example, it may be
> >   that we want to expose the prefetch offset so that people can easily
> >   play with the value to determine the correct tuning for their workload.
> 
> We choose that name for starting to discuss this how to do it better.
> We could use zynq-edac-l2 or zynq-edac-r3p2, etc version.

I'm not talking about the compatible name.  I'm certainly not suggesting
that you should describe the L2 as two separate devices in DT.  I'm saying
that this should appear as one _single_ driver for the entire device.

> Our kernel for historical reasons runs in secure mode that's why
> I don't know if this will work for us but easy to try.

Sorry, this kind of short sightedness is unacceptable.  This is the
"I'm only going to solve the problem immediately in front of my nose"
syndrome which is currently causing me to end up rewriting lots of
code in the kernel right now.

What you're doing is similar to this:
  https://twitter.com/denny/status/452867158964326400/photo/1

You're solving the problem you have without thinking about the
consequences for others.

Of course other people are going to want to use this, and as the L2C
controllers are generic, so any code which adds support for EDAC
support should also be generic and not written with a single platform
in mind.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
