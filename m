From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 12 May 2017 21:45:56 +0100
Subject: [kernel-hardening] Re: [PATCH v9 1/4] syscalls: Verify address
 limit before returning to user-mode
In-Reply-To: <20170512203044.GI4626@worktop.programming.kicks-ass.net>
References: <CAJcbSZEoRyewUtBHvqmNZL9FtT_q42Vmmd-EuC50x-ZRASiHHg@mail.gmail.com>
 <CA+55aFwvQfs_X+paQF6Luc0Rq+W3J2fKuHRou7=ANcquDdXdDA@mail.gmail.com>
 <20170512072802.5a686f23@mschwideX1>
 <CAGXu5j+EatK=DYONRkgovwLgytAnbG8jnAZaMSLckZFNVj3gig@mail.gmail.com>
 <20170512075458.09a3a1ce@mschwideX1>
 <CAGXu5jL9vUrn4kpjO+qa4cHmWBypeqP17OGbrMs=5Nz0YpQMZw@mail.gmail.com>
 <CA+55aFzbiBqsYb7vwO=+L4Vp_GOgPu+DBOrq4fBnyzq5DbBehg@mail.gmail.com>
 <CAGXu5j+xmyJ6RhtPw9rUgs7k3sZ1KKWffvyGGG--oPfu9W42ng@mail.gmail.com>
 <20170512202106.GO22219@n2100.armlinux.org.uk>
 <20170512203044.GI4626@worktop.programming.kicks-ass.net>
Message-ID: <20170512204556.GP22219@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 12, 2017 at 10:30:44PM +0200, Peter Zijlstra wrote:
> On Fri, May 12, 2017 at 09:21:06PM +0100, Russell King - ARM Linux wrote:
> > On Fri, May 12, 2017 at 12:30:02PM -0700, Kees Cook wrote:
> > > I'm clearly not explaining things well enough. I shouldn't say
> > > "corruption", I should say "malicious manipulation". The methodology
> > > of attacks against the stack are quite different from the other kinds
> > > of attacks like use-after-free, heap overflow, etc. Being able to
> > > exhaust the kernel stack (either due to deep recursion or unbounded
> > > alloca())
> > 
> > I really hope we don't have alloca() use in the kernel.  Do you have
> > evidence to support that assertion?
> > 
> > IMHO alloca() (or similar) should not be present in any kernel code
> > because we have a limited stack - we have kmalloc() etc for that kind
> > of thing.
> 
> On stack variable length arrays get implemented by the compiler doing
> alloca(), and we sadly have a few of those around.

I hope their size is appropriately limited, but something tells me it
would be foolish to assume that.

> But yes, fully agreed on the desirability of alloca() and things.

Hmm, I wonder if -fno-builtin-alloca would prevent those... it looks
like it certainly would prevent an explicit alloca() call.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
