From: djb@cr.yp.to (D. J. Bernstein)
Date: 5 Oct 2018 15:05:38 -0000
Subject: [PATCH net-next v6 19/23] zinc: Curve25519 ARM implementation
References: <20180925145622.29959-1-Jason@zx2c4.com>
 <20180925145622.29959-20-Jason@zx2c4.com>
 <CAKv+Gu9FLDRLxHReKcveZYHNYerR5Y2pZd9gn-hWrU0jb2KgfA@mail.gmail.com>
 <CAHmME9rp0Fi5ObK5oi8FHj1_nK5hP4T2Bq7_dAmzq4OQ0mp0uw@mail.gmail.com>
Message-ID: <20181005150538.17006.qmail@cr.yp.to>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For the in-order ARM Cortex-A8 (the target for this code), adjacent
multiply-add instructions forward summands quickly. A simple in-order
dot-product computation has no latency problems, while interleaving
computations, as suggested in this thread, creates problems. Also, on
this microarchitecture, occasional ARM instructions run in parallel with
NEON, so trying to manually eliminate ARM instructions through global
pointer tracking wouldn't gain speed; it would simply create unnecessary
code-maintenance problems.

See https://cr.yp.to/papers.html#neoncrypto for analysis of the
performance of---and remaining bottlenecks in---this code. Further
speedups should be possible on this microarchitecture, but, for anyone
interested in this, I recommend focusing on building a cycle-accurate
simulator (e.g., fixing inaccuracies in the Sobole simulator) first.

Of course, there are other ARM microarchitectures, and there are many
cases where different microarchitectures prefer different optimizations.
The kernel already has boot-time benchmarks for different optimizations
for raid6, and should do the same for crypto code, so that implementors
can focus on each microarchitecture separately rather than living in the
barbaric world of having to choose which CPUs to favor.

---Dan
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181005/4e88b0fb/attachment.sig>
