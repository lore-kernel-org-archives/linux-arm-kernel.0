From: balbi@ti.com (Felipe Balbi)
Date: Wed, 25 Feb 2015 11:51:43 -0600
Subject: build warning on v4.0-rc1
Message-ID: <20150225175143.GE11136@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Al,

commit 3b994d98a815d934ab6a77a380882865982c14f9 (get rid of the second
argument of acct_kill()) added a new build warning when building
kernel/acct.c. Warning can be seen below. Revert of that commit is
non-trivial, so I haven't tried to check if reverting it fixes the
warning.

One one to silent the warning would be to cast return of cmpxchg to void
on the call inside acct_pin_kill(), but maybe there's a better way?

In file included from ./arch/arm/include/asm/atomic.h:19:0,
                 from include/linux/atomic.h:4,
                 from include/linux/debug_locks.h:5,
                 from include/linux/lockdep.h:23,
                 from include/linux/spinlock_types.h:18,
                 from include/linux/spinlock.h:81,
                 from include/linux/mmzone.h:7,
                 from include/linux/gfp.h:5,
                 from include/linux/mm.h:9,
                 from kernel/acct.c:46:
kernel/acct.c: In function ?acct_kill?:
./arch/arm/include/asm/cmpxchg.h:205:3: warning: value computed is not used [-Wunused-value]
  ((__typeof__(*(ptr)))__cmpxchg_mb((ptr),   \
   ^
kernel/acct.c:181:3: note: in expansion of macro ?cmpxchg?
   cmpxchg(&ns->bacct, acct, NULL);
   ^

cheers

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150225/ef25bff5/attachment.sig>
