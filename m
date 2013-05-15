From: will.deacon@arm.com (Will Deacon)
Date: Wed, 15 May 2013 15:06:07 +0100
Subject: [PATCH 3/4] ARM: mm: kill unused TLB_CAN_READ_FROM_L1_CACHE and
 use ALT_SMP instead
In-Reply-To: <51939386.7010709@free-electrons.com>
References: <1364235581-17900-1-git-send-email-will.deacon@arm.com>
 <1364235581-17900-4-git-send-email-will.deacon@arm.com>
 <51938B3D.2070508@free-electrons.com>
 <20130515134117.GH23869@mudshark.cambridge.arm.com>
 <51939386.7010709@free-electrons.com>
Message-ID: <20130515140607.GI23869@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 15, 2013 at 02:54:14PM +0100, Gregory CLEMENT wrote:
> On 05/15/2013 03:41 PM, Will Deacon wrote:
> > Is this using dmatest.ko, or a different test program?
> 
> No they are self-test from the mv_xor driver

Ok. And the CPU locks up, rather than the DMA master?

> > Ok, so the ALT_UP case should be emitted after patching, correct?
> 
> Indeed it was I excepted but I didn't check (I don't know how to do)

If you don't have JTAG, that's trickier. Hopefully my other suggestion will
help.

> >> I made some investigation. And in UP if I remove the line:
> >> 	ALT_UP(W(nop))
> > 
> > Did you remove the ALT_SMP case as well? You could also try making the
> > ALT_SMP case use W(nop) too and see if it changes anything.
> 
> OK I will try it.

You could also try deleting both of the ALT_* lines and just putting a
W(nop) in there directly.

> > If you don't have both of the alternatives, things will go wrong.
> 
> For my own culture, how ALT_UP and ALT_SMP work in SMP case?
> When I disassembled the proc-v7.o, I saw that the SMP variant of the code were
> written. How the kernel switch to the UP version of the code?

Early in boot (head.S:__fixup_smp), we detect whether the CPU has the MP
extensions then, if we're actually UP but the kernel has CONFIG_SMP=y, we
walk over the .alt.smp.init section looking at each entry in there. The
ALT_UP macro spits out an (address, instruction) pair, so in
__do_fixup_smp_on_up, we store the instruction to the address for each pair,
replacing the SMP instruction which sat there in the compiled image.

It could be that the CPUID checks are failing on your Marvell part. Can you
tell me what you have in your mpidr (mrc p15, 0, Rd, c0, c0, 5) and also
your midr (mrc p15, 0, Rd, c0, c0) please?

Cheers,

Will
