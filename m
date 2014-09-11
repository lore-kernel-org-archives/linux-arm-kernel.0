From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 11 Sep 2014 12:31:43 +0200
Subject: [PATCH 1/2] ARM: cache-l2x0: clean up aurora cache handling
In-Reply-To: <20140911101649.GI12361@n2100.arm.linux.org.uk>
References: <2852268.nkG1OoBDfE@wuerfel>
 <20140908153946.GB12361@n2100.arm.linux.org.uk>
 <2958731.nsOomQFma0@wuerfel> <3459745.mC0zoLRDxy@wuerfel>
 <20140911105441.7876966a@free-electrons.com>
 <20140911101649.GI12361@n2100.arm.linux.org.uk>
Message-ID: <20140911123143.01e4beda@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

On Thu, 11 Sep 2014 11:16:49 +0100, Russell King - ARM Linux wrote:

> > Thanks for working on this.
> 
> You know, we wouldn't be in this situation today with these warnings
> if people /cooperated/ with me when I was working on this code.  So
> I take your thanks to Arnd as a bit of an insult to me.

I apologize if you took it this way, because it clearly wasn't the
intention here. Clearly the L2 cache code looks much better after your
big cleanup, I don't think anybody will question that.

Your original patch series was very large and therefore a bit scary to
look at. At the time, I was not able to dedicate enough time to review
a 97 patches patch series. Maybe splitting the patch series into
smaller chunks, and get the cleanup progressively merged would have
helped getting more review.

That's not really an excuse, but I was always never Cc'ed on your patch
series (which isn't your fault: I'm not a maintainer), while I was
Cc'ed on Arnd patches.

Also, to be honest, my initial reaction to a 97 patches patch series
from Russell King cleaning up the L2 cache stuff is: I definitely trust
Russell when working on this sort of stuff, and I know he's very
careful when doing cleanups, and since I don't have enough time to
review this, I'll trust him to do the right thing.

Turns out my (maybe blind?) trust seems to have worked: as far as
Marvell EBU platforms are concerned, I believe nothing was broken by
your changes. All Arnd is doing right now are further cleanups.

> Right, which is why aurora is broken today - the behaviour you end up with
> is 100% dependent on whether you've also included L2C310 support or not.
> So, using Aurora with a single zImage (which will have support for L2C310
> enabled) is going to make this a no-op.

Which works, as per my previous answer to Arnd, after checking the
datasheet and vendor tree.

> This is why I didn't touch the Aurora code - I don't know what the correct
> answer is, and I was ignored when I was working on this code.  So, I
> decided that the current warnings which the code produces will serve as a
> lesson to people *not* to ignore me, and they can remain there until
> people start taking an interest in this.  This seems to be the only way
> to get stuff done - being nice and civil gets you nowhere.

I think all of the kernel developers are encouraged and told to not send
huge patch series, because it is well-known that large patch series
will discourage potential reviewers. I'm pretty sure it's the major
reason for the lack of review of your patch series. Had it been sent in
20 patches chunks, maybe merged across a few kernel releases, I'm sure
you would have had more reviews and comments.

> > /*
> >  * Common code for all cache controllers.
> >  */
> > static inline void l2c_wait_mask(void __iomem *reg, unsigned long mask)
> > {
> >         /* wait for cache operation by line or way to complete */
> >         while (readl_relaxed(reg) & mask)
> >                 cpu_relax();
> > }
> > 
> > And this does not seem to be in any conditional making it specific to
> > PL210/PL220 as your commit log suggests.
> 
> Why would this need to be moved under an ifdef?  __l2c_op_way() also makes
> use of l2c_wait_mask, which itself is used by l2c210_flush_all() and
> l2c220_op_way().

I'm not saying it should be under a #ifdef, but Arnd's commit log was
saying that the l2c_wait_mask code was only used on pl210/pl220, which
according to:

-#ifdef CONFIG_CACHE_PL310
-static inline void cache_wait(void __iomem *reg, unsigned long mask)
-{
-	/* cache operations by line are atomic on PL310 */
-}
-#else
-#define cache_wait	l2c_wait_mask
-#endif

is not correct, because l2c_wait_mask is in fact used on all !PL310
configurations, which includes Aurora.

So I was not suggesting to change how l2c_wait_mask is defined, I was
merely pointing out what the current implementation does.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
