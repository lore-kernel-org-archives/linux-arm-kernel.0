From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 12 Jan 2011 23:52:01 +0100 (CET)
Subject: BUG: spinlock recursion (sys_chdir, user_path_at, do_path_lookup
	...)
In-Reply-To: <20110112210241.GM24920@pengutronix.de>
References: <AANLkTimb3i4BiuXvnCdhXn-xnN==NjVg8MDLsDkuFwLC@mail.gmail.com>
	<20110112210241.GM24920@pengutronix.de>
Message-ID: <alpine.LFD.2.00.1101122344500.2678@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 12 Jan 2011, Uwe Kleine-K?nig wrote:
> > Reverting: fs: rcu-walk aware d_revalidate method
> > commit: 34286d6662308d82aed891852d04c7c3a2649b16
> I found that one, too, in the meantime.  Currently debugging that with
> tglx on irc.

The last finding is that parent and dentry in
nameidata_dentry_drop_rcu() are the same, which explains the lock
recursion nicely. 

@nick: Anything you want us to add to the debugging ?

@peterz: Why does lockdep ignore the lock recursion in that
	 spin_lock_nested() call?

Thanks,

	tglx
