From: gilles.chanteperdrix@xenomai.org (Gilles Chanteperdrix)
Date: Tue, 23 Mar 2010 13:39:14 +0100
Subject: ARM caches variants.
Message-ID: <4BA8B672.7030508@xenomai.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

I am trying to have a better understanding of the issues with the
various types of caches used on ARM, and I came to a question I feel is
really stupid, but can not find the answer myself.

As I understood, the VIVT cache has the following issues:
- issue #1; two processes may use the same virtual address for different
physical addresses, but will share the same cache line and see memory
corruption if no precaution is taken;
- issue #2; two processes may use different virtual addresses for the
same physical address (shared mapping), but will use different cache
lines, causing all sorts of incoherence if no precaution is taken;
- issue #3; the same process may use different virtual addresses for the
same physical address (same shared mapping mapped several time in the
same process virtual memory), basically almost the same issue as issue #2.

The Linux kernel, solves issue #1 and #2 by flushing the cache at every
context switch, and issue #3 by remapping the multiply mapped shared
mapping in "uncacheable, buffered only" mode if write buffer is
sufficiently well behaved, or "uncacheable, unbuffered" mode if write
buffer is buggy.

Now, if we look at VIPT, aliasing caches:
- the physical tagging solves issue #1 automatically,
- the cache colouring technique used in arch_get_unmapped_area solves
issue #2 and #3 by ensuring that the areas using the same physical
address will end up using the same cache lines, and avoid aliases "by
construction".

VIPT non-aliasing caches have none of the three issues.

First question: did I get it right?
Second question: do issue #1, #2 and #3 have official non-ambiguous names?
Now, the stupid question: why not using the cache colouring technique
used for VIPT caches to solve issue #3 with VIVT caches?

I have thought about several answers:
- there is a technical reason which will make the cache colouring
technique fail with VIVT;
- the reason is purely historical, the two solutions were implemented at
different times;
- the issue #3 is a corner case and the cache colouring technique
induces a potential waste of virtual address space, so the trade off is
not interesting.

Thanks in advance for your answer.

-- 
					    Gilles.
