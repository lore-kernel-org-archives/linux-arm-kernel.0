From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 6 Jun 2013 12:17:39 -0400 (EDT)
Subject: [PATCH 0/5] Kernel mode NEON for XOR and RAID6
In-Reply-To: <20130606151705.GG16794@mudshark.cambridge.arm.com>
References: <1370530985-20619-1-git-send-email-ard.biesheuvel@linaro.org>
 <20130606151705.GG16794@mudshark.cambridge.arm.com>
Message-ID: <alpine.LFD.2.03.1306061156330.18597@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 6 Jun 2013, Will Deacon wrote:

> On Thu, Jun 06, 2013 at 04:03:00PM +0100, Ard Biesheuvel wrote:
> > Hi all,
> 
> Hi Ard,
> 
> > This is a partial repost of the patches I proposed a couple of weeks ago to add
> > support for VFP/NEON in kernel mode.
> > 
> > This time, I have included two use cases that I have been using, XOR and RAID-6
> > checksumming. The former gets a 60% performance boost on the NEON, the latter
> > over 400%.
> 
> Whilst that sounds impressive, can you achieve similar results across all
> NEON-capable CPUs? In particular, we need to make sure this doesn't cause
> performance regressions on some cores.

Note that the kernel performs runtime benchmarking of all the different 
implementations it has available at boot time and selects the best one.  
So if this would turn out to make things worse on some cores then the 
Neon code would simply not be used.

> Furthermore, do you have any power figures to complement your 
> findings?

This is going to be most useful in server type environments where a bit 
more power is not such an issue but throughput is ... unless you start 
using RAID6 arrays on your phone that is.  :-)  Otherwise this can be 
left configured out for mobile targets.

> The increased context-switch overhead
> is also worth measuring if you can (i.e. run some userspace NEON-based
> benchmarks in parallel with NEON and non-NEON implementations of the
> checksumming).

Do we know the context switch cost of normal task scheduling between 
tasks using FP operations?  The in-kernel Neon usage should bring about 
the same cost.  Measuring it would be interesting albeit probably 
difficult.

> We support building the kernel with older toolchains, so I don't see the
> benefit of using intrinsics here.

These days the compiler tends to do a better job than humans at properly 
scheduling instructions for some code.  We shouldn't deprive ourselves 
from it when a recent enough gcc is available.


Nicolas
