From: peda@axentia.se (Peter Rosin)
Date: Thu, 3 Dec 2015 16:12:06 +0000
Subject: Domain faults when CONFIG_CPU_SW_DOMAIN_PAN is enabled
In-Reply-To: <20151203133727.GN8644@n2100.arm.linux.org.uk>
References: <1267b061b66c4d1fa8af1955825bc97a@EMAIL.axentia.se>
 <20151203110041.GK8644@n2100.arm.linux.org.uk>
 <f7774151e4a849e682ae5a607a98140b@EMAIL.axentia.se>
 <20151203115143.GM8644@n2100.arm.linux.org.uk>
 <533b0f1f264e42e78b94bbff9570fb50@EMAIL.axentia.se>
 <20151203133727.GN8644@n2100.arm.linux.org.uk>
Message-ID: <94580382ca344ae2b64f66fb778c6ff7@EMAIL.axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King wrote:
> On Thu, Dec 03, 2015 at 12:08:11PM +0000, Peter Rosin wrote:
> > Russell King wrote:
> > > On Thu, Dec 03, 2015 at 11:38:20AM +0000, Peter Rosin wrote:
> > > > Russell King wrote:
> > > > > On Thu, Dec 03, 2015 at 08:33:13AM +0000, Peter Rosin wrote:
> > > > > > I wrote:
> > > > > > > If I enable CONFIG_CPU_SW_DOMAIN_PAN, I sometimes (but not always) get the
> > > > > > > following (or very similar) on boot.
> > > > > > 
> > > > > > I should have said "if I don't disable", as the option is "default y".
> > > > > > 
> > > > > > Also, if it survives on boot, below is an example of later trouble (after
> > > > > > 30+ minutes on this occasion).
> > > > > 
> > > > > Please apply this patch so we (might) get a slightly better oops dump,
> > > > > and then try to reproduce.
> > > > 
> > > > Sure thing, but it's still "DAC: 00000051"...
> > > 
> > > Thanks, that confirms that something in the uaccess-with-memcpy code
> > > is clearing the DACR back to 0x51.
> > > 
> > > This has come up several times before, and I really can't spot the
> > > problem in this code, so I've always said to disable the
> > > uaccess-with-memcpy code.  Personally, I'd like to see the back
> > > of that code...
> > 
> > Ok, but it's not me doing crazy things if that's what you are implying
> > (not saying that you are), because the sama5_defconfig has
> > 
> > 	CONFIG_UACCESS_WITH_MEMCPY=y
> > 
> > So, something needs to happen or sama5 remains default-broken.
> 
> I have no solution for this, other than saying that uaccess-with-memcpy
> seems to be (for some unknown reason) incompatible with SW PAN.
> 
> Out of the two features, I'd go for SW PAN over uaccess-with-memcpy,
> but others will have a different opinion.  The real solution is to
> track down what's going on and why, but I don't think anyone has the
> motivation to do that.
> 
> I've looked into this problem, and I've been unable to identify what's
> going on here.  I can see no reason for the DACR to be set to 0x51 in
> this code.
> 
> The entry path into this code is via __copy_to_user(), which saves and
> sets the DACR to 0x55 before calling arm_copy_to_user(), which for
> uaccess-with-memcpy() is in arch/arm/lib/uaccess_with_memcpy.c.  That
> tail-calls into __copy_to_user_memcpy(), which should run with the
> DACR set to 0x55.
> 
> The only place that the DACR is changed is inside __put_user(), which
> saves the DACR before also setting it to 0x55, and then restores the
> old DACR value, which, because the old value was 0x55, will have no
> effect.
> 
> So, I can see no way that the DACR should ever be 0x51 inside
> __copy_to_user_memcpy(), but you are seeing such a scenario.  I've no
> idea how you could ever get a value of 0x51 out of the DACR within this
> code.

Since it seems like a race is at the bottom of the observed problems, I'm
going to look for things that look racy. The things that stand out to me
are:

* uaccess.h:modify_domain() does a read-modify-write on DACR using
  get_domain and set_domain, and I don't see any locking. Is that
  safe? Why?

* uaccess_with_memcpy.c:__copy_to_user() has a mode in which it copies
  "non-atomically" (if faulthandler_disabled() returns 0). If a fault
  happens during __copy_to_user, what prevents some other thread from
  clobbering DACR?

* In uaccess.h:uaccess_save_and_enable(), what prevents a context
  switch between the get_domain and set_domain calls?

Just asking questions, I have no prior experience with this code...

Cheers,
Peter
