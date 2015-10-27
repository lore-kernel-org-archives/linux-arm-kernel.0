From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 27 Oct 2015 14:37:06 +0000
Subject: Trustzone: DSB before/after SMC
In-Reply-To: <562F84BA.5060203@free.fr>
References: <562F7CBA.7060806@free.fr> <20151027134318.GD3091@leverpostej>
 <562F84BA.5060203@free.fr>
Message-ID: <20151027143706.GF3091@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 27, 2015 at 03:05:46PM +0100, Mason wrote:
> On 27/10/2015 14:43, Mark Rutland wrote:
> 
> > On Tue, Oct 27, 2015 at 02:31:38PM +0100, Mason wrote:
> > 
> >> I have a few questions about SMC. (I'm using Cortex-A9)
> >>
> >> Platforms that use SMC often/always execute DSB beforehand.
> > 
> > Please give an example. We don't do this for PSCI, for instance.
> 
> arch/arm/mach-exynos/exynos-smc.S
> arch/arm/mach-highbank/smc.S
> arch/arm/mach-omap2/omap-smc.S

>From a quick look, it's not obvious to me why those DSBs are present. It
would be best to ask the original authors; it may simply be that this
was never necessary and has simply been copied.

In particular, the DSB; DMB; SMC sequence in omap_smc2 makes no sense to
me, given that a DSB provides a superset of the guarantees of a DMB. If
the DSB is necessary I don't see that the DMB would also be necessary.

> A few that don't execute DSB before SMC:
> arch/arm/mach-bcm/bcm_kona_smc.c
> arch/arm/mach-keystone/smc.S
> 
> >> 1a) Is DSB required before SMC?
> >> 1b) Is DSB required  after SMC?
> >> 2a) Is DSB required before returning to non-secure OS?
> >> 2b) Is DSB required  after returning to non-secure OS?
> > 
> > It depends on what you're trying to achieve, and the design of both the
> > secure and non-secure OS code.
> 
> In my case, I just want to write the L2_CONTROL register.

Is that a register in the L2, or in the CPU? Which L2/CPU?

There may be a constraint that the memory system needs to be quiescent
or something to that effect. Without more information I cannot say what
specifically you need to do.

> > A DSB is certainly not always required before nor after an SMC.
> 
> That makes sense. But a colleague mentioned that the secure OS may
> be using different MMU mappings. In that case, it might be required
> to wait for all in-flight accesses to resolve?

Are you referring to differing VAs or differing attributes?

For ARMv6 and above the former does not matter; the caches behaves as if
they are PIPT.

The latter may require the use of barriers and/or cache maintenance if
the secure and non-secure OSs are communicating through shared memory.
That's somewhat independent of the SMC itself.

Thanks,
Mark.
