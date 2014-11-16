From: dalias@libc.org (Rich Felker)
Date: Sun, 16 Nov 2014 00:56:56 -0500
Subject: ARM atomics overhaul for musl
Message-ID: <20141116055656.GA13940@brightrain.aerifal.cx>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

One item on the agenda for this release cycle is overhauling the way
atomics are done on ARM. I'm cc'ing people who have been involved in
this discussion in the past in case anyone's not on the musl list and
has opinions about what should be done.

The current situation looks like the following:

Pre-v6: Hard-coded to use cas from kuser_helper page (0xffff0fc0)

v6: Hard-coded to use ldrex/strex with mcr-based barrier

v7+: Hard-coded to use ldrex/strex with dmb-based barrier

In the cases where ldrex/strex are used directly, they're still not
used optimally; all the non-cas primitives like atomic inc/dec are
built on top of cas and thus have more loop complexity and probably
more barriers than they should.

Aside from that, the only case among the above that's "right" already
is v7+. Hard-coding the mcr-based barrier on v6 is wrong because it's
deprecated (future models may not support the instruction, and
although the kernel could trap and emulate it this would be horribly
slow) and hard-coding kuser helper on pre-v6 is wrong because pre-v6
binaries might run on v6+ hardware and kernel where the kernel has
been built with the kuser_helper page removed for security.

My main goals for this overhaul are:

1. Make baseline (pre-v6) binaries truely universal so they run even
   on kernels with kuser_helper removed.

2. Make v7+ perform competitively. This means optimal code sequences
   for a_cas, a_swap, a_fetch_add, a_store, etc. rather than just
   doing everything with a_cas.

What's still not entirely clear is what to do with v6, and how goal #1
should be achieved. The options are basically:

A. Prefer using ldrex/strex and an appropriate barrier directly, but
   fall back to kuser_helper (assuming it's present) if the hwcap or
   similar does not indicate availability of atomics.

B. Prefer kuser_helper and and only fallback to using atomics and an
   appropriate barrier directly if kuser_helper page is missing.

Of these two approaches, A seems easier, because it's easier to know
that atomics are available (via HWCAP_TLS) than that kuser_helper is
(which requires some sort of probe for the mapping if we want to
support grsec kernels where the mapping is completely missing; if not,
we can just check the kuser version number at a fixed address).
However neither is really very easy because it seems impossible to
detect whether the mcr-based barrier or the dmb-based barrier should
be used -- there's no hwcap flag to indicate support for the latter.
This also complicates what to do in builds for v6.

Before proceeding, I think we need some sort of proposed way to detect
the availability of dmb. If there really is none, we probably need to
go with option B (prefer kuser_helper) for both pre-v6 and v6 (i.e.
only use atomics directly on v7+) and choose what to do when
kuser_helper is missing: either assume v7+ and use dmb, or assume that
the mcr barrier is still working and use it. I think I would lean
towards the latter.

Rich
