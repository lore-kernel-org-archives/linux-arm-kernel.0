From: fgenfb@yahoo.com (Harm Hanemaaijer)
Date: Sat, 13 Jul 2013 21:51:18 +0000 (UTC)
Subject: Call for testing/opinions: Optimized memset/memcpy
References: <loom.20130713T172357-560@post.gmane.org>
 <20130713172445.GL32054@1wt.eu>
Message-ID: <loom.20130713T232124-511@post.gmane.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Willy Tarreau <w <at> 1wt.eu> writes:

> OK I've run bench.script on the following platforms :

Thanks, that's incredibly helpful!

Note that Thumb2 mode usually doesn't do much in synthetic benchmarks,
because the benchmark code will fit into the L1 instruction cache; the
benefit of Thumb2 happens in real-world usage when the active code
footprint becomes larger.

To summarize, memset seems to be in good shape and also the "fast path"
for common word-aligned memcpy of size <= 256 seems to be working well.

However, the copy_page and memcpy results for larger sizes seem to suggest
that the prefetch strategy isn't working well on these platforms. Note also
that on the quad core the existing copy_page is also highly sub-optimal.

Fixing the preload strategy for these platforms may simply be a case of
changing the configurable constant PREFETCH_DISTANCE from 3 to 2 (from an
offset of 192 bytes to 128 bytes), which more closely mimics the original
kernel memcpy. I have added PREFETCH_DISTANCE as a configurable parameter
in the Makefile in the latest version of test-arm-kernel-memcpy. It will
be interesting to see the results of testing with a PREFETCH_DISTANCE
of 2 especially on the quad-core platform or a similar one.
