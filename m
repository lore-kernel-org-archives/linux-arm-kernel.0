From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 09 Jan 2013 19:20:39 -0500
Subject: [PATCH 04/16] ARM: b.L: Add baremetal voting mutexes
In-Reply-To: <1357777251-13541-1-git-send-email-nicolas.pitre@linaro.org>
References: <1357777251-13541-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1357777251-13541-5-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dave Martin <dave.martin@linaro.org>

This patch adds a simple low-level voting mutex implementation
to be used to arbitrate during first man selection when no load/store
exclusive instructions are usable.

For want of a better name, these are called "vlocks".  (I was
tempted to call them ballot locks, but "block" is way too confusing
an abbreviation...)

There is no function to wait for the lock to be released, and no
vlock_lock() function since we don't need these at the moment.
These could straightforwardly be added if vlocks get used for other
purposes.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 Documentation/arm/big.LITTLE/vlocks.txt | 211 ++++++++++++++++++++++++++++++++
 arch/arm/common/vlock.S                 | 108 ++++++++++++++++
 arch/arm/common/vlock.h                 |  43 +++++++
 3 files changed, 362 insertions(+)
 create mode 100644 Documentation/arm/big.LITTLE/vlocks.txt
 create mode 100644 arch/arm/common/vlock.S
 create mode 100644 arch/arm/common/vlock.h

