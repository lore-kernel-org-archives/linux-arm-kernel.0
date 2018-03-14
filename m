From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 14 Mar 2018 16:57:09 +0000
Subject: [PATCH 0/3] irqchip: GIC kexec/kdump improvement and workarounds
In-Reply-To: <72c7a6d2-a4c4-26b2-2982-c1d1ffb39b81@arm.com>
References: <20180313172103.24281-1-marc.zyngier@arm.com>
 <20180313175156.gmncij4rnqcdl5ie@lakrids.cambridge.arm.com>
 <72c7a6d2-a4c4-26b2-2982-c1d1ffb39b81@arm.com>
Message-ID: <20180314165708.daoui66waxvicciq@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 13, 2018 at 06:35:07PM +0000, Marc Zyngier wrote:
> On 13/03/18 17:51, Mark Rutland wrote:
> > On Tue, Mar 13, 2018 at 05:21:00PM +0000, Marc Zyngier wrote:
> >> As kexec and kdump are getting used a bit more intensively, I've been
> >> made aware of a number of shortcomings.
> >>
> >> The main gripe is from folks trying to launch a kdump kernel from
> >> within an interrupt handler. If using EOImode==1, things work as
> >> expected. If using EOImode==0 (such as in a guest), the secondary
> >> kernel hangs as the previous interrupt hasn't been EOI'd, and the
> >> active priority is still set. The first two patches are addressing
> >> this situation for both GICv2 and GICv3 by reseting the APRs to their
> >> default value.
> > 
> > As a more general thing, if irqchip drivers have state that needs to be
> > reset in their init code, can we live all this irqchip reset to the
> > crashdump kernel, and kill machine_kexec_mask_interrupts() entirely?
> 
> We could, once we know for sure that all the potential irqchips have
> been fixed. Or we could just remove it immediately, and see what breaks.

I would be very tempted to do the latter.

Thanks,
Mark.
