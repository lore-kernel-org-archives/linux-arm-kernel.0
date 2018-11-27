From: will.deacon@arm.com (Will Deacon)
Date: Tue, 27 Nov 2018 19:44:43 +0000
Subject: [PATCH 0/4] Rewrite of percpu atomics and introduction of LSE
Message-ID: <1543347887-21101-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Whilst looking at what it would take to use LSE atomics for the percpu
operations, I ended up rewriting most of our implementation to address
a number of issues I spotted.

The result is a net reduction of code, whilst at the same time avoiding
duplication, adding support for LSE and improving our manipulation of
the preempt count.

Ard -- I think most of this is orthogonal to your LSE work, since this
doesn't make use of the out-of-line atomics at all. Still, please take
a look all the same!

Cheers,

Will

--->8

Will Deacon (4):
  arm64: Avoid redundant type conversions in xchg() and cmpxchg()
  arm64: Avoid masking "old" for LSE cmpxchg() implementation
  arm64: percpu: Rewrite per-cpu ops to allow use of LSE atomics
  arm64: cmpxchg: Use "K" instead of "L" for ll/sc immediate constraint

 arch/arm64/include/asm/atomic_ll_sc.h |  63 +++---
 arch/arm64/include/asm/atomic_lse.h   |  48 ++---
 arch/arm64/include/asm/cmpxchg.h      | 116 +++++-----
 arch/arm64/include/asm/percpu.h       | 390 ++++++++++++++--------------------
 4 files changed, 278 insertions(+), 339 deletions(-)

-- 
2.1.4
