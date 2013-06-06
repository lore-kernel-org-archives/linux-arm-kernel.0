From: will.deacon@arm.com (Will Deacon)
Date: Thu, 6 Jun 2013 16:17:05 +0100
Subject: [PATCH 0/5] Kernel mode NEON for XOR and RAID6
In-Reply-To: <1370530985-20619-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1370530985-20619-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20130606151705.GG16794@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 06, 2013 at 04:03:00PM +0100, Ard Biesheuvel wrote:
> Hi all,

Hi Ard,

> This is a partial repost of the patches I proposed a couple of weeks ago to add
> support for VFP/NEON in kernel mode.
> 
> This time, I have included two use cases that I have been using, XOR and RAID-6
> checksumming. The former gets a 60% performance boost on the NEON, the latter
> over 400%.

Whilst that sounds impressive, can you achieve similar results across all
NEON-capable CPUs? In particular, we need to make sure this doesn't cause
performance regressions on some cores. Furthermore, do you have any power
figures to complement your findings? The increased context-switch overhead
is also worth measuring if you can (i.e. run some userspace NEON-based
benchmarks in parallel with NEON and non-NEON implementations of the
checksumming).

> lib/raid6: add ARM-NEON accelerated syndrome calculation
> 
> This is a port of the RAID-6 checksumming code in altivec.uc ported to use NEON
> intrinsics. It is about 4x faster than the sequential code. As this code does
> not live under arch/arm, I will send this patch separately to the appropriate 
> list if/when the prerequisite patches from this series have been accepted.

We support building the kernel with older toolchains, so I don't see the
benefit of using intrinsics here. Have you tried writing an implementation
with NEON instructions directly?

Will
