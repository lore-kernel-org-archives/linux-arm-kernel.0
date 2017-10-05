From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 5 Oct 2017 16:11:10 +0100
Subject: [PATCH] arm64: Use larger stacks when KASAN is selected
In-Reply-To: <20171004113908.GD23092@leverpostej>
References: <1507051546-11677-1-git-send-email-mark.rutland@arm.com>
 <20171004113130.t76oxehchtfcvbo3@armageddon.cambridge.arm.com>
 <20171004113908.GD23092@leverpostej>
Message-ID: <20171005151110.dvgnpruwyiml2pse@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 04, 2017 at 12:39:09PM +0100, Mark Rutland wrote:
> On Wed, Oct 04, 2017 at 12:31:31PM +0100, Catalin Marinas wrote:
> > On Tue, Oct 03, 2017 at 06:25:46PM +0100, Mark Rutland wrote:
> > > AddressSanitizer instrumentation can significantly bloat the stack, and
> > > with GCC 7 this can result in stack overflows at boot time in some
> > > configurations.
> > > 
> > > We can avoid this by doubling our stack size when KASAN is in use, as is
> > > already done on x86 (and has been since KASAN was introduced).
> > > Regardless of other patches to decrease KASAN's stack utilization,
> > > kernels built with KASAN will always require more stack space than those
> > > built without, and we should take this into account.
> > > 
> > > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > Cc: Will Deacon <will.deacon@arm.com>
> > > Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> > > ---
> > >  arch/arm64/include/asm/memory.h | 9 ++++++---
> > >  1 file changed, 6 insertions(+), 3 deletions(-)
> > > 
> > > In local testing (with KASAN and other options enabled), I've seen a stack
> > > depth of 23928 bytes while booting to a prompt with an Ubuntu 14.04 filesystem
> > > mounted over NFS. Without KASAN (but with other debug options enabled), this
> > > was 7992 bytes.
> > > 
> > > I wonder if we want to go for 4x rather than 2x...
> > 
> > Let's hope it's fine for now with 32K stacks. We may run into allocation
> > issues with 64K stacks (and without VMAP_STACKS).
> > 
> > Do you want this patch for 4.14?
> 
> If you're happy to take it, that would be great, but otherwise it can
> wait for v4.15.
> 
> Arguably this fixes the introduction of KASAN to arm64, but I'm not sure
> how much we care about backporting this to stable.

I queued it for 4.14. If anyone thinks it's really important for older
kernels, we can send it to stable later (I don't think it is though).

-- 
Catalin
