From: mpeg.blue@free.fr (Mason)
Date: Sun, 28 Dec 2014 19:24:43 +0100
Subject: Memory copy between Linux-managed RAM and other RAM
Message-ID: <54A04AEB.1070502@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello everyone,

I'm working on a Cortex-A9 SoC equipped with 2 GB of RAM.

However, Linux is only given a fraction (typically 256 MB) of the RAM
to manage (via the mem= bootparam) while the rest is managed using
"OS-agnostic software". This "other memory" is meant to be shared
between different hardware blocks of the SoC.

We have a custom "memory_copy" kernel module, to copy between
"Linux-managed RAM" and "SoC-wide RAM". However, the performance
of this routine is... disappointingly underwhelming (8.5 MB/s).

Taking a closer look at the implementation, I spotted some
inefficiencies.

1) data is first copied (in chunks) to a temporary kernel buffer

2) for each word, a hardware remap is setup, then the word
is copied, then the hardware remap is reset. (This hardware
remap technique dates back to when we used MIPS.)

I thought I could both make the implementation simpler, and boost
the performance.

A) I used ioremap to have Linux map the "SoC-wide RAM" physical
addresses to virtual addresses that can be used in the module.

B) I then use copy_{to,from}_user directly between the user-space
buffer and the "SoC-wide RAM".

This approach is ~20x faster than the original.

My main question is:

Is this safe/guaranteed to work all the time? (as long as the
"SoC-wide RAM" is indeed RAM, not MM registers)


Secondary thoughts/questions:

We have routines for accesses in units of {8,16,32} bits.
Since we're dealing with memory, I don't think the width
of the accesses is important, right? (for correctness)

AFAIU, ioremap maps as MT_DEVICE, i.e. uncached, no WC,
all memory optimizations disabled, etc. There might be
some performance improvements by using cached accesses,
and manually flushing when the copy is done.

Also, I don't know if copy_{to,from}_user is optimized
using SIMD/NEON? Maybe there is some perf left on the
table there?

Regards.
