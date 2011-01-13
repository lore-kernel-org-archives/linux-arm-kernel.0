From: peterz@infradead.org (Peter Zijlstra)
Date: Thu, 13 Jan 2011 12:01:00 +0100
Subject: BUG: spinlock recursion (sys_chdir, user_path_at,
	do_path_lookup ...)
In-Reply-To: <alpine.LFD.2.00.1101122344500.2678@localhost6.localdomain6>
References: <AANLkTimb3i4BiuXvnCdhXn-xnN==NjVg8MDLsDkuFwLC@mail.gmail.com>
	<20110112210241.GM24920@pengutronix.de>
	<alpine.LFD.2.00.1101122344500.2678@localhost6.localdomain6>
Message-ID: <1294916460.19601.89.camel@laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-01-12 at 23:52 +0100, Thomas Gleixner wrote:
> On Wed, 12 Jan 2011, Uwe Kleine-K?nig wrote:
> > > Reverting: fs: rcu-walk aware d_revalidate method
> > > commit: 34286d6662308d82aed891852d04c7c3a2649b16
> > I found that one, too, in the meantime.  Currently debugging that with
> > tglx on irc.
> 
> The last finding is that parent and dentry in
> nameidata_dentry_drop_rcu() are the same, which explains the lock
> recursion nicely. 
> 
> @nick: Anything you want us to add to the debugging ?
> 
> @peterz: Why does lockdep ignore the lock recursion in that
>          spin_lock_nested() call?

$ git show 34286d6662308d82aed891852d04c7c3a2649b16 | grep spin_lock_nested | wc -l
0

Uhm, whot?!
