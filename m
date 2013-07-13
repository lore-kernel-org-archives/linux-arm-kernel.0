From: fgenfb@yahoo.com (Harm Hanemaaijer)
Date: Sat, 13 Jul 2013 15:51:07 +0000 (UTC)
Subject: Call for testing/opinions: Optimized memset/memcpy
Message-ID: <loom.20130713T172357-560@post.gmane.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I've been doing some work on optimizing the memset/memcpy family of
functions for modern ARM platforms, including copy_page, memset,
memzero, memcpy, copy_from_user and copy_to_user. It appears that
there is room for improvement, especially with regard to using an
optimal preload strategy for armv6/v7 architectures as well as
aligning the write target. For example, on an armv6-based platform
(RPi) I am seeing a 80% speed-up in copy_page and large sized
memcpy. Gains in the range 10-25% are seen on a Cortex A8 device.
These optimizations use the regular register file, like the
previous implementation, and do not use any NEON or vfp registers.

To properly benchmark and test these new implementations, I've
created a userspace testing utility that can be used to compare
and validate exact copies of the original and optimized kernel
versions of the functions in userspace. The repository is
available at https://github.com/hglm/test-arm-kernel-memcpy.git.
It would be useful to compare the results on different
platforms and to check whether changes in the prefetch distance
or write alignment result in optimized performance.

I've created a preliminary patch set that replaces the copy_page,
memset and memzero functions for all ARM platforms. Features
include use of a configurable prefetch distance in copy_page,
translation to 16-bit Thumb2 instructions whenever possible,
optimization for the common word-aligned case in memset/memzero,
and application of a predefined write alignment in memset/memzero.
In order to safely use unified ARM assembler syntax, which appears
to be desirable going forward, the first patch in the set renames
all references of the "push" macro so that it no longer conflicts
with the "push" instruction defined in unified syntax. The new
memset/memzero functions use the unified syntax. The patch set
is available at
https://github.com/hglm/patches/tree/master/arm-mem-funcs.

Optimization of memcpy/copy_from_user/copy_to_user is more
complicated, and although I've created optimized versions that
provide better results in benchmarks, we have to be careful that
increased code size and branch prediction burden does not result
in lower performance in real-world use, especially on older
platforms. Therefore it might be desirable to only enable them
on newer platforms like armv6/v7.

So in short, I am looking for opinions, and test results especially
from the userspace benchmark, to see the relative merit of these
optimizations on different platforms.
