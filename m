From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 22 Apr 2011 21:37:53 +0200 (CEST)
Subject: Common clock and dvfs
In-Reply-To: <BANLkTimVXbp1pFsGPcs-RPY+PTOF6ZRyoQ@mail.gmail.com>
References: <BANLkTimVXbp1pFsGPcs-RPY+PTOF6ZRyoQ@mail.gmail.com>
Message-ID: <alpine.LFD.2.02.1104222039330.3323@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 22 Apr 2011, Colin Cross wrote:
> Now that we are approaching a common clock management implementation,
> I was thinking it might be the right place to put a common dvfs
> implementation as well.

Hehe, that would have been my next stupid question :)
 
> Is the clock api the right place to do dvfs, or should the clock api
> be kept simple, and more complicated operations like dvfs be kept
> outside?

I think it's an orthogonal issue which can be solved once we have
generic implementations in place for clk_ functions which result in
DFVS relevant changes.

clk_prepare()
{
	lock_tree();
	if (dvfs_validate())
		return -ECRAP;
	prepare();
	unlock_tree();
}

clk_unprepare()
{
	lock_tree();
	unprepare();
	dvfs_recalc();
	unlock_tree();
}

clk_set_rate()
{
	lock_tree();

	if (rate > clk->rate && dvfs_prevalidate(rate))
		return -ECRAP;

	set_and_propagate_rate();

	if (rate < old->rate)
	   dvfs_recalc();

	unlock_tree();
}

We can put the dvfs functions into the propagation code as well and
back out there when dvfs tells us. That probably works nicely for
prepare and unprepare, but might be complex for set_rate in the actual
set_rate propagation (except when the rate is less than the original
one).

I was wondering already whether we might need to do a pre check for
set_rate when we get called from random drivers. For two reasons:

 1) Is the change valid for all childs of the clock

 2) Be more clever than saying no, when the requested rate cannot be
    provided. Someone mentioned this elsewhere in the clk thread, that
    it would be nice to be able to figure out whether changing one of
    the parent clocks would allow to satisfy all childs up the tree.

Again, that's an extension and optimization and fits nicely into the
basic feature set I'm trying to come up with.

Those functions want to be implemented in drivers/clk/ so they can
share internals with the clock interface. Then you can also integrate
other DVFS users by locking the clk tree for validation or propagation
purposes.

So yes, we want integration at the interface and concept level, but
the actual implementation wants to be outside. That keeps the clk code
nice and simple. A few extra checks/calls here and there with proper
inline replacements for the !DVFS case are not making the code a big
mess. Of course you need at least a pointer to the OPP tables in the
clock structure, but that's the least of our worries.

Thanks,

	tglx