diff --git a/Documentation/arm/big.LITTLE/vlocks.txt b/Documentation/arm/big.LITTLE/vlocks.txt
new file mode 100644
index 0000000000..90672ddc6a
--- /dev/null
+++ b/Documentation/arm/big.LITTLE/vlocks.txt
@@ -0,0 +1,211 @@
+vlocks for Bare-Metal Mutual Exclusion
+======================================
+
+Voting Locks, or "vlocks" provide a simple low-level mutual exclusion
+mechanism, with reasonable but minimal requirements on the memory
+system.
+
+These are intended to be used to coordinate critical activity among CPUs
+which are otherwise non-coherent, in situations where the hardware
+provides no other mechanism to support this and ordinary spinlocks
+cannot be used.
+
+
+vlocks make use of the atomicity provided by the memory system for
+writes to a single memory location.  To arbitrate, every CPU "votes for
+itself", by storing a unique number to a common memory location.  The
+final value seen in that memory location when all the votes have been
+cast identifies the winner.
+
+In order to make sure that the election produces an unambiguous result
+in finite time, a CPU will only enter the election in the first place if
+no winner has been chosen and the election does not appear to have
+started yet.
+
+
+Algorithm
+---------
+
+The easiest way to explain the vlocks algorithm is with some pseudo-code:
+
+
+	int currently_voting[NR_CPUS] = { 0, };
+	int last_vote = -1; /* no votes yet */
+
+	bool vlock_trylock(int this_cpu)
+	{
+		/* signal our desire to vote */
+		currently_voting[this_cpu] = 1;
+		if (last_vote != -1) {
+			/* someone already volunteered himself */
+			currently_voting[this_cpu] = 0;
+			return false; /* not ourself */
+		}
+
+		/* let's suggest ourself */
+		last_vote = this_cpu;
+		currently_voting[this_cpu] = 0;
+
+		/* then wait until everyone else is done voting */
+		for_each_cpu(i) {
+			while (currently_voting[i] != 0)
+				/* wait */;
+		}
+
+		/* result */
+		if (last_vote == this_cpu)
+			return true; /* we won */
+		return false;
+	}
+
+	bool vlock_unlock(void)
+	{
+		last_vote = -1;
+	}
+
+
+The currently_voting[] array provides a way for the CPUs to determine
+whether an election is in progress, and plays a role analogous to the
+"entering" array in Lamport's bakery algorithm [1].
+
+However, once the election has started, the underlying memory system
+atomicity is used to pick the winner.  This avoids the need for a static
+priority rule to act as a tie-breaker, or any counters which could
+overflow.
+
+As long as the last_vote variable is globally visible to all CPUs, it
+will contain only one value that won't change once every CPU has cleared
+its currently_voting flag.
+
+
+Features and limitations
+------------------------
+
+ * vlocks are not intended to be fair.  In the contended case, it is the
+   _last_ CPU which attempts to get the lock which will be most likely
+   to win.
+
+   vlocks are therefore best suited to situations where it is necessary
+   to pick a unique winner, but it does not matter which CPU actually
+   wins.
+
+ * Like other similar mechanisms, vlocks will not scale well to a large
+   number of CPUs.
+
+   vlocks can be cascaded in a voting hierarchy to permit better scaling
+   if necessary, as in the following hypothetical example for 4096 CPUs:
+
+	/* first level: local election */
+	my_town = towns[(this_cpu >> 4) & 0xf];
+	I_won = vlock_trylock(my_town, this_cpu & 0xf);
+	if (I_won) {
+		/* we won the town election, let's go for the state */
+		my_state = states[(this_cpu >> 8) & 0xf];
+		I_won = vlock_lock(my_state, this_cpu & 0xf));
+		if (I_won) {
+			/* and so on */
+			I_won = vlock_lock(the_whole_country, this_cpu & 0xf];
+			if (I_won) {
+				/* ... */
+			}
+			vlock_unlock(the_whole_country);
+		}
+		vlock_unlock(my_state);
+	}
+	vlock_unlock(my_town);
+
+
+ARM implementation
+------------------
+
+The current ARM implementation [2] contains a some optimisations beyond
+the basic algorithm:
+
+ * By packing the members of the currently_voting array close together,
+   we can read the whole array in one transaction (providing the number
+   of CPUs potentially contending the lock is small enough).  This
+   reduces the number of round-trips required to external memory.
+
+   In the ARM implementation, this means that we can use a single load
+   and comparison:
+
+	LDR	Rt, [Rn]
+	CMP	Rt, #0
+
+   ...in place of code equivalent to:
+
+	LDRB	Rt, [Rn]
+	CMP	Rt, #0
+	LDRBEQ	Rt, [Rn, #1]
+	CMPEQ	Rt, #0
+	LDRBEQ	Rt, [Rn, #2]
+	CMPEQ	Rt, #0
+	LDRBEQ	Rt, [Rn, #3]
+	CMPEQ	Rt, #0
+
+   This cuts down on the fast-path latency, as well as potentially
+   reducing bus contention in contended cases.
+
+   The optimisation relies on the fact that the ARM memory system
+   guarantees coherency between overlapping memory accesses of
+   different sizes, similarly to many other architectures.  Note that
+   we do not care which element of currently_voting appears in which
+   bits of Rt, so there is no need to worry about endianness in this
+   optimisation.
+
+   If there are too many CPUs to read the currently_voting array in
+   one transaction then multiple transations are still required.  The
+   implementation uses a simple loop of word-sized loads for this
+   case.  The number of transactions is still fewer than would be
+   required if bytes were loaded individually.
+
+
+   In principle, we could aggregate further by using LDRD or LDM, but
+   to keep the code simple this was not attempted in the initial
+   implementation.
+
+
+ * vlocks are currently only used to coordinate between CPUs which are
+   unable to enable their caches yet.  This means that the
+   implementation removes many of the barriers which would be required
+   when executing the algorithm in cached memory.
+
+   packing of the currently_voting array does not work with cached
+   memory unless all CPUs contending the lock are cache-coherent, due
+   to cache writebacks from one CPU clobbering values written by other
+   CPUs.  (Though if all the CPUs are cache-coherent, you should be
+   probably be using proper spinlocks instead anyway).
+
+
+ * The "no votes yet" value used for the last_vote variable is 0 (not
+   -1 as in the pseudocode).  This allows statically-allocated vlocks
+   to be implicitly initialised to an unlocked state simply by putting
+   them in .bss.
+
+   An offset is added to each CPU's ID for the purpose of setting this
+   variable, so that no CPU uses the value 0 for its ID.
+
+
+Colophon
+--------
+
+Originally created and documented by Dave Martin for Linaro Limited, for
+use in ARM-based big.LITTLE platforms, with review and input gratefully
+received from Nicolas Pitre and Achin Gupta.  Thanks to Nicolas for
+grabbing most of this text out of the relevant mail thread and writing
+up the pseudocode.
+
+Copyright (C) 2012  Linaro Limited
+Distributed under the terms of Version 2 of the GNU General Public
+License, as defined in linux/COPYING.
+
+
+References
+----------
+
+[1] Lamport, L. "A New Solution of Dijkstra's Concurrent Programming
+    Problem", Communications of the ACM 17, 8 (August 1974), 453-455.
+
+    http://en.wikipedia.org/wiki/Lamport%27s_bakery_algorithm
+
+[2] linux/arch/arm/common/vlock.S, www.kernel.org.
diff --git a/arch/arm/common/vlock.S b/arch/arm/common/vlock.S
new file mode 100644
index 0000000000..0a1ee3a7f5
--- /dev/null
+++ b/arch/arm/common/vlock.S
@@ -0,0 +1,108 @@
+/*
+ * vlock.S - simple voting lock implementation for ARM
+ *
+ * Created by:	Dave Martin, 2012-08-16
+ * Copyright:	(C) 2012  Linaro Limited
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *
+ *
+ * This algorithm is described in more detail in
+ * Documentation/arm/big.LITTLE/vlocks.txt.
+ */
+
+#include <linux/linkage.h>
+#include "vlock.h"
+
+#if VLOCK_VOTING_SIZE > 4
+#define FEW(x...)
+#define MANY(x...) x
+#else
+#define FEW(x...) x
+#define MANY(x...)
+#endif
+
+@ voting lock for first-man coordination
+
+.macro voting_begin rbase:req, rcpu:req, rscratch:req
+	mov	\rscratch, #1
+	strb	\rscratch, [\rbase, \rcpu]
+	dsb
+.endm
+
+.macro voting_end rbase:req, rcpu:req, rscratch:req
+	mov	\rscratch, #0
+	strb	\rscratch, [\rbase, \rcpu]
+	dsb
+	sev
+.endm
+
+/*
+ * The vlock structure must reside in Strongly-Ordered or Device memory.
+ * This implementation deliberately eliminates most of the barriers which
+ * would be required for other memory types, and assumes that independent
+ * writes to neighbouring locations within a cacheline do not interfere
+ * with one another.
+ */
+
+@ r0: lock structure base
+@ r1: CPU ID (0-based index within cluster)
+ENTRY(vlock_trylock)
+	add	r1, r1, #VLOCK_VOTING_OFFSET
+
+	voting_begin	r0, r1, r2
+
+	ldrb	r2, [r0, #VLOCK_OWNER_OFFSET]	@ check whether lock is held
+	cmp	r2, #VLOCK_OWNER_NONE
+	bne	trylock_fail			@ fail if so
+
+	strb	r1, [r0, #VLOCK_OWNER_OFFSET]	@ submit my vote
+
+	voting_end	r0, r1, r2
+
+	@ Wait for the current round of voting to finish:
+
+ MANY(	mov	r3, #VLOCK_VOTING_OFFSET			)
+0:
+ MANY(	ldr	r2, [r0, r3]					)
+ FEW(	ldr	r2, [r0, #VLOCK_VOTING_OFFSET]			)
+	cmp	r2, #0
+	wfene
+	bne	0b
+ MANY(	add	r3, r3, #4					)
+ MANY(	cmp	r3, #VLOCK_VOTING_OFFSET + VLOCK_VOTING_SIZE	)
+ MANY(	bne	0b						)
+
+	@ Check who won:
+
+	ldrb	r2, [r0, #VLOCK_OWNER_OFFSET]
+	eor	r0, r1, r2			@ zero if I won, else nonzero
+	bx	lr
+
+trylock_fail:
+	voting_end	r0, r1, r2
+	mov	r0, #1				@ nonzero indicates that I lost
+	bx	lr
+ENDPROC(vlock_trylock)
+
+@ r0: lock structure base
+ENTRY(vlock_unlock)
+	mov	r1, #VLOCK_OWNER_NONE
+	dsb
+	strb	r1, [r0, #VLOCK_OWNER_OFFSET]
+	dsb
+	sev
+	bx	lr
+ENDPROC(vlock_unlock)
diff --git a/arch/arm/common/vlock.h b/arch/arm/common/vlock.h
new file mode 100644
index 0000000000..94c29a6caf
--- /dev/null
+++ b/arch/arm/common/vlock.h
@@ -0,0 +1,43 @@
+/*
+ * vlock.h - simple voting lock implementation
+ *
+ * Created by:	Dave Martin, 2012-08-16
+ * Copyright:	(C) 2012  Linaro Limited
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#ifndef __VLOCK_H
+#define __VLOCK_H
+
+#include <asm/bL_entry.h>
+
+#define VLOCK_OWNER_OFFSET	0
+#define VLOCK_VOTING_OFFSET	4
+#define VLOCK_VOTING_SIZE	((BL_CPUS_PER_CLUSTER + 3) / 4 * 4)
+#define VLOCK_SIZE		(VLOCK_VOTING_OFFSET + VLOCK_VOTING_SIZE)
+#define VLOCK_OWNER_NONE	0
+
+#ifndef __ASSEMBLY__
+
+struct vlock {
+	char data[VLOCK_SIZE];
+};
+
+int vlock_trylock(struct vlock *lock, unsigned int owner);
+void vlock_unlock(struct vlock *lock);
+
+#endif /* __ASSEMBLY__ */
+#endif /* ! __VLOCK_H */
-- 
1.8.0
