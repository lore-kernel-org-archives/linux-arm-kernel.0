From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 11 Sep 2014 11:16:49 +0100
Subject: [PATCH 1/2] ARM: cache-l2x0: clean up aurora cache handling
In-Reply-To: <20140911105441.7876966a@free-electrons.com>
References: <2852268.nkG1OoBDfE@wuerfel>
 <20140908153946.GB12361@n2100.arm.linux.org.uk> <2958731.nsOomQFma0@wuerfel>
 <3459745.mC0zoLRDxy@wuerfel> <20140911105441.7876966a@free-electrons.com>
Message-ID: <20140911101649.GI12361@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 11, 2014 at 10:54:41AM +0200, Thomas Petazzoni wrote:
> Arnd,
> 
> Thanks for working on this.

You know, we wouldn't be in this situation today with these warnings
if people /cooperated/ with me when I was working on this code.  So
I take your thanks to Arnd as a bit of an insult to me.

> On Mon, 08 Sep 2014 22:42:23 +0200, Arnd Bergmann wrote:
> > -#ifdef CONFIG_CACHE_PL310
> > -static inline void cache_wait(void __iomem *reg, unsigned long mask)
> > -{
> > -	/* cache operations by line are atomic on PL310 */
> > -}
> > -#else
> > -#define cache_wait	l2c_wait_mask
> > -#endif
> 
> How do you conclude from this that cache_wait() does nothing? When
> we're on PL310, it indeed does nothing, but in our case, we're not on a
> PL310, so cache_wait is equivalent to l2c_wait_mask, which does:

Right, which is why aurora is broken today - the behaviour you end up with
is 100% dependent on whether you've also included L2C310 support or not.
So, using Aurora with a single zImage (which will have support for L2C310
enabled) is going to make this a no-op.

This is why I didn't touch the Aurora code - I don't know what the correct
answer is, and I was ignored when I was working on this code.  So, I
decided that the current warnings which the code produces will serve as a
lesson to people *not* to ignore me, and they can remain there until
people start taking an interest in this.  This seems to be the only way
to get stuff done - being nice and civil gets you nowhere.

> /*
>  * Common code for all cache controllers.
>  */
> static inline void l2c_wait_mask(void __iomem *reg, unsigned long mask)
> {
>         /* wait for cache operation by line or way to complete */
>         while (readl_relaxed(reg) & mask)
>                 cpu_relax();
> }
> 
> And this does not seem to be in any conditional making it specific to
> PL210/PL220 as your commit log suggests.

Why would this need to be moved under an ifdef?  __l2c_op_way() also makes
use of l2c_wait_mask, which itself is used by l2c210_flush_all() and
l2c220_op_way().

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
