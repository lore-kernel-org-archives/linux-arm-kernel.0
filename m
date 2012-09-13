From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 13 Sep 2012 09:52:06 +0100
Subject: [PATCH] ARM: suspend: use flush range instead of flush all
In-Reply-To: <CAG9bXv=UzR1iDJ_+6JAC5Ue2caZs7JvGOMjABidsbgRKNhxJrA@mail.gmail.com>
References: <1347434328-7207-1-git-send-email-wzch@marvell.com>
 <CAMQu2gwK+TP+7qQG0cET04y7+BYn--5UwkVuffOUu0kuv8Ps6A@mail.gmail.com>
 <20120912085445.GW13739@n2100.arm.linux.org.uk>
 <CAMQu2gx_Wk259F2PNY-T5H1N04i-JwseO5mPNw7xZ__tjonw1A@mail.gmail.com>
 <20120912094648.GX13739@n2100.arm.linux.org.uk>
 <CAG9bXv=UzR1iDJ_+6JAC5Ue2caZs7JvGOMjABidsbgRKNhxJrA@mail.gmail.com>
Message-ID: <20120913085206.GA13739@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 13, 2012 at 10:20:30AM +0800, Raul Xiong wrote:
> I have several questions:
> 1. Even we call flush_calche_all in __cpu_suspend_save, since later we
> will outer_clean_range which may cause cache operations so we still
> need to flush again in finisher, right?

Why would it?  Any data which would be pulled back into the L1 cache
from that point is either going to be clean (in other words, a copy of
it exists elsewhere in the system) or it is going to be dirty (in
which case, it's been explicitly written to - and that's the stuff the
finisher needs to take care of.

We do not care abou the dirty data created by calling subsequent
functions as this is not used for resuming.

> 2. Not every platform the L1 will be lost, we have the option to keep
> L1 retentive, right? Just consider single core CA9. So we may not need
> to flush all every time.

That's where you start paying the price for having such a complex
architecture, and the need to have generic code to keep things simple.

Rather than thinking "we need to eliminate that flush and move it into
the finisher" start thinking "we need to communicate what parts of the
system are lost over suspend and get the suspend code to use that to
determine what it needs to do".

> 3. Why it's difficult to call cache maintenance in assembly? Moreover,
> not every finisher is assembly, right?

Have you tried to see whether a function called 'flush_cache_all'
actually exists in your System.map file?  It doesn't.  What you have
is a bunch of cache specific functions, one of which either gets aliased
to that name at build time, or that name gets aliased to a function
pointer (in a structure) to point at the relevant cache specific
function.  And there are platforms where hard-coding just one is not
correct.

What we have today is a massive improvement over what we had earlier on
where every platform was implementing all the suspend/resume stuff
themselves.  I'm not going back to the situation where we have that
again.
