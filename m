From: viro@ZenIV.linux.org.uk (Al Viro)
Date: Fri, 12 May 2017 23:57:55 +0100
Subject: [kernel-hardening] Re: [PATCH v9 1/4] syscalls: Verify address
 limit before returning to user-mode
In-Reply-To: <1494625675.29205.21.camel@redhat.com>
References: <CAGXu5j+EatK=DYONRkgovwLgytAnbG8jnAZaMSLckZFNVj3gig@mail.gmail.com>
 <20170512075458.09a3a1ce@mschwideX1>
 <CAGXu5jL9vUrn4kpjO+qa4cHmWBypeqP17OGbrMs=5Nz0YpQMZw@mail.gmail.com>
 <CA+55aFzbiBqsYb7vwO=+L4Vp_GOgPu+DBOrq4fBnyzq5DbBehg@mail.gmail.com>
 <CAGXu5j+xmyJ6RhtPw9rUgs7k3sZ1KKWffvyGGG--oPfu9W42ng@mail.gmail.com>
 <20170512202106.GO22219@n2100.armlinux.org.uk>
 <20170512210645.GS390@ZenIV.linux.org.uk>
 <CAGXu5jJu=VTqp2tzkPB4RAVxdGC+_SSQwrUwdzWpu24AA-zEcg@mail.gmail.com>
 <20170512214144.GT390@ZenIV.linux.org.uk>
 <1494625675.29205.21.camel@redhat.com>
Message-ID: <20170512225755.GU390@ZenIV.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 12, 2017 at 05:47:55PM -0400, Rik van Riel wrote:

> > Seriously, look at these beasts.??Overwriting ->addr_limit is nowhere
> > near
> > the top threat.??If attacker can overwrite thread_info, you have
> > lost.
> 
> That is why THREAD_INFO_IN_TASK exists. It moves
> the struct thread_info to a location away from the
> stack, which means a stack overflow will not overwrite
> the thread_info.

... in which case such attacks on ->addr_limit also become a non-issue.

AFAICS, we are mixing several unrelated issues here:
	* amount of places where set_fs() is called.  Sure, reducing it
is a good idea and we want to move to primitives like kernel_write() et.al.
Fewer users => lower odds of screwing it up.
	* making sure that remaining callers are properly paired.  Ditto.
	* switching to ->read_iter()/->write_iter() where it makes sense.
Again, no problem with that.
	* providing sane environment for places like perf/oprofile.  Again,
a good idea, and set_fs(USER_DS) is only a part of what's needed there.
	* switching _everything_ to ->read_iter()/->write_iter().  Flat-out
insane and AFAICS nobody is signing up for that.
	* getting rid of set_fs() entirely.  I'm afraid that it's not feasible
without the previous one and frankly, I don't see much point.
	* sanity-checking on return to userland.  Maybe useful, maybe not.
	* taking thread_info out of the way of stack overflows.  Reasonable,
but has very little to do with the rest of that.
	* protecting against Lovecraftian horrors slithering in from the outer
space only to commit unspeakable acts against ->addr_limit and ignoring much
tastier targets next to it, but then what do you expect from degenerate
spawn of Great Old Ones - sanity?
