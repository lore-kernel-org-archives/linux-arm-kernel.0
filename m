From: peterz@infradead.org (Peter Zijlstra)
Date: Thu, 13 Jan 2011 12:37:57 +0100
Subject: BUG: spinlock recursion (sys_chdir, user_path_at,
	do_path_lookup ...)
In-Reply-To: <alpine.LFD.2.00.1101131220240.2678@localhost6.localdomain6>
References: <AANLkTimb3i4BiuXvnCdhXn-xnN==NjVg8MDLsDkuFwLC@mail.gmail.com>
	<20110112210241.GM24920@pengutronix.de>
	<alpine.LFD.2.00.1101122344500.2678@localhost6.localdomain6>
	<1294916460.19601.89.camel@laptop> <1294917467.19601.94.camel@laptop>
	<alpine.LFD.2.00.1101131220240.2678@localhost6.localdomain6>
Message-ID: <1294918677.19601.102.camel@laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-01-13 at 12:21 +0100, Thomas Gleixner wrote:
> On Thu, 13 Jan 2011, Peter Zijlstra wrote:
> 
> > 
> > > On Wed, 2011-01-12 at 23:52 +0100, Thomas Gleixner wrote:
> > 
> > > > @peterz: Why does lockdep ignore the lock recursion in that
> > > >          spin_lock_nested() call?
> > 
> > So after some hints on IRC on where to look:
> > 
> > <tglx>         spin_lock(&parent->d_lock);
> > <tglx>         spin_lock_nested(&dentry->d_lock, DENTRY_D_LOCK_NESTED);
> > <tglx> if parent == dentry
> > 
> > That won't yell because you explicitly tell lockdep its ok, I know what
> > I'm doing.
> > 
> > Several lockdep annotations (including this one) allow you to annotate
> > real bugs away, hence you really need to be sure about things when you
> > make them.
> 
> Yeah, I suspected that, but checking whether the pointers are same
> would be nice as it would tell us right away where we fcked up :)
> 

Something like the below would indeed do that, but it makes the
lock_acquire path more expensive, since it will now have to iterate the
held lock stack every time.

(not actually tested)

---
 kernel/lockdep.c |   18 +++++++++++++++++-
 1 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/kernel/lockdep.c b/kernel/lockdep.c
index 42ba65d..d053d9a 100644
--- a/kernel/lockdep.c
+++ b/kernel/lockdep.c
@@ -2740,11 +2740,12 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 {
 	struct task_struct *curr = current;
 	struct lock_class *class = NULL;
-	struct held_lock *hlock;
+	struct held_lock *hlock, *rhlock;
 	unsigned int depth, id;
 	int chain_head = 0;
 	int class_idx;
 	u64 chain_key;
+	int i;
 
 	if (!prove_locking)
 		check = 1;
@@ -2817,6 +2818,21 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 	hlock->holdtime_stamp = lockstat_clock();
 #endif
 
+	for (i = depth-1; i >= 0; i--) {
+		rhlock = curr->held_locks + i;
+		if (rhlock->instance == lock) {
+			if (debug_locks_off() || debug_locks_silent)
+				return 0;
+			printk("Lock recursion, trying to acquire:\n");
+			print_lock(hlock);
+			printk("while already holding:\n");
+			print_lock(rhlock);
+			printk("which is the same lock instance!\n");
+			dump_stack();
+			return 0;
+		}
+	}
+
 	if (check == 2 && !mark_irqflags(curr, hlock))
 		return 0;
 
