From: peterz@infradead.org (Peter Zijlstra)
Date: Thu, 13 Jan 2011 12:17:47 +0100
Subject: BUG: spinlock recursion (sys_chdir, user_path_at,
	do_path_lookup ...)
In-Reply-To: <1294916460.19601.89.camel@laptop>
References: <AANLkTimb3i4BiuXvnCdhXn-xnN==NjVg8MDLsDkuFwLC@mail.gmail.com>
	<20110112210241.GM24920@pengutronix.de>
	<alpine.LFD.2.00.1101122344500.2678@localhost6.localdomain6>
	<1294916460.19601.89.camel@laptop>
Message-ID: <1294917467.19601.94.camel@laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On Wed, 2011-01-12 at 23:52 +0100, Thomas Gleixner wrote:

> > @peterz: Why does lockdep ignore the lock recursion in that
> >          spin_lock_nested() call?

So after some hints on IRC on where to look:

<tglx>         spin_lock(&parent->d_lock);
<tglx>         spin_lock_nested(&dentry->d_lock, DENTRY_D_LOCK_NESTED);
<tglx> if parent == dentry

That won't yell because you explicitly tell lockdep its ok, I know what
I'm doing.

Several lockdep annotations (including this one) allow you to annotate
real bugs away, hence you really need to be sure about things when you
make them.
