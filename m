From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 15 May 2013 18:16:11 +0100
Subject: [PATCH 3/4] ARM: mm: kill unused TLB_CAN_READ_FROM_L1_CACHE
 and use ALT_SMP instead
In-Reply-To: <20130515164843.GN23869@mudshark.cambridge.arm.com>
References: <51938B3D.2070508@free-electrons.com>
 <20130515134117.GH23869@mudshark.cambridge.arm.com>
 <51939386.7010709@free-electrons.com>
 <20130515140607.GI23869@mudshark.cambridge.arm.com>
 <51939FBC.3060705@free-electrons.com>
 <20130515150402.GK23869@mudshark.cambridge.arm.com>
 <5193AB8B.90100@free-electrons.com>
 <20130515154113.GM23869@mudshark.cambridge.arm.com>
 <5193B7CF.2020208@free-electrons.com>
 <20130515164843.GN23869@mudshark.cambridge.arm.com>
Message-ID: <20130515171611.GN18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 15, 2013 at 05:48:43PM +0100, Will Deacon wrote:
> On Wed, May 15, 2013 at 05:29:03PM +0100, Gregory CLEMENT wrote:
> > On 05/15/2013 05:41 PM, Will Deacon wrote:
> > > On Wed, May 15, 2013 at 04:36:43PM +0100, Gregory CLEMENT wrote:
> > >> On 05/15/2013 05:04 PM, Will Deacon wrote:
> > >>> On Wed, May 15, 2013 at 03:46:20PM +0100, Gregory CLEMENT wrote:
> > >>>> On 05/15/2013 04:06 PM, Will Deacon wrote:
> > >>>>> You could also try deleting both of the ALT_* lines and just putting a
> > >>>>> W(nop) in there directly.
> > >>>>
> > >>>> If I just delete the both of the ALT_* lines it no more hangs.
> > >>>> If I put a  W(nop) instead it hangs.
> > >>
> > >> It also hang with a simple nop by the way
> > > 
> > > Ok. Have you tried adding a different instruction (mov r0, r0, for example)?
> > 
> > it hanged again :(
> > 
> > I also try to boot a kernel in Thumb2, it doesn't hang in the same place but the kernel
> > crash latter
> 
> Crikey, that's not much fun. My last idea is to try sticking an isb
> instruction in there. Does that make any difference?
> 
> Can you get access to another 370 board and see if the problem reproduces
> there? Is there any possibility of getting JTAG (again, perhaps on a
> different board)?
> 
> Failing that, I think you need to pester the CPU guys and/or the board guys
> to help you debug this.

I've just tried it on the cubox (Dove, Armada 510) which has the xor
engines enabled in the config.  I see in the boot messages:

mv_xor mv_xor.0: Marvell XOR driver
mv_xor mv_xor.0: Marvell XOR: ( xor cpy )
mv_xor mv_xor.0: Marvell XOR: ( xor fill cpy )
mv_xor mv_xor.1: Marvell XOR driver
mv_xor mv_xor.1: Marvell XOR: ( xor cpy )
mv_xor mv_xor.1: Marvell XOR: ( xor fill cpy )

and /proc/interrupts shows that the interrupts have fired:

 39:          2  orion_irq  mv_xor.0
 40:          2  orion_irq  mv_xor.0
 42:          2  orion_irq  mv_xor.1
 43:          2  orion_irq  mv_xor.1

on each boot.  So I assume that they're doing this self-test.

Anyway, I've added the 'nop' to cpu_v7_dcache_clean_area, and it boots
just fine.  The CPU is:

CPU: ARMv7 Processor [560f5815] revision 5 (ARMv7), cr=10c53c7d
