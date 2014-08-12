From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 12 Aug 2014 11:50:07 +0100
Subject: arm64 spin-table cpu-return-addr
In-Reply-To: <1407544200.8971.138.camel@smoke>
References: <1407544200.8971.138.camel@smoke>
Message-ID: <20140812105007.GD30614@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 09, 2014 at 01:30:00AM +0100, Geoff Levand wrote:
> Hi Mark,

Hi Geoff,

> Regarding adding a cpu-return-addr property to the spin-table
> cpu enable method for arm64, we need to decide how to handle
> a difference in endian mode between the kernel and the
> spin-table code.
> 
> Will the spin-table code always be built as little endian?  If
> so, then either the kernel or the spin code could handle this
> difference, and we need to decide which will do it.  If not,
> then the only way is for the spin code to do it as the kernel
> has no way to tell endian mode of the spin code, unless to test
> and save how it was entered at startup.

A spin-table implementation could be either endianness as it's possible
to build BE-only or LE-only systems.

There are several other bits of CPU state a spin-table implementation
might care about, so ideally the spin-table implementation would put the
CPU through reset to restore everything to a suitable state.

Depending on the platform and what the rest of the spin-table
implementation looks like, the return code in the spin-table could be as
simple as:

return_addr:
	msr	daifset, 0xf	/* Mask everything, just in case */
	mov	x0, 0x1		/* Cold reset, A64 */
	msr	rmr_el2, x0	/* If EL2 is highest EL implemented */
	isb
1:	wfi			/* Wait for reset */
	b	1b

That would depend on any IMPLEMENTATION DEFINED work you might have to
do, where rvbar_el2 points, and so on.

>From the kernel side I expect we'd try to meet the same requirements as
we expect of the firmware at boot time:
- MMU off
- D-cache clean
- I-cache on or off
- PSTATE.DAIF masked
- Everything else unknown

Does that sound sane to you?

Thanks,
Mark.
