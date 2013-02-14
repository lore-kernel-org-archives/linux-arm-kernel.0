From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Thu, 14 Feb 2013 17:07:43 +0000
Subject: [BUG] v7_coherent_kern_range broken on big.LITTLE
Message-ID: <1360861663.3266.58.camel@linaro1.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The function v7_coherent_kern_range uses the macro icache_line_size to
read the current CPUs icache line size for the purpose of invalidating
all cache lines in the given range.

Unfortunately, on the TC2 big.LITTLE test chip, the A15 icache line size
is 64 bytes, but the A7 size is only 32 bytes. So when the function
executes on the A15 it will miss out every alternate cache line for the
A7.

Presumably all the functions which use dcache_line_size are also
potentially buggy?

This problem was discovered whilst investigating why function tracer was
crashing in an unpredictable fashion. This was discussed previously but
the root cause misdiagnosed, see http://lkml.org/lkml/2012/12/6/261

-- 
Tixy


 
