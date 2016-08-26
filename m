From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 26 Aug 2016 14:45:00 +0100
Subject: [PATCH] arm: sys_oabi-compat: Use kmalloc_array() in two functions
In-Reply-To: <dd343c72-2ec7-2114-bee5-1d16fc6c04ac@users.sourceforge.net>
References: <5deba521-2dd4-cd2e-23d7-226a1a7728c3@users.sourceforge.net>
 <20160825224632.GL1041@n2100.armlinux.org.uk>
 <dd343c72-2ec7-2114-bee5-1d16fc6c04ac@users.sourceforge.net>
Message-ID: <20160826134459.GR1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 26, 2016 at 03:22:29PM +0200, SF Markus Elfring wrote:
> >> Multiplications for the size determination of memory allocations
> >> indicated that array data structures should be processed.
> > 
> > I'm afraid the above comment doesn't mean much to me, can you rephrase?
> 
> Yes, of course.
> 
> How verbose should the explanation for this update suggestion become?

It should at least make basic English sense.  I'm afraid the above
doesn't convey any meaning what so ever, at least to me.  It doesn't
matter how many times I read it, I still end up wondering "wtf is
this trying to tell me?"

A commit message which doesn't convey any meaning is totally useless.
The commit message is there to describe the change not just for the
present, but for years into the future.  It _has_ to be meaningful
and it _has_ to make sense.

> >> @@ -285,7 +285,7 @@ asmlinkage long sys_oabi_epoll_wait(int epfd,
> >>  		return -EINVAL;
> >>  	if (!access_ok(VERIFY_WRITE, events, sizeof(*events) * maxevents))
> >>  		return -EFAULT;
> >> -	kbuf = kmalloc(sizeof(*kbuf) * maxevents, GFP_KERNEL);
> >> +	kbuf = kmalloc_array(maxevents, sizeof(*kbuf), GFP_KERNEL);
> > 
> > kmalloc_array() here actually buys us no additional safety at either
> > of the callsites in your patch
> 
> Can this inline function apply a few sanity checks in a consistent way?
> http://lxr.free-electrons.com/source/include/linux/slab.h#L564

What do you mean "a consistent way" ?  This function is already checking
in this way:

asmlinkage long sys_oabi_epoll_wait(int epfd,
                                    struct oabi_epoll_event __user *events,
                                    int maxevents, int timeout)

        if (maxevents <= 0 ||
                        maxevents > (INT_MAX/sizeof(*kbuf)) ||
                        maxevents > (INT_MAX/sizeof(*events)))
                return -EINVAL;

Do you mean doing something like:

static inline bool array_size_valid(int num, int size)
{
	return num >= 0 && size && num > SIZE_MAX / size;
}

with the above becoming:

	if (!max_events ||
	    !array_size_valid(max_events, sizeof(*kbuf)) ||
	    !array_size_valid(max_events, sizeof(*events)))
		return -EINVAL;

then maybe - but notice that this is using "int" arguments (which can
be negative) as opposed to kmalloc_array() which takes size_t arguments.
So we can't have one helper that fits both kmalloc_array() and this
case - you're talking about creating a specific helper for these cases.

> > - we need to have carefully checked the values to ensure
> > they don't overflow prior to the kmalloc for other reasons.
> 
> Are there any more constraints to consider?

For these functions, I don't think so.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
