From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 5 Apr 2014 10:43:13 +0100
Subject: Help for doubt about why update SCTLR by cr_alignment every
 syscall,IRQ,exception ?
In-Reply-To: <CAEjEV8DLk5fhQHMomrrO3h+_9=yo3pMiEvjXG7nOydJOWdf7zg@mail.gmail.com>
References: <CAEjEV8DLk5fhQHMomrrO3h+_9=yo3pMiEvjXG7nOydJOWdf7zg@mail.gmail.com>
Message-ID: <20140405094313.GI7528@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 05, 2014 at 01:41:17PM +0800, qixuan wu wrote:
> Dear King, all,
> 
> If we enable CONFIG_ALIGNMENT_TRAP:

This code in arch/arm/kernel/head-common.S:

        bicne   r4, r0, #CR_A                   @ Clear 'A' bit
        stmneia r7, {r0, r4}                    @ Save control register values

saves different values to cr_alignment and cr_no_alignment.  One always
has the A bit cleared, the other may have the A bit set.

For ARMv5 and older, we must have the A bit set while in the kernel so
misaligned loads are aborted, so that they can be fixed up.  This
behaviour is relied upon by the networking code amongst other places.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
